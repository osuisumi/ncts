package com.haoyu.ncts.course.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.utils.Collections3;

@Controller
@RequestMapping("**/section")
public class SectionController extends AbstractBaseController{
	
	@Resource
	private ISectionService sectionService;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/make/section/");
	}
	
	@RequestMapping(value="create", method=RequestMethod.GET)
	public String create(Section section, Model model){
		model.addAttribute("section", section);
		return getLogicalViewNamePrefix() + "edit_section";
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Section section, Model model){
		model.addAttribute("section", sectionService.getSection(section.getId()));
		return getLogicalViewNamePrefix() + "edit_section";
	}
	
	@RequestMapping(value="{id}/editSectionConfig", method=RequestMethod.GET)
	public String editSectionConfig(Section section, Model model){
		model.addAttribute("section", sectionService.getSection(section.getId()));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "edit_section_config";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(Section section){
		return sectionService.createSection(section);
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Section section){
		return sectionService.updateSection(section);
	}
	
	@RequestMapping(value="{id}", method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Section section){
		return sectionService.deleteSectionByLogic(section);
	}
	
	@RequestMapping(value="{id}/updateSectionConfig", method=RequestMethod.PUT)
	@ResponseBody
	public Response updateSectionConfig(Section section, String dateTime){
		return sectionService.updateSectionConfig(section, dateTime);
	}

	@RequestMapping(value="{id}/editSectionTime", method=RequestMethod.GET)
	public String editSectionTime(Section section, Model model){
		model.addAttribute("section", sectionService.getSection(section.getId()));
		model.addAllAttributes(request.getParameterMap());
		return TemplateUtils.getTemplatePath("/teach/course/") + "edit_section_time";
	}
	
	@RequestMapping(value="updateBatch", method = RequestMethod.PUT)
	@ResponseBody
	public Response updateBatch(Course course){
		if (Collections3.isNotEmpty(course.getSections())) {
			for (Section section : course.getSections()) {
				sectionService.updateSection(section);
			}
		}
		return Response.successInstance();
	}
}
