<script type="text/javascript" src="/ncts/js/photo3d.js"></script>
<div class="g-addElement-lyBox">
	<div class="g-addElement-tab">
		<div class="g-add-step">
            <ol class="m-add-step num3">
                <li class="step in">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">1</i></span>
                    	<br>
                        <span class="txt">教学课件</span>
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
				<@textInfo id="${activity.entityId! }">
					<#if (activity.id)??>
						<form id="saveActivityForm" action="${ctx }/make/activity/${activity.id!}" method="put">
							<input type="hidden" name="textInfo.id" value="${textInfo.id! }"> 
					<#else>
						<form id="saveActivityForm" action="${ctx }/${CSAIdObject.getCSAIdObject().scid }/make/activity" method="post">
							<input type="hidden" name="activity.relation.id" value="${CSAIdObject.getCSAIdObject().scid }"> 
							<input type="hidden" name="textInfo.textInfoRelations[0].relation.id" value="${CSAIdObject.getCSAIdObject().cid }"> 
					</#if> 
							<input type="hidden" name="activity.type" value="${activity.type! }">
							<ul class="g-addElement-lst g-addCourse-lst">
								<li class="m-addElement-item">
									<div class="ltxt">
										<em>*</em>标题：
									</div>
									<div class="center">
										<div class="m-pbMod-ipt">
											<input type="text" name="textInfo.title" placeholder="输入标题" class="u-pbIpt required" value="${(textInfo.title)!}">
										</div> 
									</div>
								</li>
								<li class="m-addElement-item">
						            <div class="ltxt">
						               	类型：
						            </div>
						            <div class="center m-revise-way">
						                <div class="m-check-mod">
						                	<label class="m-radio-tick">
						                        <strong>
						                            <i class="ico"></i>
						                            <input type="radio" name="textInfo.type" checked="checked" value="editor">
						                        </strong>
						                        <span>编辑器</span>
						                    </label>
						                    <label class="m-radio-tick">
						                        <strong>
						                            <i class="ico"></i>
						                            <input type="radio" name="textInfo.type" value="link">
						                        </strong>
						                        <span>链接</span>
						                    </label>
						                    <label class="m-radio-tick">
						                        <strong>
						                            <i class="ico"></i>
						                            <input type="radio" name="textInfo.type" value="file">
						                        </strong>
						                        <span>文件</span>
						                    </label>
						                    <label class="m-radio-tick">
						                        <strong>
						                            <i class="ico"></i>
						                            <input type="radio" name="textInfo.type" value="photo">
						                        </strong>
						                        <span>三维展示</span>
						                    </label>
						                </div>
						            </div>
						        </li>
					        	<div id="editor_div" class="typeDiv">
						        	<li class="m-addElement-item">
										<div class="ltxt">
											<em>*</em>内容：
										</div>
										<div class="center">
											<div class="m-pbMod-ipt">
												<script id="editor" type="text/plain" style="height: 300px; width: 100%"></script>
												<input id="textInfoContent" name="textInfo.content" type="hidden">
											</div>
										</div>
									</li>
						        </div>
						        <div id="link_div" class="typeDiv" style="display: none;">
						        	<li class="m-addElement-item">
										<div class="ltxt">
											<em>*</em>链接：
										</div>
										<div class="center">
											<div class="m-pbMod-ipt">
												<input type="text" name="textInfo.content" placeholder="输入可访问的链接" class="u-pbIpt required" 
													<#if 'link' == (textInfo.type)!''>value="${(textInfo.content)!}"</#if>>
											</div> 
										</div>
									</li>
						        </div>
						        <div class="typeDiv" style="display: none;">
						        	<li class="m-addElement-item">
										<div class="ltxt">
											<em>*</em>文件：
										</div>
										<div class="center">
											<div class="m-pbMod-ipt">
												<div id="fileDiv" class="center">
													<#import "/ncts/make/common/upload_file_list.ftl" as uploadFileList /> 
													<@uploadFileList.uploadFileListFtl relationId="${textInfo.id!}" relationType="textInfo" paramName="textInfo.fileInfos" divId="fileDiv" btnTxt="上传文件" fileNumLimit=1 fileTypeLimit="doc,docx,ppt,pptx,pdf"/>
												</div>
											</div> 
										</div>
									</li>
						        </div>
						        <div class="typeDiv" style="display: none;">
						        	<li class="m-addElement-item">
					                    <div class="ltxt">上传作品：</div>
					                    <ul id="photoUl" class="center ag-pbac-lst">
								        	<#if '' != (textInfo.id)!''>
								        		<@textInfoFilesDirective textInfoId=(textInfo.id)!'' orders='CREATE_TIME'>
									        		<#list textInfoFiles as textInfoFile>
								                        <li class="m-add-opus-ct am-pb-mod-vp">
								                        	<input type="hidden" name="textInfo.textInfoFiles[${textInfoFile_index }].id" value="${textInfoFile.id }">
								                            <div class="m-add-opusTl">作品<span class="opus-num">${textInfoFile_index }</span></div>
								                            <div class="m-addElement-item">
								                                <div class="ltxt">作品名称：</div>
								                                <div class="c-center">
								                                    <div class="m-pbMod-ipt">
								                                        <input type="text" name="textInfo.textInfoFiles[${textInfoFile_index }].name" placeholder="输入作品名称" class="textInfoFileTitle u-pbIpt required" value="${(textInfoFile.name)!}">
								                                    </div>
								                                </div>
								                            </div>     
								                            <div class="m-addElement-item last">
								                                <div class="ltxt">上传作品：</div>
								                                <div id="photo_div_${textInfoFile_index }" class="c-center photo_div">
								                                    <div class="m-opus-cont fileLi success" fileId="${textInfoFile.fileInfo.id }">
																	    <i class="ub-sfile-ico zip"></i>
																	    <div class="name">
																	        <a href="javascript:void(0);" class="name fileName">${textInfoFile.fileInfo.fileName }</a>
																	    </div>
																	    <a href="javascript:void(0);" class="deleteBtn dlt"><i class="u-delete-ico2"></i>删除</a>                                   
																	</div>
								                                </div>
								                            </div>   
								                            <a href="javascript:void(0);" class="m-add-opus-del"><i class="u-delete-ico"></i></a>
								                        </li>
									        		</#list>
												</@textInfoFilesDirective>
											<#else>
												<li class="m-add-opus-ct am-pb-mod-vp">
						                            <div class="m-add-opusTl">作品<span class="opus-num"></span></div>
						                            <div class="m-addElement-item">
						                                <div class="ltxt">作品名称：</div>
						                                <div class="c-center">
						                                    <div class="m-pbMod-ipt">
						                                        <input type="text" name="textInfo.textInfoFiles[0].name" placeholder="输入活动名称" class="textInfoFileTitle u-pbIpt required" >
						                                    </div>
						                                </div>
						                            </div>     
						                            <div class="m-addElement-item last">
						                                <div class="ltxt">上传作品：</div>
						                                <div id="photo_div_0" class="c-center" paramName="textInfo.textInfoFiles[0].fileInfo">
						                                    <div class="m-pbMod-udload">
						                                        <a href="javascript:void(0);" class="picker btn u-inverse-btn u-opt-btn"><i class="u-upload-ico"></i>上传压缩包</a>
						                                    </div>
						                                    <p class="m-addElement-ex">文件格式必须为zip，rar</p>
						                                </div>
						                            </div>   
						                            <a href="javascript:void(0);" class="m-add-opus-del"><i class="u-delete-ico"></i></a>
						                        </li>
							        		</#if>
							        		<li class="m-add-opus-ct m-add-opus-btn">
					                             <a href="javascript:void(0);" class="au-nbtn au-add-vp"><span class="add"></span>添加作品</a>                            
					                        </li>        
							        	</ul>
							        </li>
						        </div>
								<li class="m-addElement-btn">
									<a onclick="saveHtml()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">下一步</a>
									<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
								</li>
							</ul>
						</form>
				</@textInfo>
			</div>
			<div class="g-addElement-tabList">
				<#import "/ncts/make/activity/text/edit_html_activity_attribute.ftl" as eva /> 
				<@eva.editHtmlActivityAttributeFtl activity=activity />
			</div>
			<div class="g-addElement-tabList">
				<#import "/ncts/make/activity/edit_activity.ftl" as ea /> 
				<@ea.editActivityFtl activity=activity courseType=(courseType[0])!'' />
			</div>
		</div>
	</div>
</div>
<div class="m-opus-cont fileLi" id="photoLiTemplet" style="display: none;">
    <i class="ub-sfile-ico zip"></i>
    <div class="name">
        <a href="javascript:void(0);" class="name fileName"></a>
        <div class="fileBar m-pbar">
            <div class="bar">
            	<div class="barLength yet" style="width: 100%;"><span class="barNum"></span></div>
            </div>
            <span class="barTxt bar-txt">上传中</span>
        </div>
    </div>
    <a href="javascript:void(0);" class="deleteBtn dlt"><i class="u-delete-ico2"></i>删除</a>                                   
</div>
<script>
	var content = '';
	if('${(textInfo.type)!}' == 'editor'){
		content = '${(textInfo.content)!}';
	}
	var ue = initProduceEditor('editor', content, '${(Session.loginer.id)!}');

	$(function(){
		$('#saveActivityForm input[name="textInfo.type"]').click(function(){
			$('.typeDiv').hide();
			var index = $('#saveActivityForm input[name="textInfo.type"]').index(this);
			$('.typeDiv').eq(index).show();
			if($(this).val() == 'file'){
				initUploader('fileDiv');
			}else if($(this).val() == 'photo'){
				photo3dJs.fn.init();
			}
		});
		$('#saveActivityForm input[name="textInfo.type"][value="${(textInfo.type)!}"]').prop('checked', true);
		$('#saveActivityForm input[name="textInfo.type"][value="${(textInfo.type)!}"]').trigger('click');
	});
	
	function saveHtml(){
		if(!$('#saveActivityForm').validate().form()){
			return false;
		}
		
		var type = $('#saveActivityForm').find('input[name="textInfo.type"]:checked').val();
		if(type == 'editor'){
			var content = ue.getContent();
			if(content.length == 0){
				alert("内容不能为空");
				return false;
			}
			$('#textInfoContent').val(content);
		}else if(type == 'photo'){
			var txt_index = $('#photoUl :text').length;
			var file_index = $('#photoUl .fileParam').length;
			if(file_index / txt_index != 3){
				alert('请先上传压缩包');
				return false;
			}
		}else if(type == 'file'){
			var file_num = $('#fileDiv .fileParam').length;
			if(file_num <= 0){
				alert('请先上传文件');
				return false;
			}
		}
		$('#saveActivityForm input[name="textInfo.content"]').not('#'+type+'_div input[name="textInfo.content"]').remove();
		
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
		}else{
			if(json.responseMsg == 'file made by wps is not supported'){
				alert('不支持WPS创建的文件. 请用OFFICE创建, 或者用OFFICE打开文件后重新保存', null, 5000);
			}
		}
	}
</script>