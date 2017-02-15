package com.haoyu.ncts.template;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.haoyu.tip.schedule.entity.Schedule;
import com.haoyu.tip.schedule.service.IScheduleService;
import com.haoyu.tip.schedule.web.param.ScheduleParam;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.SimpleScalar;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public class ScheduleDataDirective implements TemplateDirectiveModel{
	@Resource
	private IScheduleService scheduleServiceImpl;

	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
		PageBounds pageBounds = null;
		ScheduleParam scheduleParam = new ScheduleParam();
		if (params.containsKey("scheduleParam")) {
			BeanModel beanModel = (BeanModel) params.get("scheduleParam");
			scheduleParam = (ScheduleParam)beanModel.getWrappedObject();
		}
		if (params.containsKey("pageBounds")) {
			BeanModel beanModel = (BeanModel) params.get("pageBounds");
			pageBounds = (PageBounds)beanModel.getWrappedObject();
		}
		Map<String,Object> parammeter = new HashMap<String,Object>();
		scheduleParam.setParam(parammeter);
		List<Schedule> schedules = scheduleServiceImpl.findSchedules(parammeter,pageBounds);
		env.setVariable("schedules", new DefaultObjectWrapper().wrap(schedules));
		PageList pageList = (PageList)schedules;
		env.setVariable("paginator" , new DefaultObjectWrapper().wrap(pageList.getPaginator()));
		body.render(env.getOut());
		
	}

}
