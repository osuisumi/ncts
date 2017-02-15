<div class="g-addElement-lyBox" id="questionnaireWrap">
	<div class="g-addElement-tab">
		<div class="g-add-step">
			<ol class="m-add-step num3">
				<li class="step in">
					<span class="line"></span>
					<a href="javascript:void(0);">
					<span class="ico"><i class="u-rhombus-ico">1</i></span><br/> <span class="txt">调查问卷</span> </a>
				</li>
				<li id="editQuestion" class="step <#if activity.entityId??>yet</#if>">
					<span class="line"></span>
					<a  href="javascript:void(0);"> 
					<span class="ico"><i class="u-rhombus-ico">2</i></span><br/> <span class="txt">编辑题目</span> </a>
				</li>
				<li class="step last <#if activity.entityId??>yet</#if>">
					<span class="line"></span>
					<span class="ico"><i class="u-rhombus-ico">3</i></span><br/> <span class="txt">活动设置</span> </a>
				</li>
			</ol>
		</div>
		<br/>
		<div id="tabListDiv" class="g-addElement-tabCont">
			<@survey id=(activity.entityId)!''>
			<div class="g-addElement-tabList" style="display:block">
				<#if (activity.id)??>
					<form id="saveSurveyForm" action="${ctx }/make/activity/${activity.id!}" method="put">
					<input type="hidden" name="survey.id" value="${survey.id! }"> 
				<#else>
					<form id="saveSurveyForm" action="${ctx }/${CSAIdObject.getCSAIdObject().scid }/make/activity" method="post">
					<input type="hidden" name="activity.relation.id" value="${CSAIdObject.getCSAIdObject().scid }"> 
					<input type="hidden" name="survey.surveyRelations[0].relation.id" value="${CSAIdObject.getCSAIdObject().cid }"> 
				</#if>
				<input type="hidden" name="activity.type" value="${activity.type! }">
				<ul class="g-addElement-lst g-addCourse-lst">
					<li class="m-addElement-item">
						<div class="ltxt">
							<em>*</em>问卷标题：
						</div>
						<div class="center">
							<div class="m-pbMod-ipt">
								<input type="text" name="survey.title" placeholder="输入问卷主题" class="u-pbIpt required" value="${(survey.title)!}">
							</div>
						</div>
					</li>
					<li class="m-addElement-item">
						<div class="ltxt">
							<em>*</em>问卷描述：
						</div>
						<div class="center">
							<div class="m-pbMod-ipt">
								<script id="editor" type="text/plain" style="height: 200px; width: 100%"></script>
								<input id="surveyDescription" name="survey.description" type="hidden">
							</div>
						</div>
					</li>
					<li class="m-addElement-btn">
						<a onclick="saveSurvey()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">保存并下一步</a>
						<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a> 
					</li>
				</ul>
				</form>	
			</div>
			</@survey>
			<!--编辑题目-->
			<div class="g-addElement-tabList">
				<#import "edit_survey_question.ftl" as editQuestion/>
				<@editQuestion.editQuestionFtl survey=survey/>
			</div>
			<!--活动设置-->
			<div class="g-addElement-tabList">
				<#import "/ncts/make/activity/edit_activity.ftl" as ea /> 
				<@ea.editActivityFtl activity=activity courseType=(courseType[0])!'' />
			</div>
		</div>
	</div>
</div>
<#import "survey_question_model.ftl" as model/>
<@model.questionModelFtl survey=survey/>

<script type="text/javascript">
	var ue = initProduceEditor('editor', '${(survey.description)!}', '${(Session.loginer.id)!}');
	
	function saveSurvey(){
		if(!$('#saveSurveyForm').validate().form()){
			return false;
		}
		var content = ue.getContent();
		if(content.length == 0){
			alert("描述不能为空");
			return false;
		}
		$('#surveyDescription').val(content);
		var data = $.ajaxSubmit('saveSurveyForm');
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
