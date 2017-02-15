package com.haoyu.ncts.course.listener;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityResultState;
import com.haoyu.aip.assignment.entity.AssignmentUser;
import com.haoyu.aip.assignment.event.SubmitAssignmentUserEvent;
import com.haoyu.aip.assignment.service.IAssignmentUserService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;

@Component
public class ActivitySubmitAssignmentUserListener implements ApplicationListener<SubmitAssignmentUserEvent>{

	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IAssignmentUserService assignmentUserService;
	
	@Override
	public void onApplicationEvent(SubmitAssignmentUserEvent event) {
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
			AssignmentUser assignmentUser = (AssignmentUser) event.getSource();
			assignmentUser = assignmentUserService.getAssignmentUser(assignmentUser.getId());
			String relationId = assignmentUser.getAssignmentRelation().getRelation().getId();
			String assignmentId = assignmentUser.getAssignmentRelation().getAssignment().getId();
			Activity activity = activityService.getActivityByEntityId(assignmentId);
			ActivityResult activityResult = activityResultService.createIfNotExists(activity.getId(), relationId);
			activityResult.setState(ActivityResultState.IN_PROGRESS);
			activityResultService.updateActivityResult(activityResult);
		}
	}
}
