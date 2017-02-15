package com.haoyu.ncts.course.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.course.utils.CourseRegisterState;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("**/teach/course")
public class CourseTeachController extends AbstractBaseController{
	
	@Resource
	private ICourseService courseService;
	@Resource
	private ISectionService sectionService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/teach/course/");
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String list(Course course, Model model) {
		model.addAttribute("course", course);
		model.addAttribute("pageBounds", getPageBounds(12, true));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_course";
	}
	
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String study(Course course, Model model) {
		course = courseService.getCourse(course.getId());
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "teach_course_index";
	}
	
	@RequestMapping(value = "statistic", method = RequestMethod.GET)
	public String statistic(Model model) {
		return getLogicalViewNamePrefix() + "statistic";
	}
	
	@RequestMapping(value="courseRegister/statistic",method=RequestMethod.GET)
	public String listCourseRegisterStatistic(Model model,String courseResultState,String realName){
		CourseRegister courseRegister = new CourseRegister();
		Course course = new Course(CSAIdObject.getCSAIdObject().getCid());
		courseRegister.setCourse(course);
		courseRegister.setState(CourseRegisterState.PASS);
		model.addAttribute("courseRegister", courseRegister);
		model.addAttribute("courseResultState", courseResultState);
		model.addAttribute("realName", realName);
		this.getPageBounds(10, true);
		return getLogicalViewNamePrefix() + "list_course_register_statistic";
	}
	
	@RequestMapping(value = "progess", method = RequestMethod.GET)
	public String progess(String userId, Model model) {
		List<Section> sections = sectionService.listSectionByCourseId(CSAIdObject.getCSAIdObject().getCid());
		List<String> sectionIds = Collections3.extractToList(sections, "id");
		model.addAttribute("sectionIds", sectionIds);
		model.addAttribute("userId", userId);
		return getLogicalViewNamePrefix() + "progess";
	}
}
