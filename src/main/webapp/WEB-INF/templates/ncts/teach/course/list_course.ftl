<#include "/ncts/make/include/layout.ftl"/>
<@layout title="课程辅导中心">
	<@courseNum courseAuthorizeUserId=ThreadContext.getUser().id courseAuthorizeRole="teacher">
		<#assign allNum=allNum> 
		<#assign beginningNum=beginningNum> 
		<#assign notBegunNum=notBegunNum> 
		<#assign endNum=endNum> 
	</@courseNum>
	<div id="g-bd">
        <div class="addCoursePage">
            <div class="g-innerAuto g-addCourse-cont">
                <div class="g-addcourse-dt">
                    <div class="g-CourseList-tp">
                        <h2 class="tt">课程助学<span>Course Teaching</span></h2>
                        <label class="m-srh">
                            <input id="searchTxt" type="text" value="${course.title! }" class="ipt" placeholder="搜索">
                            <i class="u-srh1-ico"></i>
                        </label>
                        <script>
                        	$(function(){
                        		$('#searchTxt').keydown(function(e){
                      				if(e.keyCode==13){
                      					$('#listCourseForm input[name="title"]').val($(this).val());
                      					$('#listCourseForm #currentPage').val(1);
                      					$('#listCourseForm').submit();
                      				}
                      		    });
                        	});
                        </script>
                    </div>
                    <div class="g-courseList-bd">
                        <div class="g-clist-optRow">
                            <div id="timeParamTab" class="m-clist-tabli">
                                <a timeParam="" onclick="listCourse('')" href="javascript:void(0);" class="z-crt"><span>全部</span>（${allNum}）<i class="trg"></i></a>
                                <a timeParam="beginning" onclick="listCourse('beginning')" href="javascript:void(0);"><span>进行中</span>（${beginningNum}）<i class="trg"></i></a>
                                <a timeParam="notBegun" onclick="listCourse('notBegun')" href="javascript:void(0);"><span>未开始</span>（${notBegunNum}）<i class="trg"></i></a>
                                <a timeParam="end" onclick="listCourse('end')" href="javascript:void(0);"><span>已结束</span>（${endNum}）<i class="trg"></i></a>
                            </div>
                            <script>
                            	$(function(){
                            		$('#timeParamTab a').removeClass('z-crt');
                            		$('#timeParamTab a[timeParam="${(timeParam[0])!}"]').addClass('z-crt');
                            	});
                            </script>
                            <div id="listModeBtn" class="m-viewMode">
                                <a listMode="list" class="u-view-list z-crt" title="列表模式"><i class="u-viewL-ico"></i></a>
                                <a listMode="flat" class="u-view-tiled" title="平铺模式"><i class="u-viewT-ico"></i></a>
                            </div>
                            <script>
                            	$(function(){
                            		$('#listModeBtn a').click(function(){
                            			var index = $('#listModeBtn a').index($(this));
                            			$('#listModeBtn a').removeClass('z-crt');
                            			$(this).addClass('z-crt');
                            			$('.courseUl').hide();
                            			$('.courseUl').eq(index).show();
                            			$('#listModeParam').val($(this).attr('listMode'));
                            		});
                            		if('${(listMode[0])!}' == 'flat'){
                            			$('#listModeBtn a').eq(1).trigger('click');
                            		}
                            	});
                            </script>
                        </div>
                        <div class="g-clist-tabcon">
                        	<div class="g-clist-cont">
                            	<@coursesDirective timeParam=(timeParam[0])! title=(course.title)!'' courseAuthorizeUserId=ThreadContext.getUser().id courseAuthorizeRole="teacher" page=(pageBounds.page)!1 limit=(pageBounds.limit)!12 orders='CREATE_TIME.DESC'>
									<ul class="courseUl g-myCourse-lst g-studyH-couse">
										<#list courses as course>	
											<#if !(TimeUtils.hasBegun((course.timePeriod.startTime)!''))>
												<li class="m-fig-viewList unissue">
											<#elseif (TimeUtils.hasEnded((course.timePeriod.endTime)!''))>	
												<li class="m-fig-viewList end">
											<#else>
												<li class="m-fig-viewList going">
											</#if>
		                                        <a courseId="${course.id! }" href="javascript:void(0);" class="figure">
		                                        	<#import "/common/image.ftl" as image/>
													<@image.imageFtl url="${course.image! }" default="${app_path }/images/defaultCourseImg.png" />
		                                        </a>
		                                        <h3 class="tt"><a href="javascript:void(0);">${course.title!}</a></h3>
		                                        <p>
		                                            <i class="u-sList-ico"></i>
		                                            <span class="txt">${course.code!}</span>
		                                            <span class="link">/</span>
		                                            <span class="txt">${course.termNo!}</span>
		                                        </p>
		                                        <p><i class="u-sTime-ico"></i><span class="txt">开课时间: ${(course.timePeriod.startTime?string('yyyy/MM/dd'))! }</span></p>
	                                            <div class="tagRow">
	                                            	<span class="u-cTag">
	                                                	<#if !(TimeUtils.hasBegun((course.timePeriod.startTime)!''))>
															未开始
														<#elseif (TimeUtils.hasEnded((course.timePeriod.endTime)!''))>	
															已结束	
														<#else>
															进行中
														</#if>
													</span>
	                                            </div>
		                                        <div class="m-course-coach">
		                                        	<#if (TimeUtils.hasBegun((course.timePeriod.startTime)!''))>
		                                        		<a onclick="teachCourse('${course.id}')" href="javascript:;"> 进入辅导</a>
		                                        	</#if>
                                           		</div>
		                                    </li>
		                             	</#list>
									</ul>
									<ul class="courseUl g-fig-tiled" style="display:none;">
										<#list courses as course>	
	                                        <li class="g-studyH-course2">
	                                        	<#if !(TimeUtils.hasBegun((course.timePeriod.startTime)!''))>
													<div class="m-fig-tiled unissue">
												<#elseif (TimeUtils.hasEnded((course.timePeriod.endTime)!''))>	
													<div class="m-fig-tiled end">
												<#else>
													<div class="m-fig-tiled going">	
												</#if>
													<a onclick="editCourseConfig('${course.id}')" courseId="${course.id! }" href="javascript:void(0);" class="figure">
	                                                    <#import "/common/image.ftl" as image/>
														<@image.imageFtl url="${course.image! }" default="${app_path }/images/defaultCourseImg.png" />
														<#if (TimeUtils.hasBegun((course.timePeriod.startTime)!''))>
	                                                    	<span onclick="teachCourse('${course.id}')" class="go-coach">进入辅导</span>
	                                                    </#if>
	                                                </a>
	                                                <h3 class="tt"><a href="javascript:void(0);">${course.title!}</a></h3>
	                                                <div class="tagRow">
	                                                    <span class="u-cTag type2">
	                                                    	<#if !(TimeUtils.hasBegun((course.timePeriod.startTime)!''))>
																未开始
															<#elseif (TimeUtils.hasEnded((course.timePeriod.endTime)!''))>	
																已结束	
															<#else>
																进行中
															</#if>
	                                                    </span>
	                                                </div>  
	                                            </div>
	                                        </li>
	                                	</#list>
                                    </ul>
                                    <form id="listCourseForm" action="${ctx}/teach/course">	
                                    	<input type="hidden" name="title" value="${(course.title)! }">
										<input id="timeParam" type="hidden" name="timeParam" value="${(timeParam[0])! }">
										<input id="listModeParam" type="hidden" name="listMode" value="${(listMode[0])! }">
	                                    <div id="myCoursePage" class="m-laypage"></div>
	                                    <#import "/common/pagination.ftl" as p/>
										<@p.paginationFtl formId="listCourseForm" divId="myCoursePage" paginator=paginator />
									</form>
								</@coursesDirective>
                            </div>    
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="previewId" type="hidden">
</@layout>
<script>
	function listCourse(time){
		$('#listCourseForm #timeParam').val(time);
		$('#listCourseForm #currentPage').val(1);
		$('#listCourseForm').submit();
	}
	
	function teachCourse(courseId){
		window.open('${ctx}/teach/course/'+courseId);
	}
</script>