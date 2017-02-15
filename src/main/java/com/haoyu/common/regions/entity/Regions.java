package com.haoyu.common.regions.entity;

import com.haoyu.base.entity.BaseEntity;

public class Regions extends BaseEntity{

	private static final long serialVersionUID = -7803521442655996163L;

	private String id;
	
	private String regionsCode;
	
	private String regionsName;
	
	private String parentCode;
	
	private String regionsLevel;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRegionsCode() {
		return regionsCode;
	}

	public void setRegionsCode(String regionsCode) {
		this.regionsCode = regionsCode;
	}

	public String getRegionsName() {
		return regionsName;
	}

	public void setRegionsName(String regionsName) {
		this.regionsName = regionsName;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getRegionsLevel() {
		return regionsLevel;
	}

	public void setRegionsLevel(String regionsLevel) {
		this.regionsLevel = regionsLevel;
	}

}
