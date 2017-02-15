package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.faq.controller.param.FaqQuestionParam;
import com.haoyu.ncts.faq.service.IFaqQuestionNctsService;
import com.haoyu.tip.faq.entity.FaqQuestion;
import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
@Component
public class FaqListDataDirective implements TemplateDirectiveModel {
	@Resource
	private IFaqQuestionNctsService faqQuestionNctsService;
	
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = null;
		FaqQuestionParam faqQuestionParam = new FaqQuestionParam();
		if (params.containsKey("faqQuestion")) {
			BeanModel beanModel = (BeanModel) params.get("faqQuestion");
			faqQuestionParam = (FaqQuestionParam) beanModel.getWrappedObject();
		}
		if (params.containsKey("pageBounds")) {
			BeanModel beanModel = (BeanModel) params.get("pageBounds");
			pageBounds = (PageBounds) beanModel.getWrappedObject();
		}
		List<FaqQuestion> faqQuestions = faqQuestionNctsService.listFaqQuestion(faqQuestionParam, pageBounds,true);
		if (pageBounds != null && pageBounds.isContainsTotalCount()) {
			PageList pageList = (PageList)faqQuestions;
			env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		}
		env.setVariable("faqQuestions", new DefaultObjectWrapper().wrap(faqQuestions));
		body.render(env.getOut());
	}

}
