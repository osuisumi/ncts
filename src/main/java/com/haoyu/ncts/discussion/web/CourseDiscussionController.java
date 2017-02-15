package com.haoyu.ncts.discussion.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.discussion.entity.DiscussionPost;
import com.haoyu.aip.discussion.service.IDiscussionPostService;
import com.haoyu.aip.discussion.service.IDiscussionService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.core.web.SearchParam;

@Controller
@RequestMapping("**/course/discussion")
public class CourseDiscussionController extends AbstractBaseController {
	
	@Resource
	private IDiscussionPostService discussionPostService;

	@Resource
	private IDiscussionService discussionService;
	
	private String getLogicViewNamePerfix() {
		return TemplateUtils.getTemplatePath("/study/discussion/");
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(SearchParam searchParam,Model model) {
		model.addAttribute(searchParam);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "list_discussion";
	}

	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String view(@PathVariable String id,Model model) {
		model.addAttribute("discussionId", id);
		getPageBounds(10, true);
		return getLogicViewNamePerfix() + "view_discussion";
	}
	
	@RequestMapping(value="post/{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Response update(DiscussionPost discussionPost){
		return discussionPostService.updateDiscussionPost(discussionPost);
	}
	
	@RequestMapping(value="post/{id}",method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(DiscussionPost discussionPost){
		return discussionPostService.deleteDiscussionPost(discussionPost);
	}
	
	@RequestMapping(value="post/child",method=RequestMethod.GET)
	public String listChildPost(SearchParam searchParam,Model model){
		model.addAttribute("childPosts", discussionPostService.list(searchParam, getPageBounds(Integer.MAX_VALUE, true)));
		model.addAllAttributes(request.getParameterMap());
		return getLogicViewNamePerfix() + "list_child_discussion_post";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response save(Discussion discussion){
		return discussionService.createDiscussion(discussion);
	}
	
	@RequestMapping(value = "post/{id}/edit", method = RequestMethod.GET)
	public String edit(DiscussionPost discussionPost, Model model){
		model.addAttribute("discussionPost",discussionPostService.get(discussionPost.getId()));
		return getLogicViewNamePerfix() + "edit_discussion_post";
	}

}
