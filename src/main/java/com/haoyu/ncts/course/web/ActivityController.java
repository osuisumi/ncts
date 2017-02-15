package com.haoyu.ncts.course.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityType;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.IActivityBizService;
import com.haoyu.ncts.course.web.param.ActivityParam;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("**/activity")
public class ActivityController extends AbstractBaseController {
	
	@Resource
	private IActivityBizService activityBizService;
	@Resource
	private IActivityService activityService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/make/activity/");
	}

	@RequestMapping(method = RequestMethod.GET)
	public String list(Activity activity, Model model){
		model.addAttribute("activity", activity);
		return getLogicalViewNamePrefix() + "list_activity";
	}
	
	@RequestMapping(value="{id}" ,method = RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Activity activity){
		return activityService.deleteActivityByLogic(activity);
	}
	
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String create(Activity activity, Model model){
		model.addAttribute("activity", activity);
		model.addAllAttributes(request.getParameterMap());
		if (ActivityType.DISCUSSION.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "discussion/edit_discussion";
		}else if (ActivityType.VIDEO.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "video/edit_video";
		}else if (ActivityType.HTML.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "text/edit_html";
		}else if (ActivityType.ASSIGNMENT.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "assignment/edit_assignment";
		}else if(ActivityType.SURVEY.equals(activity.getType())){
			return getLogicalViewNamePrefix() + "survey/edit_survey";
		}
		return getLogicalViewNamePrefix() + activity.getType()+"/edit_"+activity.getType();
	}
	
	@RequestMapping(value="{id}/edit", method = RequestMethod.GET)
	public String edit(Activity activity, Model model){
		activity = activityService.getActivity(activity.getId());
		model.addAttribute("activity", activity);
		model.addAllAttributes(request.getParameterMap());
		if (ActivityType.DISCUSSION.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "discussion/edit_discussion";
		}else if (ActivityType.VIDEO.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "video/edit_video";
		}else if (ActivityType.HTML.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "text/edit_html";
		}else if (ActivityType.ASSIGNMENT.equals(activity.getType())) {
			return getLogicalViewNamePrefix() + "assignment/edit_assignment";
		}else if(ActivityType.SURVEY.equals(activity.getType())){
			return getLogicalViewNamePrefix() + "survey/edit_survey";
		}
		return getLogicalViewNamePrefix() + activity.getType()+"/edit_"+activity.getType();
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response create(ActivityParam activityParam){
		return activityBizService.createActivity(activityParam);
	}
	
	@RequestMapping(value="{activity.id}", method = RequestMethod.PUT)
	@ResponseBody
	public Response update(ActivityParam activityParam){
		return activityBizService.updateActivity(activityParam);
	}
	
	@RequestMapping(value="{id}/update", method = RequestMethod.PUT)
	@ResponseBody
	public Response updateActivity(Activity activity){
		return activityService.updateActivity(activity, false);
	}
	
	@RequestMapping(value="updateBatch", method = RequestMethod.PUT)
	@ResponseBody
	public Response updateBatch(Section section){
		if (Collections3.isNotEmpty(section.getActivities())) {
			for (Activity activity : section.getActivities()) {
				activityService.updateActivity(activity, false);
			}
		}
		return Response.successInstance();
	}
}
