<div class="g-addElement-lyBox">
	<div class="g-addElement-tab">
		<div class="g-add-step">
            <ol class="m-add-step num5">
                <li class="step in">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                    	<span class="ico"><i class="u-rhombus-ico">1</i></span>
                    	<br>
                        <span class="txt">作业</span>
                    </a>
                </li>
                <li class="step <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">2</i></span>
                    	<br>
                        <span class="txt">作答设置</span>
                    </a>
                </li>
                <li class="step <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">3</i></span>
                    	<br>
                        <span class="txt">批改设置</span>
                    </a>
                </li>
                <li class="step <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">4</i></span>
                    	<br>
                        <span class="txt">评分项设置</span>
                    </a>
                </li>
                <li class="step last <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">5</i></span>
                    	<br>
                        <span class="txt">活动设置</span>
                    </a>
                </li>
            </ol>
        </div>
        <br>
		<div id="tabListDiv" class="g-addElement-tabCont">
			<div class="g-addElement-tabList" style="display: block">
				<@assignment id=(activity.entityId)!''> 
					<#if (activity.id)??>
						<form id="saveActivityForm" action="${ctx }/make/activity/${activity.id!}" method="put">
							<input type="hidden" name="assignment.id" value="${assignment.id! }"> 
							<input type="hidden" name="updateFile" value="true"> 
					<#else>
						<form id="saveActivityForm" action="${ctx }/${CSAIdObject.getCSAIdObject().scid }/make/activity" method="post">
							<input type="hidden" name="activity.relation.id" value="${CSAIdObject.getCSAIdObject().scid }"> 
							<input type="hidden" name="assignment.assignmentRelations[0].relation.id" value="${CSAIdObject.getCSAIdObject().cid }"> 
							<input type="hidden" name="isUpdateFileString" value="true"> 
					</#if> 
							<input type="hidden" name="activity.type" value="${activity.type! }">
							<ul class="g-addElement-lst g-addCourse-lst">
								<li class="m-addElement-item">
									<div class="ltxt">
										<em>*</em>作业标题：
									</div>
									<div class="center">
										<div class="m-pbMod-ipt">
											<input type="text" name="assignment.title" placeholder="输入作业标题" class="u-pbIpt required" value="${(assignment.title)!}">
										</div>
									</div>
								</li>
								<li class="m-addElement-item">
									<div class="ltxt">
										<em>*</em>作业描述：
									</div>
									<div class="center">
										<div class="m-pbMod-ipt">
											<script id="editor" type="text/plain" style="height: 200px; width: 100%"></script>
											<input id="assignmentContent" name="assignment.content" type="hidden">
										</div>
									</div>
								</li>
								<li class="m-addElement-item">
									<div class="ltxt">附件：</div>
									<div id="fileDiv" class="center">
										<#import "/ncts/make/common/upload_file_list.ftl" as uploadFileList /> 
										<@uploadFileList.uploadFileListFtl relationId="${assignment.id!}" paramName="assignment.fileInfos" />
									</div>
								</li>
								<li class="m-addElement-btn">
									<a onclick="saveAssignment()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">保存并下一步</a> 
									<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
								</li>
							</ul>
						</form>
				</@assignment>
			</div>
			<@assignmentRelation assignmentId=(activity.entityId)!'' relationId=CSAIdObject.getCSAIdObject().cid>
				<div class="g-addElement-tabList">
					<#import "edit_assignment_response_config.ftl" as earc /> 
					<@earc.editAssignmentResponseConfigFtl assignmentRelation=assignmentRelation!/>
				</div>
				<div class="g-addElement-tabList">
					<#import "edit_assignment_mark_config.ftl" as eamc /> 
					<@eamc.editAssignmentMarkConfigFtl assignmentRelation=assignmentRelation!/>
				</div>
			</@assignmentRelation>
			<div class="g-addElement-tabList">
				<#import "/ncts/make/common/edit_evaluate.ftl" as ee /> 
				<@ee.editEvaluateFtl relationId=(assignment.id)!'' type="assignment" />
			</div>
			<div class="g-addElement-tabList">
				<#import "/ncts/make/activity/edit_activity.ftl" as ea /> 
				<@ea.editActivityFtl activity=activity courseType=(courseType[0])!'' />
			</div>
		</div>
	</div>
</div>
<script>
	var ue = initProduceEditor('editor', '${(assignment.content)!""}', '${(Session.loginer.id)!""}');
	
	function saveAssignment(){
		if(!$('#saveActivityForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		if(content.length == 0){
			alert("内容不能为空");
			return false;
		}
		$('#assignmentContent').val(content);
		var data = $.ajaxSubmit('saveActivityForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			listActivity('${CSAIdObject.getCSAIdObject().scid }');
			var activity = json.responseData;
			if(activity != null){
				refreshAndNextForm(activity.id);
			}else{
				$('.m-add-step li').eq(1).trigger('click');
			}
		}
	}
</script>