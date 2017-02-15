<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<@courseRegisterStatDirective courseResultState=(courseResultState)! courseId=cid page=(pageBounds.page)!1 orders=orders!'CREATE_TIME.DESC'>
<@courseStatsDirective courseId=cid>
<#assign courseStat=(courseStats[0])! />
</@courseStatsDirective>
<table>
	<thead>
		<tr>
			<th width="13%">学员姓名</th>
			<th width="16%">所在单位</th>
			<th width="7%">视频</th>
			<th width="8%">教学课件</th>
			<th width="8%">主题研讨</th>
			<th width="8%">问卷调查</th>
			<th width="8%">测验</th>
			<th width="8%">作业</th>
			<th width="8%">成绩</th>
			<th width="16%">总评</th>
		</tr>
	</thead>
	<tbody id="courseRegisterStaticContent">
		<#if courseRegisterStats??>
			<#list courseRegisterStats as crs>
				<tr>
					<td>${(crs.courseRegister.user.realName)!}</td>
					<td>${(crs.courseRegister.user.deptName)!}</td>
					<td>${(crs.completeVideoNum)!0}/${(courseStat.activityVideoNum)!0}</td>
					<td>${(crs.completeHtmlNum)!0}/${(courseStat.activityHtmlNum)!0}</td>
					<td>${(crs.completeDiscussionNum)!0}/${(courseStat.activityDiscussionNum)!0}</td>
					<td>${(crs.completeSurveyNum)!0}/${(courseStat.activitySurveyNum)!0}</td>
					<td>${(crs.completeTestNum)!0}/${(courseStat.activityTestNum)!0}</td>
					<td>${(crs.completeAssignmentNum)!0}/${(courseStat.activityAssignmentNum)!0}</td>
					<td>${(crs.courseResult.score)!0}分</td>
					<td>
						<#if (crs.courseResult.state)??>
							<#if (crs.courseResult.state) = 'pass'>
								<i class="yes"></i>
								合格
							<#elseif (crs.courseResult.state) = 'nopass'>
								<i class="no"></i>
								不合格
							</#if>
						<#else>
							<i class="no"></i>
							不合格
						</#if>
					</td>
				</tr>
			</#list>
		</#if>
	</tbody>
</table>

<form id="listCourseRegisterActivityStatForm" action="${ctx}/${cid}/teach/course/courseRegister/statistic">
	<#import "/common/pagination-ajax.ftl" as p/>
	<@p.paginationAjaxFtl formId="listCourseRegisterActivityStatForm" divId="listCourseRegisterActivityStatPage" paginator=paginator! refreshDivId="courseRegisterStaticContent" />
	<input type="hidden" name="realName" value="${realName!}">
	<input type="hidden" name="courseResultState" value="${courseResultState!}">
	<div class="m-MS-page">
		<div id="listCourseRegisterActivityStatPage" class="m-laypage"></div>
	</div>
</form>
</@courseRegisterStatDirective>
