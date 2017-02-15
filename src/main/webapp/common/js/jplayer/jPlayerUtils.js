/*
 * url:视频地址
 * size：包含width,height,cssClass的json
 * cssSelectorAncestor:包裹视频的div的id,用于定位
 * cssSelector:包含jplayer一系列的按钮的json
 * playerWindow:播放窗体id
 * eventListeners:事件监听
 */
function createJPlayer(url,size,cssSelectorAncestor,cssSelector,playerWindow,eventListeners) {
	//设置size,cssSelectorAncestor,cssSelector默认值
	size = arguments[1]||{
		width:'670px',
		height:'370px',
		cssClass:'jp-video-360p'
	};
	cssSelectorAncestor = arguments[2]||$.jPlayer.prototype.options.cssSelectorAncestor;
	
	cssSelector = arguments[3]||$.jPlayer.prototype.options.cssSelector;
	
	playerWindow = arguments[4]||"#jquery_jplayer_1";

	return $(playerWindow).jPlayer({
		ready : function() {
			$(this).jPlayer("setMedia", {
				flv:url,
				m4v:url
			});
		},
		swfPath : "/js/jplayer/dist/jplayer",
		supplied : 'flv,m4v',
		solution : "flash,html",
		// 尺寸
		size : size,
		error : function(event) {
			switch (event.jPlayer.error.type) {
			case $.jPlayer.error.URL:
				alert('视频不存在');
				break;
			case $.jPlayer.error.NO_SUPPORT:
				alert('不支持的格式');
			}
		},
		// 平滑过渡播放条,默认false
		smoothPlayBar : false,
		// 初始化全屏状态，默认false
		fullScreen : false,
		// 设置全窗口模式的初始状态 false
		fullWindow : false,
		// 初始音量0-1
		volume : 0.5,
		// 初始化静音状态
		muted : false,
		// 为true时音量从底部开始计算
		verticalVolume : false,
		// 背景色，默认
		backgroundColor : '#000000',
		// 启用通过alert报错 false
		// errorAlerts:true,
		// 启用alert提示信息 false
		warningAlerts : true,
		cssSelectorAncestor : cssSelectorAncestor,
		cssSelector:cssSelector,
		useStateClassSkin : true,
		autoBlur : false,
		smoothPlayBar : true,
		keyEnabled : true,
		remainingDuration : true,
		toggleDuration : true,
		timeupdate: function(event){
			if(eventListeners.timeupdate){
				eventListeners.timeupdate(event);
			}
		}
	});
}

function reSetVideo(url){
	var media = {};
	media['flv'] = url;
	media['mp4'] = url;
	$('#jquery_jplayer_1').jPlayer( "setMedia",media); 
}
