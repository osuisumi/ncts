package com.haoyu.ncts.course.event;

import org.springframework.context.ApplicationEvent;

public class UpdateCourseAuthorizeEvent extends ApplicationEvent {

	private static final long serialVersionUID = 7590508621279805509L;

	public UpdateCourseAuthorizeEvent(Object source) {
		super(source);
	}

}
