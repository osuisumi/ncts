$(document).ready(function(){

	activityJs.fn.init();
})
//定义研修模块js
var activityJs = $(window).activityJs || {};

activityJs.fn = {
	init : function(){
		var _this = this;
		//添加标签
        _this.set_tag();
        //发布页高级选项
		_this.high_options();
		//自定义下拉框
        _this.drop_down_box();
        //倒计时
        _this.countDown();
         //展开评论回复框
        _this.commentOpa(".am-comment-box");
        _this.commentOpa(".am-isComment-box");
        //评论列表效果
        _this.commentShow();
	},
	/*-------添加标签-----------*/
    set_tag : function(){
        var $tag_parents = $(".am-add-tag");
        $tag_parents.each(function(){

            var _ts = $(this);
                $ipt_parents = _ts.find(".am-tagipt"),
                $ipt = $ipt_parents.find(".au-ipt"),
                $hint_lst = $ipt_parents.find(".l-slt-lst"),
                $add_btn = _ts.find(".au-add-tag"),
                $tag_lst = _ts.find(".am-tag-lst");

            //显示标签提示框  
            activityJs.fn.tag_hint_show($ipt,$hint_lst);  
            activityJs.fn.add_tag($ipt,$add_btn,$tag_lst);  
            activityJs.fn.delete_tag($tag_lst);  
        })
        
        
    },
    //显示标签提示框
    tag_hint_show : function($ipt,$hint_lst){
        //输入框获取焦点
        $ipt.on("focus",function(){
            if( !$(this).val()=="" ){

                $hint_lst.show();
                
            }

        })
        $ipt.on("keyup",function(){

            //判断输入文字是，提示框显示
            if( !$(this).val()=="" ){

                $hint_lst.show();

            }else {
                
                $hint_lst.hide();
            }
        })


        this.tag_hint_hide($ipt,$hint_lst);
    },
    //关闭标签提示框
    tag_hint_hide : function($ipt,$hint_lst){
        //获取
        $(document).on("click",function(e){
            var target = $(e.target); 
            //判断是否点击的是标签提示框和输入框，如果不是，隐藏标签提示框
            if(target.closest($hint_lst).length == 0 && target.closest($ipt).length == 0){ 

                $hint_lst.hide();
            }

        }); 
        //选择提示框选项关闭提示框
        $hint_lst.on("click","a",function(){

            $hint_lst.hide();
            $ipt.val($(this).text());
        })

    },
    //添加标签
    add_tag : function($ipt,$add_btn,$tag_lst){
        $add_btn.on("click",function(){
            var ss = false;
            var lengths = $tag_lst.children().length;
            //判断输入框是否为空
            if($ipt.val() != ""){
               //遍历标签列表
                for(var i = 0; i < lengths; i++){
                    //如果已有相同标签
                    if($ipt.val() == $tag_lst.children().eq(i).find(".txt").text()){
                        alert("已有相同标签");
                        $ipt.val('');
                        $ipt.focus();
                        ss = true;
                    }

                }
                //如果没有相同标签，添加新的标签
                if(!ss){
                    $tag_lst.append(
                        '<li>'+
                            '<span class="txt">'+$ipt.val()+'</span>'+
                            '<a href="javascript:void(0);" class="dlt" title="删除标签">×</a>'+
                        '</li>'
                    );
                    //添加标签后，清除输入框中的文字
                    $ipt.val("");
                }
            }
        })

    },
    //删除标签
    delete_tag : function($tag_lst){
        $tag_lst.on("click",".dlt",function(){
            $(this).parent().remove();
        })
    },
    //显示隐藏高级选项
    high_options : function(){
        var $high_options = $(".ag-high-options"),
            $high_option_btn = $high_options.find(".au-high-option"),
            $high_option_lst = $high_options.find(".ag-high-lst");

        $high_option_btn.on("click",function(){
            _ts = $(this);

            if(_ts.hasClass("z-crt")){

                _ts.removeClass("z-crt");
                $high_option_lst.hide();
            }else {

                _ts.addClass("z-crt");
                $high_option_lst.show();
            }
        })
    },

    /*--------自定义下拉框----------*/
    drop_down_box : function(){
    	var $dd_box = $(".am-slt-lst");

		$dd_box.each(function(){
			var _ts = $(this),
				$show_block = _ts.children(".show"),
				$show_txt = $show_block.children(".txt"),
				$lst = _ts.children(".lst"),
				$dd = $lst.children("a"),
				cur = "z-crt";

			//点击按钮选择选项
			$show_block.on("click",function(){
				//判断是否打开
				var $this = $(this);
				if($this.hasClass(cur)){

					$lst.hide();
					$this.removeClass(cur);
				}else {
					$lst.show();
					$this.addClass(cur);
				}

				//判断是否点击其他地方
	            $(document).on("click",function(e){ 
	                var target = $(e.target); 
	                if(target.closest(_ts).length == 0){ 
	                    $lst.hide();
						$show_block.removeClass(cur);
	                } 
	            }); 
	            //点击选项关闭
				_ts.on("click",".lst a",function(){
					$lst.hide();
					$show_block.removeClass(cur);
					$show_txt.text($(this).text());
					$(this).addClass(cur).siblings().removeClass(cur);
				})
			})			
		});
    },
    //倒计时
    countDown : function(){
        var $countDownBox = $(".am-count-down"),
            //$endTime = new Date($countDownBox.find(".endTime")),
            $endTime = $countDownBox.find(".endTime"),
            $day = $countDownBox.find(".day"),
            $hour = $countDownBox.find(".hour"),
            $minute = $countDownBox.find(".minute"),
            $second = $countDownBox.find(".second");
        var endTime = new Date($endTime.val()); //结束日期
        var nowTime = new Date(); //当前日期
        var leftTime = parseInt((endTime.getTime()-nowTime.getTime())/1000); //计算剩下的时间 parseInt()为javascript中的取整
        var leftDay = parseInt(leftTime/(24*60*60)); //计算剩下的天数
        var leftHours = parseInt(leftTime/(60*60)%24); //计算小时
        var leftMinutes = parseInt(leftTime/60%60); //计算分钟
        var leftSeconds =  parseInt(leftTime%60); //计算分钟
            
        $day.text(leftDay);//设置天
        $hour.text(leftHours);//设置小时
        $minute.text(leftMinutes);//设置分钟
        $second.text(leftSeconds);//设置秒
        //判断天数是否小于10
        if(leftDay < 10) {
            $day.text("0" + leftDay);
        }
        //判断小时是否小于10
        if(leftHours < 10) {
            $hour.text("0" + leftHours);
        }
        //判断分钟是否小于10
        if(leftMinutes < 10) {
            $minute.text("0" + leftMinutes);
        }
        //判断秒钟是否小于10
        if(leftSeconds < 10) {
            $second.text("0" + leftSeconds);
        }
        //判断是否到了结束时间
        if(leftTime < 1){
            clearTimeout(countDownTimer);
            $day.text("00");
            $hour.text("00");
            $minute.text("00");
            $second.text("00");
        }  
        var countDownTimer = setInterval(function(){
            var nowTime = new Date(); //当前日期
            var leftTime = parseInt((endTime.getTime()-nowTime.getTime())/1000); //计算剩下的时间 parseInt()为javascript中的取整
            var leftDay = parseInt(leftTime/(24*60*60)); //计算剩下的天数
            var leftHours = parseInt(leftTime/(60*60)%24); //计算小时
            var leftMinutes = parseInt(leftTime/60%60); //计算分钟
            var leftSeconds =  parseInt(leftTime%60); //计算分钟
            $day.text(leftDay);
            $hour.text(leftHours);
            $minute.text(leftMinutes);
            $second.text(leftSeconds);
            if(leftDay < 10) {
                $day.text("0" + leftDay);
            }
            if(leftHours < 10) {
                $hour.text("0" + leftHours);
            }
            if(leftMinutes < 10) {
                $minute.text("0" + leftMinutes);
            }
            if(leftSeconds < 10) {
                $second.text("0" + leftSeconds);
            }
            //判断是否到了结束时间
            if(leftTime < 1){
                clearTimeout(countDownTimer);
                $day.text("00");
                $hour.text("00");
                $minute.text("00");
                $second.text("00");
            } 
        },1000);
    },
    //评论框效果
    commentOpa : function(commentBox){
        var commentBox = commentBox,
            commentTextarea = commentBox + " " + ".au-textarea",
            u_height = 76,//输入框展开后的输入框高度
            s_height = 22;//输入框收起后的输入框高度
        //获取焦点时展开输入框
        $(commentTextarea).on('focus',function(){
            var _ts = $(this),
                $part = _ts.parents(commentBox),
                $placeholder = $part.find(".comment-placeholder"),
                $opa_row = $part.find(".am-cmtBtn-block"),
                $face_btn = $part.find(".au-face"),
                $confirm_btn = $part.find(".au-cmtPublish-btn");
            //隐藏占位符
            $placeholder.stop().animate({opacity : '0'},200,function(){
                $(this).hide();
            });
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
                        $placeholder.stop().animate({opacity : '1'},200,function(){
                            $(this).show();
                        });
                        _ts.stop().animate({height : s_height + "px"},100,function(){
                            $opa_row.hide();
                        });
                    };
                }; 
            }); 
        });
    },
    //评论列表效果
    commentShow : function(){
        var $comment_lst = $(".ag-cmt-lst-p"),
            $comment_block = $comment_lst.children("li"),
            $a_comment_ico = $comment_block.find(".au-comment"),
            $a_comment_mod = $comment_block.find(".ag-is-comment");
        //遍历评论列表，获取索引
        $comment_block.each(function(){
            var _ts = $(this),
                $comment_ico = _ts.find(".au-comment"),
                $is_comment_mod = _ts.find(".ag-is-comment"),
                t_height = $is_comment_mod.innerHeight();

            $comment_ico.on("click",function(){
                //判断是否打开评论列表
                var _this = $(this);
                if(_this.hasClass("z-crt")){
                    //关闭评论列表
                    _this.removeClass("z-crt");
                    $is_comment_mod.hide();

                }else {
                    //打开评论列表
                     $a_comment_mod.hide();
                     $a_comment_ico.removeClass("z-crt");
                     _this.addClass("z-crt");
                     $is_comment_mod.find(".au-comment-trg").css("left", Math.ceil(_this.position().left) - 25);
                     $is_comment_mod.show();
                     //activityJs.fn.commentOpa($(".am-isComment-box"));
                }
            })
        })
    },
    //弹出框
    aJumpLayer : function(layer){
        var layer = $(layer),
            width = layer.innerWidth(),
            height = layer.innerHeight();
        layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
        $('.ag-blackbg').show().css("opacity","0.5");

        /*clickBtn.bind('click',function(){
            layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
            $('.m-blackbg').show().css("opacity","0.5");

        })*/
        layer.find('.au-confirm-btn').bind('click',function(){
            layer.hide();
            $('.ag-blackbg').hide().css("opacity","1");
        })
        layer.find('.au-cancel-btn').bind('click',function(){
            layer.hide();
            $('.ag-blackbg').hide().css("opacity","1");
        })
        layer.find('.au-close-btn').bind('click',function(){
            layer.hide();
            $('.ag-blackbg').hide().css("opacity","1");
        })
    },
    //打开绝对定位弹出框
    openABlayer : function(abLayer){
        var $layersLayout = $(abLayer),
            $whiteBg = $(".ag-whitebg"),
            scrollTop = $(window).scrollTop();
        //打开弹出框
        $layersLayout.show().css('top',scrollTop + 100 + 'px');
        $whiteBg.show();
        //关闭弹出框
        this.closeABlayer($layersLayout,$whiteBg);

    },
    //关闭绝对定位弹出框
    closeABlayer : function($layersLayout,$whiteBg){
        var $colseBtn = $layersLayout.find(".au-closelayer-ico"),
            $cancelBtn = $layersLayout.find(".au-cancel-btm");
        $colseBtn.on("click",function(){
            $layersLayout.hide();
            $whiteBg.hide();
        });
        $cancelBtn.on("click",function(){
            $layersLayout.hide();
            $whiteBg.hide();
        });
    }
};




/*--start----多个同类名选项卡----start---*/
$.fn.extend({
    myTab : function(options)
    {
        var defaults = 
        {
            pars    : '.myTab',   //最外层父级
            tabNav  : '.tabNav',  //标签导航
            li      : 'li',       //标签
            tabCon  : '.tabCon',  //区域父级
            tabList : '.tabList', //t区域模块
            cur     : 'cur',      //选中类
            eType   : 'click',    //事件
            page    : 0 //默认显示第几个模块
        }
        var options = $.extend(defaults,options),
        _ts = $(this),
        tabBtn  = _ts.find(options.tabNav).find(options.li);
        tabList  = _ts.find(options.tabCon).find(options.tabList);
        this.each(function(){
            tabBtn.removeClass(options.cur);
            tabBtn.eq(options.page).addClass(options.cur);
            tabList.hide();
            tabList.eq(options.page).show();
            tabBtn.eq(options.page).show();
            tabBtn.on(options.eType,function(){
                var index = $(this).parents(options.tabNav).find(options.li).index(this);
                $(this).addClass(options.cur).siblings().removeClass(options.cur);
                $(this).parents(options.pars).find(options.tabCon).find(options.tabList).eq(index).css({'display':'block'}).siblings().css({'display':'none'});
            })
        })
        return this;
    }
})
/*--end-----多个同类名选项卡---end---*/