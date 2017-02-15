<#macro editDiscussionActivityAttributeFtl activity>
	<form id="saveActivityAttributeForm" action="${ctx }/make/activity/${(activity.id)!}" method="put">
		<ul class="g-addElement-lst g-addCourse-lst">
			<li class="m-addElement-item">
				<div class="ltxt">回复数：</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input id="mainPostNumParam" type="text" name="activity.attributeMap[main_post_num].attrValue" placeholder="输入主贴数" class="u-pbIpt {digits:true, min:0}" value="${(activity.attributeMap.main_post_num.attrValue)!}">
					</div>
				</div>
			</li>
			<!-- <li class="m-addElement-item">
				<div class="ltxt">主贴比重：</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input id="mainPostPctParam" type="text" name="activity.attributeMap[main_post_pct].attrValue" placeholder="输入主贴比重" class="u-pbIpt {number:true, min:0}" value="${(activity.attributeMap.main_post_pct.attrValue)!}">
					</div>
				</div>
			</li> -->
			<li class="m-addElement-item">
				<div class="ltxt">子回复数：</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input id="subPostNumParam" type="text" name="activity.attributeMap[sub_post_num].attrValue" placeholder="输入子贴数" class="u-pbIpt {digits:true, min:0}" value="${(activity.attributeMap.sub_post_num.attrValue)!}">
					</div>
				</div>
			</li>
			<!-- <li class="m-addElement-item">
				<div class="ltxt">子贴比重：</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input id="subPostPctParam"  type="text" name="activity.attributeMap[sub_post_pct].attrValue" placeholder="输入子贴比重" class="u-pbIpt {number:true, min:0}" value="${(activity.attributeMap.sub_post_pct.attrValue)!}">
					</div>
				</div>
			</li> -->
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
		//其余验证
/* 		var mainPostPct = $('#mainPostPctParam').val();
		if(mainPostPct != null && parseInt(mainPostPct) > 0){
			var mainPostNum = $('#mainPostNumParam').val();
			if(mainPostNum == null || mainPostNum == '' || parseInt(mainPostNum) == 0){
				alert('主帖比重大于0的情况下, 主帖数必须大于0', null, 2000);
				return false;
			}
		}
		var subPostPct = $('#subPostPctParam').val();
		if(subPostPct != null && parseInt(subPostPct) > 0){
			var subPostNum = $('#subPostNumParam').val();
			if(subPostNum == null || subPostNum == '' || parseInt(subPostNum) == 0){
				alert('子帖比重大于0的情况下, 子帖数必须大于0', null, 2000);
				return false;
			}
		}
		if(subPostPct != '' || mainPostPct != ''){
			if(parseInt(subPostPct) +　parseInt(mainPostPct)　!= 100){
				alert('主帖比重与子帖比重相加必须等于100', null, 2000);
				return false;
			}
		} */
		
		var data = $.ajaxSubmit('saveActivityAttributeForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			nextForm(obj);
		}
	}
	</script>
</#macro>