<form id="saveSectionConfigForm" action="${ctx }/make/section/${section.id }/updateSectionConfig" method="put">
	<div class="g-addElement-lyBox">
        <ul class="g-addElement-lst g-addCourse-lst1">
        	<#if ('self' != "${(type[0])!''}")>
        		<li class="m-addElement-item">
	                <div class="ltxt">发布日期 ：</div>
	                <div class="center">
	                    <div class="m-pbMod-ipt date">
	                        <input name="dateTime" type="text" value="${(section.timePeriod.startTime?string("yyyy/MM/dd"))!}" onFocus="WdatePicker({minDate:'${.now?date}',dateFmt:'yyyy/MM/dd'})" class="u-pbIpt">
	                    </div>
	                </div>
	            </li>
	            <li class="m-addElement-item">
	                <div class="ltxt">发布时间：</div>
	                <div class="center">
	                    <div class="m-slt-row date">
	                        <div class="block">
	                            <div class="m-selectbox style1">
	                                <strong><span class="simulateSelect-text">0</span><i class="trg"></i></strong>
	                                <select id="hourSelect" name="dateTime">
	                                	<#list 0..23 as i>
	                                		<option value="${i}">${i}</option>
	                                	</#list>
	                                </select>
	                                <script>
	                                	$(function(){
	                                		$('#hourSelect').simulateSelectBox({
										        byValue: "${TimeUtils.getFieldValue((section.timePeriod.startTime)!, 'hour')}"
										    });	
	                                	});
	                                </script>
	                            </div>
	                        </div>
	                        <div class="space">时</div>
	                        <div class="block">
	                            <div class="m-selectbox style1">
	                                <strong><span class="simulateSelect-text">---</span><i class="trg"></i></strong>
	                                <select id="minuteSelect" name="dateTime">
	                                	<#list 0..59 as i>
	                                		<option value="${i}">${i}</option>
	                                	</#list>
	                                </select>
	                                <script>
	                                	$(function(){
	                                		$('#minuteSelect').simulateSelectBox({
	                                			byValue: "${TimeUtils.getFieldValue((section.timePeriod.startTime)!, 'minute')}"
										    });	
	                                	});
	                                </script>
	                            </div>
	                        </div>
	                        <div class="space">分</div>
	                    </div>
	                </div>
	            </li>
        	</#if>
            <li class="m-addElement-item">
                <div class="ltxt"></div>
                <div class="center">
                    <div class="m-check-mod">
                        <label class="m-checkbox-tick">
                            <strong class="isHiddenStrong">
                                <i class="ico"></i>
                                <#if (section.isHidden)! = 'Y'>
                                	<input type="checkbox" checked="checked" name="isHidden" value="Y"/>
                                <#else>
                                	<input type="checkbox" name="isHidden" value="Y" />
                                </#if>
                            </strong>
                            <span>对学生隐藏</span>
                        </label>
                    </div>
                </div>
            </li>
            <li class="m-addElement-btn">
            	<a onclick="saveSectionConfig()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmLayer">保存</a>
                <a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
            </li>
        </ul>
    </div>
</form>
<script>
$(function(){
	$('.m-checkbox-tick input').bindCheckboxRadioSimulate();
});

function saveSectionConfig(){
	if(!$('.isHiddenStrong').hasClass('on')){
		$('#saveSectionConfigForm').append('<input type="hidden" value="N" name="isHidden"/>');
	}
	var data = $.ajaxSubmit('saveSectionConfigForm');
	var json = $.parseJSON(data);
	if(json.responseCode == '00'){
		alert('设置成功');
		$('.u-cancelLayer-btn').trigger('click');
	}
}
</script>