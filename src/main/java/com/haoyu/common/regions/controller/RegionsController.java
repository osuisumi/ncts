package com.haoyu.common.regions.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.common.regions.entity.Regions;
import com.haoyu.common.regions.utils.RegionsUtils;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/regions")
public class RegionsController extends AbstractBaseController{

	@RequestMapping(value="entities",method=RequestMethod.GET)
	@ResponseBody
	public List<Regions> getEntites(String level,String parentCode){
		return RegionsUtils.getEntryList(level, parentCode);
	}
	
}
