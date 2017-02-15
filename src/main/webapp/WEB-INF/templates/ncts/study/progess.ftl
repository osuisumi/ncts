<#include "/ncts/study/include/layout.ftl"/>
<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<@layout>
<@courseRegisterStatDirective courseId=cid userId=Session.loginer.id>
<@courseStatsDirective courseId=cid>
	<#assign crs = (courseRegisterStats[0])!/>
	<#assign courseStat = (courseStats[0])! />
	<#assign course=(courseStat.course)! />
	<div class="g-progress-box">
		<div class="m-progress-info">
			<#if ('lead' = (course.type)!'') && ('' = (crs.courseResult.state)!'') >
				<div class="u-tip-sign"><i></i> 引领式课程需要培训结束后公布成绩，请耐心等待！</div>
			</#if>
			<!--<h3 class="u-tit">当前学习进度：<span>现代教育技术——现代教育技术概述——现代教育技术的发展趋势（上次浏览到7:36）</span></h3>
			<div class="m-bar">
				<span class="u-bar"><span class="u-val" style="width:30%;"></span></span>
				<span class="u-txt">已完成<b>30</b>%</span>
			</div>
			-->
			<div class="u-end">
				<span>
					<i class="u-ico-clock"></i>
					<#if course.timePeriod??>
						<#if TimeUtils.hasBegun(course.timePeriod.startTime)>
							<#if course.timePeriod.endTime?? && !TimeUtils.hasEnded(course.timePeriod.endTime)>
								距离课程结束还有${TimeUtils.prettyEndTime(course.timePeriod.endTime)}
							<#elseif course.timePeriod.endTime?? && TimeUtils.hasEnded(course.timePeriod.endTime) >
								课程已结束
							<#else>
								进行中
							</#if>
						<#elseif course.timePeriod.startTime?? && !TimeUtils.hasBegun(course.timePeriod.startTime)>
							距离课程开始还有${TimeUtils.prettyStartTime(course.timePeriod.startTime)}
						<#else>
							进行中
						</#if>
					</#if>
				</span>
			</div>
				<#if course.type = 'lead' && '' = (crs.courseResult.state)!''>
					
				<#else>
					<div class="m-score">
						<span class="u-num"><b>${(crs.courseResult.score)!0}</b>分</span>
						<p>
							当前课程成绩
						</p>
						<div class="u-state">
							<#if (crs.courseResult.state)??>
								<#if (crs.courseResult.state) = 'pass'>
									合格
								<#elseif (crs.courseResult.state) = 'nopass'>
									未达标
								</#if>
							<#else>
								未达标
							</#if>
							<span class="u-tips">
								 <span class="u-txt"> 
								 	<span class="u-box"> <i></i> 
								 		<span>课程考核指标</span>
										<p>
											课程需达<b>60</b>分以上，方算合格
										</p> 
									</span> 
								</span> 
							</span>
						</div>
					</div>
				</#if>
				<span class="u-btm"></span>
		</div>
		<div class="g-progress-type">
			<ul class="m-progress-lst">
				<li>
					<div class="u-type u-tit-type1">
						视频
					</div>
					<p>
						已观看<b>${(crs.completeVideoNum)!0}</b>个
					</p>
					<p>
						共需要观看<b>${(courseStat.activityVideoNum)!0}</b>个
						<#if 0 = (courseStat.activityVideoNum)!0>
							<#assign pal = 1 />
						<#else>
							<#assign pal = courseStat.activityVideoNum />
						</#if>
					</p>
					<span class="u-bar <#if ((crs.completeVideoNum)!0) = ((courseStat.activityVideoNum)!0) >u-gt</#if>"><span class="u-val" style="width:${((crs.completeVideoNum)!0)/((pal))*100}%"></span></span>
				</li>
				<li>
					<div class="u-type u-tit-type2">
						主题讨论
					</div>
					<p>
						已参与<b>${(crs.completeDiscussionNum)!0}</b>个
					</p>
					<p>
						共需参与<b>${(courseStat.activityDiscussionNum)!0}</b>个
						<#if courseStat.activityDiscussionNum = 0>
							<#assign pal = 1 />
						<#else>
							<#assign pal = courseStat.activityDiscussionNum />
						</#if>
					</p>
					<span class="u-bar <#if ((crs.completeDiscussionNum)!0) = ((courseStat.activityDiscussionNum)!0) >u-gt</#if>"><span class="u-val" style="width:${((crs.completeDiscussionNum)!0)/((pal)!1)*100}%"></span></span>
				</li>
				<li class="nobor">
					<div class="u-type u-tit-type3">
						教学课件
					</div>
					<p>
						已观看<b>${(crs.completeHtmlNum)!0}</b>个
					</p>
					<p>
						共需要观看<b>${(courseStat.activityHtmlNum)!0}</b>个
						<#if courseStat.activityHtmlNum = 0>
							<#assign pal = 1 />
						<#else>
							<#assign pal = courseStat.activityHtmlNum />
						</#if>
					</p>
					<span class="u-bar <#if ((crs.completeHtmlNum)!0) = ((courseStat.activityHtmlNum)!0) >u-gt</#if>"><span class="u-val" style="width:${((crs.completeHtmlNum)!0)/((pal)!1)*100}%"></span></span>
				</li>
				<li>
					<div class="u-type u-tit-type4">
						问卷调查
					</div>
					<p>
						已完成<b>${(crs.completeSurveyNum)!0}</b>个
					</p>
					<p>
						共需要完成<b>${(courseStat.activitySurveyNum)!0}</b>个
						<#if courseStat.activitySurveyNum = 0>
							<#assign pal = 1 />
						<#else>
							<#assign pal = courseStat.activitySurveyNum />
						</#if>
					</p>
					<span class="u-bar <#if ((crs.completeSurveyNum)!0) = ((courseStat.activitySurveyNum)!0) >u-gt</#if>"><span class="u-val" style="width:${((crs.completeSurveyNum)!0)/((pal)!1)*100}%"></span></span>
				</li>
				<li>
					<div class="u-type u-tit-type5">
						测验
					</div>
					<p>
						已完成<b>${(crs.completeTestNum)!0}</b>个
					</p>
					<p>
						共需要完成<b>${(courseStat.activityTestNum)!0}</b>个
						<#if courseStat.activityTestNum = 0>
							<#assign pal = 1 />
						<#else>
							<#assign pal = courseStat.activityTestNum />
						</#if>
					</p>
					<span class="u-bar <#if ((crs.completeTestNum)!0) = ((courseStat.activityTestNum)!0) >u-gt</#if>"><span class="u-val" style="width:${((crs.completeTestNum)!0)/((pal)!1)*100}%"></span></span>
				</li>
				<li class="nobor">
					<div class="u-type u-tit-type6">
						作业
					</div>
					<p>
						已完成<b>${(crs.completeAssignmentNum)!0}</b>篇
					</p>
					<p>
						共需要完成<b>${(courseStat.activityAssignmentNum)!0}</b>篇
						<#if courseStat.activityAssignmentNum = 0>
							<#assign pal = 1 />
						<#else>
							<#assign pal = courseStat.activityAssignmentNum />
						</#if>
					</p>
					<span class="u-bar <#if ((crs.completeAssignmentNum)!0) = ((courseStat.activityAssignmentNum)!0) >u-gt</#if>"><span class="u-val" style="width:${((crs.completeAssignmentNum)!0)/((pal)!1)*100}%"></span></span>
				</li>
			</ul>
		</div>
	</div>
	<script>
		$(function(){
			lightMenu('progess');
		});
	</script>
	</@courseStatsDirective>
</@courseRegisterStatDirective>
</@layout>