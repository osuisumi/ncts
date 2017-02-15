<%@page import="com.haoyu.aip.video.entity.VideoUser"%>
<%@page import="com.haoyu.aip.video.dao.impl.mybatis.VideoUserDao"%>
<%@page import="com.haoyu.aip.video.dao.IVideoUserDao"%>
<%@page import="org.springframework.data.redis.core.RedisTemplate"%>
<%@page import="com.haoyu.sip.core.utils.PropertiesLoader"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>

</head>
<body>
</body>
<script>
	<% 
		ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(request.getServletContext());
		IVideoUserDao dao = (IVideoUserDao)applicationContext.getBean(VideoUserDao.class);
		VideoUser videoUser = new VideoUser();
		videoUser.setId('');
		videoUser.setUpdateTime(1);
		videoUser.setViewTime(1)
		dao.update(videoUser);
 	%>
</script>
</html>