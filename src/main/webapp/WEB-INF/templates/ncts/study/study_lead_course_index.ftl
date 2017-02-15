<#include "/ncts/study/include/layout.ftl"/>
<@layout>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign sid=(CSAIdObject.getCSAIdObject().scid)!>
	<#assign aid=(CSAIdObject.getCSAIdObject().aid)!>
	<@courseDirective id=cid>
		<#global course=courseModel>
	</@courseDirective>
	<@leadCourseContent courseId=cid getResult=true>
		<div class="g-cl-content">
			<div class="g-cl-study">
				<div class="g-study-frame f-cb">
					<div class="g-study-sd">
						<#assign parent_index=0> 
						<#assign child_index=0> 
						<ul class="g-course-catalog" id="courseCatalog">
							<#list sections as section>
								<#if ('Y' != (section.isHidden)!'') && (!(section.timePeriod.startTime)?? || (TimeUtils.hasBegun(section.timePeriod.startTime)))>
									<li>
										<dl class="m-course-catalog">
											<dt class="z-crt">
												<h3 class="tt-b" title="${section.title!}">
													<i class="u-catalog-ico"></i>${section.title!}</h3>
												<div class="tr">
													<a href="javascript:;" class="opt"></a>
												</div>
											</dt>
											<#list section.childSections as childSection> 
												<#if ('Y' != (childSection.isHidden)!'') && (!(childSection.timePeriod.startTime)?? || (TimeUtils.hasBegun(childSection.timePeriod.startTime)))>
													<#if sid! == '' && section_index == parent_index && childSection_index == child_index> 
														<#assign sid=childSection.id> 
													</#if>
													<dd>
														<a onclick="studyCourse('${cid}', '${childSection.id }')" href="###" class="section tt-s 
						                                    	<#if sid == childSection.id>
						                                    		z-crt
						                                    	</#if>
						                                    "> 
						                                    <span class="txt" title="${childSection.title!}">${childSection.title!}</span>
						                                    <#assign completeNum=0>
						                                    <#if (activityResultMap[childSection.id])?? >
						                                    	<#list activityResultMap[childSection.id] as activityResult>
							                                    	<#if activityResult.state! == 'complete'>
							                                    		<#assign completeNum=completeNum+1>
							                                    	</#if>
							                                    </#list>
						                                    </#if>
						                                    <#if completeNum == (activityNumMap[childSection.id])!0>
						                                    	<span class="tr"><i class="u-state-ico done"></i></span>
						                                    <#elseif completeNum == 0>
						                                    	<span class="tr"><i class="u-state-ico"></i></span>
						                                    <#else>
						                                    	<span class="tr"><i class="u-state-ico ing"></i></span>
						                                    </#if>
														</a>
													</dd>
												<#else>	
													<#assign child_index=child_index+1> 
												</#if>
											</#list>
										</dl>
									</li>
								<#else>
									<#assign parent_index=parent_index+1> 
								</#if>
							</#list>
						</ul>
					</div>
					<div class="g-study-mn">
						<div class="m-study-box">
							<div class="m-study-opt" id="studySelectAct">
								<@activitiesDirective relationId="${sid! }" getResult=true>
								<div class="dd-box">
									<a href="javascript:void(0);" class="swich"><i class="u-listH-ico"></i></a>
									<ul class="t-list">
										<#if activities??>
											<#list activities as activity> <#if aid! == '' && activity_index == 0> <#assign aid=activity.id> </#if>
												<li class="
													<#if aid == activity.id>z-crt</#if>
												">
													<a onclick="studyCourse('${cid}','','${activity.id }')" href="###" class="
				                         				<#if activity.type == 'video'>
				                         					video 
				                         				<#elseif activity.type == 'test'>
				                         					test
				                         				<#elseif activity.type == 'discussion'>
				                         					discuss
				                         				<#elseif activity.type == 'survey'>
				                         					survey
				                         				<#elseif activity.type == 'assignment'>
				                         					task
				                         				<#elseif activity.type == 'html'>
				                         					html
				                         				</#if>
				                         				">${activity.title }
						                         	</a>
						                         </li> 
					                         </#list>
										</#if>
									</ul>
								</div>
								<div class="list-box">
									<ul class="m-studyAct-lst">
										<#if activities??>
											<#list activities as activity>
												<#assign state = (activityResultMap[activity.id].state)!''>
												<li class="
													<#if (state == 'complete')>finish</#if>
													<#if aid == activity.id>z-crt</#if>
												">
													<a onclick="studyCourse('${cid}','','${activity.id }')" href="javascript:void(0);" class="
				                           				<#if activity.type == 'video'>
				                           					video 
				                           				<#elseif activity.type == 'test'>
				                           					test
				                           				<#elseif activity.type == 'discussion'>
				                           					discuss
				                           				<#elseif activity.type == 'survey'>
				                           					survey
				                           				<#elseif activity.type == 'assignment'>
				                         					task
				                         				<#elseif activity.type == 'html'>
				                         					html
				                           				</#if>
														">
														<#if (state == 'complete')>
															<i class="u-finish-con">已完成</i>
														</#if>
														<span>${activity.title }</span>
													</a>
												</li> 
											</#list>
										</#if>
									</ul>
								</div>
								</@activitiesDirective>
								<div class="opt-box">
									<a href="javascript:void(0);" class="prev"><i class="u-iPrev-ico"></i></a> 
									<a href="javascript:void(0);" class="next"><i class="u-iNext-ico"></i></a>
								</div>
							</div>
							<#if aid??> 
								<@activityDirective id="${aid }">
									<#if (activity.type)! == 'discussion'> 
										<#import "/ncts/study/activity/discussion/view_discussion.ftl" as vd /> 
										<@vd.viewDiscussionFtl discussionId=activity.entityId! aid=activity.id! relationId=cid /> 
									<#elseif (activity.type)! == 'video'> 
										<#import "/ncts/study/activity/video/view_video.ftl" as vv /> 
										<@vv.viewVideoFtl videoId=activity.entityId! aid=activity.id! relationId=cid/> 
									<#elseif (activity.type)! == 'html'> 
										<#import "/ncts/study/activity/text/view_html.ftl" as vh /> 
										<@vh.viewHtmlFtl textInfoId=activity.entityId! aid=activity.id! relationId=cid/> 
									<#elseif (activity.type)! == 'survey'>
										<#if (surveyStep[0])! == 'viewResult'>
											<#import "/ncts/study/activity/survey/view_survey_result.ftl" as viewSurveyResult/>
											<@viewSurveyResult.viewSurveyResultFtl surveyId=activity.entityId! aid=activity.id relationId=cid />
										<#elseif (surveyStep[0])! == 'questionResultDetail'>
											<#import "/ncts/study/activity/survey/list_survey_submission.ftl" as listSubmissions/>
											<@listSubmissions.listSurveySubmissionsFtl surveyId=activity.entityId! aid=activity.id questionId=(questionId[0])! relationId=cid />
										<#else>
											<#import "/ncts/study/activity/survey/view_survey.ftl" as viewSurvey />
											<@viewSurvey.viewSurveyFtl surveyId=activity.entityId! aid=activity.id relationId=cid /> 
										</#if>
									<#elseif (activity.type)! == 'assignment'>
										<#import "/ncts/study/activity/assignment/view_assignment.ftl" as va />
										<@va.viewAssignmentFtl assignmentId=activity.entityId! aid=activity.id! index=index! relationId=cid/> 
									<#elseif (activity.type)! == 'test'>
										<#import "/ncts/study/activity/test/view_test.ftl" as vt />
										<@vt.viewTestFtl testId=activity.entityId! aid=activity.id! relationId=cid/> 
									</#if> 
								</@activityDirective> 
							</#if>
						</div>
						<span class="u-ltr" id="lTr"><i class="u-ico-triangle"></i></span>
					</div>
				</div>
				<div class="m-studyRight-opt">
					<a href="javascript:void(0);" class="item1" id="openNoteLayerUnit"><i class="u-iNote-ico"></i><br>笔记</a> 
					<a href="javascript:void(0);" class="item2" id="openQaLayerUnit"><i class="u-iQuestion-ico"></i><br>问答</a>
					<div id="videoSummaryDiv" style="display: none;">
						<a href="javascript:void(0);" class="item3" id="end"><i class="u-iRead-ico"></i></br>课前导读</a>
						<span class="g-studyRead-layer">
	                        <i class="close">跳过></i>
	                        <h3>课前导读</h3>
	                        <p class="txt"></p>
	                        <i class="arrow"></i>                            
	                    </span>             
					</div>
				</div>
				<div class="g-studyShade" id="studyFrameShade"></div>
				<div  class="g-studyF-layer" id="studyNoteLayer">
				</div>
				<div  class="g-studyF-layer" id="studyQaLayer">
				</div>
			</div>
		</div>
		<div class="active-tipindex" style="display: none;">
            <p class="big">鼠标移到这里</p>
            <p>可以查看该节下面所有活动哦~</p>
            <a href="javascript:;" class="Abtn">下一步</a>
        </div>
		<form id="studyCourseForm">
			<input type="hidden" name="offsetTop">
    	</form>
	</@leadCourseContent>
	
	<div class="active-tipindex step0">
        <p class="big">点击这里</p>
        <p>可以展开该章下面的所有小节哦~</p>
        <a href="javascript:;" class="Abtn Abtn0">下一步</a>
    </div>
    <div class="active-tipindex step1">
        <p class="big">点击这里</p>
        <p>可以查看该节下面所有活动哦~</p>
        <a href="javascript:;" class="Abtn Abtn1">下一步</a>
    </div>
    <div class="active-tipindex step2">
        <p class="big">点击这里</p>
        <p>可以进行小节下面的活动切换并且可以查看小节完成状态哦~</p>
        <a href="javascript:;" class="Abtn Abtn2">下一步</a>
    </div>
    <div class="active-tipindex step3">
        <p class="big">点击这里</p>
        <p>可以查看当前课程的学习进度达标情况哦~</p>
        <a href="javascript:;" class="Abtn Abtn3">下一步</a>
    </div>
    <div class="active-tipindex step4">
        <p class="big">点击这里</p>
        <p>可以进行活动左右查看切换哦~</p>
        <a href="javascript:;" class="Abtn Abtn4">完成</a>
    </div>
    <!-- start animation -->
    <div id="g-animation">
        <img src="${app_path }/css/images/animation1.gif" alt="" class="animation1">
        <div class="tips">Hi,我是引导小助手，看操作引导可以点我哦~</div>
    </div>
</@layout>
<script>
	$(function(){
		//默认打开章节
		$('.section.z-crt').parents('dl').find('dt .tr').trigger('click');
		
		$(document).scrollTop(parseFloat('${(offsetTop[0])!"0"}'));
		
		//搜索框动画
	    showSearchBoxAnimate();
	    //章节列表显示隐藏
	    courseLearningFn.sectionCatalog();
	  	//课程学习选中活动
	    studySelectAct.star($('.m-studyAct-lst li').index($('.m-studyAct-lst li.z-crt')));
	  	//隐藏活动完成情况
	    study_prompt();
		//下拉滚动侧边栏固定定位
	    //courseLearningFn.sideFixed();
		//隐藏显示侧边
	    LayerOpreationFnAjax("#openNoteLayerUnit","#studyNoteLayer",'${ctx}/note/course?courseId=${cid}&sectionId=${sid}');
	    LayerOpreationFnAjax("#openQaLayerUnit","#studyQaLayer",'${ctx}/faq_question/course/${cid}');
	    //侧边栏收缩
	    slide();
	    //活动点击提示
	    active_tip('${app_path}', '${Session.loginer.id}');
	    var par = $("#g-animation");
		//点击小人重新引导
	    par.on("click",function(){
	        $(this).animate({"right":"-78px"},500);
	        active_tip('${app_path}');
	    });
		
		$('.topCourseName').text('${course.title!}');
		
		//如果是预览, 去掉部分菜单栏
		if('${SecurityUtils.getSubject().hasRole("preview_"+cid)?string("Y","N")}' == 'Y'){
			$('.m-cl-menu a[item="discussion"]').remove();
			$('.m-cl-menu a[item="progess"]').remove();
			$('.m-cl-menu a[item="schedule"]').remove();
		}
	});

	function studyCourse(courseId, sectionId, activityId){
		var url = '${ctx}/study/course/'+courseId;
		if(sectionId != null && sectionId != ''){
			url = '${ctx}/'+sectionId+'/study/course/'+courseId;
		}
		if(activityId != null && activityId != ''){
			url = '${ctx}/'+activityId+'/study/course/'+courseId;
		}
		$('#studyCourseForm').attr('action', url);
		$('#studyCourseForm input[name="offsetTop"]').val($(document).scrollTop());
		$('#studyCourseForm').submit();
	}
	
	//隐藏活动完成情况
	function study_prompt(){
	    $(".g-study-prompt .close").on("click",function(){
	        var $this_p = $(this).parent(".g-study-prompt");
	            $this_p.css({"display":"none"});
	    });
	    $(".g-study-prompt").delay(20000).fadeOut(500,0);

	}
</script>