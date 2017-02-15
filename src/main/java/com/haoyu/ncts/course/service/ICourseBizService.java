package com.haoyu.ncts.course.service;

import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.sip.core.service.Response;

public interface ICourseBizService {
	
	CSAIdObject getCSAIdObject(String key, CSAIdObject csaIdObject);

	Response createExtendCourse(String sourceId,String courseTopicId);
	
}
