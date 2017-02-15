<#macro editAssignmentMarkConfigFtl assignmentRelation >
	<#assign assignment=(assignmentRelation.assignment)! >
	<form id="saveAssignmentMarkConfigForm" action="${ctx }/make/assignment/${(assignment.id)!}" method="put">
		<input type="hidden" name="assignmentRelations[0].id" value="${(assignmentRelation.id)! }">
		<input type="hidden" name="isUpdateFile" value=false> 
		<ul class="g-addElement-lst g-addCourse-lst">
			<li class="m-addElement-item">
				<div class="ltxt">
					批阅时间：
				</div>
				<div class="center">
					<div class="m-slt-row">
						<div class="block">
							<div class="m-pbMod-ipt date">
								<input id="startTimeParam" name="assignmentRelations[0].markStartTime" type="text" value="${(assignmentRelation.markTime.startTime?string(" yyyy-MM-dd"))!}" class="u-pbIpt" onfocus="WdatePicker({minDate:'${.now?date}',dateFmt:'yyyy-MM-dd'})">
							</div>
						</div>
						<div class="space">至</div>
						<div class="block">
							<div class="m-pbMod-ipt date">
								<input name="assignmentRelations[0].markEndTime" type="text" value="${(assignmentRelation.markTime.endTime?string(" yyyy-MM-dd"))!}" class="u-pbIpt {gtAndEqStartTime:'startTimeParam'}" onclick="WdatePicker({minDate:'${.now?date}',dateFmt:'yyyy-MM-dd'})">
							</div>
						</div>
					</div>
				</div>
			</li>
			<li class="m-addElement-item">
	            <div class="ltxt m-revise-txt">
	               	批阅方式：
	               	<span class="way-des" style="width: 600px; text-align: left;">
	               		<p>学员互评： 学员之间互相批阅作业的方式。学员必须提交一份作业，随机抽取并批阅若干数量的作业才可完成活动。学员的得分=其他学员对其作业打分的平均分+学员参与批阅获得的分数</p>
	               		<p>教师批阅： 助学批阅作业的方式。助学的打分即是学员该作业的得分</p>
                        <i></i>
                    </span>
                    <ins></ins>                
	            </div>
	            <div class="center m-revise-way">
	                <div class="m-check-mod">
	                	<label class="m-radio-tick">
	                        <strong>
	                            <i class="ico"></i>
	                            <input type="radio" name="markType" checked="checked" value="each_other">
	                        </strong>
	                        <span>学员互评</span>
	                    </label>
	                    <label class="m-radio-tick">
	                        <strong>
	                            <i class="ico"></i>
	                            <input type="radio" name="markType" value="teacher">
	                        </strong>
	                        <span>教师批阅</span>
	                    </label>
	                </div>
	            </div>
	            <script>
	            	$(function(){
	            		$('#saveAssignmentMarkConfigForm input[name="markType"]').click(function(){
	            			$('.markTypeDiv').hide();
	            			$('#'+$(this).val()+'_div').show();
	            		});
	            		$('#saveAssignmentMarkConfigForm input[name="markType"][value="${(assignment.markType)!}"]').trigger('click');
	            	});
	            </script>
	        </li>
	        <div id="each_other_div" class="markTypeDiv" >
		        <li class="m-addElement-item">
					<div class="ltxt m-revise-txt">
						互评分比重(%)：
						<span class="way-des" style="width: 400px;">
		               		学员批阅完成若干数量的作业后可获得的分数(%)
	                        <i></i>
	                    </span>
	                    <ins></ins>             
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="eachOtherMarkConfig.markScorePct" class="u-pbIpt" value="${(assignment.eachOtherMarkConfig.markScorePct)!}">
						</div>
					</div>
				</li>
				<li class="m-addElement-item">
					<div class="ltxt m-revise-txt">
						互评数：
						<span class="way-des">
		               		学员需批阅的作业份数
	                        <i></i>
	                    </span>
	                    <ins></ins>             
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="eachOtherMarkConfig.markNum" class="u-pbIpt {digits:true, min:0, required:true}" value="${(assignment.eachOtherMarkConfig.markNum)!}">
						</div>
					</div>
				</li>
	        </div>
	        <div id="teacher_div" class="markTypeDiv" style="display: none;">
	        	
	        </div>
			<li class="m-addElement-btn">
				<a onclick="saveAssignmentMarkConfig(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmLayer">保存并下一步</a> 
				<a onclick="prevForm(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">上一步</a> 
				<a class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
			</li>
		</ul>
	</form>
	<script>
		function saveAssignmentMarkConfig(obj){
			if(!$('#saveAssignmentMarkConfigForm').validate().form()){
				return false;
			}
			var data = $.ajaxSubmit('saveAssignmentMarkConfigForm');
			var json = $.parseJSON(data);
			if(json.responseCode == '00'){
				nextForm(obj);
			}
		}
	</script>
</#macro>