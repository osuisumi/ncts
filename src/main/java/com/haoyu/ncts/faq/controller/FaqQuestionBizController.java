package com.haoyu.ncts.faq.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.faq.controller.param.FaqQuestionParam;
import com.haoyu.ncts.faq.service.IFaqQuestionNctsService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.faq.entity.FaqQuestion;
import com.haoyu.tip.faq.service.IFaqQuestionService;

@Controller
@RequestMapping("**/faq_question")
public class FaqQuestionBizController extends AbstractBaseController{
	
	@Resource
	private IFaqQuestionNctsService faqQuestionNctsService;
	
	@Resource
	private IFaqQuestionService faqQuestionService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/study/faq/");
	}

	@RequestMapping(method=RequestMethod.GET)
	public String listFaqQuestion(FaqQuestionParam faqQuestionParam, Model model){
		model.addAttribute("faqQuestion", faqQuestionParam);
		getPageBounds(5, true);
		return getLogicalViewNamePrefix() + "list_faqQuestion";
	}
	
	
	@RequestMapping(value="api",method = RequestMethod.GET)
	@ResponseBody
	public List<FaqQuestion> api(FaqQuestionParam faqQuestionParam,Model model){
		List<FaqQuestion> faqQuestions = this.faqQuestionNctsService.listFaqQuestion(faqQuestionParam, getPageBounds(5,true),true);
		return faqQuestions;
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(FaqQuestion faqQuestion){
		return faqQuestionService.createFaqQuestion(faqQuestion);
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(FaqQuestion faqQuestion){
		return faqQuestionService.updateFaqQuestion(faqQuestion);
	}
	
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(FaqQuestion faqQuestion){
		return this.faqQuestionService.deleteFaqQuestion(faqQuestion);
	}
	
	@RequestMapping(method = RequestMethod.DELETE)
	@ResponseBody
	public Response deleteBatch(FaqQuestion faqQuestion){
		return this.faqQuestionService.deleteFaqQuestion(faqQuestion);
	}
	
	@RequestMapping(value="course/{courseId}",method=RequestMethod.GET)
	public String loadCourseFaqQuestion(@PathVariable String courseId,Model model){
		getPageBounds(10, true);
		model.addAttribute("cid", courseId);
		return this.getLogicalViewNamePrefix() + "faq";
	}

}
