package com.haoyu.ncts.utils;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.sip.utils.Collections3;

import freemarker.core.Environment;
import freemarker.ext.beans.BeanModel;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateModelException;

public class PageSplitUtils {

	public static PageBounds getPageBounds(Map params, Environment env){
		PageBounds pageBounds = null;
		if (params.containsKey("pageBounds")  && params.get("pageBounds") != null) {
			BeanModel beanModel = (BeanModel) params.get("pageBounds");
			pageBounds = (PageBounds)beanModel.getWrappedObject();
			if (Collections3.isEmpty(pageBounds.getOrders())) {
				String orders = "CREATE_TIME.DESC";
				pageBounds.setOrders(Order.formString(orders));
				try {
					env.setVariable("orders", new DefaultObjectWrapper().wrap(orders));
				} catch (TemplateModelException e) {
					e.printStackTrace();
				}
			}else{
				List<Order> orderList = pageBounds.getOrders();
				StringBuilder sb = new StringBuilder();
				for (Order order : orderList) {
					sb.append(order.toString()).append(",");
				}
				String orders = StringUtils.replace(StringUtils.removeEnd(sb.toString(), ","), " ", ".");
				try {
					env.setVariable("orders", new DefaultObjectWrapper().wrap(orders));
				} catch (TemplateModelException e) {
					e.printStackTrace();
				}
			}
		}else if(params.containsKey("limit") && params.get("limit")!=null){
			String limit = params.get("limit").toString();
			pageBounds = new PageBounds();
			pageBounds.setContainsTotalCount(true);
			pageBounds.setLimit(Integer.valueOf(limit));
		}
		return pageBounds;
	}
	
}
