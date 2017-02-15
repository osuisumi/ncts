package com.haoyu.ncts.assignment.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.aip.assignment.entity.AssignmentMark;
import com.haoyu.aip.assignment.entity.AssignmentUser;
import com.haoyu.aip.assignment.service.IAssignmentMarkService;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/assignment/biz")
public class AssignmentBizController extends AbstractBaseController{
	
	@Resource
	private ISectionService sectionService;
	@Resource
	private IAssignmentMarkService assignmentMarkService;
	
	private String getLogicalViewNamePrefix() {
		return TemplateUtils.getTemplatePath("/study/activity/assignment/");
	}
	
	@RequestMapping("markAssignmentUser")
	public String markAssignmentUser(AssignmentMark assignmentMark, Model model){
		model.addAttribute("assignmentMark", assignmentMark);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "mark_assignment_user";
	}
	
	@RequestMapping("listAssignmentUser")
	public String listAssignmentUser(AssignmentUser assignmentUser, Model model){
		model.addAttribute("assignmentUser", assignmentUser);
		model.addAllAttributes(request.getParameterMap());
		getPageBounds(10, true);
		return TemplateUtils.getTemplatePath("/teach/assignment/") + "list_assignment_user";
	}

}
