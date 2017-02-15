package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.sip.evaluate.entity.Evaluate;
import com.haoyu.sip.evaluate.entity.EvaluateRelation;
import com.haoyu.sip.evaluate.service.IEvaluateItemSubmissionService;
import com.haoyu.sip.evaluate.service.IEvaluateRelationService;
import com.haoyu.sip.evaluate.service.IEvaluateService;
import com.haoyu.sip.evaluate.service.IEvaluateSubmissionService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class EvaluateItemResultDataDirective implements TemplateDirectiveModel {

	@Resource
	private IEvaluateRelationService evaluateRelationService;
	@Resource
	private IEvaluateService evaluateService;
	@Resource
	private IEvaluateSubmissionService evaluateSubmissionService;
	@Resource
	private IEvaluateItemSubmissionService evaluateItemSubmissionService;
	

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		//作业ID, 查evaluateId
		if (params.containsKey("assignmentId") && params.containsKey("assignmentUserId")) {
			String assignmentId = params.get("assignmentId").toString();
			EvaluateRelation evaluateRelation = evaluateRelationService.getEvaluateRelationByRelationId(assignmentId);
			if (evaluateRelation != null) {
				env.setVariable("evaluateRelation", new DefaultObjectWrapper().wrap(evaluateRelation));
				
				//查询评价项列表
				String evaluateId = evaluateRelation.getEvaluate().getId();
				Evaluate evaluate = evaluateService.getEvaluate(evaluateId);
				env.setVariable("evaluate", new DefaultObjectWrapper().wrap(evaluate));
				
				//查询每一项的平均得分
				String assignmentUserId = params.get("assignmentUserId").toString();
				Map<String, Float> itemScoreMap = evaluateItemSubmissionService.mapEvaluateItemScore(evaluateId, assignmentUserId);
				env.setVariable("itemScoreMap", new DefaultObjectWrapper().wrap(itemScoreMap));
			}
		}
		body.render(env.getOut());
	}
	
}
