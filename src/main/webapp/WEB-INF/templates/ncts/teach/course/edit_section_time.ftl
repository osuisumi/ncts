<div class="g-set-time">
    <div class="g-section-tt">
        <div class="m-setT-notice">
           <i></i> <span>温馨提示：您可以对当前节点及该节点下的活动进行独立的学习时长设置。</span>
        </div>
        <div class="g-setT-active-tl">
            <h3 class="m-section-tt">
                <span>${section.title}</span>
            </h3>
            <div class="m-setTime-ben">
                <div class="optRow">
                    <div class="block">开放时间：</div>
                    <div class="dataBlock">
                        <div class="m-pbMod-ipt date">
                            <input id="start_date" type="text" value="${(section.timePeriod.startTime?string("yyyy-MM-dd"))!}" class="u-pbIpt"
                            onFocus="WdatePicker({oncleared:function(){clearSectionDate('start')},onpicked:function(){updateSectionConfig()},dateFmt:'yyyy-MM-dd'})" />
                        </div>
                    </div>
                    <div class="timeBlock">
                        <div class="m-selectbox style1">
                            <strong><span class="simulateSelect-text">---</span><i></i></strong>
                            <select id="start_hourSelect" onchange="updateSectionConfig()">
                               	<#list 0..23 as i>
                               		<#if (i < 10)>
                               			<#assign j='0'+i>  
                               			<option value="${j}">${j}</option>
                               		<#else>
                               			<option value="${i}">${i}</option>
                               		</#if>
                               	</#list>
                            </select>
                            <script>
                               	$(function(){
                               		var hour = "${TimeUtils.getFieldValue((section.timePeriod.startTime)!, 'hour')}";
                               		if(hour < 10){
                               			hour = '0'+hour;
                               		}
                               		$('#start_hourSelect').simulateSelectBox({
									    byValue: hour
									});	
                               	});
                            </script>
                        </div>
                    </div>
                    <div class="block">时</div>
                    <div class="timeBlock">
                        <div class="m-selectbox style1">
                            <strong><span class="simulateSelect-text">---</span><i></i></strong>
                            <select id="start_minuteSelect" onchange="updateSectionConfig()">
                                  	<#list 0..59 as i>
                                  		<#if (i < 10)>
	                               			<#assign j='0'+i>  
	                               			<option value="${j}">${j}</option>
	                               		<#else>
	                               			<option value="${i}">${i}</option>
	                               		</#if>
                                  	</#list>
                               </select>
                               <script>
                               $(function(){
                              		var minute = "${TimeUtils.getFieldValue((section.timePeriod.startTime)!, 'minute')}";
	                              		if(minute < 10){
	                              			minute = '0'+minute;
	                              		}
	                              		$('#start_minuteSelect').simulateSelectBox({
										    byValue: minute
										});	
	                              	});
                               </script>
                        </div>
                    </div>
                    <div class="block">分</div>
                </div>
                <span class="where">至</span>
                <div class="optRow">
                    <div class="dataBlock">
                        <div class="m-pbMod-ipt date">
                            <input id="end_date" type="text" value="${(section.timePeriod.endTime?string("yyyy-MM-dd"))!}" class="u-pbIpt"
                            onFocus="WdatePicker({oncleared:function(){clearSectionDate('end')},onpicked:function(){updateSectionConfig()},dateFmt:'yyyy-MM-dd'})" />
                        </div>
                    </div>
                    <div class="timeBlock">
                        <div class="m-selectbox style1">
                            <strong><span class="simulateSelect-text">---</span><i></i></strong>
                            <select id="end_hourSelect" onchange="updateSectionConfig()">
                               	<#list 0..23 as i>
                               		<#if (i < 10)>
                               			<#assign j='0'+i>  
                               			<option value="${j}">${j}</option>
                               		<#else>
                               			<option value="${i}">${i}</option>
                               		</#if>
                               	</#list>
                            </select>
                            <script>
                               	$(function(){
                               		var hour = "${TimeUtils.getFieldValue((section.timePeriod.endTime)!, 'hour')}";
                               		if(hour < 10){
                               			hour = '0'+hour;
                               		}
                               		$('#end_hourSelect').simulateSelectBox({
									    byValue: hour
									});	
                               	});
                            </script>
                        </div>
                    </div>
                    <div class="block">时</div>
                    <div class="timeBlock">
                        <div class="m-selectbox style1">
                            <strong><span class="simulateSelect-text">---</span><i></i></strong>
                            <select id="end_minuteSelect" onchange="updateSectionConfig()">
                                  	<#list 0..59 as i>
                                  		<#if (i < 10)>
	                               			<#assign j='0'+i>  
	                               			<option value="${j}">${j}</option>
	                               		<#else>
	                               			<option value="${i}">${i}</option>
	                               		</#if>
                                  	</#list>
                               </select>
                               <script>
                               $(function(){
                              		var minute = "${TimeUtils.getFieldValue((section.timePeriod.endTime)!, 'minute')}";
	                              		if(minute < 10){
	                              			minute = '0'+minute;
	                              		}
	                              		$('#end_minuteSelect').simulateSelectBox({
										    byValue: minute
										});	
	                              	});
                               </script>
                        </div>
                    </div>
                    <div class="block">分</div>
                </div>                     
            </div>
        </div>
        
        <@activitiesDirective relationId=section.id>
	        <div class="g-setT-active-del">
	            <ins class="u-arrow"></ins>
	            <ul>
	            	<#list activities as activity>
	            		<li>
		                    <h4 class="m-setTime-txt">
		                        <i class="td-icon"></i>
		                        <span>${activity.title }</span>
		                    </h4>                       
		                    <div class="m-setTime-ben">
		                        <div class="optRow">
		                            <div class="block">开放时间：</div>
		                            <div class="dataBlock">
		                                <div class="m-pbMod-ipt date">
		                                    <input id="start_date_${activity.id }" type="text" value="${(activity.timePeriod.startTime?string("yyyy-MM-dd"))!}" class="u-pbIpt"
                            				onFocus="WdatePicker({oncleared:function(){clearActivityDate('start', '${activity.id }')},onpicked:function(){updateActivityConfig('${activity.id }')},dateFmt:'yyyy-MM-dd'})" />
		                                </div>
		                            </div>
		                             <div class="timeBlock">
				                        <div class="m-selectbox style1">
				                            <strong><span class="simulateSelect-text">01</span><i></i></strong>
				                            <select id="start_hourSelect_${activity.id }" onchange="updateActivityConfig('${activity.id }')">
				                               	<#list 0..23 as i>
				                               		<#if (i < 10)>
				                               			<#assign j='0'+i>  
				                               			<option value="${j}">${j}</option>
				                               		<#else>
				                               			<option value="${i}">${i}</option>
				                               		</#if>
				                               	</#list>
				                            </select>
				                            <script>
				                               	$(function(){
				                               		var hour = "${TimeUtils.getFieldValue((activity.timePeriod.startTime)!, 'hour')}";
				                               		if(hour < 10){
				                               			hour = '0'+hour;
				                               		}
				                               		$('#start_hourSelect_${activity.id }').simulateSelectBox({
													    byValue: hour
													});	
				                               	});
				                            </script>
				                        </div>
				                    </div>
				                    <div class="block">时</div>
				                    <div class="timeBlock">
				                        <div class="m-selectbox style1">
				                            <strong><span class="simulateSelect-text">01</span><i></i></strong>
				                            <select id="start_minuteSelect_${activity.id }" onchange="updateActivityConfig('${activity.id }')">
				                                  	<#list 0..59 as i>
				                                  		<#if (i < 10)>
					                               			<#assign j='0'+i>  
					                               			<option value="${j}">${j}</option>
					                               		<#else>
					                               			<option value="${i}">${i}</option>
					                               		</#if>
				                                  	</#list>
				                               </select>
				                               <script>
				                               $(function(){
				                              		var minute = "${TimeUtils.getFieldValue((activity.timePeriod.startTime)!, 'minute')}";
					                              		if(minute < 10){
					                              			minute = '0'+minute;
					                              		}
					                              		$('#start_minuteSelect_${activity.id }').simulateSelectBox({
														    byValue: minute
														});	
					                              	});
				                               </script>
				                        </div>
				                    </div>
				                    <div class="block">分</div>
				                </div>
				                <span class="where">至</span>
				                <div class="optRow">
				                    <div class="dataBlock">
				                        <div class="m-pbMod-ipt date">
				                            <input id="end_date_${activity.id }" type="text" value="${(activity.timePeriod.endTime?string("yyyy-MM-dd"))!}" class="u-pbIpt"
				                            onFocus="WdatePicker({oncleared:function(){clearActivityDate('end', '${activity.id }')},onpicked:function(){updateActivityConfig('${activity.id }')},dateFmt:'yyyy-MM-dd'})" />
				                        </div>
				                    </div>
				                    <div class="timeBlock">
				                        <div class="m-selectbox style1">
				                            <strong><span class="simulateSelect-text">01</span><i></i></strong>
				                            <select id="end_hourSelect_${activity.id }" onchange="updateActivityConfig('${activity.id }')">
				                               	<#list 0..23 as i>
				                               		<#if (i < 10)>
				                               			<#assign j='0'+i>  
				                               			<option value="${j}">${j}</option>
				                               		<#else>
				                               			<option value="${i}">${i}</option>
				                               		</#if>
				                               	</#list>
				                            </select>
				                            <script>
				                               	$(function(){
				                               		var hour = "${TimeUtils.getFieldValue((activity.timePeriod.endTime)!, 'hour')}";
				                               		if(hour < 10){
				                               			hour = '0'+hour;
				                               		}
				                               		$('#end_hourSelect_${activity.id }').simulateSelectBox({
													    byValue: hour
													});	
				                               	});
				                            </script>
				                        </div>
				                    </div>
				                    <div class="block">时</div>
				                    <div class="timeBlock">
				                        <div class="m-selectbox style1">
				                            <strong><span class="simulateSelect-text">01</span><i></i></strong>
				                            <select id="end_minuteSelect_${activity.id }" onchange="updateActivityConfig('${activity.id }')">
				                                  	<#list 0..59 as i>
				                                  		<#if (i < 10)>
					                               			<#assign j='0'+i>  
					                               			<option value="${j}">${j}</option>
					                               		<#else>
					                               			<option value="${i}">${i}</option>
					                               		</#if>
				                                  	</#list>
				                               </select>
				                               <script>
				                               $(function(){
				                              		var minute = "${TimeUtils.getFieldValue((activity.timePeriod.endTime)!, 'minute')}";
					                              		if(minute < 10){
					                              			minute = '0'+minute;
					                              		}
					                              		$('#end_minuteSelect_${activity.id }').simulateSelectBox({
														    byValue: minute
														});	
					                              	});
				                               </script>
				                        </div>
				                    </div>
				                    <div class="block">分</div>
		                        </div>                     
		                    </div>
		                </li>
	            	</#list>
	            </ul>                
	        </div>
       	</@activitiesDirective>
        <div class="m-setTime-btn ">
            <button type="button" class="btn u-inverse-btn mylayer-cancel">完成</button>
        </div>
    </div>  
</div>
<script>
	function updateSectionConfig(){
		var start_Date = $('#start_date').val();
		var start_hour = $('#start_hourSelect').val();
		var start_minute = $('#start_minuteSelect').val();
		start_Date = parseTime(start_Date, start_hour, start_minute);
		var end_Date = $('#end_date').val();
		var end_hour = $('#end_hourSelect').val();
		var end_minute = $('#end_minuteSelect').val();
		end_Date = parseTime(end_Date, end_hour, end_minute);
		var data = 'startTime='+start_Date+'&endTime='+end_Date;
		$.put('${ctx}/teach/section/${section.id!}', data);
	}
	
	function updateActivityConfig(activityId){
		var start_Date = $('#start_date_'+activityId).val();
		var start_hour = $('#start_hourSelect_'+activityId).val();
		var start_minute = $('#start_minuteSelect_'+activityId).val();
		start_Date = parseTime(start_Date, start_hour, start_minute);
		var end_Date = $('#end_date_'+activityId).val();
		var end_hour = $('#end_hourSelect_'+activityId).val();
		var end_minute = $('#end_minuteSelect_'+activityId).val();
		end_Date = parseTime(end_Date, end_hour, end_minute);
		var data = 'startTime='+start_Date+'&endTime='+end_Date;
		$.put('${ctx}/teach/activity/'+activityId+'/update', data);
	}
	
	function parseTime(date, hour, minute){
		if(date != null && date != ''){
			if(hour != null && hour != ''){
				date += ' '+hour;
			}else{
				date += ' 00';
			}
			if(minute != null && minute != ''){
				date += ':'+minute+':00';
			}else{
				date += ':00:00';
			}
			return date;
		}
		return '';
	}
	
	function clearSectionDate(type){
		$('#'+type+'_hourSelect').simulateSelectBox();
		$('#'+type+'_minuteSelect').simulateSelectBox();
		updateSectionConfig();
	}
	
	function clearActivityDate(type, activityId){
		$('#'+type+'_hourSelect_'+activityId).simulateSelectBox();
		$('#'+type+'_minuteSelect_'+activityId).simulateSelectBox();
		updateActivityConfig(activityId);
	}
</script>