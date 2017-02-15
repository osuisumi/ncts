<#macro markEachOtherFtl assignmentUser aid>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign assignmentRelation=assignmentUser.assignmentRelation> 
	<#assign assignment=assignmentRelation.assignment> 
	<#assign inCurrentDate=TimeUtils.inCurrentDate((assignmentRelation.markTime)!'')>	
	<@assignmentMarks assignmentRelationId=assignmentRelation.id>
		<div class="g-studyAct-time">
	       	<div class="am-main-r">
	       		<#assign timePeriods=[]>
				<#assign timePeriods = timePeriods + [(assignmentRelation.markTime)!]>
				<#import "/ncts/study/common/show_time.ftl" as st /> 
				<@st.showTimeFtl timePeriods=timePeriods label="作业互评" /> 
	        </div>    
	    </div>
	    <div id="assignmentContentDiv" class="g-studyTask-dt">
			<div class="g-studyAct-tasklst">
	            <ul class="g-studyTask-lst">
	            	<#assign complete=true>
	            	<#assign expiredDays=PropertiesLoader.get('assignment.mark.expired.days')>
	            	<#list assignmentMarks as assignmentMark>
		                <li>
		                	<#if assignmentMark.state != 'marked'>
		                		<#assign complete=false>
		                	</#if>
		                    <h3 class="title"><a href="###">作业${assignmentMark_index + 1 }</a></h3>
		                    <p class="info">
		                        <span class="txt">${TimeUtils.formatDate(assignmentMark.assignmentUser.responseTime, 'yyyy/MM/dd HH:mm') }</span>
		                        <span class="line">|</span>
		                        <#if assignmentMark.score??>
			                       	<span class="txt">已评分：<em>${assignmentMark.score!0 }分</em></span>
			                    <#else>   	
			                       	<span class="txt">请尽快批阅, <em>
			                       		<#if (expiredDays?number - (.now?long - assignmentMark.createTime)/1000/60/60/24 ) < 1>
			                       			1
			                       		<#else>
			                       			${(expiredDays?number - (.now?long - assignmentMark.createTime)/1000/60/60/24 )?string('0')}
			                       		</#if>
			                       	</em>天后失效</span>
		                        </#if>
		                    </p>
		                    <a onclick="markAssignmentUser('${assignmentMark.id}')" class="btn u-main-btn u-opt-btn">我要评分</a>
		                </li>
		        	</#list>
	            </ul>
	            <br><br>
				<#if (assignment.eachOtherMarkConfig.markNum > 0 && assignmentMarks?size < assignment.eachOtherMarkConfig.markNum)>
					<div class="g-studyAct-center">
		                <p class="text">
		                	您需要批阅<strong>${assignment.eachOtherMarkConfig.markNum }</strong>份作业, 
		                	您已领取<strong>${assignmentMarks?size }</strong>份
		                	<br><br>
		                	领取作业后<strong>${expiredDays }</strong>天内未批阅的作业需要重新领取
		                </p>
		                <#if (inCurrentDate)>
		                	<div class="btn-row">
			                    <a onclick="createAssignmentMark()" class="btn u-main-btn u-opt-btn">领取作业</a>
			                </div>
		                </#if>
		            </div>
		        <#else>
		        	<#if (complete)>
		        		<div class="btn-row">
		                    <a onclick="goStep(2)" class="btn u-main-btn u-opt-btn">下一步</a>
		                </div>
		        	</#if>
				</#if>
	        </div>
		</div>
		<script>
			function createAssignmentMark(){
				$.post('${ctx}/study/assignment/mark', 'assignment.id=${assignment.id}&id=${assignmentRelation.id}', function(data){
					if(data.responseCode == '00'){
						studyCourse('${cid}','','${aid}')
					}else{
						if(data.responseMsg == 'assigment is not enough'){
							alert('暂时没有未领取的作业, 请稍候重试', null, 2000);
						}
					}
					
				});
			}
			
			function markAssignmentUser(assignmentMarkId){
				$('#assignmentContentDiv').load('${ctx}/${aid}/study/assignment/biz/markAssignmentUser', 'id='+assignmentMarkId+'&inCurrentDate=${inCurrentDate?string("true", "false")}');
			}
		</script>
	</@assignmentMarks>
</#macro>