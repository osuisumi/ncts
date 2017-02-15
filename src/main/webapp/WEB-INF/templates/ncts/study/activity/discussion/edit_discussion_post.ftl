<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
<#if hasTeachRole>
	<#assign role='teach'>
<#else>
	<#assign role='study'>
</#if>
<form id="updateDiscussionPostForm" action="${ctx }${cid}/${role }/discussion/post/${discussionPost.id}" method="put">
	<div class="g-addElement-lyBox">
        <div class="g-addElement-lst g-addChapter-lst">
            <li class="m-addElement-item m-addElement-item1" style="padding: 0; width: 500px; margin: 30px 0 0 50px;">
                <div class="center">
                    <div class="m-pbMod-ipt">
                    	<textarea rows="5" cols="5" name="content" class="u-pbIpt required">${discussionPost.content!}</textarea>
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
			if('${discussionPost.mainPostId}' == ''  || '${discussionPost.mainPostId}' == 'null'){
				window.location.reload();
			}else{
				listChildPost('${discussionPost.mainPostId}')
				$('.mylayer-cancel').trigger('click');
			}
		});
	}
}
</script>