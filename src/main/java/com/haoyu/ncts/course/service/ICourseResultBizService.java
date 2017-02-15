package com.haoyu.ncts.course.service;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.core.service.Response;

public interface ICourseResultBizService {

	Response updateCourseResult(String courseId, List<String> userIds, boolean isLimit);
	
	Response updateCourseResult(String courseId, List<String> userIds, boolean isLimit, boolean markAssignment);
	
	Response updateCourseResult(String courseId, List<String> userIds);

	Response updateCourseResultTmp(String trainId, String courseId, List<String> userIds, boolean isLimit);

	void export(Map<String, Object> parameter, PageBounds pageBounds, ServletOutputStream outputStream);

}
