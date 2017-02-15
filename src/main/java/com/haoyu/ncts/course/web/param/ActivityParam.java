package com.haoyu.ncts.course.web.param;

import java.io.Serializable;
import java.text.ParseException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;

import com.haoyu.aip.activity.entity.Activity;
import com.haoyu.aip.assignment.entity.Assignment;
import com.haoyu.aip.discussion.entity.Discussion;
import com.haoyu.aip.qti.entity.Test;
import com.haoyu.aip.survey.entity.Survey;
import com.haoyu.aip.text.entity.TextInfo;
import com.haoyu.aip.video.entity.Video;
import com.haoyu.sip.core.entity.TimePeriod;
import com.haoyu.sip.core.utils.PropertiesLoader;

public class ActivityParam implements Serializable{
	
	private static final long serialVersionUID = 6615033007480337515L;

	private Activity activity;
	
	private Discussion discussion;
	
	private Video video;
	
	private TextInfo textInfo;
	
	private Assignment assignment;
	
	private Test test;
	
	private Survey survey;
	
	private String startTime;
	
	private String endTime;
	
	private String isUpdateFileString;
	
	private boolean isUpdateFile;

	public String getIsUpdateFileString() {
		return isUpdateFileString;
	}

	public void setIsUpdateFileString(String isUpdateFileString) {
		this.isUpdateFileString = isUpdateFileString;
	}

	public boolean isUpdateFile() {
		if (StringUtils.isNotEmpty(isUpdateFileString)) {
			return Boolean.valueOf(isUpdateFileString);
		}
		return isUpdateFile;
	}

	public void setUpdateFile(boolean isUpdateFile) {
		this.isUpdateFile = isUpdateFile;
	}

	public Assignment getAssignment() {
		return assignment;
	}

	public void setAssignment(Assignment assignment) {
		this.assignment = assignment;
	}

	public Test getTest() {
		return test;
	}

	public void setTest(Test test) {
		this.test = test;
	}

	public TextInfo getTextInfo() {
		return textInfo;
	}

	public void setTextInfo(TextInfo textInfo) {
		this.textInfo = textInfo;
	}

	public Video getVideo() {
		return video;
	}

	public void setVideo(Video video) {
		this.video = video;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		if (StringUtils.isNotEmpty(startTime)) {
			try {
				if (activity.getTimePeriod() == null) {
					activity.setTimePeriod(new TimePeriod());
				}
				activity.getTimePeriod().setStartTime(DateUtils.parseDate(startTime, PropertiesLoader.get("activity.timePeriod.pattern")));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		if (StringUtils.isNotEmpty(endTime)) {
			try {
				if (activity.getTimePeriod() == null) {
					activity.setTimePeriod(new TimePeriod());
				}
				activity.getTimePeriod().setEndTime(DateUtils.parseDate(endTime, PropertiesLoader.get("activity.timePeriod.pattern")) );
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		this.endTime = endTime;
	}

	public Activity getActivity() {
		return activity;
	}

	public void setActivity(Activity activity) {
		this.activity = activity;
	}

	public Discussion getDiscussion() {
		return discussion;
	}

	public void setDiscussion(Discussion discussion) {
		this.discussion = discussion;
	}

	public Survey getSurvey() {
		return survey;
	}

	public void setSurvey(Survey survey) {
		this.survey = survey;
	}
	
	

}
