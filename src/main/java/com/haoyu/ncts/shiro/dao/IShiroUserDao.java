package com.haoyu.ncts.shiro.dao;

import java.util.List;
import java.util.Map;

import com.haoyu.ncts.shiro.entity.ShiroUser;
import com.haoyu.sip.auth.entity.AuthUser;

public interface IShiroUserDao {

	ShiroUser selectByUserName(String username);

	List<AuthUser> selectAuthUser(Map<String, Object> param);

	ShiroUser selectById(String id);

}
