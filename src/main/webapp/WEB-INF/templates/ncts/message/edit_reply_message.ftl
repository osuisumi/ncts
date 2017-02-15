<@messageDirective id=messageId>
<div class="g-replay-notice">
	<div class="m-note m-rep-notice">
		<div class="note">
			<span class="note-l">小纸条</span>
			<span class="note-c">${TimeUtils.formatDate(message.createTime,'yyyy/MM/dd')}</span>
			<span class="note-r">来自：<a href="javascript:;">${(message.sender.realName)!}</a> </span>
		</div>
		<div class="p-width">
			<p>
				${(message.content)!}
			</p>
		</div>
	</div>
	<form id="saveMessageReplyForm" action="${ctx}/message">
		<input type="hidden" name="sender.id" value="${(ThreadContext.getUser().getId())!}">
		<input type="hidden" name="receiver.id" value="${(message.sender.id)!}">
		<input type="hidden" name="title" value="回复">
		<div class="m-pbMod-ipt">
			<textarea name="content" required id="" placeholder="回复内容" class="u-textarea"></textarea>
		</div>
	</form>
	<div class="m-addElement-item">
		<div class="m-addElement-btn g-addCourse-lst2">
			<a onclick="mylayerFn.closelayer($('#saveMessageReplyForm'));" href="javascript:void(0);" data-href="index1.html" class="btn u-inverse-btn" id="confirmLayer">取消</a>
			<a onclick="reply()" href="javascript:void(0);" class="btn u-main-btn u-cancelLayer-btn">回复</a>
		</div>
	</div>
</div>
</@messageDirective>
<script>
	function reply(){
		if(!$('#saveMessageReplyForm').validate().form()){
			return false;
		}
		var response = $.ajaxSubmit('saveMessageReplyForm');
		response = $.parseJSON(response);
		if(response.responseCode == '00'){
			alert("发送成功",function(){
				mylayerFn.closelayer($('#saveMessageReplyForm'));
			});
		}else{
			alert('发送失败',function(){
				
			});
		}
		
	}
</script>