package com.haoyu.ncts.resource.utils;

import org.apache.commons.lang3.StringUtils;

public class ResourceTypeUtils {
	
	private static String TYPE_RESOURCE = "resource";
	
	public static String getResourceTypeClass(String fileName, String type){
		String subfix = StringUtils.substringAfterLast(fileName, ".");
		if ("doc".equals(subfix) || "docx".equals(subfix)) {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type word ";
			}
		}else if ("xls".equals(subfix) || "xlsx".equals(subfix)) {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type excel ";
			}
		}else if ("ppt".equals(subfix) || "pptx".equals(subfix)) {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type ppt ";
			}
		}else if ("pdf".equals(subfix)) {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type pdf ";
			}
		}else if ("txt".equals(subfix)) {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type txt ";
			}
		}else if ("zip".equals(subfix) || "rar".equals(subfix)) {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type zip ";
			}
		}else if ("jpg".equals(subfix) || "jpeg".equals(subfix) || "png".equals(subfix) || "gif".equals(subfix)) {
			return "img";
		}else if ("mp4".equals(subfix) || "avi".equals(subfix) || "rmvb".equals(subfix) || "rm".equals(subfix) || "asf".equals(subfix)
				 || "divx".equals(subfix) || "mpg".equals(subfix) || "mpeg".equals(subfix) || "mpe".equals(subfix) || "wmv".equals(subfix)
				 || "mkv".equals(subfix) || "vob".equals(subfix) || "3gp".equals(subfix)) {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type video ";
			}
		}else {
			if (TYPE_RESOURCE.equals(type)) {
				return " u-file-type other ";
			}
		}
		return "";
	}
	
}
