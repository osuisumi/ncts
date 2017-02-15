package com.haoyu.ncts.schedule.controller;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.ThreadContext;
import com.haoyu.sip.core.web.AbstractBaseController;
import com.haoyu.tip.schedule.entity.Schedule;
import com.haoyu.tip.schedule.entity.ScheduleRelation;
import com.haoyu.tip.schedule.service.IScheduleService;
import com.haoyu.tip.schedule.web.param.ScheduleParam;

@Controller
@RequestMapping("**/study/schedule")
public class ScheduleController extends AbstractBaseController{
	@Resource
	private IScheduleService scheduleServiceImpl;
	
	private String getLogicalViewNamePrefix(){
		return TemplateUtils.getTemplatePath("/study/schedule/");
	}
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {  
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
	dateFormat.setLenient(false);  
	//true:允许输入空值，false:不能为空值
	binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
	@RequestMapping(value="create",method=RequestMethod.GET)
	public String create(Schedule schedule,Model model){
		model.addAttribute("schedule", schedule);
		return this.getLogicalViewNamePrefix() + "edit_schedule";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response save(Schedule schedule){
		return scheduleServiceImpl.createSchedule(schedule);
	}
	
	@RequestMapping(value="saveSchedules",method=RequestMethod.POST)
	@ResponseBody
	public Response saveSchedules(ScheduleParam scheduleParam){
		if(CollectionUtils.isNotEmpty(scheduleParam.getSchedules())){
			for(Schedule s:scheduleParam.getSchedules()){
				setStartAndEndTime(s);
			}
		}
		return scheduleServiceImpl.createSchedules(scheduleParam);
	}
	
	@RequestMapping(value="delete/{id}")
	@ResponseBody
	public Response delete(Schedule schedule){
		return	scheduleServiceImpl.deleteSchedule(schedule);
	}
	
	
	@RequestMapping(method=RequestMethod.PUT)
	public Response update(Schedule schedule){
		return scheduleServiceImpl.updateSchedule(schedule);
	}
	
	@RequestMapping(value="my",method = RequestMethod.GET)
	public String mySchedule(){
		return this.getLogicalViewNamePrefix() + "my_schedule";
	}
	
	@RequestMapping(value="api",method=RequestMethod.GET)
	@ResponseBody
	public List<Schedule> api(ScheduleParam scheduleParam){
		return scheduleServiceImpl.findSchedules(scheduleParam);
	}
	
	
	private void setStartAndEndTime(Schedule schedule){
		if(schedule.getScheduleRelation()!=null){
			ScheduleRelation sr = schedule.getScheduleRelation();
			if(sr.getTimePeriod().getStartTime()!=null){
				Date startTime = sr.getTimePeriod().getStartTime();
				sr.getTimePeriod().setStartTime(setDayBegin(startTime));
			}
			if(sr.getTimePeriod().getEndTime()!=null){
				Date endTime = sr.getTimePeriod().getEndTime();
				sr.getTimePeriod().setEndTime(setDayEnd(endTime));
			}
		}
	}
	
	private Date setDayBegin(Date date){
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.HOUR_OF_DAY, 0); 
		c.set(Calendar.MINUTE, 0); 
		c.set(Calendar.SECOND,0);
		c.set(Calendar.MILLISECOND, 0);
		return c.getTime();
	}
	
	private Date setDayEnd(Date date){
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.set(Calendar.HOUR_OF_DAY, 23); 
		c.set(Calendar.MINUTE, 59); 
		c.set(Calendar.SECOND,59);
		return c.getTime();
	}
	

}
