package com.haoyu.ncts.user.controller;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.shiro.entity.ShiroUser;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.login.Loginer;
import com.haoyu.sip.user.entity.UserInfo;
import com.haoyu.sip.user.service.IUserInfoService;

@Controller
@RequestMapping("**/ncts/users")
public class UserBizController extends AbstractBaseController{
	
	@Resource
	private IUserInfoService userService;
	
	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/user/");
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(UserInfo user,Model model){	
		return getLogicalViewNamePrefix() + "edit_user";
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(UserInfo user){
		Response response = userService.updateUser(user);
		if (response.isSuccess()) {
			Loginer shiroUser = (Loginer) request.getSession().getAttribute("loginer");
			if (StringUtils.isNotEmpty(user.getRealName())) {
				shiroUser.setRealName(user.getRealName());
			}
			if (StringUtils.isNotEmpty(user.getAvatar())) {
				shiroUser.getAttributes().put("avatar", user.getAvatar());
			}
		}
		return response;
	}
}
