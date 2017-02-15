<#assign cid=CSAIdObject.getCSAIdObject().cid>
<@testDeliveryUserDirective testId=test.id relationId=cid activityId=(aid[0])!>
	<#assign testDeliveryUser=testDeliveryUser/>
	<#assign questions=questions!/>
	<#assign testSubmissionMap=testSubmissionMap/>
</@testDeliveryUserDirective>
		<div class="g-study-dt g-study-check-dt">
									<span class="u-arrow"></span>
	                        		<div class="g-question-box">
			                            <div class="am-title">    
			                            	<h2>
                                                <span class="aa-type-txt">【测验】</span>
                                                <span class="txt">${testDeliveryUser.testDelivery.test.title}</span>
                                            </h2>   
                                            <#if testDeliveryUser.completionStatus=='completed'>
                                            	<p class="m-studyTest-grade">已得：<span><strong>${testDeliveryUser.sumScore}</strong>分</span></p>
                                            </#if>                                    
			                            </div>
                                        <div class="g-question-box-title">
                                            <div class="g-question-tx">${testDeliveryUser.testDelivery.test.description}</div>
                                        </div>                                                                            
                                        <ol class="g-topic-lst" id="topicList">                                        	
                                        	<#assign testDeliveryUserId=testDeliveryUser.id/>
											<#if questions??>
												<#list questions as question>
													<#if question.quesType ='SINGLE_CHOICE' || question.quesType ='MULTIPLE_CHOICE' || question.quesType = 'TRUE_FALSE'>
														<#if testSubmissionMap??>
															<#assign testSubmission=testSubmissionMap[question.id]/>															
														</#if>														
														<li class="m-topic-item">
														<form method="post" id="${question.itemKey?replace(':','_')}_itemForm" action="${ctx}/${(aid[0])! }/study/unique_uid_${Session.loginer.id }/test/delivery/${testDeliveryUser.id!''}/handleResponse">
														<input type="hidden" name="qti_item_${question.itemKey!''}_RESPONSE"/>
		                                                <div class="m-topic m-topic01">
		                                                    <h3 class="title"><span class="item-num">${question_index+1}、</span>${question.title}<i class="item-score">（${question.score}分）</i></h3>
		                                                    <ol class="m-question-lst">
		                                                    	<#if question.interactionOptions??>
																<#list question.interactionOptions as interactionOption>
																	<#if interactionOption??>
																		<#assign isChecked="false"/>
																		<#if testSubmission.candidateResponses??>
																			<#list testSubmission.candidateResponses as response>
																				<#if response?trim==interactionOption.id>
																					 <#assign isChecked="true"/>
																				</#if>																		
																			</#list>
																		</#if>	
				                                                        <li>
				                                                            <label class="m-<#if question.quesType == 'SINGLE_CHOICE' || question.quesType == 'TRUE_FALSE'>radio<#elseif question.quesType == 'MULTIPLE_CHOICE'>checkbox<#else></#if>-tick">
				                                                                <strong>
				                                                                    <i class="ico ico2"></i>
						                                                             <#if question.quesType == 'SINGLE_CHOICE' || question.quesType == 'TRUE_FALSE'>
																						<input type="radio" name="qti_response_${question.itemKey}_RESPONSE" <#if testDeliveryUser.completionStatus!='completed'>onclick="handleResponse('${question.itemKey?replace(':','_')}_itemForm')"</#if>  <#if isChecked=='true'>checked="checked"</#if> value="${interactionOption.id}">
																					  <#else>																						
																						<input type="checkbox" name="qti_response_${question.itemKey}_RESPONSE" <#if testDeliveryUser.completionStatus!='completed'>onclick="handleResponse('${question.itemKey?replace(':','_')}_itemForm')" </#if> <#if isChecked =="true">checked="checked"</#if>  value="${interactionOption.id}">
																					  </#if>
				                                                                </strong>
				                                                                <span>${ConverNumToABCUtils.conver(interactionOption_index)}、${interactionOption.text}</span>
				                                                            </label>
				                                                        </li>  
																		
																		
				                                                     </#if>
																</#list>
																</#if>                                                      
		                                                    </ol>
		                                					<#if testDeliveryUser.completionStatus=='completed'>
		                                						<div class="m-check-result <#if !testSubmission.correct>wrong</#if>">
			                                                        <div class="m-ck-result-txt">
			                                                            <p class="m-ck-result">您的答案：
			                                                                <i class="m-ck-judge"></i>
			                                                            </p>
			                                                                                                                     
			                                                        </div>                                                 
			                                                    </div>
		                                					</#if>
		                                            	</div>
		                                            	</form>
												  		</li><!--end topic item -->
												  	</#if>
												</#list>
											</#if>
											<#if testDeliveryUser.completionStatus!='completed'>
                                            <div class="g-studyIpt-box"><!--start suggest 培训的建议-->

                                                <div class="m-studyIpt-btn m-common-btn t-fr m-common-btn01 m-study-check-btn">
                                                    <form id="testForm" method="put" action="${ctx}/${(aid[0])! }/study/unique_uid_${Session.loginer.id }/test/delivery/${testDeliveryUserId}/finishTest">
                                                    <!--<button type="button" class="btn u-inverse-btn">取消</button>-->
                                                    <a href="###" onclick="javascript:finishTest();"><button type="button"  class="btn u-main-btn">提交</button></a>
                                                    </form>
                                                </div>
                                            </div>

											</#if>
                                        </ol>
                                    </div>
                                </div>
                                <script>
	                                $(function(){
	                            		$('.m-radio-tick input').bindCheckboxRadioSimulate();
	                            		$('.m-checkbox-tick input').bindCheckboxRadioSimulate();
	                            	});
                                
                                	function handleResponse(formId){
                                		var data = $.ajaxSubmit(formId);
                                		if (!isMatchJson(data)){
                        					$('body').html($(data));
                        				}else{
                        					var json = $.parseJSON(data);
    										if(json.responseCode == '01'){
    											console.log(json.responseMsg);
    										}
                        				}
                                	}
                                	
                                	function finishTest(){
                                		confirm("提交后不允许修改测验答案，确定要提交吗？",function(){
	                                		var data = $.ajaxSubmit('testForm');
	                                		if (!isMatchJson(data)){
	                        					$('body').html($(data));
	                        				}else{
	                        					var json = $.parseJSON(data);
												if(json.responseCode == '01'){
													alert(json.responseMsg);
												}else{
													viewTest();
												}
	                        				}
										});
										
                                	}
                                </script>    
