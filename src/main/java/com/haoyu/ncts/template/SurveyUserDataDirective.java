package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Component;

import com.haoyu.aip.activity.entity.ActivityResult;
import com.haoyu.aip.activity.service.IActivityResultService;
import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.aip.survey.entity.SurveyUser;
import com.haoyu.aip.survey.service.ISurveyUserService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class SurveyUserDataDirective implements TemplateDirectiveModel{
	
	@Resource
	private ISurveyUserService surveyUserService;
	@Resource
	private IActivityResultService activityResultService;
	@Resource
	private IActivityService activityService;
	
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		if(params.containsKey("surveyId")&&params.containsKey("relationId")){
			String surveyId = params.get("surveyId").toString();
			String relationId = params.get("relationId").toString();
			SurveyUser surveyUser = surveyUserService.createFirstTimeGetSurveyUser(surveyId, relationId);
			if (surveyUser != null) {
				env.setVariable("surveyUser", new DefaultObjectWrapper().wrap(surveyUser));
				if(CollectionUtils.isNotEmpty(surveyUser.getSurveySubmissions())){
					Map map = Collections3.extractToMap(surveyUser.getSurveySubmissions(), "question.id", "response");
					env.setVariable("surveyUserSubmissions", new DefaultObjectWrapper().wrap(map));
				}
			}else{
				env.setVariable("surveyUser", new DefaultObjectWrapper().wrap(new SurveyUser()));
			}
			
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
