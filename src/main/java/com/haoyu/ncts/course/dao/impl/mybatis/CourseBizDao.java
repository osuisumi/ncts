package com.haoyu.ncts.course.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.course.dao.ICourseBizDao;
import com.haoyu.ncts.course.entity.CourseResultStat;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class CourseBizDao extends MybatisDao implements ICourseBizDao{

	@Override
	public CSAIdObject selectCSAIdObjectByKey(CSAIdObject csaIdObject) {
		return selectOne("selectCSAIdObjectByKey", csaIdObject);
	}

	@Override
	public List<CourseResultStat> selectCourseResultForTempExport(Map<String, Object> parameter, PageBounds pageBounds) {
		return selectList("selectCourseResultForTempExport", parameter, pageBounds);
	}
}
