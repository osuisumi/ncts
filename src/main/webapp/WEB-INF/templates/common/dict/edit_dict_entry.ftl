<form id="createDictEntryForm" action="${ctx }/dict" method="post">
	<input type="hidden" name="dictTypeCode" value="${dictEntry.dictTypeCode }">
	<div class="g-addElement-lyBox">
		<ul class="g-addElement-lst g-addChapter-lst">
			<li class="m-addElement-item m-addElement-item1">
				<div class="center">
					<div class="m-pbMod-ipt">
						<input type="text" value="${dictEntry.dictName! }" name="dictName" class="u-pbIpt" required>
					</div>
				</div>
			</li>
			<li class="m-addElement-btn">
				<a onclick="saveDictEntry()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmAddChapter">创建</a> 
				<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
			</li>
		</ul>
	</div>
</form>
<script>
	function saveDictEntry(){
		if(!$('#createDictEntryForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('createDictEntryForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			$('.mylayer-cancel').trigger('click');
			if(callbackFunction != undefined){			
				var $callback = callbackFunction;
				if (! $.isFunction($callback)){
					$callback = eval('(' + callback + ')');
				} 
				$callback(json.responseData.dictValue, json.responseData.dictName);
			}
		}
	}
</script>