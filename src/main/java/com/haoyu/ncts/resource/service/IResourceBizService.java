package com.haoyu.ncts.resource.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;

public interface IResourceBizService {
	List<Resources> listResource(Resources resource, PageBounds pageBounds);

	List<ResourceRelation> listResourceRelation(Resources resource, PageBounds pageBounds);
}
