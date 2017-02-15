<div class="g-replay-notice">
	<div class="m-note m-rep-notice">
		<div class="note">
			<span class="note-r">发送给：<a href="javascript:;">${(receiver.realName)!}</a> </span>
		</div>
	</div>
	<form id="saveMessageForm" action="${ctx}/message">
		<input type="hidden" name="receiver.id" value="${(receiver.id)!}">
		<input type="hidden" name="sender.id" value="${(ThreadContext.getUser().getId())!}">
		<div class="m-pbMod-ipt">
			<textarea required name="content" id="" placeholder="发送内容" class="u-textarea"></textarea>
		</div>
	</form>
	<div class="m-addElement-item">
		<div class="m-addElement-btn g-addCourse-lst2">
			<a onclick="mylayerFn.closelayer($('#saveMessageForm'))" href="javascript:void(0);" data-href="index1.html" class="btn u-inverse-btn" id="confirmLayer">取消</a>
			<a onclick="saveMessage()" href="javascript:void(0);" class="btn u-main-btn u-cancelLayer-btn">发送</a>
		</div>
	</div>

</div>
<script>
	function saveMessage(){
		if(!$('#saveMessageForm').validate().form()){
			return false;
		}
		var response = $.ajaxSubmit('saveMessageForm');
		response = $.parseJSON(response);
		if(response.responseCode == '00'){
			alert("发送成功",function(){
				mylayerFn.closelayer($('#saveMessageForm'));
			});
		}else{
			alert('发送失败',function(){
				
			});
		}
	}
	
</script>
