<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
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
<link rel="Shortcut Icon" href="../images/favicon.ico">
<link rel="stylesheet" href="../css/library/reset.css">
<link rel="stylesheet" href="css/error.css">
<title>页面出错了</title>
</head>
<body class="errorBody">
    <!--begin error auto content -->
    <div class="g-error-auto">
        <!--begin error 403 page -->
        <div class="g-error-content g-403">
            <div class="cont">
                <p>您无权限访问当前页面，您可以：</p>
                <div class="btn-row">
                    <a href="${ctx}/" class="u-main-btn">返回首页</a>
                </div>
            </div>
        </div>
        <!--end error 403 page -->
    </div>
    <!--begin error auto content -->
</body>
</html>