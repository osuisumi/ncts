package com.haoyu.ncts.faq.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.google.common.collect.Maps;
import com.haoyu.ncts.faq.controller.param.FaqQuestionParam;
import com.haoyu.ncts.faq.dao.IFaqQuestionBizDao;
import com.haoyu.ncts.faq.service.IFaqQuestionNctsService;
import com.haoyu.sip.core.web.SearchParam;
import com.haoyu.tip.faq.dao.IFaqQuestionDao;
import com.haoyu.tip.faq.entity.FaqAnswer;
import com.haoyu.tip.faq.entity.FaqQuestion;
import com.haoyu.tip.faq.service.IFaqAnswerService;

@Service
public class FaqQuestionNctsServiceImpl implements IFaqQuestionNctsService {
	@Resource
	private IFaqQuestionDao faqQuestionDao;
	@Resource
	private IFaqQuestionBizDao faqQuestionBizDao;
	@Resource
	private IFaqAnswerService faqAnswerService;

	@Override
	public List<FaqQuestion> listFaqQuestion(FaqQuestionParam faqQuestionParam, PageBounds pageBounds,boolean isLoadAnswer) {
		List<FaqQuestion> faqQuestions = this.faqQuestionBizDao.findFaqQuestionByParameter(faqQuestionParam.getParameter(), pageBounds);
		if(isLoadAnswer){
			setFaqAnswerIntoFaqQuestions(faqQuestions);
		}
		return faqQuestions;
	}

	@Override
	public int count(FaqQuestionParam faqQuestionParam) {
		return this.faqQuestionBizDao.count(faqQuestionParam.getParameter());
	}
	
	private void setFaqAnswerIntoFaqQuestions(List<FaqQuestion> faqQuestions){
		if(!CollectionUtils.isEmpty(faqQuestions)){
			SearchParam searchParam = new SearchParam();
			Map<String,List<FaqAnswer>> faqQuestionIdAnswers = Maps.newHashMap();
			List<String> faqQuestionIds = new ArrayList<String>();
			for(FaqQuestion fq:faqQuestions){
				faqQuestionIds.add(fq.getId());
				faqQuestionIdAnswers.put(fq.getId(), new ArrayList<FaqAnswer>());
			}
			searchParam.getParamMap().put("faqQuestionids", faqQuestionIds);
			List<FaqAnswer> faqAnswers = faqAnswerService.list(searchParam, null);
			if(CollectionUtils.isNotEmpty(faqAnswers)){
				for(FaqAnswer fa:faqAnswers){
					faqQuestionIdAnswers.get(fa.getQuestionId()).add(fa);
				}
			}
			
			for(FaqQuestion fq:faqQuestions){
				fq.setFaqAnswers(faqQuestionIdAnswers.get(fq.getId()));
			}
			
		}
	}

}
