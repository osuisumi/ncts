<#macro topFtl>
	<div id="g-hd">
        <div class="g-auto">
            <h1 class="m-logo">
                <a href="javascript:void(0);">昊誉信息</a>
            </h1>
        </div>
    </div>
<script>
function loadMore(){
	$('#content').load('${ctx}/message/list/more?orders=CREATE_TIME.DESC');
}

$(function(){
	$('#messageList').load("${ctx}/message/list?orders=CREATE_TIME.DESC");
})
</script>
</#macro>