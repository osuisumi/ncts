package com.haoyu.ncts.schedule.utils;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.haoyu.sip.core.entity.User;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.utils.PropertiesLoader;
import com.haoyu.sip.message.entity.Message;
import com.haoyu.sip.message.service.IMessageService;
import com.haoyu.sip.message.utils.MessageType;
import com.haoyu.sip.utils.Collections3;
import com.haoyu.sip.utils.TimeUtils;
import com.haoyu.tip.schedule.entity.Schedule;
import com.haoyu.tip.schedule.service.IScheduleService;

@Component 
public class ScheduleMessageUtils {
	@Resource  
	private RedisTemplate<Serializable,Serializable> redisTemplate;
	
	@Resource
	private IScheduleService scheduleService;
	
	@Resource
	private IMessageService messageService;
	
	@Resource
	private PropertiesLoader propertiesLoader;
	
	private static String appName;
	
	private static String endedScheduleKey;
	
	private static String ongoingScheduleKey;
	
	private static ScheduleMessageUtils scheduleMessaheUtils; 
	
	@PostConstruct
	private void init(){
		scheduleMessaheUtils = this;
		appName = propertiesLoader.getProperty("redis.app.key");
		endedScheduleKey = appName + ":" + "endedSchedule";
		ongoingScheduleKey = appName + ":" + "ongoingSchedule";
	}
	
	public static void sendScheduleMessageOnLogin(){
		String userId = getCurrentUserId();
		if(StringUtils.isNotEmpty(userId)){
			Map<String,Object> parameter = Maps.newHashMap();
			parameter.put("creator", userId);
			List<Schedule> schedules = scheduleMessaheUtils.scheduleService.findSchedules(parameter);
			if(CollectionUtils.isNotEmpty(schedules)){
				List<Schedule> ongoingList = Lists.newArrayList();
				List<Schedule> endedList = Lists.newArrayList();
				for(Schedule s:schedules){
					if(getScheduleDateState(s) == 0){
						ongoingList.add(s);
					}else if(getScheduleDateState(s)<0){
						endedList.add(s);
					}
				}
				sendOngoingMessage(userId, ongoingList);
				sendEndedMessage(userId,endedList);
				
			}
			
		}
	}
	
	private static String getCurrentUserId(){
		Subject subject = SecurityUtils.getSubject();
		if(subject == null){
			return null;
		}
		List<Object> listPrincipals = subject.getPrincipals().asList();
		Map<String, String> attributes = (Map<String, String>) listPrincipals.get(1);
		String userId = attributes.get("id");
		return userId;
	}
	
	private static void sendOngoingMessage(String userId,List<Schedule> schedules){
		if(CollectionUtils.isNotEmpty(schedules)){
			Date today = new Date();
			String todayStr = TimeUtils.formatDate(today, "yyyy-MM-dd");
			boolean hasKey = scheduleMessaheUtils.redisTemplate.opsForHash().hasKey(ongoingScheduleKey+":"+userId,userId+todayStr);
			if(hasKey){
				List<String> messageedScheduleIds = (List<String>) scheduleMessaheUtils.redisTemplate.opsForHash().get(ongoingScheduleKey+":"+userId,userId+todayStr );
				List<Schedule> unMessageSchedules = Lists.newArrayList();
				for(Schedule s:schedules){
					if(!messageedScheduleIds.contains(s.getId())){
						unMessageSchedules.add(s);
					}
				}
				Response response = sendMessage("ongoing",unMessageSchedules,userId);
				if(response.isSuccess()){
					scheduleMessaheUtils.redisTemplate.delete(ongoingScheduleKey+":"+userId);
					messageedScheduleIds.addAll(Collections3.extractToList(unMessageSchedules, "id"));
					scheduleMessaheUtils.redisTemplate.opsForHash().put(ongoingScheduleKey+":"+userId,userId+todayStr,messageedScheduleIds);
				}
			}else{
				Response response = sendMessage("ongoing",schedules,userId);
				if(response.isSuccess()){
					scheduleMessaheUtils.redisTemplate.opsForHash().put(ongoingScheduleKey+":"+userId,userId+todayStr,Collections3.extractToList(schedules, "id"));
				}
			}
			
		}
	}
	
	private static void sendEndedMessage(String userId,List<Schedule> schedules){
		if(CollectionUtils.isNotEmpty(schedules)){
			boolean hasKey = scheduleMessaheUtils.redisTemplate.opsForHash().hasKey(endedScheduleKey, userId);
			if(hasKey){
				List<String> messageedScheduleIds = (List<String>) scheduleMessaheUtils.redisTemplate.opsForHash().get(endedScheduleKey, userId);
				List<Schedule> unMessageSchedules = Lists.newArrayList();
				for(Schedule s:schedules){
					if(!messageedScheduleIds.contains(s.getId())){
						unMessageSchedules.add(s);
					}
				}
				Response response = sendMessage("ended",unMessageSchedules,userId);
				if(response.isSuccess()){
					scheduleMessaheUtils.redisTemplate.opsForHash().delete(endedScheduleKey, userId);
					messageedScheduleIds.addAll(Collections3.extractToList(unMessageSchedules, "id"));
					scheduleMessaheUtils.redisTemplate.opsForHash().put(endedScheduleKey,userId,messageedScheduleIds);
				}
			}
			else{
				Response response = sendMessage("ended",schedules,userId);
				if(response.isSuccess()){
					scheduleMessaheUtils.redisTemplate.opsForHash().put(endedScheduleKey,userId,Collections3.extractToList(schedules, "id"));
				}
			}
		}
		
	}
	
	private static Response sendMessage(String type,List<Schedule> schedules,String userId){
		if(CollectionUtils.isNotEmpty(schedules)){
			Message message = new Message();
			message.setSender(new User("scheduleMessageUtils"));
			message.setType(MessageType.SYSTEM_MESSAGE);
			message.setReceiver(new User(userId));
			StringBuffer sb = new StringBuffer();
			if("ongoing".equals(type)){
				message.setTitle("正在进行的计划提醒");
				sb.append("您今天有"+schedules.size()+"条计划正在进行:");
			}else if("ended".equals(type)){
				message.setTitle("计划结束提醒");
				sb.append("您有"+schedules.size()+"条计划已经结束:");
			}
			for(Schedule s:schedules){
				sb.append(s.getTitle() + ",");
			}
			message.setContent(sb.toString());
			return scheduleMessaheUtils.messageService.createMessage(message);
		}else{
			return Response.failInstance();
		}
	}
	
	
	private static int getScheduleDateState(Schedule schedule){
		Date now = new Date();
		Date start = schedule.getScheduleRelation().getTimePeriod().getStartTime();
		Date end = schedule.getScheduleRelation().getTimePeriod().getEndTime();
		//正在进行 返回0
		if(start.getTime()<=now.getTime() && now.getTime()<=end.getTime()){
			return 0;
		}
		//过期  返回-1
		else if(now.getTime()>end.getTime()){
			return -1;
		}
		//还没开始
		return 1;
	}

}
