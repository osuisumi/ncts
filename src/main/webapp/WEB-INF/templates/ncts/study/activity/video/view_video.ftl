<#macro viewVideoFtl videoId aid relationId>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
	<#assign hasStudentRole=SecurityUtils.getSubject().hasRole('course_study_'+cid)>
	<@videoUser videoId=videoId activityId=aid relationId=relationId>
		<#assign videoRelation=videoUser.videoRelation>
		<#assign video=videoRelation.video>
		<#assign inCurrentDate=TimeUtils.inCurrentDate((activity.timePeriod)!'', (course.timePeriod)!'')>	
		<div class="g-study-dt">
			<#if !hasTeachRole>
				<div class="g-study-prompt">
					<p>
						<#assign view_time=(activity.attributeMap['view_time'].attrValue)!'0'>
						<#if view_time == ''>
							<#assign view_time='0'>
						</#if>
						<#if view_time?number == 0>
							观看视频即可完成活动
						<#else>
							要求观看视频<span>${view_time }</span>分钟
						</#if>
						<i>/</i>
						<#if (((videoUser.viewTime/60)!0) >= ((view_time?number)!0))>
							您已完成观看
						<#else>
							您已观看<span>${((videoUser.viewTime/60)?string("#.#"))!0 }</span>分钟
						</#if>
					</p>
	            	<i class="close">X</i>
	            </div>
	        </#if>
	        <div class="g-studyAct-box spc">
		        <div class="g-studyAct-time">
		            <div class="am-main-r" style="right:0">
		                <#assign timePeriods=[]>
						<#assign timePeriods = timePeriods + [(activity.timePeriod)!]>
						<#assign timePeriods = timePeriods + [(course.timePeriod)!]>
						<#import "/ncts/study/common/show_time.ftl" as st /> 
						<@st.showTimeFtl timePeriods=timePeriods label="活动" /> 
		            </div>    
					<h2 class="title">${(video.title)! }</h2>
					<div class="video-frame-wrap">
						<div id="playerDiv" class="m-study-video">
				        	<!-- <video controls="" width="100%" height="500">
				               <source src="../video/mo.mkv" width="100%">
				               <source src="../video/mo.mp4" width="100%">
				           </video> -->
				           <div id="player" style="height: 500px;"></div>
				           <#--<video src="${FileUtils.getFileUrl("")}${(video.videoFiles[0].url)!}" controls="controls">
								您的浏览器不支持 video 标签。
						   </video>-->
				        </div>
				    </div>
			        <div class="m-studyFt-opt">
			        	<#if video.allowDownload == 'Y'>
			        		<div class="m-studyFt-optLi">
			        			<#if ('file' == (video.type)!'')>
			        				<!-- <a onclick="downloadFile('${video.videoFiles[0].id}', '${video.videoFiles[0].fileName}')" class="btn u-inverse-btn"><i class="u-iVideo-ico"></i>下载视频</a> -->
			        			</#if>
					        </div>
			        	</#if>
				        <!-- <div class="m-studyFt-optLi">
	                        <a href="javascript:void(0);" class="btn u-inverse-btn"><i class="u-iFont-ico"></i>下载字幕</a>
	                    </div> -->
	                    <#if ((video.fileInfos)?size>0)>
			                <div class="m-studyFt-optLi">
	                            <div class="btn u-inverse-btn u-iDownload"><i class="u-iDownload-ico"></i>下载讲义
	                                <div class="m-Download" style="z-index: 999">
	                                    <ol class="Download">
	                                        <#list video.fileInfos as fileInfo>
			                            		<li><span title="${fileInfo.fileName }">${fileInfo.fileName }</span><a onclick="downloadFile('${fileInfo.id}','${fileInfo.fileName }')">下载</a></li>
			                            	</#list>
	                                        <li class="con"></li>
	                                    </ol> 
	                                </div>
	                            </div>                                                
	                        </div>
	                    </#if>
			        </div>
					<div id="player"></div>
				</div>
			</div>
		</div>
		<#if 'file' = (video.type)!''>
			<#assign url = FileUtils.getFileUrl("") + (video.videoFiles[0].url)!>
		<#elseif 'url' = (video.type)!''>	
			<#assign url = video.urls!>
		<#else>	
			<#if '' != (video.urlsMap.NR)!"">
				<#assign url = PropertiesLoader.get("video.record.play.domain") + (video.urlsMap.NR)!>
			<#else>	
				<#assign url = PropertiesLoader.get("video.record.play.domain") + (video.urlsMap.HD)!>
			</#if>
		</#if>
		<script>
			var isFirst = true;
			var startTime;
			var endTime;
			var api;
			var watchTime = 0;
			var interval = parseInt('${PropertiesLoader.get("video.lastTime.update.interval")!60}');
			//interval = 6;
			var container = document.getElementById("player");
			var cookieKey = 'video_last_view_time_${video.id!}_${Session.loginer.id}';
			var qualities = null;
			var url = null;
			var setResult = true;
			var isAlert = true;
			var isComplete = false;
			if('${video.type}' == 'file'){
				url = '${FileUtils.getFileUrl("")}${(video.videoFiles[0].url)!}';
			}else if('${video.type}' == 'url'){
				url = '${video.urls!}';
			}else{
				if('${(video.urlsMap.NR)!""}' != ''){
					url = '${PropertiesLoader.get("video.record.play.domain")}${(video.urlsMap.NR)!}';
				}else{
					url = '${PropertiesLoader.get("video.record.play.domain")}${(video.urlsMap.HD)!}';
				}
				if('${(video.urlsMap.NR)!""}' != '' && '${(video.urlsMap.HD)!""}' != ''){
					qualities = ["高清", "标清"];
				}
			} 
			$(function(){
				api =  flowplayer(container, {
					qualities: qualities,
				    defaultQuality: "标清",
					autoplay: false,		
				    clip: {
				        sources: [
				        	<#if FileUtils.getFileSuffix(url) == 'mp4'>
				        		{
					            	type: "video/mp4",
					                src:  url 
					            },
				        	</#if>
							{
								type: "video/flash",
								src:  url
							},
				        	{ 
				            	type: "video/webm",
				                src:  url 
				            }
				        ]
				    }
				});
				
				api.on("ready", function (e, api, video) {
					<#--var s_array = '${video.startTime!''}'.split(',');
					var s_h = s_array[0]==''?0:parseInt(s_array[0]);
					var s_m = s_array[1]==''?0:parseInt(s_array[1]);
					var s_s = s_array[2]==''?0:parseInt(s_array[2]);
					var e_array = '${video.endTime!''}'.split(',');
					var e_h = e_array[0]==''?0:parseInt(e_array[0]);
					var e_m = e_array[1]==''?0:parseInt(e_array[1]);
					var e_s = e_array[2]==''?0:parseInt(e_array[2]);
					startTime = s_h * 3600 + s_m * 60 + s_s;
					endTime = e_h * 3600 + e_m * 60 + e_s;
					if(startTime >= parseFloat(video.duration)){
						startTime = 0; 
					}
					if(endTime <= 0 ){
						endTime = video.duration;
					}-->
					startTime = 0; 
					endTime = video.duration;
					if(video.duration < interval){
						interval = video.duration;
					}
					
				}).on("resume", function (e, api, video) {
					if(isFirst){
						setResult = true;
						isFirst = false;
						api.seek(0);
						var cookieTime = $.cookie(cookieKey);
						if(cookieTime != null && cookieTime != ''){
							api.seek(cookieTime);
						}else{
							if('${videoUser.lastViewTime!0}' != 0){
								api.seek('${videoUser.lastViewTime!0}');
							}else{
								api.seek(startTime);
							}
						}
					}
					setTime();
					$.put('/${aid}/study/video/user/updateVideoStatus', 'id=${videoUser.id}');
				}).on("progress", function (e, api, time) {
					if((time >= endTime - 0.3 && time <= endTime + 0.3) || time >= api.video.duration - 0.5){
						api.stop();	
					}
				}).on("stop", function (e, api, video) {
					isFirst = true;
					removeCoolie();
					$('#playerDiv').stopTime('A');
					updateLastViewTime(api.video.time, false, function(){
						$.put('/${aid}/study/video/user/removeVideoStatus');
					});
				}).on("pause",function (e, api, video) {
					$('#playerDiv').stopTime('A');
					updateLastViewTime(api.video.time, false, function(){
						$.put('/${aid}/study/video/user/removeVideoStatus');
					});
				})
			});
			
			function setTime(){
				if(!isComplete){
					$('#playerDiv').everyTime('1s', 'A', function(){
						setCookie(api.video.time); 
						if(watchTime != 0 && watchTime % parseInt(interval) == 0){
							updateLastViewTime(api.video.time, true);
						}
						watchTime++;
					});
				}
			}
			
			function setCookie(time){
				if(time < endTime && time > startTime){
					$.cookie(cookieKey, time, { expires: 30, path: '/' });
				}
			}
			
			function removeCoolie(){
				$.cookie(cookieKey,null);
				$.put('${ctx}/${aid}/study/video/user/${videoUser.id}', 'lastViewTime=0');
			}
			
			function updateLastViewTime(time, isLimit, callback){
				if(!isComplete){
					time = time.toFixed(0);
					if(setResult){
						if('${hasStudentRole?string("Y", "N")}' == 'Y' && '${inCurrentDate?string("Y", "N")}' == 'Y'){
							$.put('${ctx}/${aid}/study/video/user/${videoUser.id}/updateViewTime', 'lastViewTime='+time+'&isLimit='+isLimit, function(data){
								if(callback!=undefined){
									var $callback = callback;
									if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
									$callback();
								}
								if(data.responseCode == '01' && data.responseMsg == 'more video is open'){
									api.pause();
									mylayerFn.btns({
								        content: '系统检测到您的账号已打开其他视频的观看页面, 为防止多个视频活动同时计时, 请为此前视频活动作以下选择',
								        icon: 3,
								        btns: [
								            {content:"计时观看", type:1, close: true, fn:function(){
								                $.put('/${aid}/study/video/user/updateVideoStatus', 'id=${videoUser.id}', function(data){
									        		if(data.responseCode == '00'){
									        			api.resume();
									        		}
									        	});
								            }},
								            {content:"不计时观看", type:2, close: true,fn: function(){
								                setResult = false;
								        		api.resume();
								            }}
								        ]
								    });
								}else{
									if(isAlert){
										var viewTime = data.responseData;
										if(viewTime != ''){
											viewTime = parseInt(viewTime);
											if(viewTime >= parseInt('${view_time!"0"}') * 60){
												isAlert = false;
												isComplete = true;
												$('#playerDiv').stopTime('A');
												mylayerFn.btns({
											        content: '您已完成这个活动',
											        icon: 3,
											        btns: [
											            {content:"确定", type:1, close: true}
											        ]
											    });
											}
										}
									}
								}
							});	
						}
					}
				}
			}
			<#if ((video.summary)??) && (video.summary!='')>
				$(function(){
					//课程导读
						$('#videoSummaryDiv .txt').text('${video.summary?replace("\r\n", "<br>")}');
						$('#videoSummaryDiv').show();
						flyRead();
						var flag = $.cookie('watchSummary_${(video.id)!""}_${(Session.loginer.id)!""}');
						if(flag == 'Y'){
							$('#videoSummaryDiv .g-studyRead-layer').hide();
							$(".m-studyRight-opt .item3").animate({'backgroundColor' : '#e8a119'}, 500);
						}
						$.cookie('watchSummary_${(video.id)!""}_${(Session.loginer.id)!""}', 'Y', { expires: 30, path: '/' });
				});
			</#if>
			
			function flyRead(){
			    var Texth = $(".g-studyRead-layer h3").text();
			    var Texttxt = $(".g-studyRead-layer .txt").text();
			   $(".g-studyRead-layer .close").click(function(event){ 
			        
			        $(".g-studyRead-layer h3").text("");
			        $(".g-studyRead-layer .txt").text("");
			        $(".g-studyRead-layer .close").text("");
			        var offset = $("#end").offset(); 
			        var addcar = $(this); 
			        var img = addcar.parent().find('img').attr('src'); 
			        var flyer = $(".u-flyer");
			        
			        $(".g-studyRead-layer").animate({"height":"0px","width":"40","top":"170px","left":"-250px","opacity":"0.8"},500,function(){
			            $(".g-studyRead-layer").prepend("<span class='u-flyer'></span>");
			            $(".m-studyRight-opt .item3").animate({'backgroundColor' : '#e8a119'}, 500);
			            $(".g-studyRead-layer").css({"opacity":"0"});
			            $(".g-studyShade2").css({"display":"none"});
			            $(".u-flyer").animate({'backgroundColor' : '#e8a119'}, 200);
			            var flyer = $(".u-flyer");
			
			            flyer.fly({ 
			                start: { 
			                    left: event.pageX, //开始位置（必填）#fly元素会被设置成position: fixed ,已经在js里改为position:absolute
			                    top: event.pageY //开始位置（必填） 
			                }, 
			                end: { 
			                    left: offset.left+10, //结束位置（必填） 
			                    top: offset.top+10, //结束位置（必填） 
			                    width: 40, //结束时宽度 
			                    height: 0, //结束时高度 
			                    opacity:0
			                }, 
			                autoPlay:true,
			                speed: 2.1, 
			                vertex_Rtop:400,               
			                onEnd: function(){ //结束回调 
			
			                } 
			            }); 
			
			        });
			
			    });
			
			    $("body").on("click",".m-studyRight-opt .item3",function(event){
			    	$('#videoSummaryDiv .g-studyRead-layer').show();
			        $(".g-studyRead-layer h3").text("");
			        $(".g-studyRead-layer .txt").text("");
			        $(".g-studyRead-layer .close").text("");       
			        $(this).prepend("<span class='u-flyer'></span>");
			        $(".u-flyer").css({'background':'#e8a119'}).animate({'backgroundColor' : '#fafafa'}, 200);
			        var offset = $(".g-studyRead-layer").offset(); 
			        var addcar = $(this); 
			        var img = addcar.parent().find('img').attr('src'); 
			        var flyer = $(".u-flyer");
			        
			  
			            flyer.fly({ 
			                start: { 
			                    left: event.pageX, //开始位置（必填）#fly元素会被设置成position: fixed 已经在js里改为position:absolute
			                    top: event.pageY //开始位置（必填） 
			                }, 
			                end: { 
			                    left: offset.left+10, //结束位置（必填） 
			                    top: offset.top+10, //结束位置（必填） 
			                    width: 40, //结束时宽度 
			                    height:20, //结束时高度 
			                    opacity:1
			                }, 
			                autoPlay:true,
			                speed: 2.1, 
			                vertex_Rtop:400, 
			                onEnd: function(){ //结束回调 
			                    $(".g-studyRead-layer").css({"opacity":"1"});
			                    $(".g-studyShade2").css({"display":"block"});
			                    $(".m-studyRight-opt .item3").animate({'backgroundColor' : '#bebebe'}, 500);
			                    $(".u-flyer").animate({'backgroundColor' : '#bebebe'}, 500).css({"opacity":"0"});
			                    $(".g-studyRead-layer").css({"overflow":"visible"}).animate({"height":"416px","width":"340","top":"10px","left":"-400px","z-index":""+100+""},500,function(){
			                        $(".g-studyRead-layer h3").text(Texth);
			                        $(".g-studyRead-layer .txt").text(Texttxt);
			                        $(".g-studyRead-layer .close").text("关闭>");
			                    });
			
			                } 
			            });         
			     });
			}
		</script>
	</@videoUser>
</#macro>