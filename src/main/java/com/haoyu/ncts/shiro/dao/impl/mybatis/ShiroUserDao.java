package com.haoyu.ncts.shiro.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import com.haoyu.ncts.shiro.dao.IShiroUserDao;
import com.haoyu.ncts.shiro.entity.ShiroUser;
import com.haoyu.sip.auth.entity.AuthUser;
import com.haoyu.sip.core.jdbc.MybatisDao;

public class ShiroUserDao extends MybatisDao implements IShiroUserDao{

	@Override
	public ShiroUser selectByUserName(String username) {
		return this.selectOne("selectByUserName",username);
	}

	@Override
	public List<AuthUser> selectAuthUser(Map<String, Object> param) {
		return this.selectList("selectAuthUser", param);
	}

	@Override
	public ShiroUser selectById(String id) {
		return this.selectOne("selectById",id);
	}

}
