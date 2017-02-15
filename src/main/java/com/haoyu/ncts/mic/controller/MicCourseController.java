package com.haoyu.ncts.mic.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.note.entity.Note;
import com.haoyu.tip.faq.entity.FaqQuestion;

@Controller
@RequestMapping("**/study/course/mic")
public class MicCourseController extends AbstractBaseController{

	@Resource
	private IDiscussionPostService discussionPostService;

	@Resource
	private IDiscussionService discussionService;
	
	private String getLogicViewNamePerfix() {
		return TemplateUtils.getTemplatePath("/study/mic/");
	}

	@RequestMapping(value="listDiscussion", method = RequestMethod.GET)
	public String listDiscussion(SearchParam searchParam,Model model) {
		model.addAttribute(searchParam);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "discussion/list_discussion";
	}

	@RequestMapping(value = "{id}/viewDiscussion", method = RequestMethod.GET)
	public String view(@PathVariable String id,Model model) {
		model.addAttribute("discussionId", id);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "discussion/view_discussion";
	}
	
	@RequestMapping(value="post/child",method=RequestMethod.GET)
	public String listChildPost(SearchParam searchParam,Model model){
		model.addAttribute("childPosts", discussionPostService.list(searchParam, getPageBounds(Integer.MAX_VALUE, true)));
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "discussion/list_child_discussion_post";
	}
	
	@RequestMapping(value="listNote", method = RequestMethod.GET)
	public String listNote(Note note, Model model) {
		model.addAttribute(note);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "note/note";
	}
	
	@RequestMapping(value="listFaq", method = RequestMethod.GET)
	public String listFaq(FaqQuestion faqQuestion, Model model) {
		model.addAttribute(faqQuestion);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "faq/faq";
	}
	
	@RequestMapping(value="viewTest", method = RequestMethod.GET)
	public String viewTest(Test test, Model model) {
		model.addAttribute(test);
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "test/view_test";
	}
	
}
