<#macro editQuestionFtl test courseType="">
	<#assign cid=CSAIdObject.getCSAIdObject().cid>
	<#if test.id??>
<div class="g-addTopic-wrap" id="Test-questionnaireWrap">
     <div class="addTest-part">
         <div class="m-addTopic-opt isntFirst ">
              <span class="lx text-txt">添加题目类型 :</span>
               <div class="m-addTest-select">
                    <a href="javascript:void(0);" class="u-addTopic-single crt"><i class="u-radio-ico"></i>单选题</a>
                    <a href="javascript:void(0);" class="u-addTopic-multiple"><i class="u-checkbox-ico"></i>多选题</a>
                    <a href="javascript:void(0);" class="u-addTopic-rw"><i class="u-radio-ico"></i>是非题</a>
                    <a style="margin-right:0px" href="javascript:void(0);" class="u-addTopic-import"><i class=""></i>导入测验题文本</a>
                 <!--   <a href="javascript:void(0);" class="u-addTopic-bl "><i class="u-radio-ico u-addTest-ico"></i>填空题</a>-->
               </div>
               <span class="hint"></span>
               <script>
               		$(function(){
               			$('.m-addTest-select a').click(function(){
               				$(this).addClass('crt').siblings().removeClass('crt');
               			});
               		});
               </script>
         </div> 

     </div>	
	<div class="g-addTopic-box">
		<div class="g-topicList-box">
			<input id="testId" type="hidden" value="${test.id}" name="id">
			<ol class="g-topicList" id="topicListBox">
				<@testPackageDirective testPackage=test.testPackage>
					<#if questions??>
						<#list questions as question>
							<#if question.quesType ='SINGLE_CHOICE' || question.quesType ='MULTIPLE_CHOICE' || question.quesType = 'TRUE_FALSE'>
							<li questionId="${question.id }" class="topic-item question" data-type="<#if question.quesType ='SINGLE_CHOICE'>single<#elseif question.quesType ='MULTIPLE_CHOICE'>multiple<#elseif question.quesType = 'TRUE_FALSE'>trueFalse</#if>">
								<input type="hidden" value="${(question.id)!''}" class="questionId">
								<input type="hidden" value="${question.quesType}" class="questionType">
								<input type="hidden" value="${question.score}" class="score"/>
								<input type="hidden" value="${question.correctFeedback!''}" class="correctFeedback"/>
								<input type="hidden" value="${question.incorrectFeedback!''}" class="incorrectFeedback"/>
								<div class="m-topic-module">
									<h3 class="title"><span class="serial-number">2、</span><span class="topicTitle questionTitle">${question.title}</span></h3>
									<ol class="m-question-lst">
										<#if question.interactionOptions??>
											<#list question.interactionOptions as interactionOption>
												<#if interactionOption??>
														<li class="choice">
															<label class="m-<#if question.quesType == 'SINGLE_CHOICE' || question.quesType == 'TRUE_FALSE'>radio<#elseif question.quesType == 'MULTIPLE_CHOICE'>checkbox<#else></#if>-tick"> 
																<strong> 
																	<i class="ico"></i>
																	<#if question.quesType == 'SINGLE_CHOICE' || question.quesType == 'TRUE_FALSE'>
																		<input disabled="disabled" type="radio" name="choice${question_index}" <#if (question.correctOption!'') ==interactionOption.id>checked="checked"</#if>   value="${interactionOption.id}">
																	<#else>
																		<#assign isCorrect="false"/>
																		<#list question.correctOptions as correctOption>
																			<#if correctOption==interactionOption.id>
																				<#assign isCorrect="true"/>
																			</#if>																		
																		</#list>
																		<input disabled="disabled" type="checkbox" name="choice${question_index}" <#if isCorrect =="true">checked="checked"</#if>  value="${interactionOption.id}">
																	</#if>																	
																</strong> 
																<span><em class="aItemNum">${ConverNumToABCUtils.conver(interactionOption_index)}、</em><span class="aItemTxt title">${interactionOption.text}</span></span>
															 </label>
														</li>
												</#if>
											</#list>
										</#if>
									</ol>
									<div class="t-opt">
										<div class="nextAddNew">
											<span class="lx">在此题后插入新题：</span>
											<a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
											<a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
											<a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
											<a style="margin-right:0px" href="javascript:void(0);" class="u-addTopic-import"><i class=""></i>导入测验题文本</a>
										</div>
										<div class="btn-block">
											<a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
											<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
										</div>
									</div>
								</div>
							</li>
							</#if>
						</#list>
					</#if>					
				</@testPackageDirective>				
			</ol>
			<#if courseType != 'mic'>
				<div class="m-addElement-btn hasborder">
					<a onclick="nextStep(this)" href="javascript:void(0);"  class="btn u-main-btn" id="confirmLayer">下一步</a>
				</div>
			</#if>
		</div>
	</div>
</div>
<form id="updateTestQuestionSequenceForm" action="${ctx}/${cid}/make/test/${test.id}/updateTestQuestionSequence" method="put">
	<input id="targetQfk" type="hidden" name="targetQfk" />
	<input id="sourceQfk" type="hidden" name="sourceQfk" />
</form>

<#import "test_question_model.ftl" as model/>
<@model.questionModelFtl test=test/>
	<script>
		$(function() {
		//添加测验
			addTestQuestionFn.init($("#Test-questionnaireWrap"));
			Sub_tab();
		    addScore();
		
		  $(".addTest-part").myTab({
		      pars    : '.addTest-part',
		     tabNav  : '.m-addTest-select',
		      li      : 'a',       //标签
		     // tabCon  : '.all-sub-box',
		     // tabList : '.addtext-radio',
		     // cur     : 'crt'
		  });  
		  
		  var startIndex = 0;
		   $("#topicListBox").sortable({
		        placeholder: "ui-state-highlight",
		        items: ".topic-item",
		        opacity: 0.6,
		        containment: "body",
		        start: function(event, ui){
		        	startIndex = $('#topicListBox').children('li').index(ui.item);
		        },
		        stop: function(event, ui){
		            //执行排序
		            addTestQuestionFn.arrange();
		            
		            var endIndex = $('#topicListBox').children('li').index(ui.item);
		            $('#updateTestQuestionSequenceForm #sourceQfk').val('P1:S1:Q' + startIndex);
		            $('#updateTestQuestionSequenceForm #targetQfk').val('P1:S1:Q' + endIndex);
		            $.ajaxSubmit('updateTestQuestionSequenceForm');
		        }
		    }).disableSelection();
		   addCourseFn.firefoxDrag('#Test-questionnaireWrap','#newAddTopicBox .m-addTopic-q .m-pbMod-ipt .u-pbIpt');
		});
		
		function nextStep(a){
			if($('#topicListBox .question').size()<=0){
				alert('请添加题目');
				return false;
			}
			nextForm(a);
		}
		function Sub_tab(){ //每种题目里的每个模块
        $("body").on("click",".g-addtext-radio-item li", function(){
            var itemLi = $(this).parent(".g-addtext-radio-item").siblings('.pro-content').children('.pro-content-txt');
            var Li_Index = $(this).index()
            $(this).addClass('crt').siblings('li').removeClass('crt');
            itemLi.eq(Li_Index).addClass('pro-content-txt01').siblings('.pro-content-txt').removeClass('pro-content-txt01');

        });
        $(".pro-content-txt .delete").on("click",function(){
            var $Par = $(this).parent().parent().parent(".pro-content-txt");
            

        });

    };
    function addScore(){  //分数的增加减少
        $("body").off().on("click",".u-addtext-score01", function(){ //分数减少
            var $ScorIn = $(this).siblings(".m-addtext-score-in")
            var Sc_val = $ScorIn.val();
            // alert(Sc_val)
            if(Sc_val>0){
                Sc_val--
                $ScorIn.val(Sc_val)
                if(Sc_val==0){
                    $ScorIn.val(0)
                }
            }
        });
        $("body").off().on("click",".u-addtext-score02", function(){ //分数增加 ps:暂时总分10分
            var $ScorIn = $(this).siblings(".m-addtext-score-in")
            var Sc_val = $ScorIn.val();
            Sc_val++
            $ScorIn.val(Sc_val);

        });

    };
		
	</script>

	</#if>
</#macro>