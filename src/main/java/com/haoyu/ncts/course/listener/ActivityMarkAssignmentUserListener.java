package com.haoyu.ncts.course.listener;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityAttributeName;
import com.haoyu.aip.assignment.entity.AssignmentUser;
import com.haoyu.aip.assignment.event.MarkAssignmentUserEvent;
import com.haoyu.aip.assignment.service.IAssignmentUserService;
import com.haoyu.aip.assignment.utils.AssignmentUserState;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.ICourseResultBizService;
import com.haoyu.ncts.course.service.ICourseResultService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseType;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.service.Response;

@Component
public class ActivityMarkAssignmentUserListener implements ApplicationListener<MarkAssignmentUserEvent>{

	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IAssignmentUserService assignmentUserService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseResultBizService courseResultBizService;
	
	@Override
	public void onApplicationEvent(MarkAssignmentUserEvent event) {
		AssignmentUser assignmentUser = (AssignmentUser) event.getSource();
		assignmentUser = assignmentUserService.getAssignmentUser(assignmentUser.getId());
		String relationId = assignmentUser.getAssignmentRelation().getRelation().getId();
		String assignmentId = assignmentUser.getAssignmentRelation().getAssignment().getId();
		Activity activity = activityService.getActivityByEntityId(assignmentId);
		ActivityResult activityResult = activityResultService.createIfNotExists(activity.getId(), relationId, assignmentUser.getCreator().getId());
		Map<String, Object> result = Maps.newHashMap();
		
		if(AssignmentUserState.RETURN.equals(assignmentUser.getState())){
			activityResult.setScore(BigDecimal.valueOf(0));
			activityResult.setState(assignmentUser.getState());
			result.put(ActivityAttributeName.COMPLETE_PCT, 0);
		}else{
			BigDecimal responseScore = BigDecimal.valueOf(0);
			BigDecimal markScore = BigDecimal.valueOf(0);
			if (assignmentUser.getResponseScore() != null) {
				responseScore = assignmentUser.getResponseScore()==null?BigDecimal.valueOf(0):assignmentUser.getResponseScore();
				result.put(ActivityAttributeName.ASSIGNMENT_RESPONSE_SCORE, responseScore);
			}
			if (assignmentUser.getMarkScore() != null) {
				markScore = assignmentUser.getMarkScore()==null?BigDecimal.valueOf(0):assignmentUser.getMarkScore();
				result.put(ActivityAttributeName.ASSIGNMENT_MARK_SCORE, markScore);
			}
			activityResult.setScore(responseScore.add(markScore));
			activityResult.setState(assignmentUser.getState());
			result.put(ActivityAttributeName.COMPLETE_PCT, responseScore.add(markScore));
			result.put(ActivityAttributeName.ASSIGNMENT_MARK_NUM, assignmentUser.getMarkNum());
		}
		activityResult.setDetail(new JsonMapper().toJson(result));
		Response response = activityResultService.updateActivityResult(activityResult);
		if (response.isSuccess()) {
			Course course = courseService.getCourse(CSAIdObject.getCSAIdObject().getCid());
			if (!course.getType().equals(CourseType.LEAD) && StringUtils.isNotEmpty(course.getResultSettings())) {
				courseResultBizService.updateCourseResult(course.getId(), Lists.newArrayList(assignmentUser.getCreator().getId()));
			}
		}
	}
}
