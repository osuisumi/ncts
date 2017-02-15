package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.print.DocFlavor.STRING;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseAuthorizeRole;
import com.haoyu.ncts.course.utils.CourseState;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseNumDataDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseService courseService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		int allNum = courseService.getCourseCount(parameter);
		env.setVariable("allNum", new DefaultObjectWrapper().wrap(allNum));
		
		String role = (String) parameter.get("courseAuthorizeRole");
		if (CourseAuthorizeRole.MAKER.equals(role)) {
			parameter.put("state", CourseState.EDITING  + CourseState.REJECT);
			int editingNum = courseService.getCourseCount(parameter);
			parameter.put("state", CourseState.PUBLISHED + "," + CourseState.PASS);
			int publishedNum = courseService.getCourseCount(parameter);
			parameter.remove("state"); 
			parameter.put("isDeleted", "Y");
			int deletedNum = courseService.getCourseCount(parameter);
			
			env.setVariable("editingNum", new DefaultObjectWrapper().wrap(editingNum));
			env.setVariable("publishedNum", new DefaultObjectWrapper().wrap(publishedNum));
			env.setVariable("deletedNum", new DefaultObjectWrapper().wrap(deletedNum));
		}else if(CourseAuthorizeRole.TEACHER.equals(role)){
			parameter.remove("isDeleted");
			parameter.put("startTimeGreaterThan", new Date());
			int notBegunNum = courseService.getCourseCount(parameter);
			parameter.remove("startTimeGreaterThan");
			parameter.put("startTimeLessThanOrEquals", new Date());
			parameter.put("endTimeGreaterThanOrEquals", new Date());
			int beginningNum = courseService.getCourseCount(parameter);
			parameter.remove("startTimeLessThanOrEquals");
			parameter.remove("endTimeGreaterThanOrEquals");
			parameter.put("endTimeLessThan", new Date());
			int endNum = courseService.getCourseCount(parameter);
			
			env.setVariable("notBegunNum", new DefaultObjectWrapper().wrap(notBegunNum));
			env.setVariable("beginningNum", new DefaultObjectWrapper().wrap(beginningNum));
			env.setVariable("endNum", new DefaultObjectWrapper().wrap(endNum));
		}
		body.render(env.getOut());
	}

}
