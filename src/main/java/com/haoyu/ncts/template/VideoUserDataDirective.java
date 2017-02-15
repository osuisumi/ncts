package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.video.entity.Video;
import com.haoyu.aip.video.entity.VideoRelation;
import com.haoyu.aip.video.entity.VideoUser;
import com.haoyu.aip.video.service.IVideoService;
import com.haoyu.aip.video.service.IVideoUserService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class VideoUserDataDirective implements TemplateDirectiveModel {

	@Resource
	private IVideoUserService videoUserService;
	@Resource
	private IVideoService videoService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IActivityService activityService;
	
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		if(params.containsKey("videoId") && params.containsKey("relationId")){
			String videoId = params.get("videoId").toString();
			String relationId = params.get("relationId").toString();
			String videoRelationId = VideoRelation.getId(videoId, relationId);
			VideoUser videoUser = videoUserService.createVideoUserIfNotExists(videoRelationId);
			Video video = videoService.viewVideo(videoId, relationId);
			videoUser.getVideoRelation().setVideo(video);
			env.setVariable("videoUser", new DefaultObjectWrapper().wrap(videoUser));
			
			if(params.containsKey("activityId")){
				String activityId = params.get("activityId").toString();
				Subject currentUser = SecurityUtils.getSubject();
				if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
					ActivityResult activityResult = activityResultService.createIfNotExists(activityId, relationId);
					env.setVariable("activityResult", new DefaultObjectWrapper().wrap(activityResult));
				}
				env.setVariable("activity", new DefaultObjectWrapper().wrap(activityService.getActivity(activityId)));
			}
		}
		body.render(env.getOut());
	}
}