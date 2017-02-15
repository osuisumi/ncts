package com.haoyu.ncts.course.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.ncts.course.dao.ICourseBizDao;
import com.haoyu.ncts.course.dao.ICourseDao;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseTopic;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.IActivityBizService;
import com.haoyu.ncts.course.service.ICourseBizService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.course.utils.CourseState;
import com.haoyu.ncts.course.utils.CourseType;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Collections3;

@Service
public class CourseBizServiceImpl implements ICourseBizService{
	
	@Resource
	private ICourseBizDao courseBizDao;
	@Resource
	private ISectionService sectionService;
	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityBizService activityBizService;
	@Resource
	private ICourseDao courseDao;
	@Resource
	private ICourseService courseService;
	
	@Override
	@Cacheable(key="'CSAId:'+#key",value="CSAIdObject")
	public CSAIdObject getCSAIdObject(String key, CSAIdObject csaIdObject) {
		return courseBizDao.selectCSAIdObjectByKey(csaIdObject);
	}
	
	@Override
	public Response createExtendCourse(String sourceId,String courseTopicId) {
		Course sourceCourse = courseDao.selectByPrimaryKey(sourceId);
		Course branchCourse = new Course();

		BeanUtils.copyProperties(sourceCourse, branchCourse, new String[] { "timePeriod", "id" });

		branchCourse.setIsTemplate("N");
		branchCourse.setState(CourseState.PASS);
		if(StringUtils.isNotEmpty(courseTopicId)){
			branchCourse.setCourseTopic(new CourseTopic(courseTopicId));
		}
		if (StringUtils.isNotEmpty(sourceCourse.getSourceId())) {
			branchCourse.setSourceId(sourceCourse.getSourceId());
		} else {
			branchCourse.setSourceId(sourceCourse.getId());
		}
		PageBounds pageBounds = new PageBounds();
		pageBounds.setLimit(Integer.MAX_VALUE);
		pageBounds.setOrders(Order.formString("SORT_NO,CREATE_TIME"));

		// 创建课程
		Response response = courseService.createCourse(branchCourse);
		if (response.isSuccess()) {
			String type = branchCourse.getType();
			if (CourseType.LEAD.equals(type) || CourseType.SELF.equals(type)) {
				Map<String, Object> param = Maps.newHashMap();
				param.put("courseId", sourceCourse.getId());
				List<Section> sections = sectionService.listSection(param, true, pageBounds);
				if (Collections3.isNotEmpty(sections)) {
					for (Section section : sections) {
						section.setCourse(branchCourse);
						// 复制章
						section.setId(null);
						response = sectionService.createSection(section);
						if (response.isSuccess()) {
							List<Section> childSections = section.getChildSections();
							if (Collections3.isNotEmpty(childSections)) {
								for (Section childSection : childSections) {
									String oldSectionId = childSection.getId();
									childSection.setCourse(branchCourse);
									childSection.setParentSection(section);
									// 复制节
									childSection.setId(null);
									response = sectionService.createSection(childSection);
									if (response.isSuccess()) {
										param = Maps.newHashMap();
										param.put("relationId", oldSectionId);
										List<Activity> activities = activityService.listActivity(param, true, pageBounds);
										if (Collections3.isNotEmpty(activities)) {
											for (Activity activity : activities) {
												activityBizService.createExtendActivity(activity, childSection.getId(), branchCourse.getId(), sourceCourse.getId());
											}
										}
									}
								}
							}
						}
					}
				}
			} else {
				Map<String, Object> param = Maps.newHashMap();
				param.put("relationId", sourceCourse.getId());
				List<Activity> activities = activityService.listActivity(param, true, pageBounds);
				if (Collections3.isNotEmpty(activities)) {
					for (Activity activity : activities) {
						activityBizService.createExtendActivity(activity, branchCourse.getId(), branchCourse.getId(), sourceCourse.getId());
					}
				}
			}
		}
		return response.responseData(branchCourse);
	}
}
