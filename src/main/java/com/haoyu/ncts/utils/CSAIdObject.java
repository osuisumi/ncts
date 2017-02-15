/**
 * 
 */
package com.haoyu.ncts.utils;

import java.io.Serializable;

import com.haoyu.sip.core.utils.ThreadContext;

/**
 * @author lianghuahuang
 *
 */
public class CSAIdObject implements Serializable {
	
	public static final String CSAIDOBJECT_KEY = ThreadContext.class.getName() + "_CSAID_OBJECT_KEY";
	//课程ID
	private String cid;
	//章ID
	private String sid;
	
	//节 ID
	private String scid;
	//活动ID
	private String aid;
	
	
	public CSAIdObject(){}
	
	public CSAIdObject(String cid, String sid) {
		super();
		this.cid = cid;
		this.sid = sid;
	}
	public CSAIdObject(String cid, String sid,String scid, String aid) {
		super();
		this.cid = cid;
		this.sid = sid;
		this.scid = scid;
		this.aid = aid;
	}
	public CSAIdObject(String cid, String sid, String scid) {
		super();
		this.cid = cid;
		this.sid = sid;
		this.scid = scid;
	}

	public CSAIdObject(String cid) {
		super();
		this.cid = cid;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}
	
	
	public String getScid() {
		return scid;
	}

	public void setScid(String scid) {
		this.scid = scid;
	}

	public static void bind(CSAIdObject casIdObject){
		if(casIdObject!=null){
			ThreadContext.put(CSAIDOBJECT_KEY,casIdObject);
		}
	}
	
	public static CSAIdObject getCSAIdObject(){
		return (CSAIdObject)ThreadContext.get(CSAIDOBJECT_KEY);
	}
	
	public static String toPath(){
		CSAIdObject csa = getCSAIdObject();
		if(csa!=null){
			StringBuffer sb = new StringBuffer();
			if(csa.getAid()!=null){
				return sb.append("/").append(csa.getAid()).toString();
			}
			if(csa.getScid()!=null){
				return sb.append("/").append(csa.getScid()).toString();
			}
			if(csa.getSid()!=null){
				return sb.append("/").append(csa.getSid()).toString();
			}
			if(csa.getCid()!=null){
				return sb.append("/").append(csa.getCid()).toString();
			}
		}
		return "/";
	}
}
