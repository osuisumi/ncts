<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
<#if hasTeachRole>
	<#assign role='teach'>
<#else>
	<#assign role='study'>
</#if>
<#macro viewSurveyFtl surveyId relationId aid>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
	<div class="g-study-dt">
		<@survey id=surveyId>
			<@surveyUser surveyId=survey.id relationId=relationId activityId=aid>
			<#assign inCurrentDate=TimeUtils.inCurrentDate((activity.timePeriod)!'', (course.timePeriod)!'')>	
				<#if !hasTeachRole>
					<div class="g-study-prompt">
						<p>
							提交调查问卷即可完成活动
							<i>/</i>
							<#if ('complete' == surveyUser.state!'')>
								您已提交
							<#else>
								您还未提交
							</#if>
						</p>
		            	<i class="close">X</i>
		            </div>
		        </#if>
				<div id="viewSurveyDiv" class="g-question-box">	
					<div class="g-studyAct-time">
                        <div class="am-main-r">
                        	<#assign timePeriods=[]>
							<#assign timePeriods = timePeriods + [(activity.timePeriod)!]>
							<#assign timePeriods = timePeriods + [(course.timePeriod)!]>
							<#import "/ncts/study/common/show_time.ftl" as st /> 
							<@st.showTimeFtl timePeriods=timePeriods label="活动" /> 
                        </div>    
                    </div>
					<h1 class="g-question-tl">${survey.title}</h1>
					<div class="g-question-tx">${survey.description}</div>
					<form id="saveSurveyUser" action="${ctx}/${aid }/${role }/unique_uid_${Session.loginer.id }/survey/user" method="post">
						<input type="hidden" value="${survey.id}" name="survey.id">
						<input type="hidden" value="${(Session.loginer.id)!}" name="creator.id">
						<input type="hidden" value="${relationId}" name="relation.id">
						<input type="hidden" value="complete" name="state">
						<ol class="g-topic-lst" id="topicList">
							<#if survey.questions??>
								<#list survey.questions as question>
									<input type="hidden" name="surveySubmissions[${question_index}].question.id" value="${question.id}">
									<input type="hidden" name="surveySubmissions[${question_index}].question.type" value="${question.type}">
									<#if question.type = 'textEntry'>
										<li class="m-studyIpt-block question">
											<input type="hidden" value="${question.id}" class="questionId"/>
											<input type="hidden" value="${question.type}" class="questionType"/>
											<div class="m-topic m-suggest-tl m-topic01">
												<div class="title">
													${question_index+1}、${question.title}
												</div>
											</div>
											<div class="m-pbMod-ipt">
												<textarea required id="${question.id}"  
												<#if (question.textEntryInteraction.minWords)??>
													<#if question.textEntryInteraction.minWords != 0>
														minlength="${(question.textEntryInteraction.minWords)!}"
													</#if>
												</#if>
												<#if (question.textEntryInteraction.maxWords)??>
													<#if question.textEntryInteraction.maxWords != 0>
														maxlength="${(question.textEntryInteraction.maxWords)!}" 
													</#if>
												</#if>
												name="surveySubmissions[${question_index}].response" id="" class="u-textarea u-textarea01" placeholder="请输入<#if (question.textEntryInteraction.minWords)??><#if question.textEntryInteraction.minWords != 0>最小字数${(question.textEntryInteraction.minWords)!}</#if></#if><#if (question.textEntryInteraction.maxWords)??><#if question.textEntryInteraction.maxWords != 0>，最大字数${(question.textEntryInteraction.maxWords)!}</#if></#if>">
												</textarea>
											</div>
											<script>
												$('#${question.id}').val('${(surveyUserSubmissions[question.id])!}');
											</script>
										</li>
									<#else>
										<li class="m-topic-item question">
											<input type="hidden" value="${question.id}" class="questionId"/>
											<input type="hidden" value="multipleChoice" class="questionType">
											<div class="m-topic m-topic01">
												<h3 class="title"><span class="item-num">${question_index+1}、</span>
													<label for="surveySubmissions[${question_index}].response"> 
														${question_index+1}、${question.title}<#if ((question.choiceGroups)?first.maxChoose)??>(最多选择${(question.choiceGroups)?first.maxChoose}项)</#if>
													</label>
												</h3>
												<ol class="m-question-lst">
													<#if question.choiceGroups??>
														<#list question.choiceGroups as choiceGroup>
															<input type="hidden" value="${choiceGroup.id}" class="groupId">
															<#if choiceGroup.choices??>
																<#list choiceGroup.choices as choice>
																	<li class="choice">
																		<input type="hidden" value="${choice.id}" class="choiceId">
																		<label class="m-<#if question.type == 'singleChoice'>radio<#elseif question.type == 'multipleChoice'>checkbox<#else>radio</#if>-tick">
																			<strong> 
																				<i class="ico ico2"></i>
																				<input required <#if (choiceGroup.maxChoose)??>maxlength="${choiceGroup.maxChoose}"</#if> value="${choice.id}" id="${choice.id}" type="<#if question.type == 'singleChoice'>radio<#elseif question.type == 'multipleChoice'>checkbox<#else>radio</#if>" name="surveySubmissions[${question_index}].response"
																					<#if (surveyUserSubmissions[question.id])!?contains(choice.id)>checked="checked"</#if>
																				>
																			</strong> 
																			<span><em class="aItemNum">${ConverNumToABCUtils.conver(choice_index)}、</em><span>${choice.content}</span></span>
																		</label>
																	</li>
																</#list>
															</#if>
														</#list>
													</#if>
												</ol>
											</div>
										</li>
									</#if>
								</#list>
							</#if>
							<div class="g-studyIpt-box">
								<div class="m-studyIpt-btn m-common-btn t-fr m-common-btn01">
									<#if hasTeachRole>
										<a onclick="viewSurveyResult()" id="viewResultBtn" type="button" class="btn u-inverse-btn"> 查看结果</a>
									<#else>	
										<#if (surveyUser.surveySubmissions?size>0)>
											<a onclick="viewSurveyResult()" id="viewResultBtn" type="button" class="btn u-inverse-btn"> 查看结果</a>
										<#else>
											<#if inCurrentDate && !hasTeachRole>
												<a id="submitSurveyUserBtn" onclick="saveSurveyUser()" type="button" class="btn u-main-btn">提交 </a>
											</#if>
										</#if>
									</#if>
								</div>
							</div>
						</ol>
					</form>
				</div>
			</@surveyUser>
		</@survey>
		<div style="display:none" id="submitOverDiv" class="g-submit">
			<div class="m-submit-pic"></div>
			<p class="m-submit-answer">
				您的答卷已经提交，感谢您的参与!
			</p>
			<div class="m-studyIpt-btn m-common-btn t-fr m-submit-btn">
				<a href="${ctx}/${aid }/${role}/course/${cid}">
				<button type="button" class="btn u-inverse-btn btn-submit">
					返回首页
				</button></a>
				<button onclick="viewSurveyResult()" type="button" class="btn u-main-btn btn-submit">
					查看结果
				</button>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
	$(function(){
		$('.item-num').hide();
		
		$('#saveSurveyUser').validate({
			errorPlacement: function(error, element){
				if (element.is(':radio') || element.is(':checkbox')) {
					//var eid = element.attr('name');
					//error.get(0).innerHTML = '请选择';
					//error.get(0).innerText= "请选择";
					var errorPlace = element.closest('.question').find('.title');
					error.appendTo(errorPlace);
				}else{
					error.insertAfter(element);
				}
			},
		});
		
		$.extend($.validator.messages, {
			maxlength: $.validator.format("最多选	{0} 个选项"),
		});
		
		$('input[type=checkbox]').on('click',function(){
			var maxlength = $(this).attr('maxlength');
			maxlength = parseInt(maxlength);
			if(maxlength){
				var name = $(this).attr('name');
				var checkedSize = $('input[name="'+name+'"]:checked').length;
				if(checkedSize>maxlength){
					alert('最多选'+maxlength+'个选项');
				}
			}
		});
	});

	function saveSurveyUser() {
		if(!$('#saveSurveyUser').validate().form()){
			return false;
		}
		/*$("#saveSurveyUser").validate({
			errorPlacement:function(error, element){
				if (element.is(':radio') || element.is(':checkbox')) { //如果是radio或checkbox
				var eid = element.attr('name'); //获取元素的name属性
					error.appendTo(element.parent()); //将错误信息添加当前元素的父结点后面
				} else {
					error.insertAfter(element);
				}
			}
		});*/
		var response = $.ajaxSubmit('saveSurveyUser');
		if (!isMatchJson(response)){
			$('body').html($(response));
		}else{
			response = $.parseJSON(response);
			if(response.responseCode == '00'){
				$('#viewSurveyDiv').toggle();
				$('#submitOverDiv').toggle();
			}
		}
	}
	
	function viewSurveyResult(){
		window.location.href = "${ctx}/${aid }/${role}/course/${cid}?surveyStep=viewResult";
	}
	
</script>
</#macro>