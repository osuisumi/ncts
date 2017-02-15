package com.haoyu.ncts.survey.controller;


import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.survey.entity.Survey;
import com.haoyu.aip.survey.service.ISurveyService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/make/survey")
public class SurveyNctsController extends AbstractBaseController{
	
	@Resource
	private ISurveyService surveyService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/make/survey/");
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(){
		return this.getLogicalViewNamePrefix() + "survey/edit_survey";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(Survey survey){
		return surveyService.createSurvey(survey);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Survey survey){
		return surveyService.updateSurvey(survey);
	}
	

}
