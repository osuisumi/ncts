package com.haoyu.ncts.shiro.service;

import java.util.List;

import com.haoyu.ncts.shiro.entity.ShiroUser;
import com.haoyu.sip.auth.entity.AuthUser;

public interface IShiroUserService {

	ShiroUser queryShiroUserByUserName(String userName);
	
	ShiroUser queryShiroUserById(String id);

	AuthUser findAuthUserByUsername(String username);

	AuthUser findAuthUserById(String id);

	List<AuthUser> findAuthUserByIds(List<String> ids);

}
