package com.haoyu.ncts.utils;

import javax.servlet.http.HttpServletRequest;

public class CommonUtils {
	
	public static Boolean getBooleanFromRequest(HttpServletRequest request, String key){
		String value = request.getParameter(key);
		return Boolean.valueOf(value);
	}

}
