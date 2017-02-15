package com.haoyu.ncts.resource.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.resource.service.IResourceBizService;
import com.haoyu.ncts.resource.utils.ResourceRelationRelationType;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.sip.file.entity.FileInfo;
import com.haoyu.sip.file.service.IFileService;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.tip.resource.dao.IResourceDao;
import com.haoyu.tip.resource.dao.IResourceRelationDao;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;
import com.haoyu.tip.resource.service.IResourceRelationService;

@Service
public class ResourceBizServiceImpl implements IResourceBizService {
	
	@Resource
	private IResourceDao resourceDao;
	@Resource
	private ISectionService sectionServiceImpl;
	@Resource
	private IFileService fileServiceImpl;
	@Resource
	private IResourceRelationService resourceRelationService;
	
	@Override
	public List<Resources> listResource(Resources resource, PageBounds pageBounds) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<String> relationIds = Lists.newArrayList();
		if("course".equals(resource.getResourceRelations().get(0).getRelation().getType())){
			relationIds = Collections3.extractToList(sectionServiceImpl.listSectionByCourseId(resource.getResourceRelations().get(0).getRelation().getId()),"id");
			if (relationIds.size() == 0) {
				relationIds.add("");
			}
		}else {
			relationIds = Lists.newArrayList(resource.getResourceRelations().get(0).getRelation().getId());
		}
		relationIds.add(resource.getResourceRelations().get(0).getRelation().getId().toString().trim());
		param.put("relationIds", relationIds);
		if(resource.getTitle() != null && resource.getTitle().trim() != ""){
			param.put("title", resource.getTitle().trim());
		}
//		List<String> relationTypes = Lists.newArrayList();
//		relationTypes.add(ResourceRelationRelationType.SECTION);
//		relationTypes.add(ResourceRelationRelationType.COURSE);
//		param.put("relationTypes", relationTypes);
		List<Resources> resources = resourceDao.select(param, pageBounds);
		Relation relation = new Relation();
		for (int i=0;i<resources.size();i++) {
			relation.setId(resources.get(i).getId());
			relation.setType("resources");
			List<FileInfo> fileInfos = fileServiceImpl.listFileInfoByRelation(relation);
			resources.get(i).setFileInfos(fileInfos);
		}
		return resources;
	}

	@Override
	public List<ResourceRelation> listResourceRelation(Resources resource, PageBounds pageBounds) {
		SearchParam searchParam  = new SearchParam();
		List<String> relationIds = Lists.newArrayList();
		if("course".equals(resource.getResourceRelations().get(0).getRelation().getType())){
			relationIds = Collections3.extractToList(sectionServiceImpl.listSectionByCourseId(resource.getResourceRelations().get(0).getRelation().getId()),"id");
			if (relationIds.size() == 0) {
				relationIds.add("");
			}
		}else {
			relationIds = Lists.newArrayList(resource.getResourceRelations().get(0).getRelation().getId());
		}
		relationIds.add(resource.getResourceRelations().get(0).getRelation().getId().toString().trim());
		searchParam.getParamMap().put("relationIds", relationIds);
		if(resource.getTitle() != null && resource.getTitle().trim() != ""){
			searchParam.getParamMap().put("title", resource.getTitle().trim());
		}
		List<ResourceRelation> resourceRelations = resourceRelationService.list(searchParam, pageBounds);
		Relation relation = new Relation();
		for (int i=0;i<resourceRelations.size();i++) {
			relation.setId(resourceRelations.get(i).getResource().getId());
			relation.setType("resources");
			List<FileInfo> fileInfos = fileServiceImpl.listFileInfoByRelation(relation);
			resourceRelations.get(i).getResource().setFileInfos(fileInfos);
		}
		return resourceRelations;
	}

}
