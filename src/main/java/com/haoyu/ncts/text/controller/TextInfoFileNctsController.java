package com.haoyu.ncts.text.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.haoyu.aip.text.entity.TextInfoFile;
import com.haoyu.ncts.utils.TemplateUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/textInfo/file")
public class TextInfoFileNctsController extends AbstractBaseController{
	
	@RequestMapping("{id}/view")
	public String view(TextInfoFile textInfoFile, Model model){
		model.addAttribute("textInfoFile", textInfoFile);
		return TemplateUtils.getTemplatePath("/study/activity/text/view_text_info_file");
	}

}
