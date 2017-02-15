package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseResultSettingsDataDirective implements TemplateDirectiveModel{
	
	@Resource
	private ISectionService sectionService;
	@Resource
	private IActivityService activityService;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Integer> activityMap = Maps.newHashMap();
		if (params.containsKey("courseId")) {
			String courseId = params.get("courseId").toString();
			List<Section> sections = sectionService.listSectionByCourseId(courseId);
			List<String> relationIds = Collections3.extractToList(sections, "id");
			if (Collections3.isNotEmpty(relationIds)) {
				Map<String, Object> param = Maps.newHashMap();
				param.put("relationIds", relationIds);
				List<Activity> activities = activityService.listActivity(param, false, null);
				if (Collections3.isNotEmpty(activities)) {
					for (Activity activity : activities) {
						if (!activityMap.containsKey(activity.getType())) {
							activityMap.put(activity.getType(), 0);
						}
						int num = activityMap.get(activity.getType());
						activityMap.put(activity.getType(), num + 1);
					}
				}
			}
		}
		env.setVariable("activityMap" , new DefaultObjectWrapper().wrap(activityMap));
		body.render(env.getOut());
	}

}
