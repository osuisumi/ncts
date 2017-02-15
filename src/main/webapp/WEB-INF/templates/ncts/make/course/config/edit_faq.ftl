<#macro editFaqFtl course faqQuestions> 
	<div id="editFaqDiv" class="g-cSet-lst">
	    <div class="g-faq-box">
	        <ul class="g-faq-lst" id="faqList">
	        	<#list faqQuestions as faqQuestion>
					<li class="faq-item">
		                <div class="m-faq">
		                    <div class="txt-row">
		                        <div class="faq-q">
		                            <span class="line"></span>
		                            <i class="u-faqD-ico">问</i>
		                            <h3 class="txt-q">
		                                <span class="txt">${faqQuestion.content }</span>
		                                <a questionId="${faqQuestion.id }" href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
		                                <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
		                            </h3>
		                        </div>
		                        <#list faqQuestion.faqAnswers as faqAnswer>
			                        <div class="faq-a">
			                            <i class="u-faqU-ico">答</i>
			                            <p class="txt-a">
			                            	<input class="idHidden" type="hidden" name="faqAnswers[0].id" value="${faqAnswer.id }">
			                                <span class="txt">${faqAnswer.content }</span>
			                                <!-- <a href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
			                                <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a> -->
			                            </p>
			                        </div>    
								</#list>
		                    </div>
		                </div>
		            </li>
				</#list>
	        </ul>
	        <div class="btn-row">
	            <button class="btn u-inverse-btn u-opt-btn" id="addFqaBtn">+ 添加常见问题</button>
	        </div>
	    </div>

	</div>
	<script>
		$(function(){
		    courseSettingFQA();
		});
		
		function courseSettingFQA(){
	        //是否可以添加
	        var ifAdd = true,
	            bindParents = '#editFaqDiv',
	            addFqaButton = '#addFqaBtn',
	            faqList = '#faqList',
	            faqIptRow = '#faqIptRow';

	        //添加输入框块html
	        var faqInputHtml =  '<div class="ipt-row" id="faqIptRow">'+
		        					'<form id="saveFaqQuestionForm">'+
			        					'<input type="hidden" name="relation.id" value="${course.id!}">'+
			        					'<input type="hidden" name="relation.type" value="course_config">'+
		                                '<div class="faq-q">'+
		                                    '<span class="line"></span>'+
		                                    '<i class="u-faqD-ico">问</i>'+
		                                    '<div class="m-pbMod-ipt">'+
		                                        '<input type="text" name="content" value="" placeholder="请输入问题" class="u-pbIpt questionInput">'+
		                                    '</div>'+
		                                '</div>'+
		                                '<div class="faq-a">'+
		                                    '<i class="u-faqU-ico">答</i>'+
		                                    '<div class="m-pbMod-ipt">'+
		                                        '<textarea name="faqAnswers[0].content" id="" placeholder="请输入问题的解答" class="u-textarea answerInput"></textarea>'+
		                                    '</div>'+
		                                    '<div class="btn-block">'+
		                                        '<button type="button" class="btn u-inverse-btn u-opt-btn confirmBtn">确定</button>'+
		                                        '<button type="button" class="btn u-inverse-btn u-opt-btn cancelBtn">取消</button>'+
		                                    '</div>'+
		                                '</div>'+   
		                                '</form>'+
	                            '</div>';
	        //添加常见问题模块html
	        var faqModHtml = '<li class="faq-item"><div class="m-faq">'+faqInputHtml+'</div></li>';
	        //常见问题文字模块Html
	        var faqTextHtml = '<div class="txt-row">'+
	                                '<div class="faq-q">'+
	                                    '<span class="line"></span>'+
	                                    '<i class="u-faqD-ico">问</i>'+
	                                    '<h3 class="txt-q">'+
	                                        '<span class="txt">服务器出错！</span>'+
	                                        '<a href="javascript:void(0);" class="editBtn u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>'+
	                                        '<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>'+
	                                    '</h3>'+
	                                '</div>'+
	                                '<div class="faq-a">'+
	                                    '<i class="u-faqU-ico">答</i>'+
	                                    '<p class="txt-a">'+
	                                        '<span class="txt">服务器出错！</span>'+
	                                        /* '<a href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>'+
	                                        '<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>'+ */
	                                    '</p>'+
	                                '</div>'+
	                            '</div>';
	        
	        //执行添加常见问题函数
	        addFn();
	        //执行修改常见问题函数
	        alterFn();

	        //添加常见问题函数
	        function addFn(){
	            //点击
	            $(bindParents).on('click',addFqaButton,function(){

	                var $this = $(this);
	                //判断是否在添加状态
	                if(ifAdd){
	                    //每次只能添加一个
	                    ifAdd = false;
	                    //给添加按钮加上不可添加状态
	                    $this.prop("disabled",true).addClass('disabled');
	                    //判断是否已存在列表
	                    if($(faqList).length > 0){
	                        //console.log('存在常见问题列表');
	                    }else {
	                        //console.log('不存在常见问题列表');
	                        $this.parent().before('<ul class="g-faq-lst" id="faqList"></ul>');
	                    }
	                    //插入输入框
	                    $(faqList).append(faqModHtml);
	                    //定义输入框模块父级
	                    var $faqIptRow = $(faqIptRow);
	                    //让第一个输入框获取焦点
	                    $faqIptRow.find('.u-pbIpt').focus();

	                    //取消添加
	                    cancelFn($faqIptRow,true);
	                    //确定添加
	                    confirmFn($faqIptRow,true);
	                }   
	            });
	        };

	        //修改常见问题函数
	        function alterFn(){
	            $(bindParents).on('click','.m-faq .u-alter',function(){
	            	$(".ipt-row").remove();
	            	$(".txt-row").show();
	                var $this = $(this),
                    $textRow = $this.parents('.txt-row');
                    questionText = $textRow.find('.txt-q .txt').text(),
                    answerText = $textRow.find('.txt-a .txt').text();
                    answerIdHidden = $textRow.find('.idHidden');
	                //修改为不可添加状态
	                ifAdd = false;
	                //隐藏常见问题文字模块，插入修改输入框
	                $textRow.hide().before(faqInputHtml);
	                //给添加按钮加上不可添加状态
	                $(addFqaButton).prop("disabled",true).addClass('disabled');
	                //定义输入框模块父级
	                var $faqIptRow = $(faqIptRow);
	                //输入框获取焦点并获取需修改的文字
	                $faqIptRow.find('.questionInput').focus().val(questionText);
	                $faqIptRow.find('.answerInput').val(answerText);
	                $faqIptRow.find('form').append(answerIdHidden);
	                //取消修改
	                cancelFn($faqIptRow,false);
	                //确定修改
	                confirmFn($faqIptRow,false,this);
	            });
	        }

	        //取消添加和修改函数 ifNew(是否是新增), ture or false;
	        function cancelFn($faqIptRow,ifNew){
	            //定义：是否新添加
	            var ifAddNew;
	            if(ifNew == '' || ifNew == null || ifNew == undefined){
	                ifAddNew = false;
	            }else {
	                ifAddNew = ifNew;
	            }

	            //取消添加
	            $faqIptRow.on('click','.cancelBtn',function(){

	                //判断为新增 or 修改
	                if(ifAddNew){
	                    $(this).parents('.faq-item').remove();
	                }else {
	                    $faqIptRow.next().show();
	                    $faqIptRow.remove();
	                }
	                //恢复可添加状态
	                ifAdd = true;
	                $(addFqaButton).prop("disabled",false).removeClass('disabled');
	            });

	        }

	        //确定添加和修改函数 ifNew(是否是新增), ture or false;
	        function confirmFn($faqIptRow,ifNew,obj){
	            //定义：是否新添加
	            var ifAddNew;
	            if(ifNew == '' || ifNew == null || ifNew == undefined){
	                ifAddNew = false;
	            }else {
	                ifAddNew = ifNew;
	            }
	            //确定添加
	            $faqIptRow.on('click','.confirmBtn',function(){
	                var $questionInput = $faqIptRow.find(".questionInput"),
	                    $answerInput = $faqIptRow.find(".answerInput"),
	                    questionText = $.trim($questionInput.val()),
	                    answerText = $.trim($answerInput.val());
	                //判断问题是否为空
	                if(questionText == '' || questionText == null || questionText == undefined){
	                    layer.msg('问题不能为空，请重新输入！', {icon: 7,time: 1500},function(){
	                        $questionInput.focus();
	                    });
	                //判断回答是否为空看
	                }else if(answerText == '' || answerText == null || questionText == undefined){
	                    layer.msg('答案不能为空，请重新输入！', {icon: 7,time: 1500},function(){
	                        $answerInput.focus();
	                    });
	                }else {
	                    //判断为新增 or 修改
	                    if(ifAddNew){
	                    	$.post('${ctx}/${CSAIdObject.getCSAIdObject().cid}/make/faq_question', $('#saveFaqQuestionForm').serialize(), function(data){
	                    		if(data.responseCode == '00'){
	                    			$faqIptRow.after(faqTextHtml);
	                    			$faqIptRow.next().find('.editBtn').attr('questionId', data.responseData.id);
	                    			$faqIptRow.next().find('.txt-a').append('<input class="idHidden" type="hidden" name="faqAnswers[0].id" value="'+data.responseData.faqAnswers[0].id+'">');
	                    			$faqIptRow.next().find('.txt-q .txt').html(questionText);
	        	                    $faqIptRow.next().find('.txt-a .txt').html(answerText);
	        	                    //恢复状态并添加
	        	                    ifAdd = true;
	        	                    $faqIptRow.remove();
	        	                    $(addFqaButton).prop("disabled",false).removeClass('disabled');
	                    		}
	                    	});
	                    }else {
	                    	$.put('${ctx}/${CSAIdObject.getCSAIdObject().cid}/make/faq_question/'+$(obj).attr('questionId'), $('#saveFaqQuestionForm').serialize(), function(data){
	                    		if(data.responseCode == '00'){
	                    			$faqIptRow.next().show();
	        	                    $faqIptRow.next().find('.txt-a').append('<input class="idHidden" type="hidden" name="faqAnswers[0].id" value="'+data.responseData.faqAnswers[0].id+'">');
	                    			$faqIptRow.next().find('.txt-q .txt').html(questionText);
	        	                    $faqIptRow.next().find('.txt-a .txt').html(answerText);
	        	                    //恢复状态并添加
	        	                    ifAdd = true;
	        	                    $faqIptRow.remove();
	        	                    $(addFqaButton).prop("disabled",false).removeClass('disabled');
	                    		}
	                    	}); 
	                    }
	                }
	            });
	        }

			//执行删除函数
			deleteFn();
			//删除
			function deleteFn(){
	            $(bindParents).on('click','.m-faq .u-delete',function(){
	            	var $this = $(this);
	                $.ajaxDelete('${ctx}/${CSAIdObject.getCSAIdObject().cid}/make/faq_question/'+$(this).prev().attr('questionId'),'',function(data){
	                	if(data.responseCode == '00'){
	                		alert('删除成功');
	                		$this.closest('li').remove();
	                	}
	                });
	            });
	        };
	    } 
	</script>
</#macro>
