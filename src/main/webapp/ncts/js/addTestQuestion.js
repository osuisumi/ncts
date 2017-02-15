/*------ add topic function -------*/
var addTestQuestionFn = $(window).addTestQuestionFn || {};

addTestQuestionFn = {
    //默认最大父级
    includeParent : $('body'),
    //题目类型
    topicType : {
        single: "single",
        multiples: "multiple",
        trueFalse: "trueFalse",
        essayQuestion: "essayQuestion",
        blankQuestion: "blankQuestion"
    },

    /* 初始化 */
    init : function(iParent){

        var _this = this;
        //判断是否传入父级参数
        if(iParent == '' || iParent == undefined || iParent == 'undefined' || iParent == null){
        }else {
            //设置默认绑定父级
           _this.includeParent = iParent;
        }

        //列表最后添加新题
        _this.lastAdd();
        //题目后面添加新题
        _this.afterAdd();
        //修改题目
        _this.alter();
        //删除题目
        _this.deleteTopic();
        //题目顺序排序
        _this.arrange();

    },
    /* 列表最后添加新题 */
    lastAdd : function(){
        //设置第一次点击
        ifFirstClick = true;

        var $topicListBox = $("#topicListBox");
        //点击添加
        addTestQuestionFn.includeParent.on('click',".m-addTopic-opt a",function(){

            var $this = $(this),
                $optMod = $this.parents(".m-addTopic-opt");

            //禁用拖拽功能
            $("#topicListBox").sortable("disable");

            //判断是否第一次点击
            if(ifFirstClick){
                $optMod.addClass('isntFirst');
            }
            ifFirstClick = false;
            //执行添加函数
            addTestQuestionFn.addType($this,$topicListBox,'append');

        });
    },
    /* 题目后面添加新题 */
    afterAdd : function(){
        //点击添加
        this.includeParent.on('click','.m-topic-module .nextAddNew a',function(){

            var $this = $(this),
                t_parents = $(this).parents('.topic-item');
            //禁用拖拽功能
            $("#topicListBox").sortable("disable");

            //执行添加函数
            addTestQuestionFn.addType($(this),t_parents,'after');

        });


    },
    /* 
        判断即将添加题目的类型
        current : 当前操作元素，用于判断新添加题目的类型
    */
    addType : function(current,addBox,addType){

        //添加新题目按钮类型类名
        var addBtnType = {
            single:'u-addTopic-single',
            multiples:'u-addTopic-multiple',
            trueFalse: 'u-addTopic-rw',
            blankQuestion: 'u-addTopic-bl',
            importText: 'u-addTopic-import'
        }
        //设置操作类型为新添加
        var optType = 'new';
        //获取正在添加题目的编辑框
        var newAddItem = $("#topicListBox").children('.optState');
        //判断是否存在添加框
        if(newAddItem.length >= 1){
            //提示
//            var hasAdd = confirm('您有一道题目正在编辑中，是否保存正在编辑的题目？');
            //确定执行函数
//            if(hasAdd){
                newAddItem.remove();
            //取消执行函数
//            }else {
//                newAddItem.remove();
//            }
        }
        //判断类型是否为单选题
        if(current.hasClass(addBtnType.single)){
            //添加单选题
            addTestQuestionFn.add(addBox,addType,optType,'#singleChoiceBox');
        //判断类型是否为多选题
        }else if(current.hasClass(addBtnType.multiples)){
            //添加多选题
            addTestQuestionFn.add(addBox,addType,optType,'#multipleChoiceBox');
        //判断类型是否为是非题
        }else if(current.hasClass(addBtnType.trueFalse)){
            //添加是非题
            addTestQuestionFn.add(addBox,addType,optType,'#trueFalseBox');
        //判断类型是否为问答题
        }else if(current.hasClass(addBtnType.essayQuestion)){
            //添加问答题
            addTestQuestionFn.add(addBox,addType,optType,'#essayQuestionBox');
        }else if(current.hasClass(addBtnType.blankQuestion)){
            //添加填空题
            addTestQuestionFn.add(addBox,addType,optType,'#blankQuestionBox');
        }else if(current.hasClass(addBtnType.importText)){
        	addTopicFn.add(addBox,addType,optType,'#importTextarea');
        }
        //初始化模拟单选框多选框按钮样式
        $('.m-radio-tick input,.m-checkbox-tick input').bindCheckboxRadioSimulate();

    },
    /* 
        添加函数
        addBox  : 添加题目位置的元素，比如在最后添加还是在题目后面插入新的题目
        addType : 添加新题目的方法，append 或者 after
    */
    add : function(addBox,addType,optType,cloneId){
        //判断添加位置和添加方法
        if(addType == 'append'){
            //克隆添加到列表最后
            addBox.append($(cloneId).clone());
            //克隆后让添加框显示，删除特有id，添加正在操作状态
            addBox.children().last().show().prop('id','newAddTopicBox').attr('data-opt',optType).addClass('optState').find('.title-input').focus();

        }else if(addType == 'after'){
            //克隆添加到列表最后
            addBox.after($(cloneId).clone());
            //克隆后让添加框显示，删除特有id，添加正在操作状态
            addBox.next().show().prop('id','newAddTopicBox').addClass('optState').attr('data-opt',optType).find('.title-input').focus();
        }

        //启用题目答案列表拖拽
        $("#newAddTopicBox .m-addtopicQ-lst").sortable({
            placeholder: "ui-state-highlight",
            items: '.m-addTopic-q',
            opacity: 0.6,
            containment: "#newAddTopicBox",
            //停止排序时，修改答案列表占位符
            stop : function(){
                var $item = $("#newAddTopicBox .m-addTopic-q");
                var lengthNum = $item.length;
                for(var i = 0; i < lengthNum; i++){
                    $item.eq(i).find('.m-pbMod-ipt .u-pbIpt').prop('placeholder','选项'+ (i+1));
                    $item.eq(i).find('.m-pbMod-ipt .u-pbIpt-an').prop('placeholder','答案'+ (i+1));
                }
            }
        }).disableSelection();
        //解决火狐浏览器在使用jquery拖拽时输入框不能获取焦点的问题
        addCourseFn.firefoxDrag('#Test-questionnaireWrap','#newAddTopicBox .m-addTopic-q .m-pbMod-ipt .u-pbIpt');
        addCourseFn.firefoxDrag('.g-addTopic-wrap','.m-pbMod-ipt .u-textarea');
        addCourseFn.firefoxDrag('.g-addTopic-wrap','.m-ans-fb-desc .m-ans-fb-desc-inp');
        addCourseFn.firefoxDrag('.g-addTopic-wrap','.m-ans-fb-tl .m-ans-fb-tl-inp');

        
        //文本框限输入整数              
        /*$('#newAddTopicBox .minSizeNumber,#newAddTopicBox .maxSizeNumber').keydown(function (event) {  
            //console.log(window.event.keyCode);  
            var e = $(this).event || window.event;  
            var code = parseInt(e.keyCode);
            //只能输入整数
            if (code >= 96 && code <= 105 || code >= 48 && code <= 57 || code == 8) {  
                return true;  
            } else {
                return false;  
            }  
        });  */
        //执行取消
        addTestQuestionFn.cancel();
        //新增或修改框操作
        addTestQuestionFn.opreation();
        //完成添加
        
        //addTestQuestionFn.confirm();

    },
    /*  修改  */
    alter : function(){
        //点击修改
        this.includeParent.on('click','.m-topic-module .btn-block .alter',function(){

            //设置插入方式和操作类型为修改
            var addType = 'after',
                optType = 'alter';
            //获取元素
            var $this = $(this),
                $topicItem = $this.parents(".topic-item"),
                type = $topicItem.attr('data-type'),
                title = $topicItem.find('.topicTitle').text(),
                score = $topicItem.find('.score').val(),
                correctFeedback = $topicItem.find('.correctFeedback').val(),
                incorrectFeedback = $topicItem.find('.incorrectFeedback').val(),
                $answer_item = $topicItem.find('.m-question-lst').children();
                questionId = $topicItem.find('.questionId').val();
                
            //获取正在添加题目的编辑框
            var newAddItem = $("#topicListBox").children('.optState');
            //判断是否存在添加框
            if(newAddItem.length >= 1){
                //提示
                var hasAdd = confirm('您有一道题目正在编辑中，是否保存正在编辑的题目？');
                //确定执行函数
                if(hasAdd){
                    newAddItem.remove();
                //取消执行函数
                }else {
                    newAddItem.remove();
                }
            }
            //禁用拖拽功能
            $("#topicListBox").sortable("disable");
            //隐藏正在编辑的题目,需要其他在编辑的题目
            $topicItem.hide().siblings('.topic-item').show();
            //判断需要修改的类目类型
            if (type == addTestQuestionFn.topicType.single) {
                //单选题
                addTestQuestionFn.add($topicItem,addType,optType,'#singleChoiceBox');
                //设置修改框答案选项的个数
                settingItemNumber($answer_item);
                //设置修改框答案选项的文字
                settingItemText($answer_item);
            
                var correctOption =$topicItem.find('input:radio[name="correctOption"]:checked').val();
                $.each($("#newAddTopicBox").find("input:radio[name='correctOption']"),function(i,c){
                	if(i==correctOption){   
                		$(c).attr("checked","checked");
                	}
                	$(c).val(i);
                });

            }else if (type == addTestQuestionFn.topicType.multiples) {
                //多选题
                addTestQuestionFn.add($topicItem,addType,optType,'#multipleChoiceBox');
                //设置修改框答案选项的个数
                settingItemNumber($answer_item);
                //设置修改框答案选项的文字
                settingItemText($answer_item);
                
               

            }else if(type == addTestQuestionFn.topicType.trueFalse) {
                //是非题
                addTestQuestionFn.add($topicItem,addType,optType,'#trueFalseBox');
                //设置修改框答案选项的文字
                settingItemText($answer_item);

            }else if(type == addTestQuestionFn.topicType.essayQuestion) {
                //问答题
                addTestQuestionFn.add($topicItem,addType,optType,'#essayQuestionBox');                
                //设置问答题限制输入的数字
                settingsSizeNum($topicItem);
            }else if (type == addTestQuestionFn.topicType.blankQuestion) {
                //填空题
                addTestQuestionFn.add($topicItem,addType,optType,'#blankQuestionBox');
                //设置修改框答案选项的个数
                settingItemNumber($answer_item);
                //设置修改框答案选项的文字
                settingItemText($answer_item);

            };
            //初始化模拟单选框多选框按钮样式
            $('.m-radio-tick input,.m-checkbox-tick input').bindCheckboxRadioSimulate();
        
            //设置修改框标题
            $("#newAddTopicBox").find('.title-input').text(title);
            $("#newAddTopicBox").find('.m-addtext-score-in').val(score);
            $("#newAddTopicBox").find('.questionId').val(questionId);
            
            $("#newAddTopicBox").find("textarea[name='correctFeedback']").text(correctFeedback);
            $("#newAddTopicBox").find("textarea[name='incorrectFeedback']").text(incorrectFeedback);
            
           
            //完成修改
            //addTestQuestionFn.confirm();

        });
    
        //设置修改框答案选项的个数
        function settingItemNumber($answer_item){
            //获取修改框
            var $newAlterTopicBox = $("#newAddTopicBox"),
                $list = $newAlterTopicBox.find('.m-addtopicQ-lst'),
                $items = $list.children(),
                oItem_length = $answer_item.length,
                tItem_length = $items.length;

                //判断原有列表个数是否大于修改框默认个数
                if(oItem_length > tItem_length){
                    //增加修改框答案列表个数
                    for(var i = 0; i < oItem_length - tItem_length; i++){
                        //克隆选项
                        $list.append($list.children().last().clone());
                        //设置新选项的占位符
                        $list.children().eq(tItem_length + i).find('.m-pbMod-ipt .u-pbIpt').prop('placeholder' , '选项' + (tItem_length+i+1));
                        $list.children().eq(tItem_length + i).find('.m-pbMod-ipt .u-pbIpt-an').prop('placeholder' , '答案' + (tItem_length+i+1));
                    }

                //判断原有列表个数是否小于修改框默认个数
                }else if(oItem_length < tItem_length){
                    //减少修改框答案列表个数
                    $items.eq(oItem_length - 1).nextAll().remove();
                };
        };
        //设置修改框答案选项的文字
        function settingItemText($answer_item){

            var $items = $("#newAddTopicBox").find('.m-addtopicQ-lst').children();
            //设置
            $items.each(function(index){

                var $oTxts = $answer_item.eq(index).find('.aItemTxt').html(),
                    $oChoose = $answer_item.eq(index).find('label input');

                //同步文字
                $items.eq(index).find('.m-pbMod-ipt .u-pbIpt').val($oTxts);
                //判断原答案列表是否选中
                if($oChoose.prop('checked')){
                    //同步选中
                    $items.eq(index).find('label input').prop('checked',true);
                };
            });
        };
       

        //设置问答题限制输入的数字
        function settingsSizeNum($optBox){
            var $needOptBox = $("#newAddTopicBox");
            //获取原来的最小字数和最大字数
            var oMinSizeNum = $.trim($optBox.find('.minSizeNumber').text()),
                oMaxSizeNum = $.trim($optBox.find('.maxSizeNumber').text());
            //获取输入框需要修改的最小字数和最大字数
            var $oMinSize = $needOptBox.find('.minSizeNumber'),
                $oMaxSize = $needOptBox.find('.maxSizeNumber');
            //判断是否最小字数是否为不限制
            if(oMinSizeNum == '不限'){
                //不限制字数时，输入框为空看
                $oMinSize.val('');
            }else {
                //否则最小字数为获取到的数字
                $oMinSize.val(oMinSizeNum);
            }
            //判断最大字数是否为不限制
            if(oMaxSizeNum == '不限'){
                //不限制字数时，输入框为空看
                $oMaxSize.val('');
            }else {
                //否则最大字数为获取到的数字
                $oMaxSize.val(oMaxSizeNum);
            }

        }

    },
    /* 删除 */
    deleteTopic : function(){
        //点击删除按钮
        this.includeParent.on('click','.m-topic-module .btn-block .delete',function(){
            var $this = $(this),
            $topicItem = $this.parents('.topic-item');
            var questionId = $(this).closest('li').find('.questionId').eq(0).val();
            var testId=$("input#testId").val();
            var questionFormKey="P1:S1:Q"+$(this).closest('li').prevAll().length;
            //询问是否确定删除
            if(questionId){
	            confirm('您确定要删除此道题目吗',function(){
	            	$.post('make/test/'+testId+'/removeQuestion',{
	            		"_method":'DELETE',
	            		"questionFormKey":questionFormKey
	            	},function(response){
	            		if(response.responseCode == '00'){
			                $topicItem.remove();
			                //删除后执行排序
			                addTestQuestionFn.arrange();
	            		}else{
	            			alert('删除失败');
	            		}
	            	});
	            });
            }
        });
    },
    /* 取消操作 */
    cancel : function(){
        //点击取消按钮
        $("#topicListBox").on('click','.m-addTopic-module .t-opt .delete',function(){
            var $this = $(this),
                $newItem = $this.parents('.clone-item'),
                optType = $newItem.attr('data-opt');

            //判断操作类型是否为修改
            if(optType == 'alter'){
                //如果是编辑状态，取消编辑让正在编辑的题目显示
                $newItem.prev().show();
            };
            //删除操作框
            $newItem.remove();
            //启用拖拽功能
            $("#topicListBox").sortable("enable");
        });
    },
    /* 新添或者修改框操作 */
    opreation : function(){
        var addTopicBox = $(".m-addTopic-module");
        //添加答案选项
        addAnswer();
        //删除答案选项
        answerDelete();
        //添加答案选项
        function addAnswer(){
            //点击添加
            addTopicBox.on('click','.addQuestionButton',function(){
                //获取需要操作的元素
                var $this = $(this),
                $q_list = $this.parent().prevAll('.m-addtopicQ-lst'),
                $last_item = $q_list.children().last(),
                item_length = $q_list.children().length;
                //克隆新的一个选项
                $q_list.append($last_item.clone());
                //重新获取最后一个
                $new_last_item = $q_list.children().last();
                //重置单选框、多选框默认不选中
                $new_last_item.find('.m-checkbox-tick input').prop('checked',false);
                //重置输入框
                var item = $new_last_item.find('.m-pbMod-ipt .u-pbIpt');
                var name = item.attr('name').substring(0, item.attr('name').length - 1);
                $new_last_item.find('.m-pbMod-ipt .u-pbIpt').val('').prop('placeholder','选项'+(item_length+1)).attr('name',name+(item_length+1));
                $new_last_item.find('.m-pbMod-ipt .u-pbIpt-an').val('').prop('placeholder','答案'+(item_length+1));
                //初始化模拟单选框多选框按钮样式
                $('.m-radio-tick input,.m-checkbox-tick input').bindCheckboxRadioSimulate();
            });
        };
        //删除答案选项
        function answerDelete(){
            //点击删除
            addTopicBox.on('click','.m-addTopic-q .u-delete',function(){
                //获取当前需要删除的元素
                var $this = $(this),
                    $t_item = $this.parents('.m-addTopic-q'),
                    $item = $this.parents('.m-addtopicQ-lst').children(),
                    indexs = $item.index($t_item),
                    //获取列表长度
                    item_length = $item.length;
                //判断选项是否多于2个
                if(item_length > 2){
                    //重置此选项之后的选项输入框占位符数字
                    for(var i = indexs; i < item_length; i++){
                        $item.eq(i+1).find('.m-pbMod-ipt .u-pbIpt').prop('placeholder','选项'+(i+1));
                        $item.eq(i+1).find('.m-pbMod-ipt .u-pbIpt-an').prop('placeholder','答案'+(i+1));
                    };
                    //多于点击执行删除
                    $t_item.remove();
                }else {
                    //少于等于2个选项则提示不能删除
                    alert('选项列表不能少于2个');
                };

            });
        };
    },
    /* 完成 */
    confirm : function(){
        //点击完成执行
        $('#newAddTopicBox').off().on('click','.t-opt .confirm, .confirm-line',function(event){
            var $this = $(this),
                $optBox = $this.parents('#newAddTopicBox'),
                type = $optBox.attr('data-type'),
                titleTxt = $.trim($optBox.find('.title-input').val());
                questionId = $.trim($optBox.find('.questionId').val());
                correctFeedback = $.trim($optBox.find("textarea[name=correctFeedback]").val());
                incorrectFeedback = $.trim($optBox.find("textarea[name=incorrectFeedback]").val());
                score=$.trim($optBox.find("input[name=score]").val());
            //兼容firefox和IE对象属性
            e = event || window.event;
            e.stopPropagation();
            
            //设置不同题目的html
            var singleHtml,multipleHtml,trueFalseHtml,essayQuestionHtml,blankQuestionHtml;

            $("#cloneWrap").children('.topic-item').each(function(){

                var dataType = $(this).attr('data-type');
                //判断题目类型，克隆题目
                if(dataType == addTestQuestionFn.topicType.single) {
                    //克隆单选题
                    singleHtml = $(this).clone();
                    singleHtml.find('input').attr('name','single' + ($('.question[data-type="single"]').size()+1));
                }else if(dataType == addTestQuestionFn.topicType.multiples) {
                    //克隆多选题
                    multipleHtml = $(this).clone();
                }else if(dataType == addTestQuestionFn.topicType.trueFalse) {
                    //克隆是非题
                    trueFalseHtml = $(this).clone();
                }else if(dataType == addTestQuestionFn.topicType.essayQuestion) {
                    //克隆问答题
                    essayQuestionHtml = $(this).clone();
                }else if(dataType == addTestQuestionFn.topicType.blankQuestion) {
                    //克隆填空题
                    blankQuestionHtml = $(this).clone();
                };
            });
            

            if(titleTxt == ''){
                alert("标题不能为空");
            }else {
                //判断操作类型为新增or修改
                if($optBox.attr('data-opt') == 'new'){
                    //console.log('new');
                    //判断题目类型
                    if (type == addTestQuestionFn.topicType.single) {
                        //新增单选题
                        $optBox.before(singleHtml);
                    }else if (type == addTestQuestionFn.topicType.multiples) {
                        //新增多选题
                        $optBox.before(multipleHtml);
                    }else if(type == addTestQuestionFn.topicType.trueFalse) {
                        //新增是非题
                        $optBox.before(trueFalseHtml);
                    }else if(type == addTestQuestionFn.topicType.essayQuestion) {
                        //新增问答题
                        $optBox.before(essayQuestionHtml);
                    }else if (type == addTestQuestionFn.topicType.blankQuestion) {
                        //新增多选题
                        $optBox.before(blankQuestionHtml);
                    };
                    
                }else if($optBox.attr('data-opt') == 'alter') {
                    //console.log('alter');
                    //修改后显示需要修改的模块
                    $optBox.prev().show();
                };
                //设置标题
                $optBox.prev().find('.topicTitle').html(titleTxt);
                //设置反馈
                $optBox.prev().find('.correctFeedback').val(correctFeedback);
                $optBox.prev().find('.incorrectFeedback').val(incorrectFeedback);
                //设置分数
                $optBox.prev().find(".score").val(score);
                //设置questionId
                $optBox.prev().find(".questionId").val(questionId);
                //设置答案列表
                addTestQuestionFn.Confirm_fn($optBox);
                //删除操作框
                $optBox.remove();
                //添加后执行排序
                addTestQuestionFn.arrange();
                //启用拖拽功能
                $("#topicListBox").sortable("enable");
               
            };
        });

    },
    /* 点击确定是设置答案列表 */
    Confirm_fn : function($optBox){

        var $needOptBox = $optBox.prev();
            //设置答案选项长度
            settingLength();
            //同步答案列表文字或选中状态，进行排序
            settings();
            //设置问答题限制的最大字数和最小字数
            settingsSizeNum();
        
        //设置答案选项长度
        function settingLength(){
            var $oItem = $optBox.find('.m-addtopicQ-lst').children(),
                $nItem = $needOptBox.find('.m-question-lst').children();
            //获取长度
            var oItem_length = $oItem.length,
                nItem_length = $nItem.length;
            //判断个数
            if(oItem_length > nItem_length){
                //增加个数
                for(var i = 0; i < oItem_length - nItem_length; i++){
                    $nItem.last().before($nItem.last().clone());
                }
            }else if(oItem_length < nItem_length) {
                //减少个数
                $nItem.eq(oItem_length - 1).nextAll().remove();
            }
        };
        //同步答案列表文字或选中状态，进行排序
        function settings(){
            //z重新获取元素
            var $oItem = $optBox.find('.m-addtopicQ-lst').children(),
                $nItem = $needOptBox.find('.m-question-lst').children();
            //答案列表排序
            var itemArr = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
            //遍历执行
            
            $oItem.each(function(index){
                var $choose = $oItem.eq(index).find('label input');
                var $input = $oItem.eq(index).find('.m-pbMod-ipt .u-pbIpt');
               // console.log($input.val()+"=========");
                //重置默认选中状态
                $nItem.eq(index).find('label input').prop('checked',false);
                //判断是否选中
                if($choose.prop('checked') == true){
                    //增加选中状态
                    $nItem.eq(index).find('label input').prop('checked',true);
                }
                //判断输入框value是否为空
                if($.trim($input.val()) == ''){
                    //为空则取placeholder值
                    $nItem.eq(index).find('.aItemTxt').html($input.prop('placeholder'));
                }else {
                    //设置value值
                    $nItem.eq(index).find('.aItemTxt').html($input.val());
                }
                //执行排序
                $nItem.eq(index).find('.aItemNum').html(itemArr[index] + '、');

            });
            //初始化模拟单选框多选框按钮样式
            $('.m-radio-tick input,.m-checkbox-tick input').bindCheckboxRadioSimulate();            
        };
        //设置问答题限制输入的数字
        function settingsSizeNum(){
            //获取新设置的最大字数和最小字数
            var oMinSizeNum = $.trim($optBox.find('.minSizeNumber').val()),
                oMaxSizeNum = $.trim($optBox.find('.maxSizeNumber').val());
            //获取需要修改的元素
            var $oMinSize = $needOptBox.find('.minSizeNumber'),
                $oMaxSize = $needOptBox.find('.maxSizeNumber');

            //判断最小字数是否为空
            if(oMinSizeNum == ''){
                //为空则设置最小字数为不限
                $oMinSize.html('不限');
            }else {
                $oMinSize.html(oMinSizeNum);
            };
            //判断最大字数是否为空
            if(oMaxSizeNum == ''){
                //为空则设置最大字数为不限
                $oMaxSize.html('不限');
            }else {
                $oMaxSize.html(oMaxSizeNum);
            };

        };

    },
    //题目列表排序
    arrange : function(){
        //遍历排序
        addTestQuestionFn.includeParent.find('.g-topicList').children().each(function(index){

            var $this = $(this),
                $num = $this.find('.serial-number'),
                numIndex = index + 1;

            $num.html(numIndex + '、');

        });
    }
}



