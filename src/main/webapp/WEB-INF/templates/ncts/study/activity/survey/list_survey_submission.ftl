<#macro listSurveySubmissionsFtl surveyId relationId aid questionId>
<#assign cid=CSAIdObject.getCSAIdObject().cid>
<#include "view_survey_result_index.ftl">
<@viewSurveyResultIndexFtl surveyId=surveyId relationId=relationId aid=aid>
<table class="m-qes-res-table">
	<tbody>
		<tr>
			<th>用户名</th>
			<th>提交答案时间</th>
			<th>答案内容</th>
		</tr>
		<@surveySubmissions questionId="${questionId!}" relationId="${relationId!}" pageBounds=pageBounds>
			<#if surveySubmissions??>
				<#list surveySubmissions as sub>
					<tr>
						<td class="m-qes-res-table-ct">${sub.creator.realName}</td>
						<td class="m-qes-res-table-ct"><span class="m-table-tim">${TimeUtils.formatDate(sub.createTime,'yyyy/MM/dd HH:mm')}</span></td>
						<td class="m-qes-res-table-wd">${sub.response}</td>
					</tr>
				</#list>
			</#if>
		</@surveySubmissions>
	</tbody>
</table>
<form id="listSurveySubmissionsForm" action="${ctx}/${aid}/study/course/${cid}">
	<input type="hidden" name="surveyStep" value="questionResultDetail">
	<input type="hidden" name="questionId" value="${questionId!}">
	<div id="courseStudyDiscussionPage" class="m-laypage"></div>
	<#import "/common/pagination.ftl" as p/>
	<@p.paginationFtl formId="listSurveySubmissionsForm" divId="courseStudyDiscussionPage" paginator=paginator />
</form>
</@viewSurveyResultIndexFtl>
</#macro>