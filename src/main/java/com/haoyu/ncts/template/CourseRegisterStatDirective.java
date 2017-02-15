package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.ncts.course.entity.CourseRegisterStat;
import com.haoyu.ncts.course.service.ICourseRegisterStatService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseRegisterStatDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseRegisterStatService courseRegisterStatService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);

		List<CourseRegisterStat> courseRegisterStats = courseRegisterStatService.findCourseRegisterStats(parameter, pageBounds);
		
		env.setVariable("courseRegisterStats", new DefaultObjectWrapper().wrap(courseRegisterStats));

		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList) courseRegisterStats;
			env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}

		
		body.render(env.getOut());

	}

}
