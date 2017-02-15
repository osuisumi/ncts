package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CoursesDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseService courseService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String,Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		if(params.containsKey("timeParam")){
			String timeParam = params.get("timeParam").toString();
			if (StringUtils.isNotEmpty(timeParam)) {
				if ("notBegun".equals(timeParam)) {
					parameter.put("startTimeGreaterThan", new Date());
				}else if("beginning".equals(timeParam)){
					parameter.put("startTimeLessThanOrEquals", new Date());
					parameter.put("endTimeGreaterThanOrEquals", new Date());
				}else if("end".equals(timeParam)){
					parameter.put("endTimeLessThan", new Date());
				}
			}
		}  
		List<Course> courses = courseService.listCourse(parameter, pageBounds);
		env.setVariable("courses", new DefaultObjectWrapper().wrap(courses));
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)courses;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		body.render(env.getOut());
	}

}
