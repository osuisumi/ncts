package com.haoyu.ncts.course.event;

import org.springframework.context.ApplicationEvent;

public class CompleteCourseEvent extends ApplicationEvent {

	private static final long serialVersionUID = 2181176831584931771L;

	public CompleteCourseEvent(Object source) {
		super(source);
	}

}
