<#macro questionModelFtl test>
	<ul id="cloneWrap" class="cloneWrap">
		<li class="topic-item question" data-type="single">
			<input type="hidden" value="SINGLE_CHOICE" class="questionType">
			<input type="hidden" value="" class="questionId">
			<input type="hidden" value="" class="score"/>
			<input type="hidden" value="" class="correctFeedback"/>
			<input type="hidden" value="" class="incorrectFeedback"/>
            <div class="m-topic-module">
                <h3 class="title">
                    <span class="serial-number">2、</span>
                    <span class="topicTitle">请在此输入问题标题</span>
                </h3>
                <ol class="m-question-lst">
                    <li>
                        <label class="m-radio-tick ">
                            <strong class="on">
                                <i class="ico"></i>
                                <input type="radio" name="singleClone1" checked="checked"  value="">
                            </strong>
                            <span><em class="aItemNum">A、</em><span class="aItemTxt">选项1</span></span>
                        </label>
                    </li>
                    <li>
                        <label class="m-radio-tick ">
                            <strong>
                                <i class="ico"></i>
                                <input type="radio" name="singleClone1" value="" >
                            </strong>
                            <span><em class="aItemNum">B、</em><span class="aItemTxt">选项2</span></span>
                        </label>
                    </li>
                    <li>
                        <label class="m-radio-tick ">
                            <strong>
                                <i class="ico"></i>
                                <input type="radio" name="singleClone1" value="" >
                            </strong>
                            <span><em class="aItemNum">C、</em><span class="aItemTxt">选项3</span></span>
                        </label>
                    </li>
                </ol>
                <div class="t-opt">
                    <div class="nextAddNew">
                        <span class="lx">在此题后插入新题：</span>
                        <a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
                        <a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
                        <a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
                    </div>
                    <div class="btn-block">
                        <a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
                        <a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
                    </div>
                </div>
            </div>
        </li>
        <li class="topic-item question" data-type="multiple">
        	<input type="hidden" value="MULTIPLE_CHOICE" class="questionType">
			<input type="hidden" value="" class="questionId">
			<input type="hidden" value="" class="score"/>
			<input type="hidden" value="" class="correctFeedback"/>
			<input type="hidden" value="" class="incorrectFeedback"/>
            <div class="m-topic-module">
                <h3 class="title">
                    <span class="serial-number">3、</span>
                    <span class="topicTitle">请在此输入问题标题</span>
                </h3>
                <ol class="m-question-lst">
                    <li>
                        <label class="m-checkbox-tick ">
                            <strong class="on">
                                <i class="ico"></i>
                                <input type="checkbox" name="multipleClone1" checked="checked"  value="">
                            </strong>
                            <span><em class="aItemNum">A、</em><span class="aItemTxt">选项1</span></span>
                        </label>
                    </li>
                    <li>
                        <label class="m-checkbox-tick ">
                            <strong>
                                <i class="ico"></i>
                                <input type="checkbox" name="multipleClone1" value="" >
                            </strong>
                            <span><em class="aItemNum">B、</em><span class="aItemTxt">选项2</span></span>
                        </label>
                    </li>
                    <li>
                        <label class="m-checkbox-tick ">
                            <strong>
                                <i class="ico"></i>
                                <input type="checkbox" name="multipleClone1" checked="checked" value="" >
                            </strong>
                            <span><em class="aItemNum">C、</em><span class="aItemTxt">选项3</span></span>
                        </label>
                    </li>
                </ol>
                <div class="t-opt">
                    <div class="nextAddNew">
                        <span class="lx">在此题后插入新题：</span>
                        <a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
                        <a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
                        <a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
                    </div>
                    <div class="btn-block">
                        <a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
                        <a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
                    </div>
                </div>
            </div>
        </li>
        <li class="topic-item question" data-type="trueFalse">
        	<input type="hidden" value="TRUE_FALSE" class="questionType">
			<input type="hidden" value="" class="questionId">
			<input type="hidden" value="" class="score"/>
			<input type="hidden" value="" class="correctFeedback"/>
			<input type="hidden" value="" class="incorrectFeedback"/>
            <div class="m-topic-module">
                <h3 class="title">
                    <span class="serial-number">1、</span>
                    <span class="topicTitle">请在此输入问题标题</span>
                </h3>
                <ol class="m-question-lst">
                    <li>
                        <label class="m-radio-tick ">
                            <strong class="on">
                                <i class="ico"></i>
                                <input type="radio" name="trueFalseClone1" checked="checked"  value="">
                            </strong>
                            <span><em class="aItemNum">A、</em><span class="aItemTxt">正确</span></span>
                        </label>
                    </li>
                    <li>
                        <label class="m-radio-tick ">
                            <strong>
                                <i class="ico"></i>
                                <input type="radio" name="trueFalseClone1" value="">
                            </strong>
                            <span><em class="aItemNum">B、</em><span class="aItemTxt">错误</span></span>
                        </label>
                    </li>
                </ol>
                <div class="t-opt">
                    <div class="nextAddNew">
                        <span class="lx">在此题后插入新题：</span>
                        <a href="javascript:void(0);" class="u-addTopic-single">单选题</a>
                        <a href="javascript:void(0);" class="u-addTopic-multiple">多选题</a>
                        <a href="javascript:void(0);" class="u-addTopic-rw">是非题</a>
                    </div>
                    <div class="btn-block">
                        <a href="javascript:void(0);" class="btn alter"><i class="u-alter-ico"></i></a>
                        <a href="javascript:void(0);" class="btn delete"><i class="u-delete-ico"></i></a>
                    </div>
                </div>
            </div>
        </li>
        
         <li class="clone-item g-addtest" data-type="single" id="singleChoiceBox"> <!-- 单选题 -->  
            <div class="m-addTopic-module addtext-radio">
            <form>
			<input type="hidden" name="quesType" value="SINGLE_CHOICE">
			<input type="hidden" name="id" value="" class="questionId">
			<input type="hidden" name="questionFormKey" value="" class="questionFormKey">
                <ul class="g-addtext-radio-item">
                    <li class="crt">基本<i class="hov-shaow"></i></li>
                    <li>答案反馈<i class="hov-shaow"></i></li>
                </ul>
                <div class="t-opt">
                <!--      <a href="javascript:void(0);" class="btn see u-opt">
                        <i class="u-delete-ico"></i>
                        <span class="tip">预览</span>
                    </a>   -->             
                    <a onclick="saveQuestion(this)" href="javascript:void(0);" class="btn confirm u-opt"><i class="u-right-ico"></i><span class="tip">确定</span></a>
                    <a href="javascript:void(0);" class="btn delete u-opt"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                </div>
                <div class="pro-content">
                    <div class="pro-content-txt pro-content-txt01">
                        <div class="g-addtext-txt-box">
                            <div class="section">
                                <h3 class="title"><em>*</em>题目标题（单选题）</h3>
                                <div class="m-pbMod-ipt">
                                    <textarea name="title" class="u-textarea title-input required " placeholder="单选题标题"></textarea>
                                </div>
                            </div>
                            <div class="score-box">
                                <label class="addtext-score">                        
                                    <div class="m-addtext-score">
                                         <input type="number" name="score" placeholder="获得分数" class="m-addtext-score-in required"/>
                                         <span class="u-addtext-score u-addtext-score01"></span>
                                         <span class="u-addtext-score02 u-addtext-score"></span>
                                    </div>
                                    <p class="m-addtext-score-txt">分</p>
                                            
                                </label>
                            </div>
                            <div class="section">
                                <h3 class="title1">选项答案</h3>
                                <ul class="m-addtopicQ-lst">
                                    <li class="m-addTopic-q  choice">
                                        <div class="cl">
                                            <label class="m-radio-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="radio" name="correctOption" value="0" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="" name="interactionOption.text1" placeholder="选项1" class="u-pbIpt required" />
                                            </div>
                                        </div>
                                        <div class="cr">
                                            <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                                        </div>
                                    </li>
                                    <li class="m-addTopic-q  choice">
                                        <div class="cl">
                                            <label class="m-radio-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="radio" name="correctOption" value="1" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="" name="interactionOption.text2" placeholder="选项2" class="u-pbIpt required" />
                                            </div>
                                        </div>
                                        <div class="cr">
                                            <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                                        </div>
                                    </li>
                                    <li class="m-addTopic-q  choice">
                                        <div class="cl">
                                            <label class="m-radio-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="radio" name="correctOption" value="2" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="" name="interactionOption.text3" placeholder="选项3" class="u-pbIpt required" />
                                            </div>
                                        </div>
                                        <div class="cr">
                                            <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                                        </div>
                                    </li>
                                </ul>
                                <div class="m-addQs-btn g-addtextANs-btn">
                                    <a href="javascript:void(0);" class="add addQuestionButton m-addtextAns-btn">添加答案选项<i class="u-addtextAns"></i></a>
                                </div>
                            </div>
                            
                        </div>                                       
                    </div>                   
                    <div class="pro-content-txt"> <!-- begin problem answer feedback part -->
                        <div class="g-addtext-txt-box">
                            <ul class="g-addtextAns-fb-box">
                                <li class="r-ans-fb">
                                    <h4><i class="u-ans-ico"></i>回答正确的提示反馈</h4>
                                    <label class="g-ans-fb-tl">
                                        <span></span>
                                        <div class="m-ans-fb-desc">
                                                <textarea name="correctFeedback" class="m-ans-fb-desc-inp correctFeedback required" placeholder="请在此输入提示描述"></textarea>                   
                                        </div>                            
                                    </label>
                                </li>
                                <li class="r-ans-fb r-ans-fb02">
                                    <h4><i class="u-ans-ico u-ans-ico02"></i>回答错误的提示反馈</h4>
                                    <label class="g-ans-fb-tl">
                                        <span></span>
                                        <div class="m-ans-fb-desc">
                                                <textarea name="incorrectFeedback" class="m-ans-fb-desc-inp" placeholder="请在此输入提示描述"></textarea>                   
                                        </div>                            
                                    </label>
                                </li>                   
                            </ul>                             
                        </div>

                    </div>  <!-- end problem answer feedback part -->                      
                    <a onclick="saveQuestion(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>  
                    </form>                        
                </div>               
            </div>
        </li>
        
			
	
		<li class="clone-item g-addtest" data-type="multiple" id="multipleChoiceBox"> <!-- 多选题 -->   
            <div class="m-addTopic-module addtext-radio">
            	 <form>
				<input type="hidden" name="quesType" value="MULTIPLE_CHOICE">
				<input type="hidden" name="id" value="" class="questionId">
				<input type="hidden" name="questionFormKey" value="" class="questionFormKey">
                <ul class="g-addtext-radio-item">
                    <li class="crt">基本<i class="hov-shaow"></i></li>
                  <!-- <li>评分<i class="hov-shaow"></i></li>-->
                    <li>答案反馈<i class="hov-shaow"></i></li>
                </ul>            
                <div class="t-opt">
                   <!--   <a href="javascript:void(0);" class="btn see u-opt">
                        <i class="u-delete-ico"></i>
                        <span class="tip">预览</span>
                    </a>   -->             
                    <a onclick="saveQuestion(this)" href="javascript:void(0);" class="btn confirm u-opt"><i class="u-right-ico"></i><span class="tip">确定</span></a>
                    <a href="javascript:void(0);" class="btn delete u-opt"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                </div>
                <div class="pro-content">
                    <div class="pro-content-txt pro-content-txt01">
                        <div class="g-addtext-txt-box">
                            <div class="section">
                                <h3 class="title"><em>*</em>题目标题（多选题）</h3>
                                <div class="m-pbMod-ipt">
                                    <textarea name="title" class="u-textarea title-input required" placeholder="多选题标题"></textarea>
                                </div>
                            </div>
                            <div class="score-box">
                                <label class="addtext-score">                        
                                    <div class="m-addtext-score">
                                         <input type="number" placeholder="获得分数" name="score" class="m-addtext-score-in required"/>
                                         <span class="u-addtext-score u-addtext-score01"></span>
                                         <span class="u-addtext-score02 u-addtext-score"></span>
                                    </div>
                                    <p class="m-addtext-score-txt">分</p>
                                <!--    <p class="m-addtext-allscore">问题得分。要确定答案的具体分数，请选择“<span>评分</span>”！</p> -->                     
                                </label>
                            </div>                            
                            <div class="section">
                                <h3 class="title1">选项答案</h3>
                                <ul class="m-addtopicQ-lst">
                                    <li class="m-addTopic-q choice" >
                                        <div class="cl">
                                            <label class="m-checkbox-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="checkbox" name="correctOption" value="" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="" name="interactionOption.text1" placeholder="选项1" class="u-pbIpt required" />
                                            </div>
                                        </div>
                                        <div class="cr">
                                            <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                                        </div>
                                    </li>
                                    <li class="m-addTopic-q choice">
                                        <div class="cl">
                                            <label class="m-checkbox-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="checkbox" name="correctOption" value="" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="" name="interactionOption.text2" placeholder="选项2" class="u-pbIpt required" />
                                            </div>
                                        </div>
                                        <div class="cr">
                                            <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                                        </div>
                                    </li>
                                    <li class="m-addTopic-q choice">
                                        <div class="cl">
                                            <label class="m-checkbox-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="checkbox" name="correctOption" value="" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="" name="interactionOption.text3" placeholder="选项3" class="u-pbIpt required" />
                                            </div>
                                        </div>
                                        <div class="cr">
                                            <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                                        </div>
                                    </li>
                                </ul>
                                <div class="m-addQs-btn g-addtextANs-btn">
                                    <a href="javascript:void(0);" class="add addQuestionButton m-addtextAns-btn">添加答案选项<i class="u-addtextAns"></i></a>
                                </div>
                            </div>
                        </div>                       
                    </div>
                                       
                    <div class="pro-content-txt"> <!-- begin problem answer feedback part -->
                        <div class="g-addtext-txt-box">
                            <ul class="g-addtextAns-fb-box">
                                <li class="r-ans-fb">
                                    <h4><i class="u-ans-ico"></i>回答正确的提示反馈</h4>
                                    <label class="g-ans-fb-tl">
                                        <div class="m-ans-fb-desc">
                                                <textarea name="correctFeedback" class="m-ans-fb-desc-inp" placeholder="请在此输入提示描述"></textarea>                   
                                        </div>                            
                                    </label>
                                </li>
                                <li class="r-ans-fb r-ans-fb02">
                                    <h4><i class="u-ans-ico u-ans-ico02"></i>回答错误的提示反馈</h4>
                                    <label class="g-ans-fb-tl">
                                        <div class="m-ans-fb-desc">
                                                <textarea name="incorrectFeedback" class="m-ans-fb-desc-inp" placeholder="请在此输入提示描述"></textarea>                   
                                        </div>                            
                                    </label>
                                </li>                   
                            </ul>                             
                        </div>

                    </div>  <!-- end problem answer feedback part -->                      
                      <a onclick="saveQuestion(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>  
                    </form>          
                </div>
            </div>
        </li>
        
         <li class="clone-item g-addtest" data-type="trueFalse" id="trueFalseBox"> <!-- 单选题 -->  
            <div class="m-addTopic-module addtext-radio">
            <form>
			<input type="hidden" name="quesType" value="TRUE_FALSE">
			<input type="hidden" name="id" value="" class="questionId">
			<input type="hidden" name="questionFormKey" value="" class="questionFormKey">
                <ul class="g-addtext-radio-item">
                    <li class="crt">基本<i class="hov-shaow"></i></li>
                    <li>答案反馈<i class="hov-shaow"></i></li>
                </ul>
                <div class="t-opt">
               <!--     <a href="javascript:void(0);" class="btn see u-opt">
                        <i class="u-delete-ico"></i>
                        <span class="tip">预览</span>
                    </a>   -->             
                    <a onclick="saveQuestion(this)" href="javascript:void(0);" class="btn confirm u-opt"><i class="u-right-ico"></i><span class="tip">确定</span></a>
                    <a href="javascript:void(0);" class="btn delete u-opt"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
                </div>
                <div class="pro-content">
                    <div class="pro-content-txt pro-content-txt01">
                        <div class="g-addtext-txt-box">
                            <div class="section">
                                <h3 class="title"><em>*</em>题目标题（是非题）</h3>
                                <div class="m-pbMod-ipt">
                                    <textarea name="title" class="u-textarea title-input required" placeholder="是非题标题"></textarea>
                                </div>
                            </div>
                            <div class="score-box">
                                <label class="addtext-score">                        
                                    <div class="m-addtext-score">
                                         <input type="number" name="score" placeholder="获得分数" class="m-addtext-score-in required"/>
                                         <span class="u-addtext-score u-addtext-score01"></span>
                                         <span class="u-addtext-score02 u-addtext-score"></span>
                                    </div>
                                    <p class="m-addtext-score-txt">分</p>
                                            
                                </label>
                            </div>
                            <div class="section">
                                <h3 class="title1">选项答案</h3>
                                <ul class="m-addtopicQ-lst">
                                    <li class="m-addTopic-q  choice">
                                        <div class="cl">
                                            <label class="m-radio-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="radio" name="correctOption" value="0" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="正确" name="interactionOption.text1" class="u-pbIpt required" />
                                            </div>
                                        </div>
                                       
                                    </li>
                                    <li class="m-addTopic-q  choice">
                                        <div class="cl">
                                            <label class="m-radio-tick">
                                                <strong class="">
                                                    <i class="ico"></i>
                                                    <input type="radio" name="correctOption" value="1" class="answerInput">
                                                </strong>
                                            </label>
                                        </div>
                                        <div class="cc">
                                            <div class="m-pbMod-ipt">
                                                <input type="text" value="错误" name="interactionOption.text2"  class="u-pbIpt required" />
                                            </div>
                                        </div>

                                    </li>                                    
                                </ul>
                            </div>
                            
                        </div>                                       
                    </div>                   
                    <div class="pro-content-txt"> <!-- begin problem answer feedback part -->
                        <div class="g-addtext-txt-box">
                            <ul class="g-addtextAns-fb-box">
                                <li class="r-ans-fb">
                                    <h4><i class="u-ans-ico"></i>回答正确的提示反馈</h4>
                                    <label class="g-ans-fb-tl">
                                        <span>描述：</span>
                                        <div class="m-ans-fb-desc">
                                                <textarea name="correctFeedback" class="m-ans-fb-desc-inp correctFeedback" placeholder="请在此输入提示描述"></textarea>                   
                                        </div>                            
                                    </label>
                                </li>
                                <li class="r-ans-fb r-ans-fb02">
                                    <h4><i class="u-ans-ico u-ans-ico02"></i>回答错误的提示反馈</h4>
                                    <label class="g-ans-fb-tl">
                                        <span>描述：</span>
                                        <div class="m-ans-fb-desc">
                                                <textarea name="incorrectFeedback" class="m-ans-fb-desc-inp" placeholder="请在此输入提示描述"></textarea>                   
                                        </div>                            
                                    </label>
                                </li>                   
                            </ul>                             
                        </div>

                    </div>  <!-- end problem answer feedback part -->                      
                    <a onclick="saveQuestion(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>  
                    </form>                        
                </div>               
            </div>
        </li>
        
        <li class="clone-item" data-type="essayQuestion" id="importTextarea">
			<form action="${ctx}/make/test/${test.id!}/importQuestions" method="post">
				<input type="hidden" name="questionFormKey" value="" class="questionFormKey">
				<div class="m-addTopic-module">
					<div class="konw-point">
	                    <i class="u-little-icon"></i>
	                    <div class="button-alert" style="max-width: 400px;">
	                        <span class="alert-txt">
	                       		<p style="text-align: left">1. 题目标题最好以数字+顿号开头, 如:1、</p>
								<p style="text-align: left">2. 选项与选项之间不要空行</p>
								<p style="text-align: left">3. 题目类型以题目结尾的[题型]来区分, 如:[单选题]、[多选题]、[是非题]</p>
								<p style="text-align: left">4. 如果无法正确识别，请尝试在题目与题目之间加入空行</p>
								<p style="text-align: left">5. 必须有正确答案，多选题的多个答案用、分隔，如果格式错误该题目录入失败</p>
								<p style="text-align: left">6. 必须有分值，且必须大于0，如果格式错误该题目录入失败</p>
								<p style="text-align: left">7. 由于可能存在因格式等问题导致导入结果与预期有出入的情况，请在导入成功后进行检查</p>
	                        </span>
	                        <ins class="arrow"></ins>
	                        <div class="u-button" style="font-size: 12px;">我知道了</div>
	                    </div>                    
	                </div>
					<textarea name="questionsText" required class="u-textarea title-input" wrap="off" style="overflow:scroll;max-height:600px" rows="40">
您的年级是
2007级   
2006级 
2005级 
2004级
正确答案：1
分值：1

2、您的爱好是 [多选题]
读书
写作
弹琴
正确答案：1、2、3
分值：1

3、您是否支持该观点 [是非题]
是
否
正确答案：1
分值：1

					</textarea>
					<a onclick="importTestQuestions(this)" href="javascript:void(0);" class="confirm-line"><i class="u-right-ico"></i>完成</a>
				</div>
			</form>
		</li>
	</ul>
	<script>
		$(function(){
			konw_point()
		});
		
		function saveQuestion(a){
			//$(a).unbind('click');
			var form = $(a).closest('form');
			//初始化选项
			var choices = form.find('.choice');
			if(choices){
				$.each(choices,function(i,c){
					var correctOption =  $(c).find('input[type="radio"]');
					correctOption.val(i);
					var correctOptions =  $(c).find('input[type="checkbox"]');
					correctOptions.val(i);
				});
			}
			
			form.find('.questionFormKey').val("P1:S1:Q"+$(a).closest('li').prevAll().length);
		
			if(!form.validate().form()){
				return false;
			}
			if(form.find('.answerInput:checked').length == 0){
				alert('请选择答案');
				return false;
			}
			
			form.find('input[name^="interactionOption.text"]').attr('name', 'interactionOption.text');
			var questionId = form.find('.questionId').eq(0).val();
			var data = form.serialize();
			if(questionId){
				data = '_method=put'+'&'+data;
				$.ajax({
				type:'post',
				url:'${ctx}/make/question/'+questionId,
				data:data,
				success:function(response){
					$(a).attr('onclick','');
					addTestQuestionFn.confirm();
					$(a).click();
				}
				});
			}else{
				data = '_method=post'+'&'+data;
				$.ajax({
				type:'post',
				url:'${ctx}/make/test/${test.id!}/addQuestion',
				data:data,
				success:function(response){
					if(response!=null&&response.responseCode=='00'){
						alert("题目添加成功！");
						var questionId = form.find('.questionId').eq(0).val();
						$(a).attr('onclick','');
						var questionId = response.responseData.id;
						$(form).find('.questionId').val(questionId);
						addTestQuestionFn.confirm();
						$(a).click();
					}else{
						alert("题目添加失败！"+response.responseMsg);
					}
				}
				});
			}
		}
		
		function importTestQuestions(a){
			var form = $(a).closest('form');
			if(!form.validate().form()){
				return false;
			}
			form.find('.questionFormKey').val("P1:S1:Q"+$(a).closest('li').prevAll().length);
			$.ajax({
				type:'post',
				url:form.attr('action'),
				data:form.serialize(),
				success:function(response){
					if(response.responseCode == '00'){
						if(response.responseMsg == null || response.responseMsg == ''){
							alert('提交成功',function(){
								//关闭当前弹窗，
									mylayerFn.refresh({
										id: 'editActivityDiv',
							            content: '/make/activity/${(activity.id)!}/edit',
							            refreshFn: function(){
							            	$('.m-add-step li').eq(1).trigger('click');
							            	$('.m-add-step li:gt(1)').removeClass('yet');
							            }
							        });
							});
						}else{
							alert('部分导入成功<br/>'+response.responseMsg, null, 3000);
						}
					}else{
						alert(response.responseMsg, null, 3000);
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