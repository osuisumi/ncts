package com.haoyu.ncts.course.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.course.entity.CourseResultStat;
import com.haoyu.ncts.utils.CSAIdObject;

public interface ICourseBizDao {
	
	CSAIdObject selectCSAIdObjectByKey(CSAIdObject csaIdObject);

	List<CourseResultStat> selectCourseResultForTempExport(Map<String, Object> parameter, PageBounds pageBounds);

}
