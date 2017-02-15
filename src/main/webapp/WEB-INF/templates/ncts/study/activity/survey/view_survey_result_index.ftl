<#macro viewSurveyResultIndexFtl surveyId relationId aid>
	<div class="g-study-dt">
		<div class="g-question-box">
			<@survey id=surveyId relationId=relationId> 
				<h1 class="g-question-tl">${survey.title}</h1>
				<div class="g-question-tx">${survey.description}</div>
				<p class="vote">
					<#assign participateNum = (surveyRelation.participateNum)!1 />
					有效投票人次：<span id="participateNumSpan">${participateNum!}</span> 次
				</p>
				<#nested>
			</@survey>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			var questions = $('.question');
			$.each(questions,function(i,q){
				var choices = $(q).find('.choice');
				var maxHint = 0;
				$.each(choices,function(i,c){
					var choiceHint = parseInt($(c).attr('hint'));
					if(!isNaN(choiceHint)){
						if(choiceHint>maxHint){
							maxHint = choiceHint;
						}
					}
				});
				$(q).find('.choice[hint='+maxHint+']').find('.m-question-per').css('background-color','#fc995c');
			});
			
		})
	</script>
</#macro>