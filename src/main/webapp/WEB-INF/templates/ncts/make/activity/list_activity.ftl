<#assign relationId=activity.relation.id>
<@activitiesDirective relationId=relationId>
	<#if (activities?size>0)>
		<ul class="m-sectionActive-lst">
			<#list activities as activity>
	    		<#if activity.type = 'discussion'>
			        <li class="item d" aid="${activity.id}">
				<#elseif activity.type = 'video'>
					<li class="item v" aid="${activity.id}">
				<#elseif activity.type = 'html'>
					<li class="item h" aid="${activity.id}">
				<#elseif activity.type = 'assignment'>
					<li class="item w" aid="${activity.id}">
				<#elseif activity.type = 'survey'>
					<li class="item s" aid="${activity.id}">
				<#elseif activity.type = 'test'>
					<li class="item t" aid="${activity.id}">
				<#else>
					<li class="item "  aid="${activity.id}">
				</#if>    
						<i class="t-icon"></i>
					    <a href="javascript:void(0);" class="a-tt">
				    		${activity.title}
					    </a>
					    <div class="optRow">
					        <a onclick="editActivity('${activity.id}', '${activity.type}')" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
					        <a onclick="deleteActivity('${activity.id}')" href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
					    </div>
					</li>                                        
			</#list>
		</ul>
	<#else>
        <div class="g-noContent small">
            <p>还未添加活动</p>
        </div>
	</#if>
</@activitiesDirective>
<script>
$(function(){
	//章节活动拖拽排序
	$(".m-sectionActive-lst").sortable({
        containment: 'body',
        placeholder: "ui-state-highlight",
        stop: function(){
        	var data = '';
        	$('.m-sectionActive-lst li').each(function(i){
        		var sortNo = $('.m-sectionActive-lst li').index($(this)) + 1;
        		data += 'activities['+i+'].id='+$(this).attr('aid')+'&activities['+i+'].sortNo='+sortNo+'&';
        	});
        	$.put('${ctx}/${relationId}/make/activity/updateBatch', data);
        }
    }).disableSelection();
});

function deleteActivity(id){
	confirm('确定要删除此活动?', function(){
		$.ajaxDelete('${ctx}/make/activity/'+id, '', function(data){
			if(data.responseCode == '00'){
				alert('删除成功', function(){
					listActivity('${relationId}');
				});
			}	
		});
	});
}

function editActivity(id, type){
	var title = '';
	if(type == 'discussion'){
		title = '编辑主题讨论';
	}else if(type == 'video'){
		title = '编辑视频';
	}else if(type == 'assignment'){
		title = '编辑作业';
	}else if(type == 'html'){
		title = '编辑教学课件';
	}else if(type == 'survey'){
		title = '编辑调查问卷';
	}else if(type == 'test'){
		title = '编辑测试';
	}
	mylayerFn.open({
		id:'editActivityDiv',
        type: 2,
        title: title,
        fix: false,
        area: [870, $(window).height()*99/100],
        content: '${ctx}/make/activity/'+id+'/edit?courseType='+$('#courseType').val(),
        shadeClose: false
    });
}
</script>
