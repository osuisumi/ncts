package com.haoyu.ncts.course.web;

import java.util.Arrays;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.course.entity.CourseRegister;
import com.haoyu.ncts.course.service.ICourseRegisterService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@RequestMapping("**/courseRegister")
@Controller
public class CourseRegisterController extends AbstractBaseController {
	@Resource
	private ICourseRegisterService courseRegisterService;
	
	@RequestMapping(method=RequestMethod.POST)
	@ResponseBody
	public Response createCourseRegister(CourseRegister courseRegister){
		return courseRegisterService.createCourseRegister(courseRegister);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	@ResponseBody
	public Response batchUpdateCourseRegisterState(CourseRegister courseRegister,String userIds){
		return courseRegisterService.updateCourseRegisterState(courseRegister, Arrays.asList(userIds.split(",")));
	}
	
	@RequestMapping(value="{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Response deleteCourseRegister(CourseRegister courseRegister){
		return courseRegisterService.deleteCourseRegisterByPhysics(courseRegister.getId());
	}
	

}
