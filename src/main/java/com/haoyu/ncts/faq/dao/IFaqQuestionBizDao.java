package com.haoyu.ncts.faq.dao;

import java.util.List;
import java.util.Map;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.tip.faq.entity.FaqQuestion;

public interface IFaqQuestionBizDao {
	
	List<FaqQuestion> findFaqQuestionByParameter(Map<String,Object> parameter,PageBounds pageBounds);
	
	int count(Map<String,Object> parameter);
	
	

}
