/**
 * 
 */
package com.haoyu.ncts.qti.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.qti.entity.InteractionOption;
import com.haoyu.aip.qti.entity.MultipleChoiceQuestion;
import com.haoyu.aip.qti.entity.Question;
import com.haoyu.aip.qti.entity.QuestionType;
import com.haoyu.aip.qti.entity.SingleChoiceQuestion;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.aip.qti.entity.TrueFalseQuestion;
import com.haoyu.aip.qti.service.IQuestionService;
import com.haoyu.aip.survey.entity.Survey;
import com.haoyu.aip.survey.entity.SurveyQuestion;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.Collections3;

/**
 * @author lianghuahuang
 *
 */
@Controller
@RequestMapping("**/make/question")
public class QuestionNctsController extends AbstractBaseController {
	@Resource
	private IQuestionService questionService;
	
	@RequestMapping(value="/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Response updateQuestion(@PathVariable String id,HttpServletRequest request){
		Question question = extractQuestion(request);
		question.setId(id);
		return questionService.updateQuestion(question);
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
