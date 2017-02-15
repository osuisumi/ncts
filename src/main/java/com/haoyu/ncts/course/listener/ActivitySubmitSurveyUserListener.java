package com.haoyu.ncts.course.listener;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityAttributeName;
import com.haoyu.aip.activity.utils.ActivityResultState;
import com.haoyu.aip.survey.entity.SurveyUser;
import com.haoyu.aip.survey.event.SubmitSurveyUserEvent;
import com.haoyu.aip.survey.service.ISurveyUserService;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.ICourseResultBizService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseType;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;
import com.haoyu.sip.core.mapper.JsonMapper;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;

@Component
public class ActivitySubmitSurveyUserListener implements ApplicationListener<SubmitSurveyUserEvent>{

	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private ISurveyUserService surveyUserService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseResultBizService courseResultBizService;
	
	@Override
	public void onApplicationEvent(SubmitSurveyUserEvent event) {
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
			SurveyUser surveyUser = (SurveyUser) event.getSource();
			surveyUser = surveyUserService.getSurveyUser(surveyUser.getId());
			String relationId = surveyUser.getRelation().getId();
			String surveyId = surveyUser.getSurvey().getId();
			Activity activity = activityService.getActivityByEntityId(surveyId);
			ActivityResult activityResult = activityResultService.createIfNotExists(activity.getId(), relationId);
			activityResult.setState(ActivityResultState.COMPLETE);
			activityResult.setScore(BigDecimal.valueOf(100));
			Map<String, Object> result = Maps.newHashMap();
			result.put(ActivityAttributeName.COMPLETE_PCT, BigDecimal.valueOf(100));
			activityResult.setDetail(new JsonMapper().toJson(result));
			Response response = activityResultService.updateActivityResult(activityResult);
			if (response.isSuccess()) {
				Course course = courseService.getCourse(CSAIdObject.getCSAIdObject().getCid());
				if (!course.getType().equals(CourseType.LEAD) && StringUtils.isNotEmpty(course.getResultSettings())) {
					courseResultBizService.updateCourseResult(course.getId(), Lists.newArrayList(ThreadContext.getUser().getId()));
				}
			}
		}
	}
}
