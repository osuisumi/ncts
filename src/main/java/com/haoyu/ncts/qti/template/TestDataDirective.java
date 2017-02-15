package com.haoyu.ncts.qti.template;

import java.io.IOException;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Component;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.aip.qti.service.ITestService;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

@Component
public class TestDataDirective implements TemplateDirectiveModel {

	@Resource
	private ITestService testService;
	

	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		if (params.containsKey("id")) {
			String id = params.get("id").toString();
			Test test = testService.findTestById(id);
			if (test != null) {
				env.setVariable("test", new DefaultObjectWrapper().wrap(test));
			} else {
				env.setVariable("test", new DefaultObjectWrapper().wrap(new Test()));
			}
		}
		body.render(env.getOut());
	}

}
