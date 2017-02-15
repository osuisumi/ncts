package com.haoyu.ncts.faq.service;

import java.util.List;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.faq.controller.param.FaqQuestionParam;
import com.haoyu.tip.faq.entity.FaqQuestion;

public interface IFaqQuestionNctsService{
	public List<FaqQuestion> listFaqQuestion(FaqQuestionParam faqQuestionParam, PageBounds pageBounds,boolean isLoadAnswer);
	
	public int count(FaqQuestionParam faqQuestionParam);

}
