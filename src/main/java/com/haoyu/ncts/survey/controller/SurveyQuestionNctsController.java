package com.haoyu.ncts.survey.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.survey.entity.Survey;
import com.haoyu.aip.survey.entity.SurveyQuestion;
import com.haoyu.aip.survey.service.ISurveyQuestionService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("**/survey/question")
public class SurveyQuestionNctsController extends AbstractBaseController {
	@Resource
	private ISurveyQuestionService surveyQuestionService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/make/activity/survey/");
	}

	@RequestMapping(value="saveSurveyQuestions",method=RequestMethod.POST)
	@ResponseBody
	public Response createSurveyQuestions(Survey survey){
		return surveyQuestionService.createSurveyQuestions(survey);
	}
	
	@RequestMapping(value="goImport",method=RequestMethod.GET)
	public String importPage(String surveyId,Model model){
		model.addAttribute("surveyId", surveyId);
		return this.getLogicalViewNamePrefix() + "import_surveyQuestion";
	}
	
	@RequestMapping(value="importFromString",method=RequestMethod.POST)
	@ResponseBody
	public Response importSurveyQuestionFromString(String input,String surveyId){
		return surveyQuestionService.importSurveyQuestionsFromString(input,surveyId);
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response deleteQuestion(SurveyQuestion surveyQuestion){
		return surveyQuestionService.deleteSurveyQuestion(surveyQuestion);
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response createSurveyQuestion(SurveyQuestion surveyQuestion){
		return surveyQuestionService.createSurveyQuestion(surveyQuestion);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response updateSurveyQuestion(SurveyQuestion surveyQuestion){
		return surveyQuestionService.updateSurveyQuestion(surveyQuestion);
	}
	
	@RequestMapping(value="updateBatch" ,method=RequestMethod.PUT)
	@ResponseBody
	public Response updateBatch(Survey survey){
		if (Collections3.isNotEmpty(survey.getQuestions())) {
			for (SurveyQuestion surveyQuestion : survey.getQuestions()) {
				surveyQuestionService.updateSurveyQuestion(surveyQuestion);
			}
		}
		return Response.successInstance();
	}

}
