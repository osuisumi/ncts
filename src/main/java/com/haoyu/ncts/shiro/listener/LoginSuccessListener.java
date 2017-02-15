package com.haoyu.ncts.shiro.listener;

import org.springframework.context.ApplicationListener;

import com.haoyu.ncts.extend.nea.event.LoginSuccessEvent;
import com.haoyu.ncts.schedule.utils.ScheduleMessageUtils;

public class LoginSuccessListener implements ApplicationListener<LoginSuccessEvent>{

	@Override
	public void onApplicationEvent(LoginSuccessEvent event) {
		ScheduleMessageUtils.sendScheduleMessageOnLogin();
	}

}
