package com.haoyu.ncts.teacher.entity;

import com.haoyu.sip.core.entity.BaseEntity;
import com.haoyu.sip.core.entity.User;

public class UserTeacher extends BaseEntity {

	private static final long serialVersionUID = 1L;

	private String id;
	private User user;
	private String Relation;
	private String type;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRelation() {
		return Relation;
	}

	public void setRelation(String relation) {
		Relation = relation;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
