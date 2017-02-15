<#macro viewTestFtl testId aid relationId>
	<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
	<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
	<#if hasTeachRole>
		<#assign role='teach'>
	<#else>
		<#assign role='study'>
	</#if>
	<@testDeliveryUserDirective testId=testId relationId=relationId activityId=aid>
		<#assign testDeliveryUser=testDeliveryUser/>
		<#assign questions=questions/>
		<#assign testSubmissionMap=testSubmissionMap/>
		<#assign inCurrentDate=TimeUtils.inCurrentDate((activity.timePeriod)!'', (course.timePeriod)!'')>	
	</@testDeliveryUserDirective>
	
	<div class="g-study-dt g-study-check-dt">
                                    <div class="g-question-box">
                                    	<div class="am-title">
                                            <h2>
                                                <span class="aa-type-txt">【测验】</span>
                                                <span class="txt">${testDeliveryUser.testDelivery.test.title!}</span>
                                            </h2>
                                            <#if testDeliveryUser.completionStatus=='completed'>
                                            <p class="m-studyTest-grade">已得：<span><strong>${testDeliveryUser.sumScore}</strong>分</span></p>
                                            </#if>
                                            <div class="am-main-r am-g-question-tl-time">
                                                <#assign timePeriods=[]>
												<#assign timePeriods = timePeriods + [(activity.timePeriod)!]>
												<#assign timePeriods = timePeriods + [(course.timePeriod)!]>
												<#import "/ncts/study/common/show_time.ftl" as st /> 
												<@st.showTimeFtl timePeriods=timePeriods label="活动" /> 
                                                  <input type="hidden" value="2016/6/30,20:30:00" class="endTime">
                                            </div>      
                                        </div>
                                        <div class="g-question-box-title">
                                            <div class="g-question-tx">${testDeliveryUser.testDelivery.test.description}</div>
                                        </div>  
                                        	<#assign testDeliveryUserId=testDeliveryUser.id/>
                                        <form id="testForm" method="put" action="${ctx}/${aid }/${role }/unique_uid_${Session.loginer.id }/test/delivery/${testDeliveryUserId}/finishTest">                                                                          
                                        <ol class="g-topic-lst" id="topicList">                                        	
                                        
											<#if questions??>
												<#list questions as question>
													<#if question.quesType ='SINGLE_CHOICE' || question.quesType ='MULTIPLE_CHOICE' || question.quesType = 'TRUE_FALSE'>
														<#if testSubmissionMap??>
															<#assign testSubmission=testSubmissionMap[question.id]/>															
														</#if>														
														<li class="m-topic-item">
														
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
				                                                                <strong class="on">
				                                                                    <i class="ico ico2"></i>
						                                                             <#if question.quesType == 'SINGLE_CHOICE' || question.quesType == 'TRUE_FALSE'>
																						<input type="radio" name="qti_response_${question.itemKey}_RESPONSE"  <#if isChecked=='true'>checked="checked"</#if> value="${interactionOption.id}">
																					  <#else>																						
																						<input type="checkbox" name="qti_response_${question.itemKey}_RESPONSE"   <#if isChecked =="true">checked="checked"</#if>  value="${interactionOption.id}">
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
		       
												  		</li><!--end topic item -->
												  	</#if>
												</#list>
											</#if>
											<#assign maxAttempts=testDeliveryUser.testDelivery.test.maxAttempts>
											<#if (testDeliveryUser.completionStatus!='completed'||maxAttempts==0||maxAttempts>testDeliveryUser.attempts) && !hasTeachRole && inCurrentDate>
                                            <div class="g-studyIpt-box"><!--start suggest 培训的建议-->

                                                <div class="m-studyIpt-btn m-common-btn t-fr m-common-btn01 m-study-check-btn">
                                                    
                                                    <!--<button type="button" class="btn u-inverse-btn">取消</button>-->
                                                    
                                               		<a href="###" onclick="javascript:finishTest();">
                                               			<button type="button"  class="btn u-main-btn">
                                               				<#if 0 = (testDeliveryUser.attempts)!0 >
                                               					提交
                                               				<#else>	
                                               					重新提交
                                               				</#if>
                                               			</button>
                                               		</a>
                                                    
                                                </div>
                                            </div>

											</#if>
                                        </ol>
  </form>

                                    </div>
                                    <!--end study activity box 调查问卷-->
                                </div>
                                <script>
                                	function handleResponse(formId){
                                		var data = $.ajaxSubmit(formId);
                                		if (!isMatchJson(data)){
                        					$('body').html($(data));
                        				}else{
                        					var json = $.parseJSON(data);
    										if(json.responseCode == '01'){
    											alert(json.responseMsg);
    										}
                        				}
                                	}
                                	
                                	function finishTest(){
                                		<#if (maxAttempts > 0 ) &&( maxAttempts > testDeliveryUser.attempts)>
                                			var info="本测验仅允许提交${maxAttempts}次，剩余提交次数：${maxAttempts-testDeliveryUser.attempts}次,是否确定提交?";
                                		<#else>
                                			var info="您确定要提交本次测验吗？";
                                		</#if>
                                		confirm(info,function(){
	                                		var data = $.ajaxSubmit('testForm');
	                                		if (!isMatchJson(data)){
	                        					$('body').html($(data));
	                        				}else{
	                        					var json = $.parseJSON(data);
												if(json.responseCode == '01'){
													alert(json.responseMsg);
												}else{
													window.location.reload();
												}
	                        				}
										});
										
                                	}
                                </script>    
</#macro>