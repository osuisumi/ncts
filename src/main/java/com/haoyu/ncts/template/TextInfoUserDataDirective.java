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
import com.haoyu.aip.text.entity.TextInfo;
import com.haoyu.aip.text.entity.TextInfoRelation;
import com.haoyu.aip.text.entity.TextInfoUser;
import com.haoyu.aip.text.service.ITextInfoService;
import com.haoyu.aip.text.service.ITextInfoUserService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class TextInfoUserDataDirective implements TemplateDirectiveModel {

	@Resource
	private ITextInfoUserService textInfoUserService;
	@Resource
	private ITextInfoService textInfoService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IActivityService activityService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		if(params.containsKey("textInfoId") && params.containsKey("relationId")){
			String textInfoId = params.get("textInfoId").toString();
			String relationId = params.get("relationId").toString();
			String textInfoRelationId = TextInfoRelation.getId(textInfoId, relationId);
			TextInfoUser textInfoUser = textInfoUserService.createTextInfoUserIfNotExists(textInfoRelationId);
			TextInfo textInfo = textInfoService.viewTextInfo(textInfoId, relationId);
			textInfoUser.getTextInfoRelation().setTextInfo(textInfo);
			env.setVariable("textInfoUser", new DefaultObjectWrapper().wrap(textInfoUser));
			
			String activityId = params.get("activityId").toString();
			Subject currentUser = SecurityUtils.getSubject();
			if(params.containsKey("activityId") && currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_" + CSAIdObject.getCSAIdObject().getCid())){
				ActivityResult activityResult = activityResultService.createIfNotExists(activityId, relationId);
				env.setVariable("activityResult", new DefaultObjectWrapper().wrap(activityResult));
			}
			env.setVariable("activity", new DefaultObjectWrapper().wrap(activityService.getActivity(activityId)));
		}
		body.render(env.getOut());
	}
}
