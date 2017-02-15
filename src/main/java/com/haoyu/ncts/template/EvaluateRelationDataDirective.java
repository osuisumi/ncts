package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.haoyu.sip.core.entity.Relation;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.evaluate.entity.Evaluate;
import com.haoyu.sip.evaluate.entity.EvaluateRelation;
import com.haoyu.sip.evaluate.service.IEvaluateRelationService;
import com.haoyu.sip.evaluate.service.IEvaluateService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class EvaluateRelationDataDirective implements TemplateDirectiveModel {

	@Resource
	private IEvaluateRelationService evaluateRelationService;
	@Resource
	private IEvaluateService evaluateService;

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		String relationId = params.get("relationId").toString();
		String type = params.get("type").toString();
		EvaluateRelation evaluateRelation = evaluateRelationService.getEvaluateRelationByRelationId(relationId);
		if (evaluateRelation == null) {
			Evaluate evaluate = new Evaluate();
			Response response = evaluateService.createEvaluate(evaluate);
			if (response.isSuccess()) {
				evaluateRelation = new EvaluateRelation();
				evaluateRelation.setEvaluate(evaluate);
				evaluateRelation.setRelation(new Relation(relationId));
				String id = EvaluateRelation.getId(evaluate.getId(), relationId);
				evaluateRelation.setId(id);
				evaluateRelation.setType(type);
				evaluateRelationService.createEvaluateRelation(evaluateRelation);
			}                     
		}else{
			evaluateRelation.setEvaluate(evaluateService.getEvaluate(evaluateRelation.getEvaluate().getId()));
		}
		env.setVariable("evaluateRelation", new DefaultObjectWrapper().wrap(evaluateRelation));
		body.render(env.getOut());
	}
	
}
