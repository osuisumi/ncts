<#macro viewAssignmentResultFtl assignmentUser>
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#assign assignmentRelation=assignmentUser.assignmentRelation> 
	<#assign assignment=assignmentRelation.assignment> 
	<@evaluateSubmissionDirective assignmentId=(assignment.id)! assignmentUserId=(assignmentUser.id)!>
		<div class="g-studyTask-dt">
        	<div class="g-studyTask-grade noborder">
        		<h4 class="all-grade">
        			<#assign responseScore=(assignmentUser.responseScore!'0')?number>
        			<#assign markScore=(assignmentUser.markScore!'0')?number>
					综合得分：<strong><em>${responseScore + markScore}</em>分</strong>
					<#if 'each_other' = assignment.markType>
						&nbsp;&nbsp;&nbsp;
						(
							作业分：<strong><em>${responseScore}</em>分</strong>
							&nbsp;&nbsp;&nbsp;
							互评分：<strong><em>${markScore}</em>分</strong>
						)
					</#if>
				</h4>
				<@evaluateItemResultDirective assignmentId=assignment.id assignmentUserId=assignmentUser.id>
					<table class="m-studyGrade-table" id="taskGradeTable" cellpadding="0" cellspacing="0" border="0" width="100%">
						<thead>
							<tr>
								<th width="12%">序号</th>
								<th width="54%">评价内容</th>
								<th width="34%">得分</th>
							</tr>
						</thead>
						<tbody>
							<#list evaluate.evaluateItems as evaluateItem>
								<tr class="itemTr" itemId="${evaluateItem.id }">
									<td>${evaluateItem_index + 1 }</td>
									<td class="tl">${evaluateItem.content }</td>
									<td>
										<div class="starDiv m-ev-star cannot">
											<#list 1..5 as i>
												<#assign score=(itemScoreMap[evaluateItem.id])!0> 
												<span class="starBtn star <#if (score >= i) >z-crt</#if>"><em>${i * 20 }</em></span> 
											</#list>
										</div>
									</td>
								</tr>
							</#list>
						</tbody>
					</table>
				</@evaluateItemResultDirective>
        	</div>
        </div>
		<script>
			
		</script>
	</@evaluateSubmissionDirective>
</#macro>