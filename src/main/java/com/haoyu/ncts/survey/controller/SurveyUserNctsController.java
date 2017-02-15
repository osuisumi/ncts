package com.haoyu.ncts.survey.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.survey.entity.SurveyUser;
import com.haoyu.aip.survey.service.ISurveyService;
import com.haoyu.aip.survey.service.ISurveyUserService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/survey/user")
public class SurveyUserNctsController extends AbstractBaseController{
	@Resource
	private ISurveyUserService surveyUserService;
	
	
	@Resource
	private ISurveyService surveyService;
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response save(SurveyUser surveyUser){
		return surveyUserService.saveSurveyUser(surveyUser);
	}
	
}
