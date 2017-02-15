<#macro incFtl>
	<#assign path="/ncts">
	<#global app_path=PropertiesLoader.get('app.ncts.path') >
	<!-- common -->
	<link rel="stylesheet" href="${ctx }/common/js/mylayer/v1.0/skin/default/mylayer.css">
	<link rel="stylesheet" href="${ctx }/common/js/webuploader/webuploader.css">
	<link rel="stylesheet" href="${ctx }/common/js/flowplayer/skin/functional.css">
	<link rel="stylesheet" href="${ctx }/common/js/flowplayer/quality-selector/flowplayer.quality-selector.css">
	<link rel="stylesheet" href="${ctx }/common/js/validation/css/cmxform.css">
	
	<script type="text/javascript" src="${ctx }/common/js/jquery.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/jquery.timers.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/jquery.cookie.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/flowplayer/flowplayer.min.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/flowplayer/quality-selector/flowplayer.quality-selector.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/webuploader/webuploader.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/validation/jquery.validate.js"></script> 
	<script type="text/javascript" src="${ctx }/common/js/validation/lib/jquery.metadata.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/validation/expand.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/validation/localization/messages_cn.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/ueditor/ueditor.all.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/ueditor/lang/zh-cn/zh-cn.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/ueditorUtils.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/mylayer/v1.0/mylayer.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/echarts/echarts.min.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/jquery.showUserInfor.js"></script>
	<script type="text/javascript" src="${ctx }/common/js/pdfobject/pdfobject.js"></script>
	<script type="text/javascript" src="${app_path }/js/laypage/laypage.js"></script>
	
	<!-- ncts -->
	<link rel="Shortcut Icon" href="${app_path }/images/favicon.ico">
	<link rel="stylesheet" href="${ctx }/error/css/error.css">
	<link rel="stylesheet" href="${app_path }/js/calendar/css/fullcalendar.css">
	<#--<link rel="stylesheet" href="${app_path }/js/fullcalendar-2.6.1/fullxiugai.css">-->
	<link rel="stylesheet" href="${app_path }/css/reset.css">
	<link rel="stylesheet" href="${app_path }/css/activity-common.css">
	<link rel="stylesheet" href="${app_path }/css/style.css">
	<link rel="stylesheet" href="${app_path }/css/study.css">
	<link rel="stylesheet" href="${app_path }/css/haoyu-private.css">
	<script type="text/javascript" src="${path }/js/common.js"></script>
	<script type="text/javascript" src="${path }/js/sip-common.js"></script>
	<script type="text/javascript" src="${path }/js/index.js"></script>
	<script type="text/javascript" src="${path }/js/tag.js"></script>
	<script type="text/javascript" src="${path }/js/addCourse.js"></script>
	<script type="text/javascript" src="${path }/js/courseLearning.js"></script>
	<script type="text/javascript" src="${path }/js/activity-common.js"></script>
	<script type="text/javascript" src="${path }/js/activity-file.js"></script>
	<script type="text/javascript" src="${path }/js/addTopic.js"></script>
	<script type="text/javascript" src="${path }/js/evaluateStar.js"></script>
	<script type="text/javascript" src="${path }/js/photoChange.js"></script>
	<script type="text/javascript" src="${path }/js/addTestQuestion.js"></script>
	<script type="text/javascript" src="${path }/js/calendar/js/fullcalendar.min.js"></script>
	<script type="text/javascript" src="${path }/js/calendar/js/jquery.fancybox-1.3.1.pack.js"></script>
	<script type="text/javascript" src="${path }/js/calendar/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script type="text/javascript" src="${path }/js/calendar/js/addplay.js"></script>
	<script type="text/javascript" src="${path }/js/jqthumb.min.js"></script>
	<script type="text/javascript" src="${path }/js/photoAlbum.js"></script>
</#macro>