<@messagesDirective message=message pageBounds=pageBounds>
	<#if messages??>
		<#list messages as message>
			<#if message.type == "user_message">
				<li class="m-note" messageId = "${(message.id)!}">
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
					<div onclick="replyMessage(this)" class="replay">
						<span><i class="u-note-replay"></i>回复</span>
					</div>
				</li>
			<#else>
				<li class="m-Mo-replay">
					<div class="notice">
						<span class="notice-l">系统通知</span>
						<span class="notice-r">${TimeUtils.formatDate(message.createTime,'yyyy/MM/dd')}</span>
					</div>
					<p>
						${(message.content)!}
					</p>
				</li>
			</#if>
		</#list>
	</#if>
</@messagesDirective>

<script>
	function replyMessage(a){
    	var messageId = $(a).closest('li').attr('messageId');
        mylayerFn.open({
            type: 2,
            title: '回复小纸条',
            bgcolor: '#fff',
            fix: false,
            area: [510, 400],
            content: '${ctx}/message/create/reply?messageId='+messageId
        });
	}
</script>