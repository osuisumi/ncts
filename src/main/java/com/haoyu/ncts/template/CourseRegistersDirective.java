package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.entity.CourseResult;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.ncts.course.service.ICourseResultService;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseRegistersDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseRegisterService courseRegisterService;
	@Resource
	private ICourseResultService courseResultService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		List<CourseRegister> courseRegisters = courseRegisterService.listCourseRegister(parameter, pageBounds);
		env.setVariable("courseRegisters", new DefaultObjectWrapper().wrap(courseRegisters));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) courseRegisters;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		
		if(Collections3.isNotEmpty(courseRegisters)){
			if (parameter.containsKey("getResult")) {
				boolean getResult = (boolean) parameter.get("getResult");
				if (getResult) {
					List<User> users = Collections3.extractToList(courseRegisters, "user");
					List<String> userIds = Collections3.extractToList(users, "id");
					Map<String, Object> param = Maps.newHashMap();
					param.put("userIds", userIds);
					param.put("courseId", parameter.get("courseId"));
					Map<String, CourseResult> courseResultMap = courseResultService.mapCourseResult(param);
					env.setVariable("courseResultMap" , new DefaultObjectWrapper().wrap(courseResultMap));
				}
			}
		}
		body.render(env.getOut());
	}
}
