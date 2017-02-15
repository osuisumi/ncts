<#include "/ncts/teach/include/layout.ftl"/> 
<@layout> 
<#assign cid=CSAIdObject.getCSAIdObject().cid>
<script>
$(function(){
	lightMenu('assignment');
});
</script>
<div id="listAssignmentUserDiv" class="g-cl-content">
	<form id="listAssignmentUserForm" action="${ctx}/${cid!}/teach/assignment/biz/listAssignmentUser">
		<input type="hidden" name="state" value="${(assignmentUser.state)!'' }">
		<input type="hidden" name="assignmentId" value="${(assignmentId[0])!'' }">
		<div class="g-wrok-check">
			<div class="g-work-query">
				<dl>
					<dt>时间：</dt>
					<dd>
						<div class="m-date">
							<div class="m-pbMod-ipt date">
								<input name="responseStartTime" id="responseStartTimeParam" type="text" value="${(responseStartTime[0])!}" class="u-pbIpt"
                            	onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							</div>
							<span class="u-line"></span>
							<div class="m-pbMod-ipt date">
								<input name="responseEndTime" id="responseEndTimeParam" type="text" value="${(responseEndTime[0])!}" class="u-pbIpt"
                            	onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							</div>
							<a onclick="$('#listAssignmentUserForm').submit()" href="javascript:void(0);" class="u-btn-srh">搜索</a> 
							<a onclick="searchAssignmentUser('today')" class="u-mark">今天</a> 
							<a onclick="searchAssignmentUser('one_month')" class="u-mark">1个月</a> 
							<a onclick="searchAssignmentUser('three_month')" class="u-mark">3个月</a> 
							<a onclick="searchAssignmentUser('one_year')" class="u-mark">一年内</a>
						</div>
					</dd>
				</dl>
				<dl>
					<dt>作业：</dt>
					<dd id="assignmentIdParam">
						<@assignmentsDirective relationId=cid markType='teacher'>
							<a href="javascript:void(0);" class="block z-crt">全部</a> 
							<#list assignments as assignment>
								<a assignmentId="${assignment.id! }" href="javascript:void(0);" class="block">${assignment.title! }</a> 
							</#list>
						</@assignmentsDirective>
					</dd>
					<script>
						$(function(){
							$('#assignmentIdParam a').click(function(){
								$('#listAssignmentUserForm input[name="assignmentId"]').val($(this).attr('assignmentId'));
								$('#listAssignmentUserForm input[name="page"]').val(1);
								$('#listAssignmentUserForm').submit();
							});
							if('' != '${(assignmentId[0])!""}'){
								$('#assignmentIdParam a').removeClass('z-crt');
								$('#assignmentIdParam a[assignmentId=${(assignmentId[0])!""}]').addClass('z-crt');
							}
						});
					</script>
				</dl>
				<dl>
					<dt>状态：</dt>
					<dd id="stateParam">
						<a href="javascript:void(0);" class="block z-crt">全部</a> 
						<a state="commit" href="javascript:void(0);" class="block">待批阅</a> 
						<a state="complete" href="javascript:void(0);" class="block">已批阅</a> 
						<a state="return" href="javascript:void(0);" class="block">发回重做</a>
					</dd>
					<script>
						$(function(){
							$('#stateParam a').click(function(){
								$('#listAssignmentUserForm input[name="state"]').val($(this).attr('state'));
								$('#listAssignmentUserForm input[name="page"]').val(1);
								$('#listAssignmentUserForm').submit();
							});
							if('' != '${(assignmentUser.state)!""}'){
								$('#stateParam a').removeClass('z-crt');
								$('#stateParam a[state=${(assignmentUser.state)!""}]').addClass('z-crt');
							}
						});
					</script>
				</dl>
				<div class="m-search-box">
					<label class="m-srh"> 
						<input id="searchTxt" name="realName" type="text" value="${(realName[0])!''}" class="ipt" placeholder="学员姓名搜索"> 
						<i class="u-srh1-ico"></i>
					</label>
					<script>
                       	$(function(){
                       		$('#searchTxt').keydown(function(e){
                   				if(e.keyCode==13){
                   					$('#listAssignmentUserForm #currentPage').val(1);
                   					$('#listAssignmentUserForm').submit();
                   				}
                   		    });
                       	});
                    </script>
				</div>
				<div class="m-check-task">
                    <button onclick="createAssignmentMark();return false;" class="btn u-main-btn">领取作业</button>
                    <@assignmentUserNumDirective relationId=cid userId=Session.loginer.id assignmentMarkType='teacher'>
                    	<p class="txt">您已批阅<span>${markNum }/${allNum }</span>作业，还有<span>${notReceivedNum }</span>份待领取&nbsp;</p>
                    	<input type="hidden" id="notMarkedNum" value="${notMarkedNum }">
                    </@assignmentUserNumDirective>
                </div>
			</div>
			<@assignmentUsersDirective marker=Session.loginer.id responseStartTime=(responseStartTime[0])!'' responseEndTime=(responseEndTime[0])!'' realName=(realName[0])!'' page=pageBounds.page limit=pageBounds.limit orders='CREATE_TIME.DESC' state=(assignmentUser.state)!'' assignmentId=(assignmentId[0])!'' relationId=cid assignmentMarkType='teacher'>
				<table class="g-check-tbl">
					<tr class="tit">
	                    <th width="17.8%">姓名</th>
	                    <th width="14.4%">作业名称</th>
	                    <th width="16.4%">创建时间</th>
	                    <th width="15%">状态</th>
	                    <th width="16%" class="score-tit">分数</th>
	                    <th width="20.4%">操作</th>
	                </tr>
					<#list assignmentUsers as assignmentUser>
						<tr>
							<td>
								<#import "/common/image.ftl" as image/>
								<@image.imageFtl url=(assignmentUser.creator.avatar)! default="${app_path}/images/defaultAvatarImg.png" />
								<span class="name">${(assignmentUser.creator.realName)! }</span>
							</td>
							<td>${(assignmentUser.assignmentRelation.assignment.title)! }</td>
							<td>${(assignmentUser.responseTime?string('yyyy-MM-dd HH:mm'))! }</td>
							<td>
								<#if ('not_attempt' == (assignmentUser.state)!'')>
									未提交
								<#elseif ('commit' == (assignmentUser.state)!'')>
									待批阅
								<#elseif ('complete' == (assignmentUser.state)!'')>	
									已批阅
								<#elseif ('return' == (assignmentUser.state)!'')>	
									发回重做
								</#if>
							</td>
							<td class="score-num">${(assignmentUser.responseScore)!'' }</td>
							<td>
								<#if ('commit' == (assignmentUser.state)!'')>
									<a onclick="markAssignmentUser('${assignmentUser.id}')" href="javascript:void(0);" class="u-opa">批阅</a>
								<#elseif ('complete' == (assignmentUser.state)!'')>	
									<a onclick="markAssignmentUser('${assignmentUser.id}')" href="javascript:void(0);" class="u-opa">重新批阅</a>
								<#elseif ('return' == (assignmentUser.state)!'')>	
									<a onclick="markAssignmentUser('${assignmentUser.id}')" href="javascript:void(0);" class="u-opa">查看</a>
								</#if>
							</td>
						</tr>
					</#list>
				</table>
				<div id="listAssignmentUserPage" class="m-laypage"></div>
				<#import "/common/pagination.ftl" as p/>
				<@p.paginationFtl formId="listAssignmentUserForm" divId="listAssignmentUserPage" paginator=paginator />
			</@assignmentUsersDirective>
		</div>
	</form>
</div>
<div id="markAssignmentUserDiv"  style="display: none;">
	
</div>
</@layout>
<script>
	function markAssignmentUser(assignmentUserId){
		$('#markAssignmentUserDiv').load('${ctx}/${cid}/teach/assignment/biz/markAssignmentUser', 'assignmentUser.id='+assignmentUserId+'&inCurrentDate=true');
		$('#markAssignmentUserDiv').show();
		$('#listAssignmentUserDiv').hide();
	}
	
	function searchAssignmentUser(time){
		var responseStartTime = '';
		var date = new Date();
		if(time == 'one_month'){
			date.setMonth(date.getMonth() - 1);
		}else if(time == 'three_month'){
			date.setMonth(date.getMonth() - 3);
		}else if(time == 'one_year'){
			date.setFullYear(date.getFullYear() - 1);
		}
		$('#responseStartTimeParam').val(date.format("yyyy-MM-dd"));
		$('#listAssignmentUserForm input[name="page"]').val(1);
		$('#listAssignmentUserForm').submit();
	}
	
	function createAssignmentMark(){
		var notMarkedNum = parseInt($('#notMarkedNum').val());
		if(notMarkedNum > 0){
			alert('请批改完所有领取的作业后再领取');
		}else{
			$.post('/${cid}/teach/course/assignment/mark/${cid}', 'limit=10', function(data){
				if(data.responseCode == '00'){
					alert('成功领取'+data.responseData+'份作业', function(){
						$('#listAssignmentUserForm input[name="page"]').val(1);
						$('#listAssignmentUserForm').submit();
					});
				}else{
					if(data.responseMsg == 'assigment is not enough'){
						alert('暂时没有未领取的作业');
					}
				}
			});
		}
	}
</script>