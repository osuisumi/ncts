package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateBooleanModel;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class LeadCourseContentDataDirective implements TemplateDirectiveModel {

	@Resource
	private ISectionService sectionService;
	@Resource
	private ICourseService courseService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IActivityService activityService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		String courseId = null;
		if (params.containsKey("courseId")) {
			courseId = params.get("courseId").toString();
			param.put("courseId", courseId);
			Course course = courseService.getCourse(courseId);
			env.setVariable("course", new DefaultObjectWrapper().wrap(course));
		}
		if(params.containsKey("parentId")){
			String parentId = params.get("parentId").toString();
			param.put("parentId", parentId);
		}
		PageBounds pageBounds = new PageBounds();
		pageBounds.setLimit(Integer.MAX_VALUE);
		pageBounds.setOrders(Order.formString("SORT_NO,CREATE_TIME"));
		List<Section> sections = sectionService.listSection(param, true, pageBounds);
		env.setVariable("sections", new DefaultObjectWrapper().wrap(sections));
		
		//如果getResult=true, 查询每个节的活动数, 以及当前用户的活动完成情况
		if (Collections3.isNotEmpty(sections) && params.containsKey("getResult")) {
			TemplateBooleanModel model = (TemplateBooleanModel) params.get("getResult");
			if (model != null) {
				boolean getResult = model.getAsBoolean();
				if (getResult) {
					param = Maps.newHashMap();
					List<Section> childSections = Lists.newArrayList();
					for (Section section : sections) {
						childSections.addAll(section.getChildSections());
					}
					if (Collections3.isNotEmpty(childSections)) {
						List<String> relationIds = Collections3.extractToList(childSections, "id");
						param.put("relationIds", relationIds);
						param.put("courseId", courseId);
						List<Activity> activities = activityService.listActivity(param, false, null);
						Map<String, Integer> activityNumMap = Maps.newHashMap();
						for (Activity activity : activities) {
							String sectionId = activity.getRelation().getId();
							if (!activityNumMap.containsKey(sectionId)) {
								activityNumMap.put(sectionId, 0);
							}
							int num = activityNumMap.get(sectionId);
							activityNumMap.put(sectionId, num+1);
						}
						env.setVariable("activityNumMap", new DefaultObjectWrapper().wrap(activityNumMap));
						
						param = Maps.newHashMap();
						param.put("relationId", courseId);
						param.put("creator", ThreadContext.getUser().getId());
						List<ActivityResult> activityResults = activityResultService.listActivityResult(param, null);
						Map<String, List<ActivityResult>> activityResultMap = Maps.newHashMap();
						for (ActivityResult activityResult : activityResults) {
							if (activityResult.getActivity().getRelation() != null) {
								String sectionId = activityResult.getActivity().getRelation().getId();
								if (!activityResultMap.containsKey(sectionId)) {
									activityResultMap.put(sectionId, Lists.newArrayList());
								}
								activityResultMap.get(sectionId).add(activityResult);
							}
						}
						env.setVariable("activityResultMap", new DefaultObjectWrapper().wrap(activityResultMap));
					}
				}
			}
		}
		
		body.render(env.getOut());
	}

}
