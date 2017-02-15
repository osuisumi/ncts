<#macro editQuestionFtl survey>
<#assign cid=CSAIdObject.getCSAIdObject().cid>
<style>
	.error{
		color:#FF0000
	}
	
</style>
	<#if survey.id??>	
	<div class="g-addTopic-box">
		<div class="m-addTopic-opt">
			<span class="lx">添加题目类型 :</span>
			<a style="margin-right:5px" href="javascript:void(0);" class="u-addTopic-single"><i class="u-radio-ico"></i>单选题</a>
			<a style="margin-right:5px" href="javascript:void(0);" class="u-addTopic-multiple"><i class="u-checkbox-ico"></i>多选题</a>
			<a style="margin-right:5px" href="javascript:void(0);" class="u-addTopic-rw"><i class="u-radio-ico"></i>是非题</a>
			<a style="margin-right:5px" href="javascript:void(0);" class="u-addTopic-qa"><i class="u-smallList-ico"></i>问答题</a>
			<a style="margin-right:0px" href="javascript:void(0);" class="u-addTopic-import"><i class=""></i>导入问卷文本</a>
			<span class="hint"></span>
		</div>
		<div class="g-topicList-box">
			<input id="surveyId" type="hidden" value="${survey.id}" name="id">
			<ol class="g-topicList" id="topicListBox">
				<#if (survey.questions?size>0)>
					<#list survey.questions as question>
						<#if question.type ='singleChoice' || question.type ='multipleChoice' || question.type = 'trueOrFalse'>
							<#if question.type ='multipleChoice'>
								<#assign dtype='multiple'/>
							<#else>
								<#assign dtype='single'/>
							</#if>
							<li questionId="${question.id }" class="topic-item question" data-type="${dtype}">
								<input type="hidden" value="${(question.id)!''}" class="questionId">
								<input type="hidden" value="${question.type}" class="questionType">
								<input type="hidden" value="${((question.choiceGroups?first).maxChoose)!}" class="maxChoose">
								<div class="m-topic-module">
									<h3 class="title"><span class="serial-number">2、</span><span class="topicTitle questionTitle">${question.title}</span></h3>
									<ol class="m-question-lst choiceGroup">
										<#if question.choiceGroups??>
											<#list question.choiceGroups as choiceGroup>
												<#if choiceGroup.choices??>
													<#list choiceGroup.choices as choice>
														<li class="choice">
															<label class="m-<#if question.type == 'singleChoice' || question.type == 'trueOrFalse'>radio<#elseif question.type == 'multipleChoice'>checkbox<#else></#if>-tick disabled"> 
																<strong class="on"> 
																	<i class="ico"></i>
																	<input type="<#if question.type == 'singleChoice' || question.type == 'trueOrFalse'>radio<#elseif question.type == 'multipleChoice'>checkbox<#else></#if>" name="singleClone1"  disabled="disabled" value="">
																</strong> 
																<span><em class="aItemNum">${ConverNumToABCUtils.conver(choice_index)}、</em><span class="aItemTxt title">${choice.content}</span></span>
															 </label>
														</li>
													</#list>
												</#if>
											</#list>
										</#if>
									</ol>
									<div class="t-opt">
										<div class="nextAddNew">
											<span class="lx">在此题后插入新题：</span>
											<a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
											<a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
											<a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
											<a href="javascript:void(0);" class="u-addTopic-qa">问答题</a>
										</div>
										<div class="btn-block">
											<a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
											<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
										</div>
									</div>
								</div>
							</li>
						<#elseif question.type ='textEntry'>
							<li questionId="${question.id }" class="topic-item question" data-type="essayQuestion">
								<input type="hidden" value="${(question.id)!''}" class="questionId">
								<input type="hidden" value="textEntry" class="questionType">
								<span class="questionParam">
									
								</span>
								<div class="m-topic-module">
									<h3 class="title"><span class="serial-number">4、</span><span class="topicTitle questionTitle">${question.title}</span></h3>
									<div class="m-pbMod-ipt">
										<div class="size-txt">
											<span>最小字数：
												<strong class="minSizeNumber">
													<#if ((question.textEntryInteraction.minWords)!0) == 0>
														不限
													<#else>
														${(question.textEntryInteraction.minWords)!'不限'}
													</#if>
												</strong>
											</span>
											<span>最大字数：
												<strong class="maxSizeNumber">
													<#if ((question.textEntryInteraction.maxWords)!0) == 0>
														不限
													<#else>
														${(question.textEntryInteraction.maxWords)!'不限'}
													</#if>
												</strong>
											</span>
										</div>
										<textarea name="" class="u-textarea disabled" disabled=""></textarea>
									</div>
									<div class="t-opt">
										<div class="nextAddNew">
											<span class="lx">在此题后插入新题：</span>
											<a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
											<a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
											<a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
											<a href="javascript:void(0);" class="u-addTopic-qa">问答题</a>
										</div>
										<div class="btn-block">
											<a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
											<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
										</div>
									</div>
								</div>
							</li>
						<#else>	
						</#if>
					</#list>
				</#if>
			</ol>
			<div class="m-addElement-btn hasborder">
				<a onclick="nextStep(this)" href="javascript:void(0);"  class="btn u-main-btn" id="confirmLayer">下一步</a>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			//添加调查问卷
			addTopicFn.init($("#questionnaireWrap"));
			
			//题目排序
			$("#topicListBox").sortable({
		        containment: 'body',
		        placeholder: "ui-state-highlight",
		        stop: function(){
		        	addTopicFn.arrange();
		        	var data = '';
		        	$('#topicListBox').children('li').each(function(i){
		        		var sortNo = $('#topicListBox').children('li').index($(this)) + 1;
		        		data += 'questions['+i+'].id='+$(this).attr('questionId')+'&questions['+i+'].sortNo='+sortNo+'&';
		        	});
		        	$.put('${ctx}/${cid}/make/survey/question/updateBatch', data);
		        }
		    }).disableSelection();
		});
		
		function nextStep(a){
			if($('.g-topicList-box .question').size()<=0){
				alert('请添加题目');
				return false;
			}
			nextForm(a);
		}
	</script>
	</#if>
</#macro>