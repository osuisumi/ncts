<#macro incFtl>
	<#assign path="/ncts">
	<#global app_path=PropertiesLoader.get('app.ncts.path') >
	<link rel="Shortcut Icon" href="${app_path }/images/favicon.ico">
	<!-- common -->
	<link rel="stylesheet" href="${ctx }/common/css/common.base.min.css">

 	<link rel="stylesheet" href="${app_path }/css/app_make.min.css">
	<script type="text/javascript" src="${ctx }/common/js/common.base.min.js"></script>
	
	<script type="text/javascript" src="${ctx }/common/js/fly/jquery.fly.min.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/fly/requestAnimationFrame.js"></script>
	
	<script type="text/javascript" src="${app_path }/js/laypage/laypage.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${path }/js/ncts_make.min.js"></script>
	
	<!-- ueditor -->
	<script type="text/javascript" src="${ctx }/common/js/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/ueditor/ueditor.all.min.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/ueditorUtils.js"></script>
	
	<!--calendar-->
	<script type="text/javascript" src="${path }/js/calendar/js/fullcalendar.min.js"></script>
	<script type="text/javascript" src="${path }/js/calendar/js/jquery.fancybox-1.3.1.pack.js"></script>
	<script type="text/javascript" src="${path }/js/calendar/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="${path }/js/calendar/js/addplay.js"></script>
	<!--jqthumb-->
	<script type="text/javascript" src="${path }/js/jqthumb.min.js"></script>
</#macro>