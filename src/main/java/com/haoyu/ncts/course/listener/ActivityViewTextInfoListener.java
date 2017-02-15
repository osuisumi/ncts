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
import com.haoyu.aip.text.entity.TextInfoUser;
import com.haoyu.aip.text.event.ViewTextInfoEvent;
import com.haoyu.aip.text.service.ITextInfoUserService;
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
public class ActivityViewTextInfoListener implements ApplicationListener<ViewTextInfoEvent>{

	@Resource
	private IActivityService activityService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private ITextInfoUserService textInfoUserService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ICourseResultBizService courseResultBizService;
	
	@Override
	public void onApplicationEvent(ViewTextInfoEvent event) {
		Subject currentUser = SecurityUtils.getSubject();
		if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
			TextInfoUser textInfoUser = (TextInfoUser) event.getSource();
			textInfoUser = textInfoUserService.get(textInfoUser.getId());
			String relationId = textInfoUser.getTextInfoRelation().getRelation().getId();
			String textInfoId = textInfoUser.getTextInfoRelation().getTextInfo().getId();
			Activity activity = activityService.getActivityByEntityId(textInfoId);
			ActivityResult activityResult = activityResultService.createIfNotExists(activity.getId(), relationId);
			Map<String, ActivityAttribute> attributeMap = activity.getAttributeMap();
			
			int viewNum = 0;
			if (attributeMap.containsKey(ActivityAttributeName.TEXT_INFO_VIEW_NUM)) {
				String num = attributeMap.get(ActivityAttributeName.TEXT_INFO_VIEW_NUM).getAttrValue();
				if (StringUtils.isNotEmpty(num)) {
					viewNum = Integer.parseInt(num);
				}
			}
			if (textInfoUser.getViewNum() >= viewNum) {
				activityResult.setState(ActivityResultState.COMPLETE);
			}else if(textInfoUser.getViewTime() > 0){
				activityResult.setState(ActivityResultState.IN_PROGRESS);
			}
			
			float completePct = 0;
			if (viewNum > 0) {
				completePct = BigDecimal.valueOf(textInfoUser.getViewNum()).multiply(BigDecimal.valueOf(100)).divide(BigDecimal.valueOf(viewNum), 1, BigDecimal.ROUND_HALF_UP).floatValue();
				if (completePct > 100) {
					completePct = 100;
				}
			}else{
				completePct = 100;
			}
			activityResult.setScore(BigDecimal.valueOf(completePct));
			
			Map<String, Object> result = Maps.newHashMap();
			result.put(ActivityAttributeName.TEXT_INFO_VIEW_NUM, textInfoUser.getViewNum());
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
