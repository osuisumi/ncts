<#macro editVideoActivityAttributeFtl activity>
	<form id="saveActivityAttributeForm" action="${ctx }/make/activity/${(activity.id)!}" method="put">
		<ul class="g-addElement-lst g-addCourse-lst">
			<li class="m-addElement-item">
				<div class="ltxt">观看时间(分钟)：</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input type="text" name="activity.attributeMap[view_time].attrValue" placeholder="输入观看时间" class="u-pbIpt {digits:true, min:0}" value="${(activity.attributeMap.view_time.attrValue)!}">
					</div>
				</div>
			</li>
			<li class="m-addElement-btn">
				<a onclick="saveActivityAttribute(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmLayer">保存并下一步</a> 
				<a onclick="prevForm(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">上一步</a> 
				<a class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
			</li>
		</ul>
	</form>
	<script>
	function saveActivityAttribute(obj){
		if(!$('#saveActivityAttributeForm').validate().form()){
			return false;
		}
		
		var data = $.ajaxSubmit('saveActivityAttributeForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			nextForm(obj);
		}
	}
	</script>
</#macro>