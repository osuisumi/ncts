<@messagesDirective message=message pageBounds=pageBounds>
	<Br>
	<div id="courseLearning" class="g-innerAuto">
			<div class="m-notice-List" style="background-color: #fff;">
	       		<div class="g-crm c1">
	       			<div class="left">
	       				<span class="txt">您当前的位置： </span>
		                <a href="/" href="###">首页</a>
		                <span class="trg">&gt;</span>
		                <em>消息</em>
	       			</div>
	                <div class="right">
                        <a onclick="window.location.reload();">&lt;返回上一步</a>
                    </div>
	            </div>
				<ul class="m-mouse-txt m-click-txt">
					<#if (messages?size > 0)>
						<#list messages as message>
							<#if message.type == 'user_message'>
								<li class="m-note" messageId="${message.id}">
									<div class="note">
										<span class="note-l">小纸条</span>
										<span class="note-c">${TimeUtils.formatDate(message.createTime,'yyyy/MM/dd')}</span>
										<span class="note-r">来自：<a href="javascript:;">${(message.sender.realName)!}</a> </span>
										<div onclick="replyMessage(this)" class="replay"><span><i  class="u-note-replay"></i>回复</span></div>
									</div>
									<div class="p-width">
										<p>
											${(message.content)!}
										</p>
									</div>
									<span class="u-showing"><i>+</i>展开</span>
									<span class="u-up"><i>-</i>收起</span>    
								</li>
							<#else>
								<li messageId="${message.id}">
									<div class="notice">
										<span class="notice-l">系统通知</span>
										<span class="notice-r">${TimeUtils.formatDate(message.createTime,'yyyy/MM/dd')}</span>
									</div>
									<div class="p-width">
										<p>
											${(message.content)!}
										</p>
									</div>
									<span class="u-showing"><i>+</i>展开</span>
									<span class="u-up"><i>-</i>收起</span>
								</li>
							</#if>
						</#list>
					<#else>
						<div class="g-no-notice-Con admin">
	                        <p class="txt">暂时没有消息！</p>
	                    </div>
					</#if>
				</ul>
				<form id="moreMessageForm" action="${ctx}/message/list/more">
					<input type="hidden" name="limit" value="${limit!}">
					<input type="hidden" name="orders" value="${orders!}">
					<#if paginator??>
						<#import "/common/pagination-ajax.ftl" as p/>
						<@p.paginationAjaxFtl formId="moreMessageForm" divId="moreMessagePage" paginator=paginator refreshDivId="content"/>
					</#if>
				</form>
				<div id="moreMessagePage" class="m-laypage"></div>
			</div>
		</div>
	</div>
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

	$(function(){
	    head_noticeSandH(); //消息列表的展开和关闭 
	    
	    $('.g-cl-menu').hide();
	});
	
    function head_noticeSandH(){
        $(".m-click-txt li").each(function(){
            var notice_PH = $(this).find('p').height();
            // alert(notice_PH)
            if(notice_PH>31){
                $(this).find('p').addClass('Hidd').height(30);

            }        
            var pLen = $(this).find(".Hidd").length
            // alert(pLen)
            if(pLen>0){
                $(this).children('.u-showing').css({"display":"block"});
            }        
        });

        $(".m-click-txt .u-showing").click(function(event) {
            $(this).siblings('.p-width').children('.Hidd').height("");
            $(this).parents("li").addClass('Pback');
            $(this).siblings('.u-up').css({"display":"block"});
            $(this).css({"display":"none"});
        });

        $(".m-click-txt .u-up").click(function(event) {
            $(this).siblings('.p-width').children('.Hidd').height(30).removeClass('Pback');
            $(this).parents("li").removeClass('Pback');
            $(this).siblings('.u-showing').css({"display":"block"});
            $(this).css({"display":"none"});
        });

    }
	
</script>