package com.haoyu.ncts.course.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.haoyu.ncts.course.entity.CourseAuthorize;
import com.haoyu.ncts.course.service.ICourseAuthorizeService;
import com.haoyu.sip.core.service.Response;
import com.haoyu.sip.core.web.AbstractBaseController;

@Controller
@RequestMapping("**/make/course/authorize")
public class CourseAuthorizeController extends AbstractBaseController {
	
	@Resource
	private ICourseAuthorizeService courseAuthorizeService;

	@RequestMapping(value="{course.id}", method=RequestMethod.POST)
	@ResponseBody
	public Response create(CourseAuthorize courseAuthorize, String userName) {
		return courseAuthorizeService.createCourseAuthorize(courseAuthorize, userName);
	}
	
	@RequestMapping(value="{id}" ,method=RequestMethod.DELETE)
	@ResponseBody
	public Response delete(CourseAuthorize courseAuthorize) {
		return courseAuthorizeService.deleteCourseAuthorizeByLogic(courseAuthorize);
	}

}
