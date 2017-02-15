package com.haoyu.ncts.task;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.haoyu.aip.assignment.service.IAssignmentMarkService;
import com.haoyu.sip.core.service.Response;

@Component
public class AssignmentTask {
	
	@Resource
	private RedisTemplate redisTemplate;
	@Resource
	private IAssignmentMarkService assignmentMarkService;

	//每天凌晨2点执行作业领取失效
	@Scheduled(cron = "0 0 2 * * ?")
	public void updateAssignmentMarkExpired() {
		redisTemplate.setValueSerializer(redisTemplate.getDefaultSerializer());
		ValueOperations<String,String> valueOper = redisTemplate.opsForValue();
		String key = "assignment_mark_expired_date";
		String today = DateFormatUtils.format(new Date(), "yyyy-MM-dd");
		if(redisTemplate.hasKey(key)){
			String date = valueOper.get(key);
			if (today.equals(date)) {
				return;
			}
		}
		Response response = assignmentMarkService.updateAssignmentMarkExpired();
		if (response.isSuccess()) {
			valueOper.set(key, today);
		}
	}
}
