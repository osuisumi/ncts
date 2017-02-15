package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.ncts.utils.PageSplitUtils;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseRegisterDataDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseRegisterService courseRegisterService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		List<CourseRegister> result = Lists.newArrayList();
		if (params.containsKey("courseRegister") && params.get("courseRegister") != null) {
			PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
			result = courseRegisterService.listCourseRegister(getParameter(params), pageBounds);
			if (pageBounds != null && pageBounds.isContainsTotalCount()) {
				PageList pageList = (PageList) result;
				env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
			}
		}
		env.setVariable("courseRegisters", new DefaultObjectWrapper().wrap(result));
		body.render(env.getOut());
	}

	private Map<String, Object> getParameter(Map params) {
		Map<String, Object> parameter = getSelectParam(params);
		BeanModel beanModel = (BeanModel) params.get("courseRegister");
		CourseRegister courseRegister = (CourseRegister) beanModel.getWrappedObject();
		if (courseRegister.getCourse() != null && StringUtils.isNotEmpty(courseRegister.getCourse().getId())) {
			parameter.put("courseId", courseRegister.getCourse().getId());
		}
		if (courseRegister.getUser() != null && StringUtils.isNotEmpty(courseRegister.getUser().getId())) {
			parameter.put("userId", courseRegister.getUser().getId());
		}
		if (courseRegister.getState() != null && StringUtils.isNotEmpty(courseRegister.getState())) {
			parameter.put("state", courseRegister.getState());
		}
		return parameter;
	}

}
