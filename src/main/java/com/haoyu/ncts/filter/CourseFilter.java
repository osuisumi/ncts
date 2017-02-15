/**
 * 
 */
package com.haoyu.ncts.filter;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

import com.haoyu.aip.activity.service.IActivityService;
import com.haoyu.ncts.course.entity.Course;
import com.haoyu.ncts.course.entity.Section;
import com.haoyu.ncts.course.service.ICourseBizService;
import com.haoyu.ncts.course.service.ICourseService;
import com.haoyu.ncts.course.service.ISectionService;
import com.haoyu.ncts.utils.CSAIdObject;
import com.haoyu.ncts.utils.RoleCodeConstant;
import com.haoyu.sip.utils.TimeUtils;

/**
 * @author lianghuahuang
 *
 */
public class CourseFilter extends AuthorizationFilter {

	@Resource
	private ICourseBizService courseBizService;
	@Resource
	private ICourseService courseService;
	@Resource
	private ISectionService sectionService;
	@Resource
	private IActivityService activityService;

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.apache.shiro.web.filter.AccessControlFilter#isAccessAllowed(javax.servlet.ServletRequest, javax.servlet.ServletResponse, java.lang.Object)
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
		// 获取aid
		String uri = ((HttpServletRequest) request).getRequestURI();
		String aid = this.getId(uri, "a_");
		CSAIdObject csaIdObject = null;
		if (aid != null) {
			// 需要查询该aid对应的sid和cid 然后构造出CSAIdObject对象
			csaIdObject = courseBizService.getCSAIdObject(aid, new CSAIdObject(null,null,null,aid));
		}else{
			String scid = this.getId(uri, "sc_");
			if (scid != null) {
				// 需要查询该scid对应的sid,cid 然后构造出CSAIdObject对象
				csaIdObject = courseBizService.getCSAIdObject(scid, new CSAIdObject(null,null,scid));
			}else {
				String sid = this.getId(uri, "s_");
				if (sid != null) {
					// 需要查询该sid对应的cid 然后构造出CSAIdObject对象
					csaIdObject = courseBizService.getCSAIdObject(sid, new CSAIdObject(null,sid));
				}else {
					String cid = this.getId(uri, "c_");
					if (cid != null) {
						csaIdObject = new CSAIdObject(cid);
					}
				}
			}
		}
		CSAIdObject.bind(csaIdObject);
		
		if (csaIdObject != null && StringUtils.isNotEmpty(csaIdObject.getCid())) {
			if (uri.contains("study")) {
				Subject currentUser = SecurityUtils.getSubject();
				if (!currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_"+csaIdObject.getCid()) && !currentUser.hasRole(RoleCodeConstant.PREVIEW+"_"+csaIdObject.getCid())) {
					return false;
				}else{
					if(currentUser.hasRole(RoleCodeConstant.COURSE_STUDY+"_"+csaIdObject.getCid()) && !validateCourseTime()){
						return false;
					}
				}
			}else if(uri.contains("teach")){
				Subject currentUser = SecurityUtils.getSubject();
				if (!currentUser.hasRole(RoleCodeConstant.COURSE_TEACHER+"_"+csaIdObject.getCid())) {
					return false;
				}else{
					if(!validateCourseTime()){
						return false;
					}
				}
			}
		}
		return true;
	}
	
	private boolean validateCourseTime(){
		String cid = CSAIdObject.getCSAIdObject().getCid();
		if (StringUtils.isNotEmpty(cid)) {
			Course course = courseService.getCourse(cid);
			if (course.getTimePeriod() != null) {
				if (course.getTimePeriod().getStartTime() != null && !TimeUtils.hasBegun(course.getTimePeriod().getStartTime())) {
					super.setUnauthorizedUrl("/error/course_not_start.jsp");
					return false;
				}
			}
			String sid = CSAIdObject.getCSAIdObject().getSid();
			if (StringUtils.isNotEmpty(sid)) {
				Section section = sectionService.getSection(sid);
				if (section.getTimePeriod() != null) {
					if (section.getTimePeriod().getStartTime() != null && !TimeUtils.hasBegun(section.getTimePeriod().getStartTime())) {
						super.setUnauthorizedUrl("/error/course_not_start.jsp");
						return false;
					}
				}
			}
		}
		return true;
	}

	private String getId(String uri, String prefix) {
		if (uri.indexOf("/" + prefix) >= 0) {
			String id = StringUtils.substringBetween(uri, "/" + prefix, "/");
			if (StringUtils.isEmpty(id)) {
				id = StringUtils.substringAfterLast(uri, "/" + prefix);
			}
			if (StringUtils.isNotEmpty(id)) {
				id = prefix + id;
			}
			return id;
		}
		return null;
	}

}
