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
import com.haoyu.aip.activity.entity.ActivityAttribute;
import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.activity.utils.ActivityAttributeName;
import com.haoyu.aip.activity.utils.ActivityResultState;
import com.haoyu.aip.video.entity.VideoUser;
import com.haoyu.aip.video.event.UpdateVideoUserEvent;
import com.haoyu.aip.video.service.IVideoUserService;
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
public class ActivityUpdateVideoUserListener implements ApplicationListener<UpdateVideoUserEvent>{

	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IVideoUserService videoUserService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseResultBizService courseResultBizService;
	
	@Override
	public void onApplicationEvent(UpdateVideoUserEvent event) {
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
			VideoUser videoUser = (VideoUser) event.getSource();
			videoUser = videoUserService.get(videoUser.getId());
			String relationId = videoUser.getVideoRelation().getRelation().getId();
			String videoId = videoUser.getVideoRelation().getVideo().getId();
			Activity activity = activityService.getActivityByEntityId(videoId);
			ActivityResult activityResult = activityResultService.createIfNotExists(activity.getId(), relationId);
			Map<String, ActivityAttribute> attributeMap = activity.getAttributeMap();
			
			int viewTime = 0;
			if (attributeMap.containsKey(ActivityAttributeName.VIDEO_VIEW_TIME)) {
				String num = attributeMap.get(ActivityAttributeName.VIDEO_VIEW_TIME).getAttrValue();
				if (StringUtils.isNotEmpty(num)) {
					viewTime = Integer.parseInt(num) * 60;
				}
			}
			if (videoUser.getViewTime() >= viewTime) {
				activityResult.setState(ActivityResultState.COMPLETE);
			}else if(videoUser.getViewTime() > 0){
				activityResult.setState(ActivityResultState.IN_PROGRESS);
			}
			
			float completePct = 0;
			if (viewTime > 0) {
				completePct = BigDecimal.valueOf(videoUser.getViewTime()).multiply(BigDecimal.valueOf(100)).divide(BigDecimal.valueOf(viewTime), 1, BigDecimal.ROUND_HALF_UP).floatValue();
				if (completePct > 100) {
					completePct = 100;
				}
			}else{
				completePct = 100;
			}
			activityResult.setScore(BigDecimal.valueOf(completePct));
			
			Map<String, Object> result = Maps.newHashMap();
			result.put(ActivityAttributeName.VIDEO_VIEW_TIME, videoUser.getViewTime());
			result.put(ActivityAttributeName.COMPLETE_PCT, completePct);
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
