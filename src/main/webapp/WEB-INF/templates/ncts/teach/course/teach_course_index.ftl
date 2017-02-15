<#include "/ncts/teach/include/layout.ftl"/>
<@layout>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign sid=(CSAIdObject.getCSAIdObject().scid)!>
	<#assign aid=(CSAIdObject.getCSAIdObject().aid)!>
	<#global hasAssistantRole=SecurityUtils.getSubject().hasRole('course_assistant_'+cid)>
	<@leadCourseContent courseId=cid>
		<div class="g-cl-content">
			<div class="g-cl-study">
				<div class="g-study-frame f-cb">
					<div class="g-study-sd">
						<#list sections as section>
						<ul class="g-course-catalog" id="courseCatalog">
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
										<#if sid! == '' && section_index == 0 && childSection_index == 0> 
											<#assign sid=childSection.id> 
										</#if>
										<dd>
											<a onclick="teachCourse('${cid}', '${childSection.id }')" href="###" class="tt-s 
			                                    	<#if sid == childSection.id>
			                                    		z-crt
			                                    	</#if>
			                                    "> 
			                                    <span class="txt">${childSection.title!}</span>
			                                    <#if hasAssistantRole>
			                                    	<span class="tr"><i sectionId="${childSection.id }" class="u-state-icoClock u-state-ico done"></i></span>
			                                    </#if>
											</a>
										</dd>
									</#list>
								</dl>
							</li>
						</ul>
						</#list>
					</div>
					<div class="g-study-mn">
						<div class="m-study-box">
							<div class="m-study-opt" id="studySelectAct">
								<@activitiesDirective relationId="${sid! }" getResult=true>
								<div class="dd-box">
									<a href="javascript:void(0);" class="swich"><i class="u-listH-ico"></i></a>
									<ul class="t-list">
										<#list activities as activity> <#if aid! == '' && activity_index == 0> <#assign aid=activity.id> </#if>
											<li class="
												<#if aid == activity.id>z-crt</#if>
											">
												<a onclick="teachCourse('${cid}','','${activity.id }')" href="###" class="
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
									</ul>
								</div>
								<div class="list-box">
									<ul class="m-studyAct-lst">
										<#list activities as activity>
											<li class="
												<#if aid == activity.id>z-crt</#if>
											">
												<a onclick="teachCourse('${cid}','','${activity.id }')" href="javascript:void(0);" class="
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
													<span>${activity.title }</span>
												</a>
											</li> 
										</#list>
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
					<a href="javascript:void(0);" class="item2" id="openQaLayerUnit"><i class="u-iQuestion-ico"></i><br>问答</a>
				</div>
				<div class="g-studyShade" id="studyFrameShade"></div>
				<div  class="g-studyF-layer" id="studyQaLayer">
				</div>
			</div>
		</div>
		<form id="teachCourseForm">
			<input type="hidden" name="offsetTop">
    	</form>
	</@leadCourseContent>
</@layout>
<script>
	$(function(){
		//默认打开章节
		$('.section.z-crt').parents('dl').find('dt .tr').trigger('click');
		
		$(document).scrollTop(parseFloat('${(offsetTop[0])!"0"}'));
		
		//搜索框动画
	    showSearchBoxAnimate();
	  	//课程学习选中活动
	    studySelectAct.star($('.m-studyAct-lst li').index($('.m-studyAct-lst li.z-crt')));
	    //设置时间指引
	    if('${hasAssistantRole?string("true","false")}' == 'true'){
	    	if(window.location.href.indexOf('sc_') < 0 && window.location.href.indexOf('a_') < 0){
	    		var flag = $.cookie('teach_update_time_tip_${Session.loginer.id}');
	    		if(flag != 'Y'){
	    			$.cookie('teach_update_time_tip_${Session.loginer.id}', 'Y', { expires: 30, path: '/' });
	    		    var addSectionGuide = '<div class="m-guideShade"></div><div class="g-guide-hint section clock-bg-sel"><button type="button" class="confirm u-inverse-btn">我知道了</button></div>';
		        	commonJs.fn.guideHint(addSectionGuide);
	    		}
		    }
	    }
    
	    //隐藏显示侧边
	    LayerOpreationFn("#openNoteLayerUnit","#studyNoteLayer");
	   	LayerOpreationFnAjax("#openQaLayerUnit","#studyQaLayer",'${ctx}/faq_question/course/${cid}');
	    //侧边栏收缩
	    slide();
	    
	    $('.topCourseName').text('${course.title!}');
	});
	
	$(".m-course-catalog .u-state-icoClock").on("click",function(){
		var sectionId = $(this).attr('sectionId');
		mylayerFn.open({
           type: 2,
           title: '设置时长',
           fix: false,
           area: [1100, 850],
           content: '${ctx}/teach/section/'+sectionId+'/editSectionTime',
           shadeClose: true
        });
		return false;
	});

	function teachCourse(courseId, sectionId, activityId){
		var url = '${ctx}/teach/course/'+courseId;
		if(sectionId != null && sectionId != ''){
			url = '${ctx}/'+sectionId+'/teach/course/'+courseId;
		}
		if(activityId != null && activityId != ''){
			url = '${ctx}/'+activityId+'/teach/course/'+courseId;
		}
		$('#teachCourseForm').attr('action', url);
		$('#teachCourseForm input[name="offsetTop"]').val($(document).scrollTop());
		$('#teachCourseForm').submit();
	}
</script>