package com.haoyu.ncts.course.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("**/study/course")
public class CourseStudyController extends AbstractBaseController {

	@Resource
	private ICourseService courseService;
	@Resource
	private ISectionService sectionService;

	private String getLogicalViewNamePrefix() {
		return TemplateUtils.getTemplatePath("/study/");
	}
	
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String study(Course course, Model model) {
		course = courseService.getCourse(course.getId());
		if(course == null){
			return "redirect:/error/404.jsp";
		}
		model.addAllAttributes(request.getParameterMap());
		model.addAttribute("pageBounds", getPageBounds(10, true));
		return getLogicalViewNamePrefix() + "study_" + course.getType() + "_course_index";
	}
	
	@RequestMapping(value = "progess", method = RequestMethod.GET)
	public String progess(Model model) {
		List<Section> sections = sectionService.listSectionByCourseId(CSAIdObject.getCSAIdObject().getCid());
		List<String> sectionIds = Collections3.extractToList(sections, "id");
		model.addAttribute("sectionIds", sectionIds);
		return getLogicalViewNamePrefix() + "progess";
	}
	
}
