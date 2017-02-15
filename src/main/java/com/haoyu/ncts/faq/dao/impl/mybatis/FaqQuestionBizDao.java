package com.haoyu.ncts.faq.dao.impl.mybatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.ncts.faq.dao.IFaqQuestionBizDao;
import com.haoyu.sip.core.jdbc.MybatisDao;
import com.haoyu.tip.faq.entity.FaqQuestion;

@Repository
public class FaqQuestionBizDao extends MybatisDao implements IFaqQuestionBizDao{

	@Override
	public List<FaqQuestion> findFaqQuestionByParameter(Map<String, Object> parameter, PageBounds pageBounds) {
		return super.selectList("selectByParameter", parameter, pageBounds);
	}

	@Override
	public int count(Map<String, Object> parameter) {
		return super.selectOne("count", parameter);
	}

}
