package com.haoyu.ncts.utils;

import com.haoyu.sip.core.utils.PropertiesLoader;

public class TemplateUtils {
	
	public static String getTemplatePath(String path){
		return new StringBuilder((String)PropertiesLoader.get("ncts.template.path")).append(path).toString(); 
	}

}
