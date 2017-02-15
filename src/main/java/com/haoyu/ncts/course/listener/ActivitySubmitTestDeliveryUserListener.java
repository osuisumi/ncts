package com.haoyu.ncts.course.listener;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityResultState;
import com.haoyu.aip.qti.entity.TestDeliveryUser;
import com.haoyu.aip.qti.event.SubmitTestDeliveryUserEvent;
import com.haoyu.aip.qti.service.ITestDeliveryUserService;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.service.ICourseResultBizService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.utils.CourseType;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;

@Component
public class ActivitySubmitTestDeliveryUserListener implements ApplicationListener<SubmitTestDeliveryUserEvent>{

	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private ITestDeliveryUserService testDeliveryService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseResultBizService courseResultBizService;
	
	@Override
	public void onApplicationEvent(SubmitTestDeliveryUserEvent event) {
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
			TestDeliveryUser testDeliveryUser = (TestDeliveryUser) event.getSource();
			String relationId = testDeliveryUser.getTestDelivery().getRelationId();
			String testId = testDeliveryUser.getTestDelivery().getTest().getId();
			Activity activity = activityService.getActivityByEntityId(testId);
			ActivityResult activityResult = activityResultService.createIfNotExists(activity.getId(), relationId);
			activityResult.setState(ActivityResultState.COMPLETE);
			//获取分数百分比
			double score = testDeliveryUser.getTestDelivery().getTest().getScore();
			double sumScore = testDeliveryUser.getSumScore();
			if(score<=0){
				activityResult.setScore(BigDecimal.valueOf(100));
			}else{
				if(sumScore<=0){
					activityResult.setScore(BigDecimal.valueOf(0));
				}else{
					BigDecimal  scorePercent = BigDecimal.valueOf(sumScore).multiply(BigDecimal.valueOf(100)).divide(BigDecimal.valueOf(score) ,1, BigDecimal.ROUND_HALF_UP);
					if(scorePercent.doubleValue()>100){
						activityResult.setScore(BigDecimal.valueOf(100));
					}else{
						activityResult.setScore(scorePercent);
					}
					
				}
			}
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
