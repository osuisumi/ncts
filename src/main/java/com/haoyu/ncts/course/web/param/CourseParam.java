package com.haoyu.ncts.course.web.param;

import java.io.Serializable;

public class CourseParam implements Serializable{
	
	private static final long serialVersionUID = -3471030359654453093L;

	private String courseId;
	
	private String sectionId;
	
	private String activityId;

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getSectionId() {
		return sectionId;
	}

	public void setSectionId(String sectionId) {
		this.sectionId = sectionId;
	}

	public String getActivityId() {
		return activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

}
