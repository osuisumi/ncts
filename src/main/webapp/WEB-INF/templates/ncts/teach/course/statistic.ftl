<#include "/ncts/teach/include/layout.ftl"/>
<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<@layout>
<@courseStatsDirective courseId=cid>
	<#assign courseStat = (courseStats[0])! />
	<#assign course=(courseStat.course)!/>
	<div class="g-progress-box">
		<div class="g-course-hd">
			<h2 class="g-tit">${(course.title)!}</h2>
			<p class="u-info">
				<#if (course.timePeriod)??>
					开课时间：${(course.timePeriod.startTime)?string('yyyy/MM/dd')} — ${(course.timePeriod.endTime)?string('yyyy/MM/dd')}		
					<span>|</span>		
				</#if>
				选课人数：<b>${(course.courseStat.registerNum)!0}</b>
				<span>|</span>
				学时：<b>${(course.studyHours)!}</b>
			</p>
			<ul class="m-count-type">
				<li class="type1">
					<i></i><b>${(courseStat.faqQuestionNum)!0}</b>
					<p>
						提问数
					</p>
				</li>
				<li class="type2">
					<i></i><b>${(courseStat.faqAnswerNum)!0}</b>
					<p>
						回答数
					</p>
				</li>
				<li class="type3">
					<i></i><b>${(courseStat.noteNum)!0}</b>
					<p>
						笔记数
					</p>
				</li>
				<li class="type4">
					<i></i><b>${(courseStat.resourceNum)!0}</b>
					<p>
						资源数
					</p>
				</li>
				<li class="type5">
					<i></i><b>${(courseStat.discussionNum)!0}</b>
					<p>
						研讨数
					</p>
				</li>
			</ul>
		</div>
		<div class="g-count-detail">
			<div class="m-tit-tab">
				<a href="javascript:;" onclick="reloadCourseRegisterStaticContentByResultState('',this)" class="u-type z-crt">全部</a>
				<a href="javascript:;" onclick="reloadCourseRegisterStaticContentByResultState('pass',this)" class="u-type">合格</a>
				<a href="javascript:;" onclick="reloadCourseRegisterStaticContentByResultState('nopass',this)" class="u-type">不合格</a>
				<!--<a href="javascript:;" class="u-type">优秀</a>-->
				<label class="m-srh">
					<input id="search" type="text" class="ipt" placeholder="搜索">
					<i class="u-srh1-ico"></i> </label>
			</div>
			<div class="m-con-tab" id="courseRegisterStaticContent">
				<script>
					$(function(){
						$('#courseRegisterStaticContent').load('${ctx}/${cid}/teach/course/courseRegister/statistic');
					});
				</script>
			</div>
		</div>
	</div>
</@courseStatsDirective>
</@layout>
<script>
	$(function() {
		lightMenu('statistic');
		$('#search').on('keypress',function(event){
            if(event.keyCode == "13")    
            {
                $('#listCourseRegisterActivityStatForm input[name="realName"]').val($(this).val());
                $.ajaxQuery('listCourseRegisterActivityStatForm','courseRegisterStaticContent');
            }
		});
	});
	
	function reloadCourseRegisterStaticContentByResultState(resultState,a){
		$('.m-tit-tab a').removeClass('z-crt');
		$(a).addClass('z-crt');
		$('#courseRegisterStaticContent').load('${ctx}/${cid}/teach/course/courseRegister/statistic?courseResultState='+resultState);
	}
	
	
</script>