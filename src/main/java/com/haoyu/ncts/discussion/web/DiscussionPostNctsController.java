package com.haoyu.ncts.discussion.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

@Controller
@RequestMapping("**/ncts/discussion/post")
public class DiscussionPostNctsController extends AbstractBaseController{
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/study/activity/discussion/");
	}
	
	@Resource
	private IDiscussionPostService discussionPostService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(SearchParam searchParam, Model model){
		model.addAttribute("discussionPosts", discussionPostService.list(searchParam, getPageBounds(10,true)));
		model.addAllAttributes(request.getParameterMap()); 
		return getLogicalViewNamePrefix() + "list_discussion_post";
	}
	
	@RequestMapping(value="child", method = RequestMethod.GET)
	public String listChild(SearchParam searchParam, Model model){
		model.addAttribute("childPosts", discussionPostService.list(searchParam, getPageBounds(Integer.MAX_VALUE, true)));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_child_discussion_post";
	}

	@RequestMapping(value = "{id}/edit", method = RequestMethod.GET)
	public String edit(DiscussionPost discussionPost, Model model){
		model.addAttribute("discussionPost",discussionPostService.get(discussionPost.getId()));
		return getLogicalViewNamePrefix() + "edit_discussion_post";
	}
}
