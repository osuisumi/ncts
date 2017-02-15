<#macro viewSurveyResultFtl surveyId aid relationId>
<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
<#if hasTeachRole>
	<#assign role='teach'>
<#else>
	<#assign role='study'>
</#if>
<#include "view_survey_result_index.ftl">
<@viewSurveyResultIndexFtl surveyId=surveyId relationId=relationId aid=aid>
	<ol class="g-topic-lst" id="topicList">
		<#if survey.questions??>
		<#list survey.questions as question>
			<#if question.type ='singleChoice' || question.type='multipleChoice' || question.type='trueOrFalse'>
			<li class="m-topic-item question">
				<input type="hidden" value="${question.type}" class="questionType">
				<div class="m-topic m-topic01">
					<h3 class="title"><span class="item-num">${question_index+1}、</span><span class="title">${question_index+1}、${question.title}</span></h3>
					<ol class="m-question-lst">
						<#if question.choiceGroups??>
							<#list question.choiceGroups as choiceGroup>
								<#if choiceGroup.choices??>
									<#list choiceGroup.choices as choice>
										<li class="choice" hint="${(surveyRelation.choiceInteractionResults[question.id][choice.id])!}">
											<label class="m-radio-tick2"> 
												<strong class="m-question2"> 
													<#if (participateNum != 0)>
														<ins class="question-per">
															<em style="width:${((surveyRelation.choiceInteractionResults[question.id][choice.id])!0)/(participateNum)*100}%" value="${choice.id}" class="m-question-per"></em>
														</ins>
														<i class="question-num">${((surveyRelation.choiceInteractionResults[question.id][choice.id])!0)/(participateNum)*100}%</i>
													<#else>
														<ins class="question-per">
															<em style="width:0%" value="${choice.id}" class="m-question-per"></em>
														</ins>
														<i class="question-num">0%</i>
													</#if>
												</strong> 
												<span>
													<em class="aItemNum">${ConverNumToABCUtils.conver(choice_index)}、</em>
													<span>${choice.content}</span>
												</span>
											</label>
										</li>
									</#list>
								</#if>
							</#list>
						</#if>
					</ol>
				</div>
			</li>
			<#elseif question.type ='textEntry'>
				<li class="g-studyIpt-box question">
					<div class="m-studyIpt-block">
						<div class="m-topic m-suggest-tl m-topic01">
							<div class="title">
								${question_index+1}、${question.title}
							</div>
						</div>
						<div class="question2-dt">
							【<a onclick="viewResultDetail('${question.id}')">查看本题答案详细信息</a>】
						</div>
					</div>
				</li>
			</#if>
		</#list>
		</#if>
	</ol>
</@viewSurveyResultIndexFtl>

<script>
	$(function(){
		$('.item-num').hide();
	})

	function viewResultDetail(questionId){
		window.location.href = "${ctx}/${aid }/${role}/course/${cid}?surveyStep=questionResultDetail&questionId="+questionId;
	}
	
</script>
</#macro>