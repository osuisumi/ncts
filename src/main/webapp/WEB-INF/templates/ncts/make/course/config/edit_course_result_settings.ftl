<#macro editCourseResultSettingsFtl course>
<form id="saveCourseResultSettingsForm" action="${ctx!}/make/course/${(course.id)!}" method="put">
	<div class="g-cSet-lst">
		<ul class="g-addElement-lst">
			<#if ('mic' == (course.type)!'')>
				<li class="m-addElement-item">
					<div class="ltxt" style="width: 130px;">视频(1个)：</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="resultSettingsMap[video]" value="${(course.resultSettingsMap['video'])! }" placeholder="请设置分值(百分比)" class="u-pbIpt {digits:true, min:0}">
						</div>
					</div>
				</li>
				<li class="m-addElement-item">
					<div class="ltxt" style="width: 130px;">测验(1个)：</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="resultSettingsMap[test]" value="${(course.resultSettingsMap['test'])! }" placeholder="请设置分值(百分比)" class="u-pbIpt {digits:true, min:0}">
						</div>
					</div>
				</li>
			<#else>
				<@courseResultSettingsDirective courseId=course.id>
					<#if (activityMap?? && activityMap?size > 0)>
						<#list activityMap?keys as type>
							<li class="m-addElement-item">
								<div class="ltxt" style="width: 130px;">
								<#if (type == 'video')>
									视频
								<#elseif (type == 'discussion')>	
									主题研讨
								<#elseif (type == 'assignment')>	
									作业
								<#elseif (type == 'test')>	
									测验
								<#elseif (type == 'survey')>	
									调查问卷
								<#elseif (type == 'html')>	
									HTML
								</#if>
								(${activityMap[type]}个)：
								</div>
								<div class="center">
									<div class="m-pbMod-ipt">
										<input type="text" name="resultSettingsMap[${type }]" value="${(course.resultSettingsMap[type])! }" placeholder="请设置分值(百分比)" class="u-pbIpt {digits:true, min:0}">
									</div>
								</div>
							</li>
						</#list>
					<#else>
						<div class="g-noContent">
				            <p>请先编辑课程内容,再进行分值设置</p>
				        </div>
					</#if>
				</@courseResultSettingsDirective>
			</#if>
			<li class="m-addElement-btn hasborder">
				<a href="javascript:void(0);" data-href="" class="btn u-main-btn" onclick="saveCourseResultSettings()">保存</a> 
			</li>
		</ul>
	</div>
</form>
<script>
	function saveCourseResultSettings(){
		var total = 0;
		$('#saveCourseResultSettingsForm input[name^="resultSettingsMap"]').each(function(){
			if($(this).val().length > 0){
				total = total + parseInt($(this).val());
			}
		});
		if(total != 100){
			alert('请确保所有分值加起来等于100');
			return false;
		}
		var data = $.ajaxSubmit('saveCourseResultSettingsForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('保存成功');
		}
	}
</script>
</#macro>
