package com.haoyu.ncts.teacher.service.impl;


import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Identities;
import com.haoyu.ncts.teacher.dao.IUserTeacherDao;
import com.haoyu.ncts.teacher.entity.UserTeacher;
import com.haoyu.ncts.teacher.service.IUserTeacherService;

@Service
public class UserTeacherService implements IUserTeacherService{
	@Resource
	private IUserTeacherDao userTeacherDao;

	@Override
	public Response createTeacher(UserTeacher Teacher) {
		if(StringUtils.isEmpty(Teacher.getId())){
			Teacher.setId(Identities.uuid2());
		}
		Teacher.setDefaultValue();
		return userTeacherDao.insertTeacher(Teacher)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response updateTeacher(UserTeacher Teacher) {
		Teacher.setUpdateValue();
		return userTeacherDao.updateTeacher(Teacher)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public Response deleteTeacher(UserTeacher Teacher) {
		Map<String,Object> parameter = Maps.newHashMap();
		parameter.put("ids", Arrays.asList(Teacher.getId().split(",")));
		Teacher.setUpdateValue();
		parameter.put("entity", Teacher);
		return userTeacherDao.deleteTeacherByLogic(parameter)>0?Response.successInstance():Response.failInstance();
	}

	@Override
	public UserTeacher findTeacherById(String id) {
		return userTeacherDao.selectTeacherById(id);
	}

	@Override
	public List<UserTeacher> findTeachers(UserTeacher Teacher, PageBounds pageBounds) {
		Map<String,Object> parameter = Maps.newHashMap();
		return userTeacherDao.findAll(parameter, pageBounds);
	}

	@Override
	public List<UserTeacher> findTeachers(Map<String, Object> parameter, PageBounds pageBounds) {
		return userTeacherDao.findAll(parameter, pageBounds);
	}

}
