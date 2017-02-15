package com.haoyu.ncts.teacher.service;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.teacher.entity.UserTeacher;
import com.haoyu.sip.core.service.Response;

public interface IUserTeacherService {
	
	Response createTeacher(UserTeacher Teacher);
	
	Response updateTeacher(UserTeacher Teacher);
	
	Response deleteTeacher(UserTeacher Teacher);
	
	UserTeacher findTeacherById(String id);
	
	List<UserTeacher> findTeachers(UserTeacher Teacher,PageBounds pageBounds);
	
	List<UserTeacher> findTeachers(Map<String,Object> parameter,PageBounds pageBounds);
}
