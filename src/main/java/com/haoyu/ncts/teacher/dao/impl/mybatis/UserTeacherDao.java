package com.haoyu.ncts.teacher.dao.impl.mybatis;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.teacher.dao.IUserTeacherDao;
import com.haoyu.ncts.teacher.entity.UserTeacher;
import com.haoyu.sip.core.jdbc.MybatisDao;

@Repository
public class UserTeacherDao extends MybatisDao implements IUserTeacherDao {

	@Override
	public UserTeacher selectTeacherById(String id) {
		return super.selectByPrimaryKey(id);
	}

	@Override
	public int insertTeacher(UserTeacher Teacher) {
		Teacher.setDefaultValue();
		return super.insert(Teacher);
	}

	@Override
	public int updateTeacher(UserTeacher Teacher) {
		Teacher.setUpdateValue();
		return super.update(Teacher);
	}

	@Override
	public int deleteTeacherByLogic(Map<String,Object> parameter) {
		return super.deleteByLogic(parameter);
	}

	@Override
	public int deleteTeacherByPhysics(String id) {
		return super.deleteByPhysics(id);
	}

	@Override
	public List<UserTeacher> findAll(Map<String, Object> parameter) {
		return super.selectList("selectByParameter", parameter);
	}

	@Override
	public List<UserTeacher> findAll(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	
}
