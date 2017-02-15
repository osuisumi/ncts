package com.haoyu.ncts.resource.web;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.service.IFileInfoService;
import com.haoyu.sip.file.utils.FileUtils;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceRelationService;
import com.haoyu.tip.resource.service.IResourceService;
import com.sun.org.apache.xml.internal.resolver.helpers.PublicId;
import com.sun.xml.internal.fastinfoset.sax.Properties;

@Controller
@RequestMapping("**/resource")
public class ResourceBizController extends AbstractBaseController {
	
	@Resource
	private IResourceService resourceService;
	@Resource
	private IResourceRelationService resourceRelationService;
	@Resource
	private IFileInfoService fileInfoService;
	
	protected String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/study/resource/");
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public String listResources(Resources resource, Model model){
		model.addAttribute("resource", resource);
		model.addAttribute("pageBounds", getPageBounds(12, true));
		model.addAllAttributes(request.getParameterMap());
		return getLogicalViewNamePrefix() + "list_resource";
	}
	
	@RequestMapping(value = "create", method=RequestMethod.GET)
	public String create(Resources resource,Model model){
		model.addAttribute("resource",resource);
		return getLogicalViewNamePrefix() + "edit_resource"; 
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response create(Resources resource){
		return this.resourceService.createResource(resource);
	}
	
	@RequestMapping(value="{id}/edit", method=RequestMethod.GET)
	public String edit(Resources resource,Model model){	
		model.addAttribute("resource",resourceService.viewResource(resource));
		return getLogicalViewNamePrefix() + "edit_resource";
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response update(Resources resource){
		return this.resourceService.updateResource(resource);
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(Resources resource){		
		return this.resourceRelationService.delete(resource.getResourceRelations().get(0).getId());
	}
	
	@RequestMapping(value = "lib", method=RequestMethod.GET)
	public String lib(Resources resource, Model model){
		model.addAttribute("resource",resource);
		model.addAllAttributes(request.getParameterMap());
		this.getPageBounds(10, true);
		return "common/resource/resource_lib"; 
	}
	
	@RequestMapping(value="relation", method=RequestMethod.POST)
	@ResponseBody
	public Response createResourceRelation(ResourceRelation resourceRelation){
		return this.resourceRelationService.create(resourceRelation);
	}
}
