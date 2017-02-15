<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<form id="saveResourceForm" action="${ctx!}/ncts/resource" method="post">
	<input id="relationType" type="hidden" name="resourceRelations[0].relation.type" value="section">
	<input type="hidden" name="belong" value="personal">
	<#if (resource.id)??>
		<input id="id" type="hidden" name="id" value="${(resource.id)!}">
		<input type="hidden" name="resourceRelations[0].id" value="${(resource.resourceRelations[0].id)!}">
		<script>
			$('#saveResourceForm').attr('method', 'put');
		</script>
	</#if>	
<div class="g-addElement-lyBox">
    <div class="g-addElement-tab">
        <div class="g-addElement-tabCont">
            <div class="g-addElement-tabList" style="display: block;">
                <ul class="g-addElement-lst g-addCourse-lst">
                    <li class="m-addElement-item">
                        <div class="ltxt"><em>*</em>资源名称：</div>
                        <div class="center">
                            <div class="m-pbMod-ipt">
                                <input name="title" type="text" value="${(resource.title)!}" placeholder="输入资源名称" class="u-pbIpt">
                            </div>
                        </div>
                    </li>
                    <li class="m-addElement-item">
                        <div class="ltxt"><em>*</em>所属章节：</div>
                        <div class="center">
                        <div class="m-selectbox">
                               <strong><span class="simulateSelect-text type">请选择...</span><i class="trg"></i></strong>
	                           <select id="selectResourceRelation" name="resourceRelations[0].relation.id" >
	                            	<option value="${cid!}"></option>
	                            	<@resourcesData courseId=cid>
		                            	<#list sections as section>
		                            		<#list section.childSections as childSection>
		                            			<option value="${(childSection.id)!}" <#if (childSection.id)! == (resource.resourceRelations[0].relation.id)! >selected="selected"</#if> >${(childSection.title)!}</option>
		                            		</#list>
		                            	</#list>
	                            	</@resourcesData>
	                            </select>
                            </div>
                        </div>
                    </li>
                    <li class="m-addElement-item">
                        <div class="ltxt">附件：</div>
                        <div class="center">
                            <div class="m-pbMod-udload">
		                        <div id="fileDiv" class="center">
				                    <#import "/ncts/study/common/upload_file_list.ftl" as uploadFileList />
									<@uploadFileList.uploadFileListFtl relationId="${(resource.id)!}" relationType="resources" paramName="fileInfos" btnTxt="上传文件" fileNumLimit=1 />
			                    </div>  
                            </div>
                        </div>
                    </li>
                    <li class="m-addElement-btn">
                        <a onclick="closeResource()" class="btn u-inverse-btn u-cancelLayer-btn">取消</a>
                        <a onclick="submitResource()" class="btn u-main-btn" id="confirmLayer">确定</a>
                    </li>
                </ul>            
            </div>
        </div>
    </div>   
</div>
</form>
<script>
 	$(function(){
			$(".m-selectbox #selectResourceRelation").simulateSelectBox({
				byValue : '${(resource.resourceRelations[0].relation.id)!}'
			});
			var t = $('#selectResourceRelation option[value="${(resource.resourceRelations[0].relation.id)!}"]').text();
			if(t != null && t != ''){
				$('#selectResourceRelation').parent().find('.simulateSelect-text').text($('#selectResourceRelation option[value="${(resource.resourceRelations[0].relation.id)!}"]').text());	
			}
		}
	);
	
	function submitResource(){
		if (!$('#saveResourceForm').validate().form()) {
			return false;
		}
		if ($('#saveResourceForm input[name="title"]').val().trim().length <= 0){
			alert('资源名称不能为空!');
			return false;
		}
		if($('#saveResourceForm input[name="fileInfos[0].id"]').val() == null || $('#saveResourceForm input[name="fileInfos[0].id"]').val() == ''){
			alert('上传文件不能为空!');
			return false;
		}
		if($('#selectResourceRelation').val() == '${cid!}'){
			$('#saveResourceForm #relationType').val('course');
		}
		var data = $.ajaxSubmit('saveResourceForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			alert('上传成功');
			searchResource('${cid!}','course');
			closeResource();
		}
	};
	
	function closeResource(){
		$('.mylayer-wrap').remove();
	};
</script>