<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
<meta name="author" content="smile@kang.cool">
<meta name="description" content="hello">
<meta name="keywords" content="a,b,c">
<meta http-equiv="Window-target" content="_top">

<link rel="stylesheet" href="/ncts/css/reset.css">
<link rel="stylesheet" href="/ncts/css/style.css">

</head>
<body>
    <div class="g-active-time">
        <div class="time-start">
        	<#if param_msg = 'go to login'>
        		<p>请点击此处登录培训平台</p>
        		<strong></strong>
        		<a href="/"  class="btn u-main-btn">登录</a>
        	<#elseif param_msg = 'train is not started'>
        		<#if param_data??>
        			<#--<p>本次培训将于<span class="time">${param_data?string('MM月dd日')}</span>正式开放</p>-->
        			<p>本次培训还未正式开放</p>
        		<#else>
        			<p>本次培训还未正式开放</p>
        		</#if>
        		<strong>敬请关注！</strong>
        	<#elseif param_msg = 'no course seleted'>		
        		<p>您还未选课</p>
        	<#elseif param_msg = 'not sign up'>		
        		<p>您还未报名</p>
        	</#if>
        </div>
    </div>
</body>
</html> 