package com.haoyu.ncts.course.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseRegisterState;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.auth.realm.CacheCleaner;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.resource.entity.Resources;

@Controller
@RequestMapping("**/course")
public class CourseMakeController extends AbstractBaseController{
	
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseRegisterService courseRegisterService;
	@Resource
	private CacheCleaner authRealm;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/make/course/");
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Course course, Model model) {
		model.addAttribute("course", course);
		model.addAttribute("pageBounds", getPageBounds(12, true));
		model.addAttribute("listMode", request.getParameter("listMode"));
		return getLogicalViewNamePrefix() + "list_course";
	}
	
	@RequestMapping(value="list_preview_course" ,method = RequestMethod.GET)
	public String list_preview_course(Course course, Model model) {
		model.addAttribute("course", course);
		model.addAttribute("pageBounds", getPageBounds(12, true));
		model.addAttribute("listMode", request.getParameter("listMode"));
		return getLogicalViewNamePrefix() + "list_preview_course";
	}
	
	@RequestMapping(value="course_recycle", method = RequestMethod.GET)
	public String course_recycle(Course course, Model model) {
		model.addAttribute("course", course);
		model.addAttribute("pageBounds", getPageBounds(5, true));
		return getLogicalViewNamePrefix() + "course_recycle";
	}
	
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String create(Model model) {
		return getLogicalViewNamePrefix() + "edit_course";
	}
	
	@RequestMapping(value="{id}/edit", method = RequestMethod.GET)
	public String create(Model model, Course course) {
		course = courseService.getCourse(course.getId());
		model.addAttribute("course", course);
		return getLogicalViewNamePrefix() + "edit_course";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
	public Response createCourse(Course course) {
		return courseService.createCourse(course);
	}
	
	@RequestMapping(value="{id}", method = RequestMethod.PUT)
	@ResponseBody
	public Response updateCourse(Course course) {
		return courseService.updateCourse(course);
	}
	
	@RequestMapping(value="retrieve", method = RequestMethod.PUT)
	@ResponseBody
	public Response retrieve(Course course) {
		return courseService.retrieveCourse(course);
	}
	
	@RequestMapping(value="deleteByLogic", method = RequestMethod.DELETE)
	@ResponseBody
	public Response deleteByLogic(Course course) {
		return courseService.deleteCourseByLogic(course);
	}
	
	@RequestMapping(value="deleteByPhycics", method = RequestMethod.DELETE)
	@ResponseBody
	public Response deleteByPhycics(String id) {
		return courseService.deleteCourseByPhysics(id);
	}
	
	@RequestMapping(value="getDeletedNum", method = RequestMethod.GET)
	@ResponseBody
	public int getDeletedNum() {
		Map<String, Object> params = Maps.newHashMap();
		params.put("isDeleted", "Y");
		return courseService.getCourseCount(params);
	}
	
	@RequestMapping("{id}/editCourseContent")
	public String editCourseContent(Course course, Model model) {
		course = courseService.getCourse(course.getId());
		model.addAttribute("course", course);
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_" + course.getType() + "_course_content";
	}
	
	@RequestMapping("{id}/editCourseConfig")
	public String editCourseConfig(Course course, Model model) {
		model.addAttribute("course", course);
		return getLogicalViewNamePrefix() + "config/edit_course_config";
	}
	
	@RequestMapping("{id}/listCourseBranch")
	public String listCourseBranch(Course course, Model model) {
		model.addAttribute("course", course);
		model.addAttribute("listMode", request.getParameter("listMode"));
		return getLogicalViewNamePrefix() + "list_course_branch";
	}
	
	@RequestMapping("listResource")
	public String listResource(Resources resource, Model model) {
		model.addAttribute("resource", resource);
		model.addAttribute("pageBounds", getPageBounds(12, true));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "config/list_resource";
	}
	
	@RequestMapping("{id}/preview")
	public String previewCourse(Course course, Model model) {
		CourseRegister courseRegister = new CourseRegister();
		courseRegister.setCourse(course);
		courseRegister.setUser(ThreadContext.getUser());
		courseRegister.setState(CourseRegisterState.PREVIEW);
		Response response = courseRegisterService.createCourseRegister(courseRegister);
		if (response.isSuccess()) {
			authRealm.clearUserCacheById(ThreadContext.getUser().getId());
		}
		model.addAttribute("course", course);
		model.addAttribute("isPreview", true);
		return "redirect:/study/course/"+course.getId();
	}
}
