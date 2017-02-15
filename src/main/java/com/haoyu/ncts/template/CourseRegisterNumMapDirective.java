package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseRegisterNumMapDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseRegisterService courseRegisterService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		Map<String, Integer> courseRegisterNumMap = courseRegisterService.mapCourseRegisterNum(parameter);
		env.setVariable("courseRegisterNumMap", new DefaultObjectWrapper().wrap(courseRegisterNumMap));
		body.render(env.getOut());
	}
}
