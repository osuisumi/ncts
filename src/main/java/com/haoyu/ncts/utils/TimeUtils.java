package com.haoyu.ncts.utils;

import com.haoyu.sip.core.entity.TimePeriod;

public class TimeUtils extends com.haoyu.sip.utils.TimeUtils{
	
	//判断是否在当前时间之内, 时间参数不定个数, 全部验证通过才返回true
	public static boolean inCurrentDate(Object... timePeriods){
		for (Object timePeriod : timePeriods) {
			if (timePeriod instanceof TimePeriod) {
				TimePeriod tp = (TimePeriod) timePeriod;
				if (tp != null) {
					if (!TimeUtils.hasBegun(tp.getStartTime()) || TimeUtils.hasEnded(tp.getEndTime())) {
						return false;
					}
				}
			}
		}
		return true;
	}

}
