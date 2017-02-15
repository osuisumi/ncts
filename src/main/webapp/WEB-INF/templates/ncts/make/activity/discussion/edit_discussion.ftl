<div class="g-addElement-lyBox">
	<div class="g-addElement-tab">
		<div class="g-add-step">
            <ol class="m-add-step num3">
                <li class="step in">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">1</i></span>
                    	<br>
                        <span class="txt">主题讨论</span>
                    </a>
                </li>
                <li class="step <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">2</i></span>
                    	<br>
                        <span class="txt">完成指标</span>
                    </a>
                </li>
                <li class="step last <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">3</i></span>
                    	<br>
                        <span class="txt">活动设置</span>
                    </a>
                </li>
            </ol>
        </div>
        <br>
		<div id="tabListDiv" class="g-addElement-tabCont">
			<div class="g-addElement-tabList" style="display: block">
				<@discussion id="${activity.entityId! }">
					<#if (activity.id)??>
						<form id="saveActivityForm" action="${ctx }/make/activity/${activity.id!}" method="put">
							<input type="hidden" name="discussion.id" value="${discussion.id! }"> 
					<#else>
						<form id="saveActivityForm" action="${ctx }/${CSAIdObject.getCSAIdObject().scid }/make/activity" method="post">
							<input type="hidden" name="activity.relation.id" value="${CSAIdObject.getCSAIdObject().scid }"> 
							<input type="hidden" name="discussion.discussionRelations[0].relation.id" value="${CSAIdObject.getCSAIdObject().cid }"> 
					</#if> 
							<input type="hidden" name="activity.type" value="${activity.type! }">
							<ul class="g-addElement-lst g-addCourse-lst">
								<li class="m-addElement-item">
									<div class="ltxt">
										<em>*</em>研讨主题：
									</div>
									<div class="center">
										<div class="m-pbMod-ipt">
											<input type="text" name="discussion.title" placeholder="输入研讨主题" class="u-pbIpt required" value="${(discussion.title)!}">
										</div>
									</div>
								</li>
								<li class="m-addElement-item">
									<div class="ltxt">
										<em>*</em>主题描述：
									</div>
									<div class="center">
										<div class="m-pbMod-ipt">
											<script id="editor" type="text/plain" style="height: 200px; width: 100%"></script>
											<input id="discussionContent" name="discussion.content" type="hidden">
										</div>
									</div>
								</li>
								<li class="m-addElement-item">
									<div class="ltxt">附件：</div>
									<div id="fileDiv" class="center">
										<#import "/ncts/make/common/upload_file_list.ftl" as uploadFileList />
										<@uploadFileList.uploadFileListFtl relationId="${discussion.id!}" paramName="discussion.fileInfos" />
									</div>
								</li>
								<li class="m-addElement-btn">
									<a onclick="saveDiscussion()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">保存并下一步</a>
									<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a> 
								</li>
							</ul>
						</form>
				</@discussion>
			</div>
			<div class="g-addElement-tabList">
				<#import "/ncts/make/activity/discussion/edit_discussion_activity_attribute.ftl" as edm /> 
				<@edm.editDiscussionActivityAttributeFtl activity=activity />
			</div>
			<div class="g-addElement-tabList">
				<#import "/ncts/make/activity/edit_activity.ftl" as ea /> 
				<@ea.editActivityFtl activity=activity courseType=(courseType[0])!'' />
			</div>
		</div>
	</div>
</div>
<script>
	var ue = initProduceEditor('editor', '${(discussion.content)!}', '${(Session.loginer.id)!}');
	
	function saveDiscussion(){
		if(!$('#saveActivityForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		if(content.length == 0){
			alert("内容不能为空");
			return false;
		}
		$('#discussionContent').val(content);
		var data = $.ajaxSubmit('saveActivityForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			listActivity('${CSAIdObject.getCSAIdObject().scid }');
			var activity = json.responseData;
			if (activity != null) {
				refreshAndNextForm(activity.id, '${(courseType[0])!""}');
			}else{
				$('.m-add-step li').eq(1).trigger('click');
			}
		}
	}
</script>