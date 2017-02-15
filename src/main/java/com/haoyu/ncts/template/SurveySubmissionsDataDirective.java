package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.aip.survey.entity.SurveySubmission;
import com.haoyu.aip.survey.service.ISurveySubmissionService;
import com.haoyu.ncts.utils.PageSplitUtils;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class SurveySubmissionsDataDirective implements TemplateDirectiveModel{
	@Resource
	private ISurveySubmissionService surveySubmissionService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		Map<String, Object> param = Maps.newHashMap();
		if (params.containsKey("questionId") && params.containsKey("relationId")) {
			String questionId = params.get("questionId").toString();
			String relationId = params.get("relationId").toString();
			param.put("questionId", questionId);
			param.put("relationId",relationId);
			PageBounds pageBounds = PageSplitUtils.getPageBounds(params, env);
			List<SurveySubmission> surveySubmissions = surveySubmissionService.findSurveySubmissions(param, pageBounds);
			if (pageBounds != null && pageBounds.isContainsTotalCount()) {
				PageList pageList = (PageList)surveySubmissions;
				env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
			}
			env.setVariable("surveySubmissions", new DefaultObjectWrapper().wrap(surveySubmissions));
		}else{
			env.setVariable("surveySubmissions", new DefaultObjectWrapper().wrap(Lists.newArrayList()));
		}
		body.render(env.getOut());
		
	}

}
