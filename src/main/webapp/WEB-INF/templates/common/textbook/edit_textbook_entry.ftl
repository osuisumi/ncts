<form id="createTextBookEntryForm" action="${ctx }/text_book_entry" method="post">
	<input type="hidden" name="textBookTypeCode" value="${textBookEntry.textBookTypeCode }">
	<div class="g-addElement-lyBox">
		<ul class="g-addElement-lst g-addChapter-lst">
			<li class="m-addElement-item m-addElement-item1">
				<div class="center">
					<div class="m-pbMod-ipt">
						<input type="text" value="${(textBookEntry.textBookName)! }" name="textBookName" class="u-pbIpt" required>
					</div>
				</div>
			</li>
			<li class="m-addElement-btn">
				<a onclick="saveTextBookEntry()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmAddChapter">创建</a> 
				<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
			</li>
		</ul>
	</div>
</form>
<script>
	function saveTextBookEntry(){
		if(!$('#createTextBookEntryForm').validate().form()){
			return false;
		}
		var data = $.ajaxSubmit('createTextBookEntryForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			$('.mylayer-cancel').trigger('click');
			if(callbackFunction != undefined){			
				var $callback = callbackFunction;
				if (! $.isFunction($callback)){
					$callback = eval('(' + callback + ')');
				} 
				$callback(json.responseData.textBookValue, json.responseData.textBookName);
			}
		}
	}
</script>