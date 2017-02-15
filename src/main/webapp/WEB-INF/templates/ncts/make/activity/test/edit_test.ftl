<div class="g-addElement-lyBox" id="questionnaireWrap">
	<div class="g-add-step">
		<ol class="m-add-step num3">
			<li class="step in">
				<span class="line"></span>
				<a href="javascript:void(0);">
					<span class="ico"><i class="u-rhombus-ico">1</i></span><br/> <span class="txt">测验</span> 
				</a>
			</li>
			<li class="step <#if activity.entityId??>yet</#if>">
				<span class="line"></span>
				<a href="javascript:void(0);"> 
					<span class="ico"><i class="u-rhombus-ico">2</i></span><br/> <span class="txt">编辑题目</span> 
				</a>
			</li>
			<li class="step last <#if activity.entityId??>yet</#if>">
				<span class="line"></span>
				<a href="javascript:void(0);">
					<span class="ico"><i class="u-rhombus-ico">3</i></span><br/> <span class="txt">活动设置</span> 
				</a>
			</li>
		</ol>
	</div>
	<br/>
	<div id="tabListDiv" class="g-addElement-tabCont">
		<@testDirective id=(activity.entityId)!''>
		<div class="g-addElement-tabList" style="display:block">
			<#if (activity.id)??>
				<form id="saveTestForm" action="${ctx }/make/activity/${activity.id!}" method="put">
				<input type="hidden" name="test.id" value="${test.id! }"> 
			<#else>
				<form id="saveTestForm" action="${ctx }/${CSAIdObject.getCSAIdObject().scid }/make/activity" method="post">
				<input type="hidden" name="activity.relation.id" value="${CSAIdObject.getCSAIdObject().scid }"> 
				<input type="hidden" name="test.testDeliveries[0].relationId" value="${CSAIdObject.getCSAIdObject().cid }"> 
			</#if>
			<input type="hidden" name="activity.type" value="${activity.type! }">
			<ul class="g-addElement-lst g-addCourse-lst">
				<li class="m-addElement-item">
					<div class="ltxt">
						<em>*</em>测验标题：
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="test.title" placeholder="输入测验标题" class="u-pbIpt required" value="${(test.title)!}">
						</div>
					</div>
				</li>
				<li class="m-addElement-item">
					<div class="ltxt">
						<em>*</em>允许提交次数 	
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<input type="text" name="test.maxAttempts" placeholder="输入允许提交的最大次数默认设置为0不限制提交" class="u-pbIpt {number:true}" value="${(test.maxAttempts)!}">
						</div>
					</div>
				</li>
				<li class="m-addElement-item">
					<div class="ltxt">
						<em>*</em>测验描述：
					</div>
					<div class="center">
						<div class="m-pbMod-ipt">
							<script id="editor" type="text/plain" style="height: 200px; width: 100%"></script>
							<input id="testDescription" name="test.description" type="hidden" class="required">
						</div>
					</div>
				</li>
				<li class="m-addElement-btn">
					<a onclick="saveTest()" href="javascript:void(0);"  class="btn u-main-btn">保存并下一步</a>
					<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a> 
				</li>
			</ul>
			</form>	
		</div>
		</@testDirective>
		<!--编辑题目-->
		<div class="g-addElement-tabList">
			<#import "edit_test_question.ftl" as editQuestion/>
			<@editQuestion.editQuestionFtl test=test/>
		</div>
		<!--活动设置-->
		<div class="g-addElement-tabList">
			<#import "/ncts/make/activity/edit_activity.ftl" as ea /> 
			<@ea.editActivityFtl activity=activity courseType=(courseType[0])!'' />
		</div>
	</div>
</div>

<script type="text/javascript">
	var ue = initProduceEditor('editor', '${(test.description)!}', '${(Session.loginer.id)!}');
	
	function saveTest(){
		if(!$('#saveTestForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		if(content.length == 0){
			alert("描述不能为空");
			return false;
		}
		$('#testDescription').val(content);
		var data = $.ajaxSubmit('saveTestForm');
		var json = $.parseJSON(data);
		if(json.responseCode == '00'){
			listActivity('${CSAIdObject.getCSAIdObject().scid }');
			var activity = json.responseData;
			if(activity != null){
				refreshAndNextForm(activity.id, '${(courseType[0])!""}');
			}else{
				$('.m-add-step li').eq(1).trigger('click');
			}
		}
	}
</script>
