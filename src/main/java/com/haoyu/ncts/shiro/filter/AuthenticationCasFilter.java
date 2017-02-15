package com.haoyu.ncts.shiro.filter;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.UsernamePasswordToken;

import com.google.common.collect.Lists;
import com.haoyu.ncts.schedule.utils.ScheduleMessageUtils;
import com.haoyu.ncts.shiro.entity.ShiroUser;
import com.haoyu.ncts.shiro.service.IShiroUserService;
import com.haoyu.sip.auth.filter.AbstractAuthenticationCasFilter;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.login.Loginer;

public class AuthenticationCasFilter extends AbstractAuthenticationCasFilter {	
	
	private IShiroUserService shiroUserService;
	@Resource
	private CacheCleaner authRealm;
	
	public IShiroUserService getShiroUserService() {
		return shiroUserService;
	}

	public void setShiroUserService(IShiroUserService shiroUserService) {
		this.shiroUserService = shiroUserService;
	}

	public final static String getIpAddr(HttpServletRequest request)  {
		String ip = request.getHeader("X-Real-IP");
		if (StringUtils.isEmpty(ip)||ip.contains("unknown")) {
			ip = request.getHeader("x-forwarded-for");
		}
		if (StringUtils.isEmpty(ip)||ip.contains("unknown")) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (StringUtils.isEmpty(ip)||ip.contains("unknown")) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (StringUtils.isEmpty(ip)||ip.contains("unknown")) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	@Override
	protected void onLoginSuccess(UsernamePasswordToken upt, ServletRequest request, ServletResponse response) {
		ScheduleMessageUtils.sendScheduleMessageOnLogin();
		String userName = upt.getUsername();
		if (StringUtils.isNotEmpty(userName)) {
			ShiroUser shiroUser = shiroUserService.queryShiroUserByUserName(userName);
			shiroUser.setAttributes(new HashMap<String,Object>());
			shiroUser.getAttributes().put("deptId", shiroUser.getDeptId());
			shiroUser.getAttributes().put("avatar", shiroUser.getAvatar());
			shiroUser.getAttributes().put("deptName", shiroUser.getDeptName());
			shiroUser.getAttributes().put("roleCode", shiroUser.getRoleCode());
			shiroUser.getAttributes().put("areaId", shiroUser.getAreaId());
			((HttpServletRequest)request).getSession().setAttribute("loginer", (Loginer)shiroUser);
			authRealm.clearUserCacheByIds(Lists.newArrayList(shiroUser.getId()));
		}
	}
}
