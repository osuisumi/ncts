package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.SimpleSequence;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseRegisterStateDataDirective implements TemplateDirectiveModel{
	
	@Resource
	private ICourseRegisterService courseRegisterService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		if(ThreadContext.getUser() != null){
			Map<String,Object> stateResult = Maps.newHashMap(); 
			Map<String,Object> registerIdResult = Maps.newHashMap();
			Map<String,Object> param = Maps.newHashMap();
			param.put("userId",ThreadContext.getUser().getId());
			List<CourseRegister> courseRegisters = Lists.newArrayList();
			if(params.containsKey("courseId") && params.get("courseId")!=null){
				if(params.containsKey("relationId")&&params.get("relationId")!=null){
					param.put("relationId",params.get("relationId").toString());
				}
				String courseId = params.get("courseId").toString();
				param.put("courseId",courseId);
				courseRegisters = courseRegisterService.listCourseRegister(param, null);
			}
			if(params.containsKey("courses") && params.get("courses")!=null){
				SimpleSequence ss = (SimpleSequence) params.get("courses");
				List<Course> courses = ss.toList();
				if(CollectionUtils.isNotEmpty(courses)){
					List<String> ids = Collections3.extractToList(courses, "id");
					param.put("ids",ids);
					courseRegisters = courseRegisterService.listCourseRegister(param, null);
				}
			}
			if(CollectionUtils.isNotEmpty(courseRegisters)){
				for(CourseRegister cr:courseRegisters){
					stateResult.put(cr.getCourse().getId(), cr.getState());
					registerIdResult.put(cr.getCourse().getId(), cr.getId());
				}
				env.setVariable("states", new DefaultObjectWrapper().wrap(stateResult));
				env.setVariable("registerIds", new DefaultObjectWrapper().wrap(registerIdResult));
			}
		}
		body.render(env.getOut());
	}

}
