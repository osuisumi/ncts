/**
 * 
 */
package com.haoyu.ncts.qti.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.qti.entity.InteractionOption;
import com.haoyu.aip.qti.entity.MultipleChoiceQuestion;
import com.haoyu.aip.qti.entity.Question;
import com.haoyu.aip.qti.entity.QuestionFormKey;
import com.haoyu.aip.qti.entity.QuestionType;
import com.haoyu.aip.qti.entity.SingleChoiceQuestion;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.aip.qti.entity.TrueFalseQuestion;
import com.haoyu.aip.qti.service.ITestService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

/**
 * @author lianghuahuang
 *
 */
@Controller
@RequestMapping("**/make/test")
public class TestNctsController extends AbstractBaseController {
	@Resource
	private ITestService testService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/make/test/");
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(){
		return this.getLogicalViewNamePrefix() + "test/edit_test";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(Test test){
		return testService.createTest(test);
	}
	
	@RequestMapping(value="/{id}/addQuestion",method=RequestMethod.POST)
	@ResponseBody
	public Response addTestQuestion(@PathVariable String  id,HttpServletRequest request){
		return testService.addTestQuestion(new Test(id), extractQuestion(request), new QuestionFormKey(request.getParameter("questionFormKey")));
	}
	
	@RequestMapping(value="/{id}/removeQuestion",method=RequestMethod.DELETE)
	@ResponseBody
	public Response removeTestQuestion(@PathVariable String  id,HttpServletRequest request){
		return testService.removeTestQuestion(new Test(id), new QuestionFormKey(request.getParameter("questionFormKey")));
	}
	
	@RequestMapping(value="/{id}/importQuestions",method=RequestMethod.POST)
	@ResponseBody
	public Response importTestQuestions(@PathVariable String  id,HttpServletRequest request){
		String questionsText = request.getParameter("questionsText");
		if(StringUtils.isNotEmpty(questionsText)){
			return testService.importTestQuestions(new Test(id),questionsText, new QuestionFormKey(request.getParameter("questionFormKey")));
		}else{
			return Response.failInstance().responseMsg("questionsText is Null!");
		}
	}
	
	@RequestMapping(value="/{id}/updateTestQuestionSequence", method=RequestMethod.PUT)
	@ResponseBody
	public Response updateTestQuestionSequence(@PathVariable String  id,HttpServletRequest request){
		return testService.updateTestQuestionSequence(new Test(id),new QuestionFormKey(request.getParameter("targetQfk")), new QuestionFormKey(request.getParameter("sourceQfk")));
	}
	
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Test test){
		return testService.updateTest(test);
	}
	
	private Question extractQuestion(HttpServletRequest request){
		String quesType = request.getParameter("quesType");
		if(quesType.equals(QuestionType.SINGLE_CHOICE.toString())){
			SingleChoiceQuestion question = new SingleChoiceQuestion();
			question.setTitle(request.getParameter("title"));
			question.setText(request.getParameter("title"));
			question.setScore(Double.valueOf(request.getParameter("score")));
			question.setCorrectFeedback(request.getParameter("correctFeedback"));
			question.setIncorrectFeedback(request.getParameter("incorrectFeedback"));
			String correctOption = request.getParameter("correctOption");
			String[] optionTexts = request.getParameterValues("interactionOption.text");
			for(int i=0;i<optionTexts.length;i++){
				question.getInteractionOptions().add(new InteractionOption("Choice"+i,optionTexts[i]));
			}
			question.setCorrectOption("Choice"+(Integer.parseInt(correctOption)));
			return question;
		}else if(quesType.equals(QuestionType.TRUE_FALSE.toString())){
			TrueFalseQuestion question = new TrueFalseQuestion();
			question.setTitle(request.getParameter("title"));
			question.setText(request.getParameter("title"));
			question.setScore(Double.valueOf(request.getParameter("score")));
			question.setCorrectFeedback(request.getParameter("correctFeedback"));
			question.setIncorrectFeedback(request.getParameter("incorrectFeedback"));
			String correctOption = request.getParameter("correctOption");
			String[] optionTexts = request.getParameterValues("interactionOption.text");
			for(int i=0;i<optionTexts.length;i++){
				question.getInteractionOptions().add(new InteractionOption("Choice"+i,optionTexts[i]));
			}
			question.setCorrectOption("Choice"+(Integer.parseInt(correctOption)));
			return question;
		}else if(quesType.equals(QuestionType.MULTIPLE_CHOICE.toString())){
			MultipleChoiceQuestion question = new MultipleChoiceQuestion();
			question.setTitle(request.getParameter("title"));
			question.setText(request.getParameter("title"));
			question.setScore(Double.valueOf(request.getParameter("score")));
			question.setCorrectFeedback(request.getParameter("correctFeedback"));
			question.setIncorrectFeedback(request.getParameter("incorrectFeedback"));
			String[] correctOptions = request.getParameterValues("correctOption");
			String[] optionTexts = request.getParameterValues("interactionOption.text");
			for(int i=0;i<optionTexts.length;i++){
				question.getInteractionOptions().add(new InteractionOption("Choice"+i,optionTexts[i]));
			}
			for(int i=0;i<correctOptions.length;i++){
				question.getCorrectOptions().add("Choice"+(Integer.parseInt(correctOptions[i])));
			}
			return question;
		}
		return null;
	}
	
	
}
