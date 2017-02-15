<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
<#if hasTeachRole>
	<#assign role='teach'>
<#else>
	<#assign role='study'>
</#if>
<form id="updateDiscussionPostForm" action="${ctx}/${cid!}/${role }/course/discussion/post/${discussionPost.id}" method="put">
	<div class="g-addElement-lyBox">
        <div class="g-addElement-lst g-addChapter-lst">
            <li class="m-addElement-item m-addElement-item1">
                <div class="center">
                    <div class="m-pbMod-ipt">
                    	<textarea rows="" cols="" name="content" class="u-pbIpt required">${discussionPost.content!}</textarea>
                    </div>
                </div>
            </li>
            <li class="m-addElement-btn">
            	<a onclick="updateDiscussionPost()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmAddChapter">编辑</a>
                <a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
            </li>
        </div>
    </div>
</form>
<script>
function updateDiscussionPost(){
	var data = $.ajaxSubmit('updateDiscussionPostForm');
	var json = $.parseJSON(data);
	if(json.responseCode == '00'){
		alert('编辑成功', function(){
			if('${(discussionPost.mainPostId)!""}' == ''){
				if($('#micContentDiv').length == 0){
					window.location.reload();
				}else{
					$.ajaxQuery('viewDiscussionForm', 'micContentDiv');
					$('.mylayer-cancel').trigger('click');
				}
			}else{
				loadChildPost('${(discussionPost.mainPostId)!}')
				$('.mylayer-cancel').trigger('click');
			}
		});
	}
}
</script>