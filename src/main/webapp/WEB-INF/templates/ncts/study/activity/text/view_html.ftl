<#macro viewHtmlFtl textInfoId aid relationId>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
	<@textInfoUser textInfoId=textInfoId  activityId=aid relationId=relationId>
		<#assign textInfoRelation=textInfoUser.textInfoRelation>
		<#assign textInfo=textInfoRelation.textInfo>
		<#assign inCurrentDate=TimeUtils.inCurrentDate((activity.timePeriod)!'', (course.timePeriod)!'')>	
		<div id="viewHtmlDiv" class="g-study-dt">
			<#if !hasTeachRole>
				<div class="g-study-prompt">
					<p>
						<#assign view_num=(activity.attributeMap['view_num'].attrValue)!'0'>
						<#if view_num == ''>
							<#assign view_num='0'>
						</#if>
						<#if (view_num?number == 0)>
							观看文档即可完成活动
						<#else>
							要求观看文档<span>${view_num }</span>次
						</#if>
						<i>/</i>
						您已观看<span>${(textInfoUser.viewNum)!0 }</span>次
					</p>
	            	<i class="close">X</i>
	            </div>
	        </#if>
	        <div class="g-studyAct-box spc">
	            <div class="g-studyAct-time">
	                <div class="am-main-r">
	                    <#assign timePeriods=[]>
						<#assign timePeriods = timePeriods + [(activity.timePeriod)!]>
						<#assign timePeriods = timePeriods + [(course.timePeriod)!]>
						<#import "/ncts/study/common/show_time.ftl" as st /> 
						<@st.showTimeFtl timePeriods=timePeriods label="活动" /> 
	                </div>    
	            </div>
	            <h2 class="title">${(textInfo.title)!}</h2>
	            <#if 'link' == (textInfo.type)!''>
	            	<a href="javascript:;" class="u-full-screen" id="fullScreen"></a>
	            	<div class="video-frame-wrap">
	            		<iframe src="${textInfo.content }" width="100%" height="440px;"></iframe>
	            		<i class="ico-close"></i>
	            	</div>
			    <#elseif 'file' == (textInfo.type)!''>
			        <a href="javascript:;" class="u-full-screen" id="fullScreen"></a>
			        <div class="video-frame-wrap" style="height:700px;">
				        <div id="pdfwrap" style="width:100%;height:700px;">
	                                           
	                    </div>
	                    <i class="ico-close"></i>
	                </div>
                    <script>
                  		//加载pdf
                   		PDFObject.embed('${FileUtils.getFileUrl(textInfo.contentMap.pdf_url)}', "#pdfwrap",{forcePDFJS:true,PDFJS_URL:"${FileUtils.getFileUrl(textInfo.contentMap.pdf_url)}"});
                    </script>
                <#elseif 'photo' == (textInfo.type)!''>
                	<@textInfoFilesDirective textInfoId=textInfo.id!>
                		<#assign textInfoFiles=textInfoFiles>
                	</@textInfoFilesDirective>
                	<a href="javascript:;" class="u-full-screen" onclick="openNew()"></a>
                	<div class="video-frame-wrap" style="height:auto">
                		<div class="m-study-photo">
		                    <div class="g-photoPreview-wrap" id="photoPreviewBd">
		                        <div class="g-photoPreview-layer">
		                            <div class="photo-preview-content">
		                            	<i class="ico-close"></i>
		                                <div id="previewDiv" class="photo-preview-bArea" onselectstart="return false">
		                                    <!--<a href="javascript:void(0);" class="prev" id="photoPreiewPrev"></a>
		                                    <a href="javascript:void(0);" class="next" id="photoPreiewNext"></a>-->
		                                    <ul class="m-preview-bList">
		                                        <li class="z-crt" style="width: 100%;">
		                                            <div class="img-pic" style="height:700px;">
		                                            	<#list textInfoFiles as textInfoFile>
								                			<#if textInfoFile_index == 0>
								                				<iframe name="photoFrame" scrolling="no" id="photoFrame" src="/${aid}/study/course/textInfo/file/${textInfoFile.id}/view" width="100%" height="700" ></iframe>
								                			</#if>
								                		</#list>
		                                            </div>
		                                        </li>
		                                    </ul>
		                                </div>
		                                <div class="photo-preview-sArea">
		                                    <a href="javascript:void(0);" class="prev" id="photoPreiewFocusPrev"></a>
		                                    <a href="javascript:void(0);" class="next"  id="photoPreiewFocusNext"></a>
		                                    <div class="ofh">
		                                        <ul class="m-preview-sList" style="width: 2200px">
		                                        	<#list textInfoFiles as textInfoFile>
		                                            	<li textInfoFileId="${textInfoFile.id}" onclick="changeFrame('${textInfoFile.id}', this)" class="z-crt"><span class="border"></span><img src='${FileUtils.getFileUrl("text_info_file/")}${textInfoFile.id}/1.jpg' alt=""></li>
		                                            </#list>
		                                        </ul>
		                                    </div>
		                                </div>
	                				</div>
	                			</div>
	                		</div>
	                	</div>
                	</div>
                	<script>
                		$(function(){
                			$('#lTr').click(function(){
                				var $frame = $(window.frames["photoFrame"].document);
                				var $img;
                				$frame.find('.image3d').each(function(){
                					if($(this).css('display') == 'block'){
                						$img = $(this);
                						return false;
                					}
                				});
                				var width = $img.width();
                				var height = $img.height();
                				if($('#lTr').hasClass('act')){
                					var contentWidth = $('#viewHtmlDiv').width();
                					var h = contentWidth / width * height
                					$('#photoFrame').height(700);
                					$('#previewDiv').height(700);
                				}else{
                					var contentWidth = $('#content').width();
                					var h = contentWidth / width * height
                					$('#photoFrame').height(h);
                					$('#previewDiv').height(h);
                				}
                			});
                			
                			$('.m-preview-sList li img').jqthumb({
						        width: 80,
						        height: 60,
						    });
						    photoPreview.init();
						    heightauto();
						    function heightauto(){
						        var photobox = $(".photo-preview-bArea .m-preview-bList"),
						            photobox_li = photobox.children('.z-crt').height();
						            photobox.height(photobox_li);      
						    }
						    $("body").on("click","#photoPreiewPrev,#photoPreiewNext,.m-preview-sList li",function(){
						        heightauto();
						    })
						    $("body").on("click",".g-study-mn #lTr",function(){
						        heightauto();
						    });
						    
						    $('.m-preview-sList li').off('click.photoChange');
                		});
                		
                		function changeFrame(id, obj){
                			$('.m-preview-sList li').removeClass('z-crt');
						    $(obj).addClass('z-crt')
                			$('#photoFrame').attr('src', '/${aid}/study/course/textInfo/file/'+id+'/view');
                		}
                		
                		function openNew(){
                			var id = $('.m-preview-sList li.z-crt').attr('textInfoFileId');
                			console.info(id);
                			window.open('/${aid}/study/course/textInfo/file/'+id+'/view');
                		}
                	</script>
                	<!-- <a href="javascript:;" class="u-full-screen" id="fullScreen"></a>
	            	<div id="fullScreenWrap">
			            <div class="fullScreen-shadow"></div>
			            <iframe src="" frameborder="0" ></iframe>
			            <a href="javascript:;" class="close" title="关闭"></a>
			        </div> -->
	            <#else>
	            	<ul>
		                <li class=" m-topic-studyct">
		                    ${(textInfo.content)!}
		                </li> 
		            </ul> 
	            </#if>
	        </div>
	    </div>
	    <#if inCurrentDate>
	    	<script>
	    		$(function(){
	    			var interval = '${(activity.attributeMap[incInterval])!""}';
	    			if(interval == null || interval == ''){
	    				interval = 0.2
	    			}else{
	    				interval = parseFloat(interval);
	    			}
	    			$('#viewHtmlDiv').oneTime(interval * 60 + 's', 'A', function() {
	    				$.put('${ctx}/${aid}/study/course/textInfo/user/updateAttempt', 'id=${textInfoUser.id}');
	    			});
	    		})
	    	</script>
	    </#if>
	    <#if 'editor' != (textInfo.type)!''>
	    	<script>
		    	$(function(){
					fullScreen();
					screenLook(8000,500);
				});
			</script>
	    </#if>
	    <script>
			function fullScreen(){
			    var fullBtn = $("#fullScreen"),
			        par = $(".video-frame-wrap"),
			        close = par.find(".ico-close");
			    fullBtn.on('click',function(){
			        par.addClass("full");
			        $("body").css("overflow","hidden");
			    });
			    close.on("click",function(){
			        par.removeClass("full");
			        $("body").css("overflow","scroll");
			    })
			}
				
			function screenLook(delaytime,hidetime){
			    // 全屏观看提示
			    var tipLook = $('<span class="u-lookBig"><i class="arrow"></i>这里可以全 <br /> 屏观看哦~</span>');
			    $(".g-study-frame").before(tipLook);
			    $(".u-lookBig").addClass('u-look-shake').delay(delaytime).fadeOut(hidetime,0,function(){
			        $(".u-lookBig").remove();
			    });   
			}
		</script>
	</@textInfoUser>
</#macro>