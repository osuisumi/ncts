<#include "/ncts/study/include/layout.ftl"/>
<@layout>
<input type="hidden" id="ctx" value="${ctx!}">
<#assign cid=CSAIdObject.getCSAIdObject().cid>
<input type="hidden" id="courseId" value="${cid!}">
	
			<div class="g-cl-content">
				<!--begin course learning study plan 学习计划-->
				<div class="g-cl-plan">
					<div id="calendar"></div>
				</div>
				<!--end course learning study plan 学习计划-->
			</div>	
	
	<div id="add-bg" class="add-bg">
		<div id="add-bg-content" class="g-add">
			<div class="m-add-tl">
				<h1 class="u-add-tl">添加计划</h1>
				<button class="u-add-f crt">
					完成
				</button>
				<button class="u-add-d">
					取消
				</button>
			</div>
			<@leadCourseContent courseId=cid>
				<div class="m-add-l">
					<#list sections as section>
						<dl>
							<dt>
								<p>
									${(section.title)!}
								</p>
								<div class="u-add-con"></div>
								<div class="u-add-conr u-add-conr01"></div>
							</dt>
							<#list section.childSections as childSection> 
							<dd>
								<p id="${childSection.id}">
									${(childSection.title)!}
								</p>
								<div class="u-add-con"></div>
								<button onclick="addSectionToPrepareDiv(this)"  class="u-add-btn" btnvalue="${childSection.id}">
									+&nbsp;&nbsp;添加
								</button>
							</dd>
							</#list>
						</dl>
					</#list>
				</div>
			</@leadCourseContent>
	
			<div class="m-add-r">
				<div class="u-add-r-tl">
					<p>
						待添加
					</p>
					<div class="u-add-r-numbg">
						<span>0</span>
					</div>
	
				</div>
				<form id="saveSchedulesForm" action="${ctx}/study/schedule/saveSchedules">
					<div id="param">
						
					</div>
					<div class="u-add-r-ct">
						<!--                 <p class="u-add-r-plan">
						<i>55555</i>
						<span class="u-add-r-plan-mov">x&nbsp;移除</span>
		
						</p>  -->
		
					</div>
				</form>
			</div>
	
		</div>
	
	</div>
	
	
	<script>
		$(function(){
			lightMenu('schedule');
			loadSchedules();
		})
		
		function loadSchedules(){
			var sections = $('#add-bg-content dd p');
			var relationIds = '';
			$.each(sections,function(i,n){
				if(relationIds == ''){
					relationIds = $(n).attr('id');
				}else{
					relationIds = relationIds + ',' + $(n).attr('id');
				}
			});
			var view = $('#calendar').fullCalendar('getView'); 
			var startDate = (new Date(view.start)).format('yyyy-MM-dd');
			var endDate = (new Date(view.end)).format('yyyy-MM-dd');
			$.get('${ctx}/study/schedule/api',{
				minStartTime : startDate,
				maxStartTime : endDate,
				relationIds:relationIds,
				"creator.id":"${(Session.loginer.id)!}"
			},function(response){
				$.each(response,function(i,sche){
			        activityCalenda.add_schedule(sche);	
	        	});
	        	$('#calendar .fc-first').children('div').attr('style','');
			});
		}
		
		function jump(p){
			if($(p).attr('type') == 'course_study'){
				window.location.href = $(p).attr('url');
			}
		}
	</script>
</@layout>
