package com.haoyu.ncts.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

import com.haoyu.sip.core.utils.ThreadContext;

public class UniqueUidFilter extends AuthorizationFilter {

	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
		// 获取uid
		String uri = ((HttpServletRequest) request).getRequestURI();
		String uid = this.getId(uri, "unique_uid_");
		if (uid.equals(ThreadContext.getUser().getId())) {
			return true;
		}
		super.setUnauthorizedUrl("/error/not_unique_uid.jsp");
		return false;
	}

	private String getId(String uri, String prefix) {
		if (uri.indexOf("/" + prefix) >= 0) {
			String id = StringUtils.substringBetween(uri, "/" + prefix, "/");
			return id;
		}
		return null;
	}

}
