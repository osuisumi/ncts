package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.excel.utils.StringUtils;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseDirective extends AbstractTemplateDirectiveModel{
	@Resource
	private ICourseService courseService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		String id = getId(params);
		if(StringUtils.isNotEmpty(id)){
			Map<String,Object> parameter = getSelectParam(params);
			if(parameter.containsKey("getStat")){
				env.setVariable("courseModel", new DefaultObjectWrapper().wrap(courseService.getCourse(id,parameter.get("getStat").toString())));
			}else{
				env.setVariable("courseModel", new DefaultObjectWrapper().wrap(courseService.getCourse(id)));
			}
		}
		body.render(env.getOut());
	}

}
