<#macro topFtl>
	<div class="g-hd">
        <div class="g-auto">
            <h1 class="m-logo">
                <a href="###">昊誉信息</a>
            </h1>
            <ul class="m-tp-opt">
	            <li class="user">
	                <a href="javascript:void(0);" class="show">
	                    <#import "/common/image.ftl" as image/>
						<@image.imageFtl url="${Session.loginer.attributes.avatar! }" default="${app_path}/images/defaultAvatarImg.png" />
	                    <span>${Session.loginer.realName!}</span><i class="u-trg-ico"></i>
	                </a>
	                <div class="lst">
	               		<i class="trg"></i>
	                    <#--<a onclick="goEditUser('${(ThreadContext.getUser().id)!}')" href="javascript:void(0);">用户资料</a>-->
	                    <a onclick="goChangePassword()" href="javascript:void(0);"><i class="u-user2-ico"></i>修改密码</a>
	                    <a href="${ctx}/logout" class="last">退出登录</a>
	                </div>
	            </li>
 				<li class="g-notice">
					<a id="messageBtn" onclick="loadMore()" href="javascript:void(0);" class="u-bell"><i class="u-bell-ico"></i>消息</a>
					<div class="m-mouse-news">
						<i class="arrow-icon"></i>
						<ul id="messageList" class="m-mouse-txt">
							
						</ul>
						<div class="m-h-more">
							<a onclick="loadMore()" href="javascript:void(0);" class="more"><i class="u-h-see"></i>查看更多</a>
						</div>
					</div>
				</li>
	        </ul>
        </div>
        <div class="g-hd-border"></div>
    </div>
<script>
function loadMore(){
	$('#content').load('${ctx}/message/list/more?orders=CREATE_TIME.DESC');
}

$(function(){
	$('#messageBtn').hover(function(){
		var li = $('#messageList li');
		if(li.size() <= 0){
			$('#messageList').load("${ctx}/message/list?orders=CREATE_TIME.DESC");
		}
	},function(){});
})
</script>
</#macro>