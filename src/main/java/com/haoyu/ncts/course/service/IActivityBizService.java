package com.haoyu.ncts.course.service;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.ncts.course.web.param.ActivityParam;
import com.haoyu.sip.core.service.Response;

public interface IActivityBizService {
	
	Response createActivity(ActivityParam activityParam);
	
	Response updateActivity(ActivityParam activityParam);
	
	void doDiscussionActivity(DiscussionPost discussionPost);

	Response createExtendActivity(Activity activity, String sectionId, String courseId, String origCourseId);

}
