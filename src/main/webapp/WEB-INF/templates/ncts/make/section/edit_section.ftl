<form id="updateSectionForm" action="${ctx }/${CSAIdObject.getCSAIdObject().cid!}/make/section" method="post">
	<#if (section.id)! != ''>
		<script>
			$('#updateSectionForm').attr('method','put').attr('action', '${ctx }/make/section/${section.id }');
		</script>
		<#else>
		<input type="hidden" name="course.id" value="${CSAIdObject.getCSAIdObject().cid}">
	</#if> 
	<div class="g-addElement-lyBox">
        <div class="g-addElement-lst g-addChapter-lst">
            <li class="m-addElement-item m-addElement-item1">
                <div class="center">
                    <div class="m-pbMod-ipt">
                        <input type="text" name="title" value="${section.title!}" placeholder="名称" class="u-pbIpt required">
                    </div>
                    <p class="m-addElement-ex" id="CourseTypeExplain">新章节的名称，如：课程概述，尽量用描述性名称，不要用第一章这类名称</p>
                </div>
            </li>
            <li class="m-addElement-btn">
            	<a onclick="saveSection()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmAddChapter">提交</a>
                <a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
            </li>
        </div>
    </div>
</form>
<script>
function saveSection(){
	if(!$('#updateSectionForm').validate().form()){
		return false;
	}
	var data = $.ajaxSubmit('updateSectionForm');
	var json = $.parseJSON(data);
	if(json.responseCode == '00'){
		parent.window.reloadParent();
	}
}
</script>