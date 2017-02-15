function initProduceEditor(id, content, relations){
	UE.delEditor(id);
	var ue = UE.getEditor(id, {
		toolbars : [ [ 'bold', //加粗
		'italic', //斜体
		'underline', //下划线
		'strikethrough', //删除线
		'fontborder', //字符边框
		'horizontal', //分隔线
		'fontfamily', //字体
		'fontsize', //字号
		'justifyleft', //居左对齐
		'justifyright', //居右对齐
		'justifycenter', //居中对齐
		'justifyjustify', //两端对齐
		'forecolor', //字体颜色
		'backcolor', //背景色
		'lineheight', //行间距
		'imagenone', 'imageleft', 'imageright', 'imagecenter', 'simpleupload', 'insertimage' ] ],
		scaleEnabled : true
	});
	ue.ready(function() {
		ue.execCommand('serverparam', {
			'relations' : relations
		});
	});
	ue.addListener("ready", function() {
		if(content != null && content != ''){
			ue.setContent(content);
		}
	});
	return ue;
}
