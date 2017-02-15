<#macro showTimeFtl timePeriods label=''>	
	<#assign has_first_startTime=false>
	<#assign has_first_endTime=false>
	<#assign startTime=''>
	<#assign endTime=''>
	
	<#if (timePeriods?size>0)>
		<#list timePeriods as timePeriod>
			<#if (((timePeriod.startTime?long)!0) > 0)>
				<#if !has_first_startTime>
					<#assign startTime=(timePeriod.startTime)!''>
					<#assign has_first_startTime=true>
				<#else>	
					<#if (((timePeriod.startTime?long)!0) > ((startTime?long)!0))>
						<#assign startTime=(timePeriod.startTime)!''>
					</#if>
				</#if>
			</#if>
			<#if (((timePeriod.endTime?long)!0) > 0)>
				<#if !has_first_endTime>
					<#assign endTime=(timePeriod.endTime)!''>
					<#assign has_first_endTime=true>
				<#else>	
					<#if (((timePeriod.endTime?long)!0) < ((endTime?long)!0))>
						<#assign endTime=(timePeriod.endTime)!''>
					</#if>
				</#if>
			</#if>
		</#list>
	</#if>
	
	<#if has_first_startTime && has_first_endTime>
		<#if TimeUtils.hasBegun(startTime)>
			<#if !TimeUtils.hasEnded(endTime)>
				<div class="am-count-down in">
					<i class="trg"></i>
					<span class="txt">离${label}结束还剩：</span>
					<div class="t-time">${TimeUtils.prettyEndTime(endTime!)}</div>
				</div>
			<#elseif TimeUtils.hasEnded(endTime) >
				<div class="am-count-down end">
					<i class="trg"></i>
					<p class="h-txt">${label}已结束</p>
				</div>
			<#else>
				<div class="am-count-down in">
					<i class="trg"></i>
					<p class="h-txt">${label}进行中</p>
				</div>
			</#if>
		<#elseif !TimeUtils.hasBegun(startTime)>
			<div class="am-count-down">
				<i class="trg"></i>
				<span class="txt">离${label}开始还有：</span>
				<div class="t-time">${TimeUtils.prettyStartTime(startTime)}</div>
			</div>
		<#else>
			<div class="am-count-down in">
				<i class="trg"></i>
				<p class="h-txt">${label}进行中</p>
			</div>
		</#if>
	<#else>
		<div class="am-count-down in">
			<i class="trg"></i>
			<p class="h-txt">${label}进行中</p>
		</div>
	</#if>
</#macro>