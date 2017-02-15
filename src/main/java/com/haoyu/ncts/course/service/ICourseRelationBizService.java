package com.haoyu.ncts.course.service;

import com.haoyu.sip.core.service.Response;

public interface ICourseRelationBizService {

	Response updateCourseRelations(String courseIds, String relationId,String courseTopicId);
	
	

}
