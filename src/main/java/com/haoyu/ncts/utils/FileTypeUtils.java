package com.haoyu.ncts.utils;

import org.apache.commons.lang3.StringUtils;

public class FileTypeUtils {
	
	private static String TYPE_STUDY = "study";
	private static String TYPE_RESOURCE = "resource";
	private static String TYPE_RESOURCE_ZONE = "resourceZone";
	private static String TYPE_SUFFIX = "suffix";

	
	public static String getFileTypeClass(String fileName, String type){
		String subfix = StringUtils.substringAfterLast(fileName, ".");
		if ("doc".equals(subfix) || "docx".equals(subfix)) {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-word";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type word";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-word";
			}
			if (TYPE_SUFFIX.equals(type)) {
				return "word";
			}
		}else if ("xls".equals(subfix) || "xlsx".equals(subfix)) {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-excel";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type excel";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-table";
			}
			if (TYPE_SUFFIX.equals(type)) {
				return "excel";
			}
		}else if ("ppt".equals(subfix) || "pptx".equals(subfix)) {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-ppt";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type ppt";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-ppt";
			}
			if (TYPE_SUFFIX.equals(type)) {
				return "ppt";
			}
		}else if ("pdf".equals(subfix)) {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-pdf";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type pdf";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-pdf";
			}
			if (TYPE_SUFFIX.equals(type)) {
				return "pdf";
			}
		}else if ("txt".equals(subfix)) {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-txt";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type txt";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-other";
			}
			if (TYPE_SUFFIX.equals(type)) {
				return "txt";
			}
		}else if ("zip".equals(subfix) || "rar".equals(subfix)) {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-zip";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type zip";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-other";
			}
			if (TYPE_SUFFIX.equals(type)) {
				return "zip";
			}
		}else if ("jpg".equals(subfix) || "jpeg".equals(subfix) || "png".equals(subfix) || "gif".equals(subfix)) {
			return "img";
		}else if ("mp4".equals(subfix) || "avi".equals(subfix) || "rmvb".equals(subfix) || "rm".equals(subfix) || "asf".equals(subfix)
				 || "divx".equals(subfix) || "mpg".equals(subfix) || "mpeg".equals(subfix) || "mpe".equals(subfix) || "wmv".equals(subfix)
				 || "mkv".equals(subfix) || "vob".equals(subfix) || "3gp".equals(subfix)) {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-video";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type video";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-view";
			}
		}else {
			if (TYPE_STUDY.equals(type)) {
				return "au-file-other";
			}
			if (TYPE_RESOURCE.equals(type)) {
				return "u-file-type other";
			}
			if (TYPE_RESOURCE_ZONE.equals(type)) {
				return "u-ico-file u-other";
			}
			if (TYPE_SUFFIX.equals(type)) {
				return "other";
			}
		}
		return "";
	}
	
}
