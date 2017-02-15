<#assign cid=CSAIdObject.getCSAIdObject().cid> 
<#assign aid=(CSAIdObject.getCSAIdObject().aid)!> 
<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
<#if inCurrentDate[0] == 'true'>
	<#assign inCurrentDate=true>
<#else>
	<#assign inCurrentDate=false>
</#if>
<@assignmentMarkDirective assignmentUserId=(assignmentMark.assignmentUser.id)!'' id=(assignmentMark.id)!''>
	<@assignmentUserDirective id=assignmentMark.assignmentUser.id>
		<#assign assignment=assignmentUser.assignmentRelation.assignment>
		<div class="g-cl-content g-work-read">
	        <div class="g-cl-boxP g-cl-resource">
	            <div class="g-studyAct-box1">
	                <div class="m-studyTask-tBtn">
	                    <#if hasTeachRole>
							<a onclick="goTeacherMark()" class="backBtn btn u-inverse-btn u-opt-btn">返回列表</a>
						<#else>
							<a onclick="goMarkList()" class="backBtn btn u-inverse-btn u-opt-btn">返回列表</a>
						</#if>
	                </div>  
	                <div class="am-title">
	                    <h2>
	                        <span class="txt">${assignment.title! }</span>
	                    </h2>
	                </div>  
	                <div class="ag-detail-txt ag-detail-txt1">
	                    <div class="cont-txt">${assignment.content! } </div>
	                </div>           
					<#if assignment.responseType == 'editor'>
						<div class="ag-main-hd">
							
						</div>
					<#else>
						<div class="ag-adjunct-cont">
							<div class="am-mod-tt">
								<h3 class="t1">附件</h3>
							</div>
							<div class="ag-adjunct-dt">
								<ul class="am-file-lst f-cb" id="activityFileList">
									<#list assignmentUser.fileInfos as file>
										<li>
											<div class="am-file-block am-file-word">
												<div class="file-view">
													<div class="${FileTypeUtils.getFileTypeClass(file.fileName, 'study') }">
														<#if FileTypeUtils.getFileTypeClass(file.fileName, 'study') == 'img'>
															<img src="${FileUtils.getFileUrl(file.url) }" >
														</#if>
													</div>
												</div>
												<b class="f-name"><span>${file.fileName }</span></b>
												<div class="f-opa">
													<a onclick="previewFile('${file.id}')" href="javascript:void(0);" >预览</a>
													<a onclick="downloadFile('${file.id}', '${file.fileName }')" href="javascript:void(0);" class="download">下载</a> 
												</div>
											</div>
										</li>
									</#list>
								</ul>
							</div>
						</div>
					</#if>
					<div class="g-studyTask-grade">
						<h4 class="all-grade">
							满分：<strong><em id="maxScore">${assignment.score!100 * (100 - (assignment.eachOtherMarkConfig.markScorePct)!0) / 100}</em>分</strong>
						</h4>
						<@evaluateSubmissionDirective assignmentId=assignment.id assignmentUserId=assignmentUser.id>
							<#assign itemScoreMap=evaluateSubmission.evaluateItemSubmissionMap!>
							<table class="m-studyGrade-table" id="taskGradeTable" cellpadding="0" cellspacing="0" border="0" width="100%">
								<thead>
									<tr>
										<th width="12%">序号</th>
										<th width="54%">评价内容</th>
										<th width="34%">得分</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td class="tl" colspan="2"><strong>您为作业打分：</strong></td>
										<td><span class="score"><em id="totalScore">${assignmentMark.score!0 }</em>分</span></td>
									</tr>
								</tfoot>
								<tbody>
									<#list evaluate.evaluateItems as evaluateItem>
										<tr class="itemTr" itemId="${evaluateItem.id }">
											<td>${evaluateItem_index + 1 }</td>
											<td class="tl">${evaluateItem.content }</td>
											<td>
												<div class="starDiv m-ev-star">
													<#list 1..5 as i>
														<#assign score=(itemScoreMap[evaluateItem.id].score)!0> 
														<span class="starBtn star <#if (score >= i) >z-crt</#if>"><em>${i * 20 }</em></span> 
													</#list>
												</div>
											</td>
										</tr>
									</#list>
								</tbody>
							</table>
							<#if hasTeachRole>
								<form id="saveEvaluateSubmissionForm" action="/${cid }/teach/unique_uid_${Session.loginer.id }/evaluate/submission/${evaluateSubmission.id}" method="put">
							<#else>
								<form id="saveEvaluateSubmissionForm" action="/${aid }/study/unique_uid_${Session.loginer.id }/evaluate/submission/${evaluateSubmission.id}" method="put">						
							</#if>
								<input type="hidden" name="evaluateRelation.id" value="${evaluateSubmission.evaluateRelation.id }">
								<input type="hidden" name="evaluateRelation.relation.id" value="${assignmentUser.id}">
							</form>
						</@evaluateSubmissionDirective>
						<#if hasTeachRole>
							<#if ('teacher' == assignment.markType) && assignmentUser.state != 'return'>
								<div class="m-addElement-btn hasborder">
									<a onclick="returnAssignmentUser('${assignmentUser.id}')" href="javascript:void(0);" class="btn u-inverse-btn">退回重做</a>
									<a onclick="saveEvaluateSubmission()"  class="btn u-main-btn">提交</a>
								</div>
							</#if>
						<#else>
							<#if (inCurrentDate)>
								<div class="m-addElement-btn hasborder">
									<a onclick="saveEvaluateSubmission()"  class="btn u-main-btn">提交</a>
								</div>
							</#if>
						</#if>
					</div>
				</div>
			</div>
		</div>
	</@assignmentUserDirective>
</@assignmentMarkDirective>
<script>
	$(function(){
		activityFile.fn.show_file_opa();
		//星星评分
	    $('#taskGradeTable .m-ev-star').evaluateStar();
	});
	
	function saveEvaluateSubmission(){
		confirm('确定要提交对该作业的打分吗?', function(){
			$('.itemTr').each(function(){
				var itemId = $(this).attr('itemId');
				var starNum = $(this).find('.starBtn.z-crt').length;
				$('#saveEvaluateSubmissionForm').append('<input type="hidden" name="evaluateItemSubmissionMap['+itemId+'].score" value="'+starNum+'">');
			});
			var data = $.ajaxSubmit('saveEvaluateSubmissionForm');
			var json = $.parseJSON(data);
			if(json.responseCode == '00'){
				alert('提交成功', function(){
					$('.backBtn').trigger('click');
				});
			}
		});
	}
	
	function goMarkList(){
		$('#studyCourseForm').attr('action', '${ctx}/${aid}/study/course/${cid}');
		$('#studyCourseForm').append('<input type="hidden" name="index" value="1">');
		$('#studyCourseForm').submit();
	}
	
	function goTeacherMark(){
		$('#listAssignmentUserForm').submit();
	}
	
	function returnAssignmentUser(assignmentUserId){
		confirm('作业退回后无法重新批阅, 只能等待学员再次提交, 确定要退回该作业吗?', function(){
			$.put('${ctx}/assignment/user/'+assignmentUserId, 'state=return', function(data){
				alert('已退回');
				goTeacherMark();
			});
		});
	}
</script>
