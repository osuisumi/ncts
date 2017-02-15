package com.haoyu.ncts.account.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.user.service.IAccountAbstractService;

@Controller
@RequestMapping("**/ncts/account")
public class AccountNctsController extends AbstractBaseController{
	@Resource
	private IAccountAbstractService accountAbstractService;
	
	
	protected String getLogicViewNamePerfix(){
		return TemplateUtils.getTemplatePath("/account/");
	}
	
	@RequestMapping(value="edit_password",method=RequestMethod.GET)
	public String changePasswordUI(){
		return getLogicViewNamePerfix() + "edit_password";
	}
	
	@RequestMapping(value="update_password",method=RequestMethod.PUT)
	@ResponseBody
	public Response changePassword(String oldPassword,String newPassword){
		return accountAbstractService.updatePassword(oldPassword,newPassword);
	}
	
}
