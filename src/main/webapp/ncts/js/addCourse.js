$(function(){
    addCourseFn.init();
});


var addCourseFn = $(window).addCourseFn || {};

addCourseFn = {
    init: function(){
        
        this.addCourseBoxHeight();
    },
    //添加课程内容最小高度
    addCourseBoxHeight : function(){
        
        var $addCourseBox = $('.g-addCourse-cont'),
            windowHeight = $(window).height();

        $addCourseBox.css('min-height',windowHeight - 308 + 'px');
    },
    /*---
        高级设置开关 
        switchs:设置开关   
        settingBox:被控制盒子  
        defaultT:默认打开状态(true),如果设置默认关闭，则(false)
    ---*/
    settingSwitchFn : function(switchs,settingBox,defaultT){
        //设置开关
        var onOff = null;
        //判断是否传入默认打开或者关闭状态
        if(defaultT == "" || defaultT == 'undefined' || defaultT == null || defaultT == undefined){
            onOff = true;
        }else if(defaultT == false){
            onOff = false;
        }

        operationFn();
        //点击
        switchs.on('click',function(){
            operationFn();
        })
        //执行操作
        function operationFn(){
            //判断状态
            if(onOff){
                switchs.removeClass('z-crt');
                settingBox.hide();
                onOff = false;
            }else {
                switchs.addClass('z-crt');
                settingBox.show();
                onOff = true;
            }
        }
    },
    deleteDisabled : function(){
        //$(".chooseTickUnit:checked").parents(".chooseTickBox").find('.byChooseTick');
        $(".chooseTickUnit:checked").parents('.chooseTickItem').find('.byChooseTick a,.byChooseTick input,.byChooseTick button').removeClass('disabled').removeAttr('disabled');
        //修改选中项时设置元素的disabled
        /*$(document).on('click','.chooseTickUnit',function(){
            opreationFn($(this));
        });*/
        $('.chooseTickUnit').on('click',function(){
            opreationFn($(this));
        });

        function opreationFn(thisChooseTick){
            
            if(thisChooseTick.attr('checked','checked')){

                //找到需要清除disabled的元素
                var byChooseTick = thisChooseTick.parents(".chooseTickBox").find('.byChooseTick a, .byChooseTick input,.byChooseTick button');
                //给所有元素增加disabled
                byChooseTick.addClass('disabled').attr('disabled',true);
                //判断选中项
                //清除选中项下所有disabled
                thisChooseTick.parents('.chooseTickItem').find('.byChooseTick a,.byChooseTick input,.byChooseTick button').removeClass('disabled').removeAttr('disabled');
                //console.log(thisChooseTick.parents('.chooseTickItem').find('.byChooseTick').html());
            }

        }
    },
    //评论框效果
    commentOpt : function(commentBox){
        var commentBox = commentBox,
            commentTextarea = commentBox + " " + ".u-textarea",
            u_height = 76,//输入框展开后的输入框高度
            s_height = 22;//输入框收起后的输入框高度
        //获取焦点时展开输入框
        $(commentTextarea).on('focus',function(){
            var _ts = $(this),
                $part = _ts.parents(commentBox),
                $opa_row = $part.find(".m-cmtBtn-block"),
                $confirm_btn = $part.find(".u-cmtPublish-btn");
            //展开文本输入框
            _ts.stop().animate({
                height : u_height + 'px'
            },200,function(){
                $opa_row.show();
            });
            //点击其他地方，收缩文本输入框
            $(document).on("click",function(e){ 
                var target = $(e.target); 
                //event.stopPropagation();
                //判断输入框是否已经输入文字
                if(target.closest(commentBox).length == 0){ 
                    //console.log(1);
                    if(_ts.val()==""){
                        _ts.stop().animate({height : s_height + "px"},100,function(){
                            $opa_row.hide();
                        });
                    };
                }; 
            }); 
        });
    },
    //课程设置添加教师
    addPeople : function(){
        var bindParents = '#g-bd';
        var bindElment = '#addPeopleBtn';

        $(bindParents).on('click',bindElment,function(){
            var $this = $(this),
                $ipt = $this.prevAll('.u-pbIpt'),
                peopleName = $.trim($ipt.val()),
                $list = $this.parent().next();

            //判断是否为空
            if(peopleName == '' || peopleName == null || peopleName == undefined) {
                //输入为空，提示并获取焦点
                layer.msg('名字不能为空，请重新输入！', {icon: 7,time: 1500},function(){
                    $ipt.focus();
                }); 
            } else {
                //在列表中插入一个，情况输入框
                $list.append('<li><span>'+peopleName+'</span><a href="javascript:void(0);" class="delete">×</a></li>');
                $ipt.focus().val('');
            }
            
        });
        //执行删除
        deleteFn();

        //删除
        function deleteFn(){
            //点击删除
            $(bindParents).on('click','.m-addPeople-fn .list .delete',function(){
                $(this).parent().remove();
            })
        }
    },
    courseSettingFQA : function(){
        //是否可以添加
        var ifAdd = true,
            bindParents = '#g-bd',
            addFqaButton = '#addFqaBtn',
            faqList = '#faqList',
            faqIptRow = '#faqIptRow';

        //添加输入框块html
        var faqInputHtml = '<div class="ipt-row" id="faqIptRow">'+
                                '<div class="faq-q">'+
                                    '<span class="line"></span>'+
                                    '<i class="u-faqD-ico">问</i>'+
                                    '<div class="m-pbMod-ipt">'+
                                        '<input type="text" value="" placeholder="请输入问题" class="u-pbIpt questionInput">'+
                                    '</div>'+
                                '</div>'+
                                '<div class="faq-a">'+
                                    '<i class="u-faqU-ico">答</i>'+
                                    '<div class="m-pbMod-ipt">'+
                                        '<textarea name="" id="" placeholder="请输入问题的解答" class="u-textarea answerInput"></textarea>'+
                                    '</div>'+
                                    '<div class="btn-block">'+
                                        '<button type="button" class="btn u-inverse-btn u-opt-btn confirmBtn">确定</button>'+
                                        '<button type="button" class="btn u-inverse-btn u-opt-btn cancelBtn">取消</button>'+
                                    '</div>'+
                                '</div>'+    
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
                                        '<a href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>'+
                                        '<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>'+
                                    '</h3>'+
                                '</div>'+
                                '<div class="faq-a">'+
                                    '<i class="u-faqU-ico">答</i>'+
                                    '<p class="txt-a">'+
                                        '<span class="txt">服务器出错！</span>'+
                                        '<a href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>'+
                                        '<a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>'+
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

                var $this = $(this),
                    $textRow = $this.parents('.txt-row');
                    questionText = $textRow.find('.txt-q .txt').text(),
                    answerText = $textRow.find('.txt-a .txt').text();
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
                //取消修改
                cancelFn($faqIptRow,false);
                //确定修改
                confirmFn($faqIptRow,false);
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
        function confirmFn($faqIptRow,ifNew){
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
                        $faqIptRow.after(faqTextHtml);
                    }else {
                        $faqIptRow.next().show();
                    }
                    //
                    $faqIptRow.next().find('.txt-q .txt').html(questionText);
                    $faqIptRow.next().find('.txt-a .txt').html(answerText);
                    //恢复状态并添加
                    ifAdd = true;
                    $faqIptRow.remove();
                    $(addFqaButton).prop("disabled",false).removeClass('disabled');
                }
                
            });
        }

    },
    /*
        解决火狐浏览器在使用jquery拖拽时输入框不能获取焦点的问题
        bindParents: 用父级参数绑定
        input： 输入框
    */
    firefoxDrag : function(bindParents, input){
        //判断是否为firefox
        if(navigator.userAgent.indexOf("Firefox")>0){ 
            //console.log('firefox');
            //点击获取焦点 
            $(bindParents).on('click',input,function(){
                var val = $(this).val();
                //获取焦点和value值
                $(this).val('').focus().val(val);
            });
        }else {
            /*console.log('no firefox');*/
        }
    }
};