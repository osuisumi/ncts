package com.haoyu.ncts.index.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.utils.RoleCodeConstant;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.login.Loginer;

@Controller
@RequestMapping("ncts")
public class NctsIndexController extends AbstractBaseController{

	@RequestMapping("index")
	public String index(){
		Subject currentUser = SecurityUtils.getSubject();
		if (currentUser.hasRole(RoleCodeConstant.COURSE_MAKER)) {
			return "redirect:make/course";
		}else if(currentUser.hasRole(RoleCodeConstant.COURSE_TEACHER)){
			return "redirect:teach/course";
		}else if(currentUser.hasRole("course_preview")){
			return "redirect:course/list_preview_course";
		}else{
			return "redirect:study";
		}
	}
	
	@RequestMapping("study")
	public String study(Model model){
		CourseRegister courseRegister = new CourseRegister();
		model.addAttribute("courseRegister",courseRegister);
		courseRegister.setUser(new User(((Loginer)request.getSession().getAttribute("loginer")).getId()));
		model.addAttribute("courseRegister",courseRegister);
		getPageBounds(Integer.MAX_VALUE, true);
		return TemplateUtils.getTemplatePath("/study/study_index");
	}
}
