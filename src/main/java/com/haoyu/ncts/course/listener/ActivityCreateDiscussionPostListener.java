package com.haoyu.ncts.course.listener;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject; 
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.event.CreateDiscussionPostEvent;
import com.haoyu.ncts.course.service.IActivityBizService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;

@Component
public class ActivityCreateDiscussionPostListener implements ApplicationListener<CreateDiscussionPostEvent>{

	@Resource
	private IActivityBizService activityBizService;
	
	@Override
	public void onApplicationEvent(CreateDiscussionPostEvent event) {
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
			DiscussionPost discussionPost = (DiscussionPost) event.getSource();
			activityBizService.doDiscussionActivity(discussionPost);
		}
	}
}
