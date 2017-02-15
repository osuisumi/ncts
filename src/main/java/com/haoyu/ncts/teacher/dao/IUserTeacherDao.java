package com.haoyu.ncts.teacher.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.teacher.entity.UserTeacher;

public interface IUserTeacherDao {

	UserTeacher selectTeacherById(String id);

	int insertTeacher(UserTeacher Teacher);

	int updateTeacher(UserTeacher Teacher);

	int deleteTeacherByLogic(Map<String,Object> parameter);

	int deleteTeacherByPhysics(String id);

	List<UserTeacher> findAll(Map<String, Object> parameter);

	List<UserTeacher> findAll(Map<String, Object> parameter, PageBounds pageBounds);

}