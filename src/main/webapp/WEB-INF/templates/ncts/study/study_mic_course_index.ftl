<#include "/ncts/study/include/layout_mic.ftl"/>
<@layout>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign hasStudentRole=SecurityUtils.getSubject().hasRole('course_study_'+cid)>
	<@micCourseContent courseId=cid>
		<@videoUser videoId=video_activity.entityId activityId=video_activity.id relationId=cid>
			<#assign videoRelation=(videoUser.videoRelation)!>
			<#assign video=(videoRelation.video)!>
			<#assign activity=(activityResult.activity)!>
			<div class="g-bd">
	            <div class="g-wk-part1">
	                <div class="g-wk-auto">
	                    <h2 class="m-wk-tl">${(video.title)! }</h2>
	                    <div class="m-study-video">
	                        <div id="player" style="height: 500px;"></div>
	                    </div>
	                </div>                
	            </div>
	            <div class="g-wk-part2">
	                <div class="g-wk-auto">
	                    <ol class="m-wk-nav">
	                        <li><a onclick="listDiscussion()"><i class="u-discuss"></i>讨论</a></li>
	                        <li><a onclick="viewTest()" class="z-crt"><i class="u-test"></i>测验</a></li>
	                        <li><a onclick="listNote()"><i class="u-notes"></i>笔记</a></li>
	                        <li><a onclick="listFaq()"><i class="u-answer"></i>问答</a></li>
	                    </ol>
	                    <script>
	                    	$('.m-wk-nav a').click(function(){
	                    		$('.m-wk-nav a').removeClass('z-crt');
	                    		$(this).addClass('z-crt');
	                    	});
	                    </script>
	                    <div id="micContentDiv"  class="contentDiv">
	                    
	                    </div>     
	                </div>
	            </div>
	        </div>
	        <script>
	        	$(function(){
	        		viewTest();
	        		
	        		$('.topCourseName').text('${course.title!}');
	        		
	        		//如果是预览, 去掉头部底部
	        		if('${SecurityUtils.getSubject().hasRole("preview_"+cid)?string("Y","N")}' == 'Y'){
	        			$('#top').hide();
	        			$('#footer').hide();
	        		}
	        	});
	        
				var isFirst = true;
				var startTime;
				var endTime;
				var api;
				var watchTime = 0;
				var interval = parseInt('${PropertiesLoader.get("video.lastTime.update.interval")!60}');
				var container = document.getElementById("player");
				var cookieKey = 'video_last_view_time_${video.id!}_${Session.loginer.id}';
				var qualities = null;
				var url = null;
				if('${(video.type)!""}' == 'file'){
					url = '${FileUtils.getFileUrl("")}${(video.videoFiles[0].url)!}';
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
						autoplay: true,		
					    clip: {
					        sources: [
								{
									type: "video/flash",
									src:  url
								},
					        	{ 
					            	type: "video/webm",
					                src:  url 
					            },
					            {
					            	type: "video/mp4",
					                src:  url 
					            }
					        ]
					    }
					});
					
					api.on("ready", function (e, api, video) {
						var s_h = parseInt("${TimeUtils.getFieldValue((video.timePeriod.startTime)!, 'hour')}!'0'");
						var s_m = parseInt("${TimeUtils.getFieldValue((video.timePeriod.startTime)!, 'minute')!'0'}");
						var s_s = parseInt("${TimeUtils.getFieldValue((video.timePeriod.startTime)!, 'second')!'0'}");
						var e_h = parseInt("${TimeUtils.getFieldValue((video.timePeriod.endTime)!, 'hour')}!'0'");
						var e_m = parseInt("${TimeUtils.getFieldValue((video.timePeriod.endTime)!, 'minute')}!'0'");
						var e_s = parseInt("${TimeUtils.getFieldValue((video.timePeriod.endTime)!, 'second')}!'0'");
						startTime = s_h * 3600 + s_m * 60 + s_s;
						endTime = e_h * 3600 + e_m * 60 + e_s;
						if(startTime >= parseFloat(video.duration)){
							startTime = 0; 
						}
						if(endTime <= 0 ){
							endTime = video.duration;
						}
					}).on("resume", function (e, api, video) {
						if(isFirst){
							isFirst = false;
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
					}).on("progress", function (e, api, time) {
						if((time >= endTime - 0.3 && time <= endTime + 0.3) || time >= api.video.duration - 0.5){
							api.stop();	
						}
					}).on("stop", function (e, api, video) {
						isFirst = true;
						removeCoolie();
					}).on("pause",function (e, api, video) {
						$('#player').stopTime('A');
					})
				});
				
				function setTime(){
					$('#player').everyTime('1s', 'A', function(){
						setCookie(api.video.time); 
						console.info(watchTime);
						if(watchTime != 0 && watchTime % parseInt(interval) == 0){
							console.info(watchTime);
							updateLastViewTime(api.video.time);
						}
						watchTime++;
					});
				}
				
				function setCookie(time){
					if(time < endTime && time > startTime){
						$.cookie(cookieKey, time, { expires: 30, path: '/' });
					}
				}
				
				function removeCoolie(){
					$.cookie(cookieKey,'');
					updateLastViewTime(0);
				}
				
				function updateLastViewTime(time){
					if('${hasStudentRole?string("Y", "N")}' == 'Y'){
						console.info('in');
						$.put('${ctx}/video/user/${videoUser.id}', 'lastViewTime='+time+'&viewTime='+interval);	
					}
				}
				
				function listDiscussion(){
					$('#micContentDiv').load('${ctx}/${cid}/study/course/mic/listDiscussion','paramMap[relationId]=${cid!}&paramMap[relationType]=courseStudy&orders=CREATE_TIME.DESC');
				}
				
				//搜索框动画
				function showSearchBoxAnimate(){
				    var $ipts = $(".showSearchBox .ipt");

				    //获取焦点和失去焦点时执行动画
				    $ipts.on({
				        focus : function(){
				            $(this).parent().addClass('in');
				        },
				        blur : function(){
				            var $this = $(this);
				            //判断输入是否为空，不为空则不执行收回动画
				            /*if($.trim($this.val()) == ''){
				            	
				                $this.val('').parent().removeClass('in');
				            }*/
				        }
				    });
				}
				
				function listNote(){
					$('#micContentDiv').load('${ctx}/${cid}/study/course/mic/listNote');
				}
				
				function listFaq(){
					$('#micContentDiv').load('${ctx}/${cid}/study/course/mic/listFaq');
				}
				
				function viewTest(){
					$('#micContentDiv').load('${ctx}/${cid}/study/course/mic/viewTest', 'id=${test_activity.entityId}&aid=${test_activity.id}');
				}
			</script>
	    </@videoUser>
	</@micCourseContent>
</@layout>