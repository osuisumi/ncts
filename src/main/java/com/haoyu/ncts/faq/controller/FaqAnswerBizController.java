package com.haoyu.ncts.faq.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.faq.entity.FaqAnswer;
import com.haoyu.tip.faq.service.IFaqAnswerService;

@Controller
@RequestMapping("**/faq_answer")
public class FaqAnswerBizController extends AbstractBaseController{
	
	@Resource
	private IFaqAnswerService faqAnswerService;

//	@RequestMapping(method=RequestMethod.GET)
//	public String listFaqQuestion(FaqQuestion faqQuestion, Model model){
//		List<FaqQuestion> faqQuestions = faqQuestionService.listFaqQuestion(faqQuestion, getPageBounds(3,true));
//		model.addAttribute("faqQuestions", faqQuestions);
//		return "faq/listFaqQuestion";
//	}
//	
//	@RequestMapping(value="more", method=RequestMethod.GET)
//	public String listMoreFaqQuestion(FaqQuestion faqQuestion, Model model){
//		List<FaqQuestion> faqQuestions = faqQuestionService.listFaqQuestion(faqQuestion, getPageBounds(10,true));
//		model.addAttribute("faqQuestions", faqQuestions);
//		return "faq/listMoreFaqQuestion";
//	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response saveFaqQuestion(FaqAnswer faqAnswer){
		return faqAnswerService.create(faqAnswer);
	}
	
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Response deleteFaqQuestion(@PathVariable String id){
		return this.faqAnswerService.delete(id);
	}

}
