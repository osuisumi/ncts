package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.ncts.course.entity.CourseStat;
import com.haoyu.ncts.course.service.ICourseStatService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;
import com.haoyu.sip.core.utils.PropertiesLoader;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseStatsDirective extends AbstractTemplateDirectiveModel {

	@Resource
	private ICourseStatService courseStatService;
	@Resource
	private RedisTemplate redisTemplate;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> parameter = getSelectParam(params);
		PageBounds pageBounds = getPageBounds(params);
		
		String courseId = (String) parameter.get("courseId");
		if (StringUtils.isNotEmpty(courseId)) {
			String key = PropertiesLoader.get("redis.app.key") + ":courseStat:"+courseId;
			ValueOperations<String,List<CourseStat>> valueOper = redisTemplate.opsForValue();
			if(redisTemplate.hasKey(key)){
				List<CourseStat> courseStats = (List<CourseStat>) valueOper.get(key);
				env.setVariable("courseStats", new DefaultObjectWrapper().wrap(courseStats));
			}else{
				List<CourseStat> courseStats = courseStatService.findCourseStats(parameter, null);
				env.setVariable("courseStats", new DefaultObjectWrapper().wrap(courseStats));
				valueOper.set(key, courseStats);
				redisTemplate.expire(key, 12, TimeUnit.HOURS);
			}
		}else{
			List<CourseStat> courseStats = courseStatService.findCourseStats(parameter, pageBounds);
			env.setVariable("courseStats", new DefaultObjectWrapper().wrap(courseStats));

			if (pageBounds != null && pageBounds.isContainsTotalCount()) {
				PageList pageList = (PageList) courseStats;
				env.setVariable("paginator", new DefaultObjectWrapper().wrap(pageList.getPaginator()));
			}
		}
		body.render(env.getOut());

	}

}
