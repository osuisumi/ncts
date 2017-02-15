package com.haoyu.ncts.faq.controller.param;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.haoyu.tip.faq.entity.FaqQuestion;

public class FaqQuestionParam extends FaqQuestion {
	private static final long serialVersionUID = 2425054344529051844L;
	// 为follow时 查询我关注的 为creator时 查询我创建的
	private String queryType;

	private String loginerId;

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	public String getLoginerId() {
		return loginerId;
	}

	public void setLoginerId(String loginerId) {
		this.loginerId = loginerId;
	}

	public Map<String, Object> getParameter() {
		Map<String, Object> parameter = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(this.getContent())) {
			parameter.put("content", this.getContent());
		}
		if (StringUtils.isNotEmpty(this.getQueryType())) {
			if(this.getQueryType().equals("follow")){
				parameter.put("followCreatorId",this.getLoginerId());
			}else if(this.getQueryType().equals("creator")){
				parameter.put("creatorId", this.getLoginerId());
			}
			parameter.put("queryType", this.getQueryType());
		}
		if (this.getRelation() != null) {
			parameter.put("relation", this.getRelation());
		}
		return parameter;
	}

}
