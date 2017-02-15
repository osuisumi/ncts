package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityType;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.aip.qti.entity.TestDelivery;
import com.haoyu.aip.qti.service.ITestService;
import com.haoyu.aip.video.entity.Video;
import com.haoyu.aip.video.entity.VideoRelation;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.IActivityBizService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.web.param.ActivityParam;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class MicCourseContentDataDirective implements TemplateDirectiveModel {

	@Resource
	private IActivityService activityService;
	@Resource
	private ICourseService courseService;
	@Resource
	private IActivityBizService activityBizService;
	@Resource
	private ITestService testService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		if (params.containsKey("courseId")) {
			String courseId = params.get("courseId").toString();
			param.put("relationId", courseId);
			Course course = courseService.getCourse(courseId);
			env.setVariable("course", new DefaultObjectWrapper().wrap(course));
			
			PageBounds pageBounds = new PageBounds();
			pageBounds.setLimit(Integer.MAX_VALUE);
			List<Activity> activities = activityService.listActivity(param, true, pageBounds);
			//首次编辑微课, 自动创建微视频和测验
			if (Collections3.isEmpty(activities)) {
				ActivityParam activityParam = new ActivityParam();
				Activity activity = new Activity();
				activity.setRelation(new Relation(courseId));
				activityParam.setActivity(activity);
				
				Video video = new Video();
				VideoRelation videoRelation = new VideoRelation();
				videoRelation.setRelation(new Relation(courseId));
				video.setVideoRelations(Lists.newArrayList(videoRelation));
				activityParam.setVideo(video);
				activity.setType(ActivityType.VIDEO);
				Response response = activityBizService.createActivity(activityParam);
				if (response.isSuccess()) {
					env.setVariable("video_activity", new DefaultObjectWrapper().wrap(activity));
				}
				
				activity = new Activity();
				activity.setRelation(new Relation(courseId));
				activityParam.setActivity(activity);
				Test test = new Test();
				test.setTitle("课程测验");
				test.setDescription("课程测验");
				TestDelivery testDelivery = new TestDelivery();
				testDelivery.setRelationId(courseId);
				test.setTestDeliveries(Lists.newArrayList(testDelivery));
				activityParam.setTest(test);
				activity.setId(null);
				activity.setType(ActivityType.TEST);
				response = activityBizService.createActivity(activityParam);
				if (response.isSuccess()) {
					env.setVariable("test_activity", new DefaultObjectWrapper().wrap(activity));
					env.setVariable("test", new DefaultObjectWrapper().wrap(test));
				}
			}
			for (Activity activity : activities) {
				if (ActivityType.VIDEO.equals(activity.getType())) {
					env.setVariable("video_activity", new DefaultObjectWrapper().wrap(activity));
				}else if(ActivityType.TEST.equals(activity.getType())){
					env.setVariable("test_activity", new DefaultObjectWrapper().wrap(activity));
					Test test = testService.findTestById(activity.getEntityId());
					env.setVariable("test", new DefaultObjectWrapper().wrap(test));
				}
			}
		}
		body.render(env.getOut());
	}

}
