package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.google.common.collect.Maps;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.CourseAuthorize;
import com.haoyu.ncts.course.service.ICourseAuthorizeService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseAuthorizeRole;
import com.haoyu.sip.core.entity.Relation;
import com.haoyu.tip.faq.entity.FaqQuestion;
import com.haoyu.tip.faq.service.IFaqQuestionService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class CourseConfigDataDirective implements TemplateDirectiveModel {

	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseAuthorizeService courseAuthorizeService;
	@Resource
	private IFaqQuestionService faqQuestionService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		if (params.containsKey("courseId")) {
			String courseId = params.get("courseId").toString();
			Course course = courseService.getCourse(courseId);
			env.setVariable("course", new DefaultObjectWrapper().wrap(course));
			
			Map<String, Object> param = Maps.newHashMap();
			param.put("courseId", courseId);
			param.put("role", CourseAuthorizeRole.TEACHER);
			List<CourseAuthorize> courseAuthorizes = courseAuthorizeService.listCourseAuthorize(param, null);
			env.setVariable("courseAuthorizes", new DefaultObjectWrapper().wrap(courseAuthorizes));
			
			FaqQuestion faqQuestion = new FaqQuestion();
			faqQuestion.setRelation(new Relation(courseId,"course_config"));
			List<FaqQuestion> faqQuestions = faqQuestionService.listFaqQuestion(faqQuestion, null);
			env.setVariable("faqQuestions", new DefaultObjectWrapper().wrap(faqQuestions));
			
			
		}
		body.render(env.getOut());
	}

}
