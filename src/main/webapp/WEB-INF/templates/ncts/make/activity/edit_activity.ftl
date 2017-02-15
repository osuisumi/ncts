<#macro editActivityFtl activity courseType>
	<form id="saveActivityConfigForm" action="${ctx }/make/activity/${(activity.id)!}" method="put">
		<ul class="g-addElement-lst g-addCourse-lst">
			<#if ('self' != courseType)>
				<li class="m-addElement-item">
					<div class="ltxt">活动时间：</div>
					<div class="center">
						<div class="m-slt-row">
							<div class="block">
								<div class="m-pbMod-ipt date">
									<input id="startTimeParam" name="activity.startTime" type="text" value="${(activity.timePeriod.startTime?string("yyyy-MM-dd"))!}" class="u-pbIpt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
								</div>
							</div>
							<div class="space">至</div>
							<div class="block">
								<div class="m-pbMod-ipt date">
									<input id="endTimeParam" name="activity.endTime" type="text" value="${(activity.timePeriod.endTime?string("yyyy-MM-dd"))!}" class="u-pbIpt {gtAndEqStartTime:'startTimeParam'}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
								</div>
							</div>
						</div>
					</div>
				</li>
			</#if>
			<li class="m-addElement-item">
				<div class="ltxt">活动标签：</div>
				<div class="center">
					<div class="m-add-tag f-cb">
						<#import "/ncts/make/common/edit_tag.ftl" as editTag /> 
						<@editTag.editTagFtl relationId="${activity.id!}" paramPrefix="activity." />
					</div>
				</div>
			</li>
			<!-- <li class="m-addElement-item">
				<div class="ltxt">活动分：</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input type="text" name="activity.score" placeholder="输入活动分" class="u-pbIpt {number:true, min:0}" value="${(activity.score)!}">
					</div>
				</div>
			</li> --> 
			<li class="m-addElement-btn">
				<a onclick="saveActivity()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmLayer">提交</a> 
				<a onclick="prevForm()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">上一步</a> 
				<a class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
			</li>
		</ul>
	</form>
	<script>
		$(function(){
			$('.m-add-step').on('click', 'li', function(){
				if($(this).hasClass('yet')){
					if(!$('#tabListDiv form').validate().form()){
						return false;
					}else{
						$('.m-add-step li').removeClass('in');
						$(this).addClass('in');
						$(this).prevAll('li').addClass('yet');
						$('.g-addElement-tabList').hide();
						var index = $('.m-add-step li').index($(this));
						$('.g-addElement-tabList').eq(index).show();
					}
				}
			});
			
			//radio
		    $('.m-radio-tick input').bindCheckboxRadioSimulate();
		    $('.m-checkbox-tick input').bindCheckboxRadioSimulate();
		});

		function prevForm(obj){
			var index = $('#tabListDiv .g-addElement-tabList').index($(obj).parents('.g-addElement-tabList')) - 1;
			$('.m-add-step li').eq(index).trigger('click');
		}
		
		function nextForm(obj){
			var index = $('#tabListDiv .g-addElement-tabList').index($(obj).parents('.g-addElement-tabList')) + 1;
			$('.m-add-step li').eq(index).addClass('yet');
			$('.m-add-step li').eq(index).trigger('click');
		}
		
		function refreshAndNextForm(activityId, courseType){
			mylayerFn.refresh({
	            id: 'editActivityDiv',
	            content: '${ctx}/make/activity/'+activityId+'/edit?courseType='+courseType,
	            refreshFn: function(){
	            	$('.m-add-step li').eq(1).trigger('click');
	            	$('.m-add-step li:gt(1)').removeClass('yet');
	            }
	        });
		}
		
		function saveActivity(){
			if(!$('#saveActivityConfigForm').validate().form()){
				return false;
			}
			var data = $.ajaxSubmit('saveActivityConfigForm');
			var json = $.parseJSON(data);
			if(json.responseCode == '00'){
				alert('提交成功', function(){
					$('.u-cancelLayer-btn').trigger('click');
				});
			}
		}
	</script>
</#macro>