package com.haoyu.ncts.course.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.utils.ActivityType;
import com.haoyu.aip.assignment.service.IAssignmentUserService;
import com.haoyu.ncts.course.dao.ICourseBizDao;
import com.haoyu.ncts.course.dao.ICourseResultDao;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.entity.CourseRelation;
import com.haoyu.ncts.course.entity.CourseResult;
import com.haoyu.ncts.course.entity.CourseResultStat;
import com.haoyu.ncts.course.event.CompleteCourseEvent;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.ncts.course.service.ICourseRelationService;
import com.haoyu.ncts.course.service.ICourseResultBizService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseRegisterState;
import com.haoyu.ncts.course.utils.CourseResultState;
import com.haoyu.ncts.course.utils.CourseType;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.excel.ExcelExport;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.TimeUtils;

@Service
public class CourseResultBizServiceImpl implements ICourseResultBizService{

	@Resource
	private ICourseService courseService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private ICourseResultDao courseResultDao;
	@Resource
	private IAssignmentUserService assignmentUserService;
	@Resource
	private ICourseRegisterService courseRegisterService;
	@Resource
	private ICourseRelationService courseRelationService;
	@Resource
	private ApplicationContext applicationContext;
	@Resource
	private ICourseBizDao CourseBizDao;
	
	@Override
	public Response updateCourseResult(String courseId, List<String> userIds, boolean isLimit) {
		return this.updateCourseResult(courseId, userIds, isLimit, false);
	}
	
	@Override
	public Response updateCourseResult(String courseId, List<String> userIds) {
		return this.updateCourseResult(courseId, userIds, true);
	}

	@Override
	public Response updateCourseResultTmp(String trainId, String courseId, List<String> userIds, boolean isLimit) {
		if (StringUtils.isEmpty(trainId)) {
			return this.updateCourseResult(courseId, userIds, isLimit);
		}
		Map<String, Object> parameter = Maps.newHashMap();
		parameter.put("relationId", trainId);
		parameter.put("type", CourseType.SELF);
		List<CourseRelation> courseRelations = courseRelationService.listCourseRelations(parameter, null);
		for (CourseRelation courseRelation : courseRelations) {
			Course course = courseRelation.getCourse();
			courseId = course.getId();
			List<Activity> activities = courseService.listActivity(course.getId());
			Map<String, Integer> numMap = Maps.newHashMap();
			if (Collections3.isNotEmpty(activities)) {
				for (Activity activity : activities) {
					if(!numMap.containsKey(activity.getType())){
						numMap.put(activity.getType(), 0);
					}
					int num = numMap.get(activity.getType());
					numMap.put(activity.getType(), num + 1);
				}
			}
			if (!course.getResultSettingsMap().isEmpty()) {
				Map<String, Object> crParam = Maps.newHashMap();
				crParam.put("courseId", courseId);
				crParam.put("state", CourseRegisterState.PASS);
				if (userIds != null && Collections3.isNotEmpty(userIds)) {
					crParam.put("userIds", userIds);
				}
				List<CourseRegister> courseRegisters = courseRegisterService.listCourseRegister(crParam, null);
				if (Collections3.isNotEmpty(courseRegisters)) {
					for (CourseRegister cr : courseRegisters) {
						String userId = cr.getUser().getId();
						Map<String, Object> scoreMap = Maps.newHashMap();
						for (String type : course.getResultSettingsMap().keySet()) {
							scoreMap.put(type, BigDecimal.valueOf(0));
						}
						Map<String, Object> param = Maps.newHashMap();
						param.put("relationId", courseId);
						param.put("creator", userId);
						List<ActivityResult> activityResults = activityResultService.listActivityResult(param, null);
						for (ActivityResult activityResult : activityResults) {
							if (scoreMap.containsKey(activityResult.getActivity().getType())) {
								BigDecimal score = (BigDecimal) scoreMap.get(activityResult.getActivity().getType());
								if (activityResult.getScore() != null) {
									scoreMap.put(activityResult.getActivity().getType(), score.add(activityResult.getScore()));
								}
							}
						}
						BigDecimal courseScore = BigDecimal.valueOf(0);
						for (String type : course.getResultSettingsMap().keySet()) {
							BigDecimal totalScore = (BigDecimal) scoreMap.get(type);
							int num = 0;
							if (numMap.containsKey(type)) {
								num = numMap.get(type);
							}
							int pct = 0;
							if (StringUtils.isNotEmpty((String) course.getResultSettingsMap().get(type))) {
								pct = Integer.parseInt((String) course.getResultSettingsMap().get(type));
							}
							BigDecimal score = num==0?BigDecimal.valueOf(0):
												totalScore.divide(BigDecimal.valueOf(num), 1, BigDecimal.ROUND_HALF_UP)
												.multiply(BigDecimal.valueOf(pct))
												.divide(BigDecimal.valueOf(100), 1, BigDecimal.ROUND_HALF_UP);
							scoreMap.put(type, score);
							courseScore = courseScore.add(score);
						}
						String id = CourseResult.getId(courseId, userId);
						CourseResult courseResult = new CourseResult();
						courseResult.setId(id);
						courseResult.setScore(courseScore);
						courseResult.setDetailMap(scoreMap);
						courseResult.setUpdatedby(ThreadContext.getUser());
						courseResult.setUpdateTime(System.currentTimeMillis());
						if (courseResult.getScore().floatValue() >= 60) {
							courseResult.setState(CourseResultState.PASS);
						}else{
							courseResult.setState(CourseResultState.NOPASS);
						}
						int count = courseResultDao.update(courseResult);
						if (count <= 0) {
							courseResult.setCourse(new Course(courseId));
							courseResult.setUser(new User(userId));
							courseResult.setDefaultValue();
							count = courseResultDao.insert(courseResult);
						}
					}
				}
			}
		}
		return Response.successInstance();
	}

	@Override
	public Response updateCourseResult(String courseId, List<String> userIds, boolean isLimit, boolean markAssignment) {
		Course course = courseService.getCourse(courseId);
		if(isLimit){
			if (course.getType().equals(CourseType.LEAD)) {
				if (course.getTimePeriod() == null) {
					return Response.failInstance().responseMsg("course is not set endTime");
				}
				if (!TimeUtils.hasEnded(course.getTimePeriod().getEndTime())) {
					return Response.failInstance().responseMsg("course is not over");
				}
			}
		}
		List<Activity> activities = courseService.listActivity(course.getId());
		Map<String, Integer> numMap = Maps.newHashMap();
		if (Collections3.isNotEmpty(activities)) {
			for (Activity activity : activities) {
				if (activity.getType().equals(ActivityType.ASSIGNMENT) && markAssignment) {
					assignmentUserService.updateAssignmentUserEnd(activity.getEntityId());
				}
				if(!numMap.containsKey(activity.getType())){
					numMap.put(activity.getType(), 0);
				}
				int num = numMap.get(activity.getType());
				numMap.put(activity.getType(), num + 1);
			}
		}
		if (!course.getResultSettingsMap().isEmpty()) {
			Map<String, Object> crParam = Maps.newHashMap();
			crParam.put("courseId", courseId);
			crParam.put("state", CourseRegisterState.PASS);
			if (userIds != null && Collections3.isNotEmpty(userIds)) {
				crParam.put("userIds", userIds);
			}
			List<CourseRegister> courseRegisters = courseRegisterService.listCourseRegister(crParam, null);
			if (Collections3.isNotEmpty(courseRegisters)) {
				for (CourseRegister cr : courseRegisters) {
					String userId = cr.getUser().getId();
					Map<String, Object> scoreMap = Maps.newHashMap();
					for (String type : course.getResultSettingsMap().keySet()) {
						scoreMap.put(type, BigDecimal.valueOf(0));
					}
					Map<String, Object> param = Maps.newHashMap();
					param.put("relationId", courseId);
					param.put("creator", userId);
					List<ActivityResult> activityResults = activityResultService.listActivityResult(param, null);
					for (ActivityResult activityResult : activityResults) {
						if (scoreMap.containsKey(activityResult.getActivity().getType())) {
							BigDecimal score = (BigDecimal) scoreMap.get(activityResult.getActivity().getType());
							if (activityResult.getScore() != null) {
								scoreMap.put(activityResult.getActivity().getType(), score.add(activityResult.getScore()));
							}
						}
					}
					BigDecimal courseScore = BigDecimal.valueOf(0);
					for (String type : course.getResultSettingsMap().keySet()) {
						BigDecimal totalScore = (BigDecimal) scoreMap.get(type);
						int num = numMap.get(type);
						int pct = 0;
						if (StringUtils.isNotEmpty((String) course.getResultSettingsMap().get(type))) {
							pct = Integer.parseInt((String) course.getResultSettingsMap().get(type));
						}
						BigDecimal score = num==0?BigDecimal.valueOf(0):
											totalScore.divide(BigDecimal.valueOf(num), 1, BigDecimal.ROUND_HALF_UP)
											.multiply(BigDecimal.valueOf(pct))
											.divide(BigDecimal.valueOf(100), 1, BigDecimal.ROUND_HALF_UP);
						scoreMap.put(type, score);
						courseScore = courseScore.add(score);
					}
					String id = CourseResult.getId(courseId, userId);
					CourseResult courseResult = new CourseResult();
					courseResult.setId(id);
					courseResult.setScore(courseScore);
					courseResult.setDetailMap(scoreMap);
					courseResult.setUpdatedby(ThreadContext.getUser());
					courseResult.setUpdateTime(System.currentTimeMillis());
					if (courseResult.getScore().floatValue() >= 60) {
						courseResult.setState(CourseResultState.PASS);
					}else{
						courseResult.setState(CourseResultState.NOPASS);
					}
					int count = courseResultDao.update(courseResult);
					if (count <= 0) {
						courseResult.setCourse(new Course(courseId));
						courseResult.setUser(new User(userId));
						courseResult.setDefaultValue();
						count = courseResultDao.insert(courseResult);
					}
					if (count > 0) {
						Map<String, Object> map = Maps.newHashMap();
						map.put("userIds", Lists.newArrayList(userId));
						applicationContext.publishEvent(new CompleteCourseEvent(map));
					}
				}
			}
			return Response.successInstance();
		}
		return Response.failInstance().responseMsg("course result settings is not be set");
	}

	@Override
	public void export(Map<String, Object> parameter, PageBounds pageBounds, ServletOutputStream outputStream) {
		if(pageBounds != null){
			pageBounds.setContainsTotalCount(false);
		}
		List<CourseResultStat> courseResultStats = CourseBizDao.selectCourseResultForTempExport(parameter, pageBounds);
		for(CourseResultStat crs : courseResultStats){
			crs.setExportField();
		}
		ExcelExport<CourseResultStat> ee = new ExcelExport<CourseResultStat>(CourseResultStat.class);
		ee.exportExcel(courseResultStats, outputStream);
	}
}
