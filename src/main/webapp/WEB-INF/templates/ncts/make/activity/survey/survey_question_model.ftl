<#macro questionModelFtl survey>
	<ul id="cloneWrap" class="cloneWrap">
		<!--单选题模板  不带编辑框-->
		<li class="topic-item question" data-type="single">
			<input type="hidden" value="singleChoice" class="questionType">
			<input type="hidden" name="id" class="questionId">
			<div class="m-topic-module">
				<h3 class="title"><span class="serial-number">2、</span><span class="topicTitle questionTitle">请在此输入问题标题</span></h3>
				<ol class="m-question-lst choiceGroup">
					<li class="choice">
						<label class="m-radio-tick disabled"> 
							<strong class="on"> <i class="ico"></i>
							<input type="radio" name="singleClone1" checked="checked" disabled="disabled" value="">
							</strong> 
							<span><em class="aItemNum">A、</em><span class="aItemTxt title">选项1</span></span> 
						</label>
					</li>
					<li class="choice">
						<label class="m-radio-tick disabled"> <strong> <i class="ico"></i>
							<input type="radio" name="singleClone1" value="" disabled="disabled">
							</strong> <span><em class="aItemNum">B、</em><span class="aItemTxt title">选项2</span></span> </label>
					</li>
					<li class="choice">
						<label class="m-radio-tick disabled"> <strong> <i class="ico"></i>
							<input type="radio" name="singleClone1" value="" disabled="disabled">
							</strong> <span><em class="aItemNum">C、</em><span class="aItemTxt title">选项3</span></span> </label>
					</li>
				</ol>
				<div class="t-opt">
					<div class="nextAddNew">
						<span class="lx">在此题后插入新题：</span>
						<a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
						<a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
						<a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
						<a href="javascript:void(0);" class="u-addTopic-qa">问答题</a>
					</div>
					<div class="btn-block">
						<a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
						<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
					</div>
				</div>
			</div>
		</li>
		<!--多选题模板 不带编辑框-->
		<li class="topic-item question" data-type="multiple">
			<input type="hidden" value="multipleChoice" class="questionType">
			<input type="hidden" name="id" class="questionId">
			<div class="m-topic-module">
				<h3 class="title"><span class="serial-number">3、</span><span class="topicTitle questionTitle">请在此输入问题标题</span></h3>
				<ol class="m-question-lst choiceGroup">
					<li class="choice">
						<label class="m-checkbox-tick disabled"> <strong class="on"> <i class="ico"></i>
							<input type="checkbox" name="multipleClone1" checked="checked" disabled="disabled" value="">
							</strong> <span><em class="aItemNum">A、</em><span class="aItemTxt title">选项1</span></span> </label>
					</li>
					<li class="choice">
						<label class="m-checkbox-tick disabled"> <strong> <i class="ico"></i>
							<input type="checkbox" name="multipleClone1" value="" disabled="disabled">
							</strong> <span><em class="aItemNum">B、</em><span class="aItemTxt title">选项2</span></span> </label>
					</li>
					<li class="choice">
						<label class="m-checkbox-tick disabled"> <strong> <i class="ico"></i>
							<input type="checkbox" name="multipleClone1" checked="checked" value="" disabled="disabled">
							</strong> <span><em class="aItemNum">C、</em><span class="aItemTxt title">选项3</span></span> </label>
					</li>
				</ol>
				<div class="t-opt">
					<div class="nextAddNew">
						<span class="lx">在此题后插入新题：</span>
						<a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
						<a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
						<a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
						<a href="javascript:void(0);" class="u-addTopic-qa">问答题</a>
					</div>
					<div class="btn-block">
						<a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
						<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
					</div>
				</div>
			</div>
		</li>
		<!--是非题 不带编辑框-->
		<li class="topic-item" data-type="rightAndWrong">
			<input type="hidden" value="trueOrFalse" class="questionType">
			<input type="hidden" name="id" class="questionId">
			<div class="m-topic-module">
				<h3 class="title"><span class="serial-number">1、</span><span class="topicTitle">请在此输入问题标题</span></h3>
				<ol class="m-question-lst choiceGroup">
					<li>
						<label class="m-radio-tick disabled"> <strong class="on"> <i class="ico"></i>
							<input type="radio" name="rightAndWrongClone1" checked="checked" disabled="disabled" value="">
							</strong> <span><em class="aItemNum">A、</em><span class="aItemTxt">正确</span></span> </label>
					</li>
					<li>
						<label class="m-radio-tick disabled"> <strong> <i class="ico"></i>
							<input type="radio" name="rightAndWrongClone1" value="" disabled="disabled">
							</strong> <span><em class="aItemNum">B、</em><span class="aItemTxt">错误</span></span> </label>
					</li>
				</ol>
				<div class="t-opt">
					<div class="nextAddNew">
						<span class="lx">在此题后插入新题：</span>
						<a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
						<a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
						<a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
						<a href="javascript:void(0);" class="u-addTopic-qa">问答题</a>
					</div>
					<div class="btn-block">
						<a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
						<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
					</div>
				</div>
			</div>
		</li>
		<!--简答题模板  不带编辑框-->
		<li class="topic-item question" data-type="essayQuestion">
			<input type="hidden" value="textEntry" class="questionType">
			<input type="hidden" name="id" class="questionId">
			<div class="m-topic-module">
				<h3 class="title"><span class="serial-number">4、</span><span class="topicTitle questionTitle">请在此输入问题标题</span></h3>
				<div class="m-pbMod-ipt">
					<div class="size-txt">
						<span>最小字数：<strong class="minSizeNumber">30</strong></span>
						<span>最大字数：<strong class="maxSizeNumber">300</strong></span>
					</div>
					<textarea name="" class="u-textarea disabled" disabled=""></textarea>
				</div>
				<div class="t-opt">
					<div class="nextAddNew">
						<span class="lx">在此题后插入新题：</span>
						<a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
						<a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
						<a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
						<a href="javascript:void(0);" class="u-addTopic-qa">问答题</a>
					</div>
					<div class="btn-block">
						<a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
						<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
					</div>
				</div>
			</div>
		</li>
		<!--单选题模板  带编辑框-->
		<li class="clone-item" data-type="single" id="singleChoiceBox">
			<div class="m-addTopic-module">
			<form>
			<input type="hidden" name="type" value="singleChoice">
			<input type="hidden" name="survey.id" value="${(survey.id)!}">
			<input type="hidden" name="id" class="questionId">
				<div class="t-opt">
					<!--顶部保存按钮-->
					<a onclick="saveQuestion(this)" href="javascript:void(0);" class="btn confirm"><i class="u-right-ico"></i></a>
					<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
				</div>
				<div class="section">
					<h4 class="title"><em>*</em>题目标题（单选题）</h4>
					<div class="m-pbMod-ipt">
						<textarea name="title" class="u-textarea title-input" placeholder="调查问卷单选题标题"></textarea>
					</div>
				</div>
				<div class="section">
					<h4 class="title1">选项文字</h4>
					<ul class="m-addtopicQ-lst">
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-radio-tick"> <strong class=""> 
									<!--<i class="ico"></i>
									<input type="radio" name="radioTopic1" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="" name="" placeholder="选项1" class="u-pbIpt" />
								</div>
							</div>
							<div class="cr">
								<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
							</div>
						</li>
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-radio-tick"> <strong class=""> <!--<i class="ico"></i>
									<input type="radio" name="radioTopic1" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="" name="" placeholder="选项2" class="u-pbIpt" />
								</div>
							</div>
							<div class="cr">
								<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
							</div>
						</li>
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-radio-tick"> <strong class=""> <!--<i class="ico"></i>
									<input type="radio" name="radioTopic1" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="" name="" placeholder="选项3" class="u-pbIpt" />
								</div>
							</div>
							<div class="cr">
								<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
							</div>
						</li>
					</ul>
					<div class="m-addQs-btn">
						<a href="javascript:void(0);" class="add addQuestionButton">+添加答案选项</a>
					</div>
				</div>
				<a onclick="saveQuestion(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>
				</form>
			</div>
		</li>
		<!--多选题模板 带编辑框-->
		<li class="clone-item" data-type="multiple" id="multipleChoiceBox">
			<div class="m-addTopic-module">
				<form>
				<input type="hidden" name="type" value="multipleChoice">
				<input type="hidden" name="survey.id" value="${(survey.id)!}">
				<input type="hidden" name="id" class="questionId">
				<div class="t-opt">
					<a onclick="saveQuestion(this)" href="javascript:void(0);" class="btn confirm"><i class="u-right-ico"></i></a>
					<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
				</div>
				<div class="section">
					<h4 class="title"><em>*</em>题目标题（多选题）</h4>
					<div class="m-pbMod-ipt">
						<textarea name="title" class="u-textarea title-input" placeholder="调查问卷多选题标题"></textarea>
					</div>
				</div>
                <div class="section">
                    <h4 class="title1">最多选项个数</h4>
                    <div class="m-pbMod-ipt txt-chosse-number">
                        <input value="" min="1" name="choiceGroups[0].maxChoose" placeholder="请填写个数" class="u-pbIpt maxChoose" type="text">
                        <!--<span class="txt">最多5个哦！</span>-->
                    </div>
                </div>
				<div class="section">
					<h4 class="title1">选项文字</h4>
					<ul class="m-addtopicQ-lst">
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-checkbox-tick"> <strong class=""><!-- <i class="ico"></i>
									<input type="checkbox" name="checkbox1" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="" name="" placeholder="选项1" class="u-pbIpt" />
								</div>
							</div>
							<div class="cr">
								<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
							</div>
						</li>
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-checkbox-tick"> <strong class=""> <!--<i class="ico"></i>
									<input type="checkbox" name="checkbox1" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="" name="" placeholder="选项2" class="u-pbIpt" />
								</div>
							</div>
							<div class="cr">
								<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
							</div>
						</li>
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-checkbox-tick"> <strong class=""> <!--<i class="ico"></i>
									<input type="checkbox" name="checkbox1" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="" name="" placeholder="选项3" class="u-pbIpt" />
								</div>
							</div>
							<div class="cr">
								<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
							</div>
						</li>
					</ul>
					<div class="m-addQs-btn">
						<a href="javascript:void(0);" class="add addQuestionButton">+添加答案选项</a>
					</div>
				</div>
				<a onclick="saveQuestion(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>
				</form>
			</div>
		</li>
		<li class="clone-item" data-type="rightAndWrong" id="rightAndWrongBox">
			<div class="m-addTopic-module">
				<form>
				<input type="hidden" name="type" value="trueOrFalse">
				<input type="hidden" name="survey.id" value="${(survey.id)!}">
				<input type="hidden" name="id" class="questionId">
				<div class="t-opt">
					<a onclick="saveQuestion(this)" href="javascript:void(0);" class="btn confirm"><i class="u-right-ico"></i></a>
					<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
				</div>
				<div class="section">
					<h4 class="title"><em>*</em>题目标题（是非题）</h4>
					<div class="m-pbMod-ipt">
						<textarea name="title" class="u-textarea title-input" placeholder="调查问卷是非题标题"></textarea>
					</div>
				</div>
				<div class="section">
					<h4 class="title1">选项文字</h4>
					<ul class="m-addtopicQ-lst">
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-radio-tick"> <strong class=""> <!--<i class="ico"></i>
									<input type="radio" name="rightAndWrong" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="正确" name="" class="u-pbIpt" />
								</div>
							</div>
						</li>
						<li class="m-addTopic-q choice">
							<div class="cl">
								<label class="m-radio-tick"> <strong class=""> <!--<i class="ico"></i>
									<input type="radio" name="rightAndWrong" value="">-->
									</strong> </label>
							</div>
							<div class="cc">
								<div class="m-pbMod-ipt">
									<input required type="text" value="错误" name="" class="u-pbIpt" />
								</div>
							</div>
						</li>
					</ul>
				</div>
				<a onclick="saveQuestion(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>
				</form>
			</div>
		</li>
		<li class="clone-item" data-type="essayQuestion" id="essayQuestionBox">
			<div class="m-addTopic-module">
				<form>
				<input type="hidden" name="type" value="textEntry">
				<input type="hidden" name="survey.id" value="${(survey.id)!}">
				<input type="hidden" name="id" class="questionId">
				<div class="t-opt">
					<a onclick="saveQuestion(this)" href="javascript:void(0);" class="btn confirm"><i class="u-right-ico"></i></a>
					<a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
				</div>
				<div class="section">
					<h4 class="title"><em>*</em>题目标题（问答题）</h4>
					<div class="m-pbMod-ipt">
						<textarea name="title" class="u-textarea title-input" placeholder="调差问卷问答题标题"></textarea>
					</div>
				</div>
				<div class="section">
					<h4 class="title">问答设置</h4>
					<div class="m-continuous-ipt">
						<div class="c-txt">
							最小字数：
						</div>
						<div class="m-pbMod-ipt" style="width: 50px;">
							<input type="text" min="0" name="textEntryInteraction.minWords" value="" placeholder="不限" class="u-pbIpt minSizeNumber" />
						</div>
						<div class="space"></div>
						<div class="c-txt">
							最大字数：
						</div>
						<div class="m-pbMod-ipt" style="width: 50px;">
							<input type="text" name="textEntryInteraction.maxWords" value="" placeholder="不限" class="u-pbIpt maxSizeNumber" />
						</div>
					</div>
	
				</div>
				<a onclick="saveQuestion(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>
				</form>
			</div>
		</li>
		<li class="clone-item" data-type="essayQuestion" id="importTextarea">
			<form action="${ctx}/make/survey/question/importFromString" method="post">
				<input type="hidden" name="surveyId" value="${survey.id!}">
				<div class="m-addTopic-module">
					<div class="konw-point">
	                    <i class="u-little-icon"></i>
	                    <div class="button-alert" style="max-width: 400px;">
	                        <span class="alert-txt">
	                       		<p style="text-align: left">1. 题目标题最好以数字+顿号开头, 如:1、</p>
								<p style="text-align: left">2. 选项与选项之间不要空行</p>
								<p style="text-align: left">3. 题目类型以题目结尾的[题型]来区分, 如:[单选题]、[多选题]、[简答题]</p>
								<p style="text-align: left">4. 如果无法正确识别，请尝试在题目与题目之间加入空行</p>
								<p style="text-align: left">5. 由于可能存在因格式等问题导致导入结果与预期有出入的情况，请在导入成功后进行检查</p>
	                        </span>
	                        <ins class="arrow"></ins>
	                        <div class="u-button" style="font-size: 12px;">我知道了</div>
	                    </div>                    
	                </div>
					<textarea name="input" required class="u-textarea title-input" wrap="off" style="overflow:scroll;max-height:600px" rows="40">
1、您的年级是 
2007级 
2006级 
2005级 
2004级 

2、您的爱好是 [多选题]
读书
写作
弹琴

3、请写出你的感想[简答题]
					</textarea>
					<a onclick="importText(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>
				</div>
			</form>
		</li>
	</ul>
	<script>
		$(function(){
			konw_point();
		});
	
		function saveQuestion(a){
			//$(a).unbind('click');
			var form = $(a).closest('form');
			//最大最小字数控制
			var minWordInput = form.find('input[name="textEntryInteraction.minWords"]');
			var maxWordInput = form.find('input[name="textEntryInteraction.maxWords"]');
			if(minWordInput.val() == ''){
				minWordInput.val('0');
			}
			if(maxWordInput.val() == ''){
				maxWordInput.val('0');
			}
			
			//初始化选项
			var choices = form.find('.choice');
			if(choices){
				$.each(choices,function(i,c){
				var choiceContentInput = $(c).find('input[type="text"]');
				choiceContentInput.attr('name','choiceGroups[0].choices['+i+']'+'.content');
				});
			}
		
			if(!form.validate({
				rules:{
						'textEntryInteraction.maxWords':{
							max:"4000",
							min:minWordInput.val()
						}
					}
			}).form()){
				return false;
			}
			//设置题目排序号
			var questionId = form.find('.questionId').eq(0).val();
			var data = form.serialize();
			if(questionId){
				data = '_method=put'+'&'+data;
			}else{
				data = '_method=post'+'&'+data;
			}
			
			
			$.ajax({
				type:'post',
				url:'${ctx}/make/survey/question',
				data:data,
				success:function(response){
					var questionId = form.find('.questionId').eq(0).val();
					$(a).attr('onclick','');
					if(!questionId){
						questionId = response.responseData.id;
					}
					//如果更新
					if(questionId){
						$(form).find('.questionId').val(questionId);
					}
					addTopicFn.confirm();
					$(a).click();
				}
			});
		}
		
		function importText(a){
			var form = $(a).closest('form');
			if(!form.validate().form()){
				return false;
			}
			$.ajax({
				type:'post',
				url:form.attr('action'),
				data:form.serialize(),
				success:function(response){
					if(response.responseCode == '00'){
						alert('提交成功',function(){
							//关闭当前弹窗，
								mylayerFn.refresh({
						            id: 'editActivityDiv',
						            content: '${ctx}/make/activity/${(activity.id)!}/edit',
						            refreshFn: function(){
						            	$('.m-add-step li').eq(1).trigger('click');
						            	$('.m-add-step li:gt(1)').removeClass('yet');
						            }
						        });
						});
					}
				}
			});
		}
		
		function konw_point(){
		    $(".g-addTopic-box").on("click",".konw-point .u-button" ,function(){
		        $(this).parents(".button-alert").addClass('button-alertTwo');

		    });
		    $(".g-addTopic-box").on("click",".konw-point .u-little-icon" ,function(){
		        $(this).siblings('.button-alert').removeClass('button-alertTwo');


		    });
		}
	</script>
</#macro>