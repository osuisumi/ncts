package com.haoyu.ncts.template;

import java.io.IOException;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.resource.service.IResourceBizService;
import com.haoyu.ncts.utils.PageSplitUtils;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.tip.resource.entity.ResourceRelation;
import com.haoyu.tip.resource.entity.Resources;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class ResourceDataDirective implements TemplateDirectiveModel {

	@Resource
	private ISectionService sectionService;
	@Resource
	private IResourceBizService resourseBizService; 
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		Map<String, String> sectionTitles = Maps.newHashMap();
		if (params.containsKey("courseId")) {
			String courseId = params.get("courseId").toString();
			param.put("courseId", courseId);
			PageBounds pageBounds = new PageBounds();
			pageBounds.setLimit(Integer.MAX_VALUE);
			pageBounds.setOrders(Order.formString("SORT_NO,CREATE_TIME"));
			List<Section> sections = sectionService.listSection(param, true, pageBounds);
			for (Section section : sections) {
				for (Section s : section.getChildSections()) {
					sectionTitles.put(s.getId(), s.getTitle());
				}
			}
			env.setVariable("sections", new DefaultObjectWrapper().wrap(sections));
			env.setVariable("sectionTitles", new DefaultObjectWrapper().wrap(sectionTitles));
		}
		if (params.containsKey("resource") && params.get("resource") != null) {
			BeanModel beanModel = (BeanModel) params.get("resource");
			if (beanModel != null) {
				Resources resource = (Resources) beanModel.getWrappedObject();
				//第一次访问按课程查询
				if(resource.getResourceRelations().size()  == 0){
					ResourceRelation resourceRelation = new ResourceRelation();
					resourceRelation.setRelation(new Relation(param.get("courseId").toString(),"course"));
					resource.setResourceRelations(Lists.newArrayList(resourceRelation));
				}
				PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
				List<Resources> resources = resourseBizService.listResource(resource, pageBounds);
				env.setVariable("resources", new DefaultObjectWrapper().wrap(resources));
				if (pageBounds != null && pageBounds.isContainsTotalCount()) {
					PageList pageList = (PageList)resources;
					env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
				}
			}
		}
		body.render(env.getOut());
	}
}
