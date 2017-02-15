<#macro editAssignmentResponseConfigFtl assignmentRelation>
	<#assign assignment=(assignmentRelation.assignment)! >
	<form id="saveAssignmentResponseConfigForm" action="${ctx }/make/assignment/${(assignment.id)!}" method="put">
		<input type="hidden" name="assignmentRelations[0].id" value="${(assignmentRelation.id)! }">
		<input type="hidden" name="isUpdateFile" value=false>
		<ul class="g-addElement-lst g-addCourse-lst">
			<li class="m-addElement-item">
				<div class="ltxt">
					作答时间：
				</div>
				<div class="center">
					<div class="m-slt-row">
						<div class="block">
							<div class="m-pbMod-ipt date">
								<input id="startTimeParam" name="assignmentRelations[0].responseStartTime" type="text" value="${(assignmentRelation.responseTime.startTime?string(" yyyy-MM-dd"))!}" class="u-pbIpt" onfocus="WdatePicker({minDate:'${.now?date}',dateFmt:'yyyy-MM-dd'})">
							</div>
						</div>
						<div class="space">至</div>
						<div class="block">
							<div class="m-pbMod-ipt date">
								<input name="assignmentRelations[0].responseEndTime" type="text" value="${(assignmentRelation.responseTime.endTime?string(" yyyy-MM-dd"))!}" class="u-pbIpt {gtAndEqStartTime:'startTimeParam'}" onclick="WdatePicker({minDate:'${.now?date}',dateFmt:'yyyy-MM-dd'})">
							</div>
						</div>
					</div>
				</div>
			</li>
			<li class="m-addElement-item">
	            <div class="ltxt">
	               	作答方式：
	            </div>
	            <div class="center">
	                <div class="m-check-mod">
	                    <!-- <label class="m-radio-tick">
	                        <strong>
	                            <i class="ico"></i>
	                            <input type="radio" name="responseType" value="editor">
	                        </strong>
	                        <span>编辑框作答</span>
	                    </label> -->
	                    <label class="m-radio-tick">
	                        <strong>
	                            <i class="ico"></i>
	                            <input type="radio" name="responseType" value="upload" checked="checked" >
	                        </strong>
	                        <span>附件上传</span>
	                    </label>
	                </div>
	            </div>
	            <script>
	            	$(function(){
	            		$('#saveAssignmentResponseConfigForm input[name="responseType"]').click(function(){
	            			$('.responseTypeDiv').hide();
	            			$('#'+$(this).val()+'Div').show();
	            		});
	            		$('#saveAssignmentResponseConfigForm input[name="responseType"][value="${(assignment.responseType)!}"]').trigger('click');
	            	});
	            </script>
	        </li>
	        <!-- <div id="editorDiv" class="responseTypeDiv">
	        	<li class="m-addElement-item">
		            <div class="ltxt">
		               	是否允许上传图片：
		            </div>
		            <div class="center">
		                <div class="m-check-mod">
		                    <label class="m-radio-tick">
		                        <strong>
		                            <i class="ico"></i>
		                            <input type="radio" name="editorResponseConfig.allowImage" checked="checked" value="Y">
		                        </strong>
		                        <span>是</span>
		                    </label>
		                    <label class="m-radio-tick">
		                        <strong>
		                            <i class="ico"></i>
		                            <input type="radio" name="editorResponseConfig.allowImage" value="N">
		                        </strong>
		                        <span>否</span>
		                    </label>
		                </div>
		            </div>
		            <script>
		            	$(function(){
		            		$('#saveAssignmentResponseConfigForm input[name="editorResponseConfig.allowImage"][value="${(assignment.editorResponseConfig.allowImage)!}"]').prop('checked', true);
		            	});
		            </script>
		        </li>
		        <li class="m-addElement-item">
		            <div class="ltxt">
		               	是否允许上传视频：
		            </div>
		            <div class="center">
		                <div class="m-check-mod">
		                    <label class="m-radio-tick">
		                        <strong>
		                            <i class="ico"></i>
		                            <input type="radio" name="editorResponseConfig.allowVideo" checked="checked" value="Y">
		                        </strong>
		                        <span>是</span>
		                    </label>
		                    <label class="m-radio-tick">
		                        <strong>
		                            <i class="ico"></i>
		                            <input type="radio" name="editorResponseConfig.allowVideo" value="N">
		                        </strong>
		                        <span>否</span>
		                    </label>
		                </div>
		            </div>
		            <script>
		            	$(function(){
		            		$('#saveAssignmentResponseConfigForm input[name="editorResponseConfig.allowVideo"][value="${(assignment.editorResponseConfig.allowVideo)!}"]').prop('checked', true);
		            	});
		            </script>
		        </li>
		        <li class="m-addElement-item">
					<div class="ltxt">
						字数下限：
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="editorResponseConfig.minWords" class="u-pbIpt number" value="${(assignment.editorResponseConfig.minWords)!}">
						</div>
					</div>
				</li>
				<li class="m-addElement-item">
					<div class="ltxt">
						字数上限：
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="editorResponseConfig.maxWords" class="u-pbIpt number" value="${(assignment.editorResponseConfig.maxWords)!}">
						</div>
					</div>
				</li>
	        </div> -->
	        <div id="uploadDiv" class="responseTypeDiv" >
	        	<li class="m-addElement-item">
		            <div class="ltxt">
		               	允许的文件格式：
		            </div>
		            <#list DictionaryUtils.getEntryList('FILE_TYPE') as dictEntry>
		            	<label class="m-checkbox-tick">
					    	<strong class="on">
					        	<i class="ico"></i>
				            	<#if !(assignment.uploadResponseConfig.fileTypes)?? || (assignment.uploadResponseConfig.fileTypes)!?contains(dictEntry.dictValue)>
									<input type="checkbox" name="uploadResponseConfig.fileTypes" value="${dictEntry.dictValue }" checked="checked">
								<#else>
									<input type="checkbox" name="uploadResponseConfig.fileTypes" value="${dictEntry.dictValue }">
								</#if>
	                           </strong>
	                           <span style="margin-right: 10px;">${dictEntry.dictName }</span>
	                   	</label>
					</#list>
		        </li>
		        <li class="m-addElement-item">
					<div class="ltxt">
						文件大小限制(MB)：
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="uploadResponseConfig.fileSize" class="u-pbIpt number" value="${(assignment.uploadResponseConfig.fileSize)!}">
						</div>
					</div>
				</li>
	        </div>
			<li class="m-addElement-btn">
				<a onclick="saveAssignmentResponseConfig(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmLayer">保存并下一步</a> 
				<a onclick="prevForm(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">上一步</a> 
				<a class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
			</li>
		</ul>
	</form>
	<script>
		function saveAssignmentResponseConfig(obj){
			if(!$('#saveAssignmentResponseConfigForm').validate().form()){
				return false;
			}
			var data = $.ajaxSubmit('saveAssignmentResponseConfigForm');
			var json = $.parseJSON(data);
			if(json.responseCode == '00'){
				nextForm(obj);
			}
		}
	</script>
</#macro>