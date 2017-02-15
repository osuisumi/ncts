package com.haoyu.ncts.survey.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/study/survey")
public class SurveyStudyNctsController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/study/survey/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String view(String surveyId,String userId,String relationId,Model model){
		model.addAttribute("surveyId", surveyId);
		model.addAttribute("userId", userId);
		model.addAttribute("relationId", relationId);
		return getLogicalViewNamePrefix() + "view_survey";
	}
	
}
