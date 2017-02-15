///<jscompress sourcefile="common.js" />
$(document).ready(function(){
    //公共模块js初始化
    commonJs.fn.init();
    //初始化占位符
    $("input,textarea").placeholder();
    //模拟下拉框
    $(".m-selectbox select").simulateSelectBox();
    //点选按钮模拟
    $('.m-radio-tick input').bindCheckboxRadioSimulate();
    //多选按钮模拟
    $('.m-checkbox-tick input').bindCheckboxRadioSimulate();
})
//定义公共模块js
var commonJs = $(window).commonJs || {};

commonJs.fn = {
    init : function(){
        var _this = this;
        //自定义下拉框
        //_this.simulateSelectBox();
        //返回顶部
        _this.toTop();
        //搜索框动态效果
        _this.searchAnimate();
    },
    //弹出框
    aJumpLayer : function(layer){
        var layer = $(layer),
            width = layer.innerWidth(),
            height = layer.innerHeight();
        layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
        $('.m-blackbg').show();

        /*clickBtn.bind('click',function(){
            layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
            $('.m-blackbg').show().css("opacity","0.5");

        })*/
        layer.find('.u-confirm-btn').bind('click',function(){
            layer.hide();
            $('.m-blackbg').hide();
        })
        layer.find('.u-cancel-btn').bind('click',function(){
            layer.hide();
            $('.m-blackbg').hide();
        })
        layer.find('.u-close-btn').bind('click',function(){
            layer.hide();
            $('.m-blackbg').hide();
        })
    },
    //打开绝对定位弹出框
    openABlayer : function(abLayer){
        var $layersLayout = $(abLayer),
            $whiteBg = $(".m-blackbg"),
            scrollTop = $(window).scrollTop();
        //打开弹出框
        $layersLayout.show().css('top',scrollTop + 100 + 'px');
        $whiteBg.show();
        //关闭弹出框
        this.closeABlayer($layersLayout,$whiteBg);

    },
    //关闭绝对定位弹出框
    closeABlayer : function($layersLayout,$whiteBg){
        var $colseBtn = $layersLayout.find(".u-close-btn"),
            $cancelBtn = $layersLayout.find(".u-cancel-btn"),
            $canfirmlBtn = $layersLayout.find(".u-confirm-btn");
        $colseBtn.on("click",function(){
            $layersLayout.hide();
            $whiteBg.hide();
        });
        $cancelBtn.on("click",function(){
            $layersLayout.hide();
            $whiteBg.hide();
        });
        $canfirmlBtn.on("click",function(){
            $layersLayout.hide();
            $whiteBg.hide();
        });
    },
    //返回顶部
    toTop : function(){
        //点击返回顶部
        $(document).on("click","#toTop",function(){
            $('html,body').animate({
                scrollTop: 0
            },100);
            return false;
        })
    },
    //搜索框动态效果
    searchAnimate : function(){
        //判断是否为IE浏览器，如果为IE浏览器，则使用jquery动画方式，反之采用css动画
        var navigatorName = "Microsoft Internet Explorer";  
        var isIE = false;   
        if( navigator.appName == navigatorName ){   
            isIE = true;   
            IE_fn();
        }else{   
            //alert("not ie"); 
            noIE_fn();  
        }   

        //IE浏览器使用jquery动画方式
        function IE_fn(){
            $(".m-srh .ipt").on('focus',function(){
                var $this = $(this),
                icon = $this.next();
                //如果value值为空，执行动画
                if($this.val() == ''){
                    $this.stop().animate({
                        'width' : 146 + 'px',
                        'padding-left' : 12 + 'px'
                    },500);
                    icon.stop().animate({
                        'right': 10 + 'px'
                    },500);
                }
            });
            //判断失去焦点时，用户是否输入文字
            $(".m-srh .ipt").on('blur',function(){
                var $this = $(this),
                    icon = $this.next();
                //如果value值为空，执行缩回动画，反之不执行
                if($this.val() == ''){
                    $this.stop().animate({
                        'width' : 60 + 'px',
                        'padding-left' : 98 + 'px'
                    },500);
                    icon.stop().animate({
                        'right': 100 + 'px'
                    },500);
                }
            });    
        };
        //非IE浏览器使用css3动画
        function noIE_fn(){
            $(".m-srh .ipt").on('blur',function(){
                var srhBox = $(this).parent();
                //如果value值为空，执行缩回动画，反之不执行
                if($(this).val() == ''){
                    srhBox.removeClass('hasValue');
                }else {
                    srhBox.addClass('hasValue');
                }
            });
        };
    },
    //课程指引提示 
    guideHint : function(guideHtml,nextGuideFn){
        /*
            guideHtml   : 指引提示html段，必有参数
            nextGuideFn : 存在下一步指引时，执行的方法
        */

        //默认没有下一步指引
        var nextGuide = false;
        //判断是否存在下一步指引
        if(nextGuideFn == "" || nextGuideFn == 'undefined' || nextGuideFn == null || nextGuideFn == undefined) {
        }else {
            nextGuide = true;
        }
        //插入指引html段
        $("body").append(guideHtml);

        //点击关闭
        $(".g-guide-hint .confirm").on('click',function(){
            var $this = $(this);
            //关闭指引
            $this.parents(".g-guide-hint").remove();
            $(".m-guideShade").remove();
            //如果存在下一步，执行下一步方法
            if(nextGuide){
                nextGuideFn();
            }
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
});
/*--end-----多个同类名选项卡---end---*/


/*--start-----下拉多选款select按钮模拟---start---*/
(function ($) {
    $.fn.simulateSelectBox = function (options) {
        var settings = {//默认参数
            selectText: '.simulateSelect-text',
            byValue: null
        };
        //$.extend(true, settings, options);
        var options = $.extend(true,settings,options),
            _ts = this,
            selectText = options.selectText, //下拉框模拟文字class
            byValue = options.byValue;  //传入value值，重置默认选中

        return _ts.each(function(){
            var $this = $(this);
            //清除其他选中
            $this.find('option').prop('selected',false);
            //判断是否传入value值
            if(byValue == "" || byValue == null || byValue == undefined){
                $this.find('option').eq(0).prop('selected',true);
            }else {
                //编辑选项，匹配传入的value值
                for(var i = 1; i < $this.find('option').length; i++){
                    if($this.find('option').eq(i).val() == byValue) {
                        //设置传入的value值选项为默认选中
                        $this.find('option').eq(i).prop('selected',true);
                    }
                }
            }
            //改变模拟下拉框的文字
            //$this.parent().find(selectText).text($this.find('option[selected="selected"]').text());
            $this.parent().find(selectText).text($this.find('option:selected').text());
        //点击下拉改变
        }).on('change',function(){
            //改变模拟下拉框的文字
            $(this).parent().find(selectText).text($(this).find('option:selected').text());
        });

    };
})(jQuery);
/*--end-----下拉多选款select按钮模拟---end---*/

/*--start-----radio单选与checkbox多选按钮的模拟---start---*/
(function ($) {
    $.fn.bindCheckboxRadioSimulate = function (options) {
        var settings = {
            className: 'on',
            onclick: null,
            checkbox_checked_fn: function (obj) {
                obj.parent().addClass(this.className);
            },
            checkbox_nochecked_fn: function (obj) {
                obj.parent().removeClass(this.className);
            },
            radio_checked_fn: function (obj) {
                obj.parent().addClass(this.className);
            },
            radio_nochecked_fn: function (obj) {
                obj.parent().removeClass(this.className);
            }
        };
        $.extend(true, settings, options);

        //input判断执行
        function inputJudge_fn(obj_this) {
           
            var $this = obj_this,
                $type;
            if ($this.attr('type') != undefined) {
                $type = $this.attr('type');
                if ($type == 'checkbox') {//if=多选按钮
                    if ($this.prop("checked")) {
                        settings.checkbox_checked_fn($this);
                    } else {
                        settings.checkbox_nochecked_fn($this);
                    }
                } else if ($type == 'radio') {//if=单选按钮
                    var $thisName;
                    if ($this.attr('name') != undefined) {
                        $thisName = $this.attr('name');
                        if ($this.prop("checked")) {
                            settings.radio_checked_fn($this);
                            $("input[name='" + $thisName + "']").not($this).each(function () {
                                settings.radio_nochecked_fn($(this));
                            });
                        } else {
                            settings.radio_nochecked_fn($this);
                        }
                    }
                }
            }
        }
        return this.each(function () {
            inputJudge_fn($(this));
        }).click(function () {
            inputJudge_fn($(this));
            if (settings.onclick) {
                settings.onclick(this, {
                    isChecked: $(this).prop("checked"),//返回是否选中
                    objThis: $(this)//返回自己
                });
            }
        });
    };
})(jQuery);
/*--end-----radio单选与checkbox多选按钮的模拟---end---*/

/*---start---------placeholder 占位符----------start--- */
; (function(f, h, $) {
    var a = 'placeholder' in h.createElement('input'),
    d = 'placeholder' in h.createElement('textarea'),
    i = $.fn,
    c = $.valHooks,
    k,
    j;
    if (a && d) {
        j = i.placeholder = function() {
            return this
        };
        j.input = j.textarea = true
    } else {
        j = i.placeholder = function() {
            var l = this;
            l.filter((a ? 'textarea': ':input') + '[placeholder]').not('.placeholder').bind({
                'focus.placeholder': b,
                'blur.placeholder': e
            }).data('placeholder-enabled', true).trigger('blur.placeholder');
            return l
        };
        j.input = a;
        j.textarea = d;
        k = {
            get: function(m) {
                var l = $(m);
                return l.data('placeholder-enabled') && l.hasClass('placeholder') ? '': m.value
            },
            set: function(m, n) {
                var l = $(m);
                if (!l.data('placeholder-enabled')) {
                    return m.value = n
                }
                if (n == '') {
                    m.value = n;
                    if (m != h.activeElement) {
                        e.call(m)
                    }
                } else {
                    if (l.hasClass('placeholder')) {
                        b.call(m, true, n) || (m.value = n)
                    } else {
                        m.value = n
                    }
                }
                return l
            }
        };
        a || (c.input = k);
        d || (c.textarea = k);
        $(function() {
            $(h).delegate('form', 'submit.placeholder', 
            function() {
                var l = $('.placeholder', this).each(b);
                setTimeout(function() {
                    l.each(e)
                },
                10)
            })
        });
        $(f).bind('beforeunload.placeholder', 
        function() {
            $('.placeholder').each(function() {
                this.value = ''
            })
        })
    }
    function g(m) {
        var l = {},
        n = /^jQuery\d+$/;
        $.each(m.attributes, 
        function(p, o) {
            if (o.specified && !n.test(o.name)) {
                l[o.name] = o.value
            }
        });
        return l
    }
    function b(m, n) {
        var l = this,
        o = $(l);
        if (l.value == o.attr('placeholder') && o.hasClass('placeholder')) {
            if (o.data('placeholder-password')) {
                o = o.hide().next().show().attr('id', o.removeAttr('id').data('placeholder-id'));
                if (m === true) {
                    return o[0].value = n
                }
                o.focus()
            } else {
                l.value = '';
                o.removeClass('placeholder');
                l == h.activeElement && l.select()
            }
        }
    }
    function e() {
        var q,
        l = this,
        p = $(l),
        m = p,
        o = this.id;
        if (l.value == '') {
            if (l.type == 'password') {
                if (!p.data('placeholder-textinput')) {
                    try {
                        q = p.clone().attr({
                            type: 'text'
                        })
                    } catch(n) {
                        q = $('<input>').attr($.extend(g(this), {
                            type: 'text'
                        }))
                    }
                    q.removeAttr('name').data({
                        'placeholder-password': true,
                        'placeholder-id': o
                    }).bind('focus.placeholder', b);
                    p.data({
                        'placeholder-textinput': q,
                        'placeholder-id': o
                    }).before(q)
                }
                p = p.removeAttr('id').hide().prev().attr('id', o).show()
            }
            p.addClass('placeholder');
            p[0].value = p.attr('placeholder')
        } else {
            p.removeClass('placeholder')
        }
    }
} (this, document, jQuery));
/*---end---------placeholder 占位符----------end--- */
///<jscompress sourcefile="sip-common.js" />
String.prototype.trim= function(){  
    return this.replace(/(^\s*)|(\s*$)/g, "");  
};
String.prototype.equalsIgnoreCase = function(str){
	return this.toLowerCase() == str.toLowerCase();
}
$.extend({
	ajaxQuery:function(formId,divId,callback,type){
		if(type == null || type == ''){
			type = 'get';
		}
		$.ajax({
			url:$("#"+formId).attr("action"),
			data:$("#"+formId).serialize(),
			type:type,
			success:function(data){
				$("#"+divId).html(data);
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback();
				}
			}
		});		
	},
	ajaxSubmit:function(formId){
		var data = $("#"+formId).serialize();
		var method = $("#"+formId).attr("method");
		if (method == 'delete' || method == 'DELETE' || method == 'put' || method == 'PUT') {
			data = '_method='+method+'&'+data;
		}
		var rData = $.ajax({
			url:$("#"+formId).attr("action"),
			data:data,
			type:'post',
			async:false,
			beforeSend:function(){
				ajaxLoading();
			},
			success:function(data){
				 
			},
			complete:function(){
				ajaxEnd();
			}
		}).responseText;
		return rData;
	},
	ajaxDelete:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=DELETE&'+data,
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			}
		});
	},
	put:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=PUT&'+data,
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			}
		});
	}
});

function ajaxLoading(){
    mylayerFn.loading({
        id: 999,
        content: '正在加载中...',
        shade: [0.4,"#ccc"]
    });
}

function ajaxEnd(){
	 mylayerFn.close(999);
}

function assignParam(formId,objectId){
	$.each($('#'+formId+' :input'),function(){
		$(this).val($('#'+$(this).attr('id')+'_'+objectId).text());
	});
}

function checkAllBox(formId, obj){
	$(obj).click(function(){
		if($(this).prop("checked")){
			$('#'+formId+' :checkbox').each(function(){
				$(this).prop("checked",true);			
			});
		}else{
			$('#'+formId+' :checkbox').each(function(){
				$(this).prop("checked",false);			
			});
		}
	});
}

//txt:鏂囨湰妗唈query瀵硅薄
//limit:闄愬埗鐨勫瓧鏁�
//isbyte:true:瑙唋imit涓哄瓧鑺傛暟锛沠alse:瑙唋imit涓哄瓧绗︽暟
//cb锛氬洖璋冨嚱鏁帮紝鍙傛暟涓哄彲杈撳叆鐨勫瓧鏁�
function initLimit(txt,limit,isbyte,cb){
	txt.keyup(function(){
		var str=txt.val();
		var charLen;
		var byteLen=0;
		if(isbyte){
			for(var i=0;i<str.length;i++){
				if(str.charCodeAt(i)>255){
					byteLen+=2;
				}else{
					byteLen++;
				}
			}
			charLen = Math.floor((limit-byteLen)/2);
		}else{
			byteLen=str.length;
			charLen=limit-byteLen;
		}
		cb(charLen);
	});	
}

function guid(){
	var guid = (G() + G() + "" + G() + "" + G() + "" + 
			G() + "" + G() + G() + G()).toUpperCase();
	return guid;
}
function G() {
	return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}

function hintJumpLayer(){
	$('.m-blackbg').show();
	var layer = $('.g-layer-warning');
	var width = layer.innerWidth(),
    height = layer.innerHeight();
    layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
}

/*window.msg = function(txt, confirmFn){
	layer.msg(txt, {time: 1500}, confirmFn);
};*/

window.alert = function(txt, confirmFn, time){
	//layer.alert(txt, confirmFn);
	if(time == null || time == ''){
		time = 1500;
	}
	mylayerFn.msg(txt, {time: time}, confirmFn);
};

window.confirm = function(txt, confirmFn, cancelFn){
	mylayerFn.confirm({
        content: txt,
        icon: 3,
        yesFn: confirmFn,
        cancelFn: cancelFn
    });
};

function getByteLength(value){
	var length = value.trim().length; 
    for(var i = 0; i < value.length; i++){      
        if(value.charCodeAt(i) > 127){      
        	length = length+2;      
        }      
    }
    return length;
}

function getSuffix(fileName){
	var index = fileName.lastIndexOf(".");
	return fileName.substring(index+1,fileName.length);
}

function getOuterHtml(obj) {
    var box = $('<div></div>');
    for (var i = 0; i < obj.length; i ++) {
        box.append($(obj[i]).clone());
    }
    return box.html();
}

function isMatchJson(data){
	if(data.match("^\{(.+:.+,*){1,}\}$")){
		return true;
	}else{
		return false;
	}
}
///<jscompress sourcefile="index.js" />
function closeLayer(){
	var index = parent.layer.getFrameIndex(window.name); 
	parent.layer.close(index); 
}

function downloadFile(id, fileName, type, relationId) {
	$('#downloadFileForm input[name="id"]').val(id);
	$('#downloadFileForm input[name="fileName"]').val(fileName);
	$('#downloadFileForm input[name="fileRelations[0].type"]').val(type);
	$('#downloadFileForm input[name="fileRelations[0].relation.id"]').val(relationId);
	//goLogin(function(){
		$('#downloadFileForm').submit();
	//});
}

function updateFile(id, fileName) {
	$('#updateFileForm input[name="id"]').val(id);
	$('#updateFileForm input[name="fileName"]').val(fileName);
	$.post('/file/updateFileInfo.do', $('#updateFileForm').serialize());
}

function deleteFileRelation(fileId, relationId, relationType) {
	$('#deleteFileRelationForm input[name="fileId"]').val(fileId);
	$('#deleteFileRelationForm input[name="relation.id"]').val(relationId);
	$('#deleteFileRelationForm input[name="type"]').val(relationType);
	$.post('/file/deleteFileRelation.do', $('#deleteFileRelationForm').serialize());
}

function deleteFileInfo(fileId) {
	$('#deleteFileInfoForm input[name="id"]').val(fileId);
	$.post('/file/deleteFileInfo.do', $('#deleteFileInfoForm').serialize());
}

function createCourseIndex(){
	window.location.href = '/make/course?orders=CREATE_TIME.DESC'
}

function goEditUser(userId){
	mylayerFn.open({
        type: 2,
        title: '个人资料',
        fix: false,
        area: [650, $(window).height()],
        content: '/ncts/users/'+userId+'/edit',
        shadeClose: true
    });
};

function goChangePassword(){
	mylayerFn.open({
        type: 2,
        title: '修改密码',
        fix: false,
        area: [620, 480],
        content: '/ncts/account/edit_password',
    });
}

function previewFile(fileId){
	mylayerFn.open({
		id: 'previewFileDiv',
        type: 2,
        title: '预览文件',
        fix: true,
        area: [$(window).width() * 99 / 100, $(window).height() * 99 / 100],
        content: '/file/previewFile?fileId='+fileId,
        shadeClose: true
    });
}

//搜索框动画
function showSearchBoxAnimate(){
    var $ipts = $(".showSearchBox .ipt");

    //获取焦点和失去焦点时执行动画
    $ipts.on({
        focus : function(){
            $(this).parent().addClass('in');
        },
        blur : function(){
            var $this = $(this);
            //判断输入是否为空，不为空则不执行收回动画
            /*if($.trim($this.val()) == ''){
            	
                $this.val('').parent().removeClass('in');
            }*/
        }
    });
}

//隐藏显示侧边
function LayerOpreationFn(btn,layers){
    //获取元素
    var $bindParent = $('#courseLearning'),
        $maskLayer = $('#studyFrameShade'),
        $layers = $(layers),
        $closeBtn = $layers.children('.closeStudyLayerBtn');
    //打开
    $bindParent.on('click',btn,function(){
        $maskLayer.show();
        $layers.addClass('open');
        //隐藏body滚动条
        $('html,body').css('overflow','hidden');
        //关闭
        $closeBtn.on('click',function(){
            $(this).parent().removeClass('open');
            $maskLayer.hide();
            $('html,body').css('overflow','visible');
        })
    });
}

//隐藏显示侧边 异步加载隐藏页面
function LayerOpreationFnAjax(btn,layers,url){
	$(btn).click(function(){
		$.get(url,null,function(response){
			var shadeHtml = $(response);
		    var $bindParent = $('#courseLearning'),
	        $maskLayer = $('#studyFrameShade'),
	        $layers = $(layers),
	        $closeBtn = shadeHtml.children('.closeStudyLayerBtn');
		    $layers.empty();
		    $layers.append(shadeHtml);
		    //打开
	        $maskLayer.show();
	        $layers.addClass('open');
	        //隐藏body滚动条
	        $('html,body').css('overflow','hidden');
	        //关闭
	        $closeBtn.on('click',function(){
	            $(this).closest('.open').removeClass('open');
	            $maskLayer.hide();
	            $('html,body').css('overflow','visible');
	        })
		});
	});
}

//侧边栏伸缩
function slide(){
    var btn = $("#lTr"),
        side = $(".g-study-sd"),
        side_w = side.outerWidth(),
        side_h = side.innerHeight(),
        chapCon = $(".m-study-box"),
        frame = $(".g-study-frame");
    btn.on("click",function(){
        side.toggleClass("hide");
        $(this).toggleClass("act");
        if(side.hasClass("hide")){
            side.stop().animate({
                width: 0,
                opacity: 0
            },400,function(){

                var Active_allw = $(".g-study-mn").innerWidth();
                var ppw = $(".m-study-opt").width();    //父级盒子不包括padding的宽度
                var ppw_inner = $(".m-study-opt").innerWidth();    //父级盒子包括padding的宽度
                var padding_w = ppw_inner-ppw;    //计算盒子的padding值
                $("#studySelectAct .list-box").width(Active_allw-padding_w);
                //课程学习选中活动
                studySelectAct.star(0);
            });
            frame.stop().animate({
                paddingLeft: 0
            },400);
            chapCon.addClass("act");
            side.height(side_h);
        }else{
            side.stop().animate({
                width:side_w - 1 +"px",
                opacity: 1
            },400,function(){

                var Active_allw = $(".g-study-mn").innerWidth();
                var ppw = $(".m-study-opt").width();    //父级盒子不包括padding的宽度
                var ppw_inner = $(".m-study-opt").innerWidth();    //父级盒子包括padding的宽度
                var padding_w = ppw_inner-ppw;    //计算盒子的padding值
                $("#studySelectAct .list-box").width(Active_allw-padding_w);
                //课程学习选中活动
                studySelectAct.star(0);
            });
            frame.stop().animate({
                paddingLeft: side_w
            },400);
            chapCon.removeClass("act");
            side.height(side_h);
        }
    });
}

//引导
function active_tip(cssPath, userId){
	if(userId != null && userId != ''){
		var flag = $.cookie('active_tip_new_'+userId);
		if(flag == 'Y'){
			var shade = $(".g-studyShade");
		    var tipindex = $(".active-tipindex");
		    var par = $("#g-animation");
		    tipindex.css({"display":"none"});
		    shade.css({"display":"none"}); 
		    par.stop(true,true).animate({
		        "right" : 0
		    },800,function(){
		        animation(cssPath);
		    });
		    return false;
		}else{
			$.cookie('active_tip_new_'+userId, 'Y', { expires: 30, path: '/' });
		}
	}
	var shade = $(".g-studyShade");
    var tipindex = $(".active-tipindex");
    var topH = $(".g-study-mn").offset().top;
    var topL = $(".g-study-mn").offset().left;

    //引导一
    shade.css({"display":"block"});
    $(".active-tipindex.step0").css({
            "display":"block",
            "top":topH + 19,
            "left":topL - 58
        });

    //引导二
    tipindex.find(".Abtn0").on("click",function(){
        tipindex.css({"display":"none"});
        $(".active-tipindex.step1").css({
            "display":"block",
            "top":topH,
            "left":topL+3
        });
    });

    //引导三
    tipindex.find(".Abtn1").on("click",function(){
        tipindex.css({"display":"none"});
        $(".active-tipindex.step2").css({
            "display":"block",
            "top":topH,
            "left":topL + 55
        });
    });

    //引导四
    tipindex.find(".Abtn2").on("click",function(){
        tipindex.css({"display":"none"});
        $(".active-tipindex.step3").css({
            "display":"block",
            "top":topH - 69,
            "left":topL + 530
        });
    });

    //引导五
    tipindex.find(".Abtn3").on("click",function(){
        tipindex.css({"display":"none"});
        $(".active-tipindex.step4").css({
            "display":"block",
            "top":topH + 2,
            "left":topL + 650
        });
    });

    //关闭引导
    tipindex.find(".Abtn4").one("click",function(event){
        var par = $("#g-animation");
        var offset = par.offset(); 
        var addcar = $(this); 
        var flyer = $('<img class="u-flyer" src="'+cssPath+'/css/images/animation1.gif">'); 
        flyer.fly({ 
            start: { 
                left: event.pageX, //开始位置（必填）#fly元素会被设置成position: fixed 
                top: event.pageY //开始位置（必填） 
            }, 
            end: { 
                left: offset.left+10, //结束位置（必填） 
                top: offset.top+10, //结束位置（必填） 
                width: 0, //结束时宽度 
                height: 0 //结束时高度 
            }, 
            onEnd: function(){ //结束回调 
                par.stop(true,true).animate({
                    "right" : 0
                },800,function(){
                    animation(cssPath);
                });
            } 
        });
    });

    tipindex.find(".Abtn4").on("click",function(event){
        tipindex.css({"display":"none"});
        shade.css({"display":"none"});         
    });
}

//小人动画
function animation(cssPath){
    var par = $("#g-animation"),
        tips = par.find(".tips"),
        img = par.find("img"),
        src1 = cssPath+"/css/images/animation1.gif",
        src2 = cssPath+"/css/images/animation2.gif",
        src3 = cssPath+"/css/images/animation3.gif";

    var timer = null;
    clearTimeout(timer);
    timer = setTimeout(function(){
        tips.animate({
            opacity : 1,
            bottom : "140px"
        },1000).delay(2000).animate({
            opacity : 0,
            bottom : "180px"
        },1000,function(){
            tips.css("bottom","80px");
        });
    },0);

    par.on("mouseover",function(){
        img.attr("src",src2);
        if(!(tips.is(":animated"))){
            tips.stop(true,true).animate({
                opacity : 1,
                bottom : "140px"
            },800);
        }
    }).on("mouseout",function(){
        img.attr("src",src3);
        tips.stop(true,true).css({
            opacity : 0,
            bottom : "80px"
        });
    });
}
///<jscompress sourcefile="tag.js" />
commonJs.tag = {
	/*-------添加标签-----------*/
	init : function(paramPrefix) {
		commonJs.tag.init_tag_param(paramPrefix);
		var $tag_parents = $(".m-add-tag");
		$tag_parents.each(function() {

			var _ts = $(this);
			$ipt_parents = _ts.find(".m-tagipt"), 
			$ipt = $ipt_parents.find(".u-pbIpt"), 
			$hint_lst = $ipt_parents.find(".l-slt-lst"), 
			$add_btn = _ts.find(".u-add-tag"), 
			$tag_lst = _ts.find(".m-tag-lst");

			// 显示标签提示框
			commonJs.tag.tag_hint_show($ipt, $add_btn, $hint_lst);
			commonJs.tag.add_tag($ipt, $add_btn, $tag_lst, paramPrefix);
			commonJs.tag.delete_tag($tag_lst, paramPrefix);
		})

	},
	// 显示标签提示框
	tag_hint_show : function($ipt, $add_btn, $hint_lst) {
		// 输入框获取焦点
		$ipt.on("focus", function() {
			if (!$(this).val() == "") {

				$hint_lst.show();

			}

		})
		$ipt.on("keyup", function() {

			// 判断输入文字是，提示框显示
			if (!$(this).val() == "") {
				$.get('/tags', 'tag.name=' + $(this).val(), function(data) {
					if (data != null) {
						var nameArray = data;
						if ($(nameArray).length > 0) {
							$hint_lst.find('.lst').empty();
							$(nameArray).each(function() {
								$hint_lst.find('.lst').append('<a href="###" id="' + this.id + '" title="' + this.name + '">' + this.name + '</a>');
							});
							$hint_lst.show();
						}
					}
				});
			} else {
				$hint_lst.hide();
			}
		})

		commonJs.tag.tag_hint_hide($ipt, $hint_lst);
	},
	// 关闭标签提示框
	tag_hint_hide : function($ipt, $hint_lst) {
		// 获取
		$(document).on("click", function(e) {
			var target = $(e.target);
			// 判断是否点击的是标签提示框和输入框，如果不是，隐藏标签提示框
			if (target.closest($hint_lst).length == 0 && target.closest($ipt).length == 0) {
				$hint_lst.hide();
				
			}

		});
		// 选择提示框选项关闭提示框
		$hint_lst.on("click", "a", function() {

			$hint_lst.hide();
			$ipt.val($(this).text());
			$add_btn.trigger('click');
		})

	},
	// 添加标签
	add_tag : function($ipt, $add_btn, $tag_lst, paramPrefix) {
		$add_btn.on("click", function() {
			var ss = false;
			var lengths = $tag_lst.children().length;
			// 判断输入框是否为空
			if ($ipt.val() != "") {
				// 遍历标签列表
				for (var i = 0; i < lengths; i++) {
					// 如果已有相同标签
					if ($ipt.val() == $tag_lst.children().eq(i).find(".txt").text()) {
						alert("已有相同标签");
						$ipt.val('');
						$ipt.focus();
						ss = true;
					}

				}
				// 如果没有相同标签，添加新的标签
				if (!ss) {
					var id = '';
					var name = '';
					var $match = $hint_lst.find('.lst').find('a[title="'+$ipt.val()+'"]');
					if($match.length == 0){
						$.ajax({
							url: '/tags',
							data: 'name='+$ipt.val(),
							type: 'post',
							async: false,
							success: function(data){
								if(data.responseCode == '00' ){
									var label = data.responseData;
									id = label.id;
									name = label.name;
								}	
							}
						});
					}else{
						id = $match.attr('id');
						name = $match.attr('title');
					}
					$tag_lst.append('<li class="tagLi" id="'+id+'" >' 
							+ '<span class="txt">' + name + '</span>' 
							+ '<a href="javascript:void(0);" class="dlt" title="删除标签">×</a>' 
						+ '</li>');
					// 添加标签后，清除输入框中的文字
					$ipt.val("");
					//更新参数
					commonJs.tag.init_tag_param(paramPrefix);
				}
			}
		})

	},
	// 删除标签
	delete_tag : function($tag_lst, paramPrefix) {
		$tag_lst.on("click", ".dlt", function() {
			$(this).parent().remove();
			commonJs.tag.init_tag_param(paramPrefix);
		})
	},
	init_tag_param: function(paramPrefix){
		var $form = $('#tagList').closest('form');
		$form.find('.tagParam').remove();
		$('#tagList').find('.tagLi').each(function(i) {
			var id = $(this).attr('id');
			$form.append('<input class="tagParam" name="'+paramPrefix+'tags[' + i + '].id" value="' + id + '" type="hidden"/>');	
		});
	}
}
///<jscompress sourcefile="courseLearning.js" />
$(function(){
    courseLearningFn.init();
});


var courseLearningFn = $(window).courseLearningFn || {};

courseLearningFn = {
    init: function(){
        this.courseCatalog('close');
    },
    /*---
        设置
        allSwitch:是否默认打开或者关闭 'open'为默认打开，'close'为默认关闭   
        tParents: 传入父级参数  
    ---*/
    courseCatalog : function(allSwitch,tParents){

        //设置开关
        var openT = null;
        var catalogItem = '.m-course-catalog';
        
        //判断是否传入默认全部打开或者全部关闭状态
        if(allSwitch == "" || allSwitch == 'undefined' || allSwitch == null || allSwitch == undefined){
            openT = true;
        }else if(allSwitch == 'open'){
            openT = true;
        }else if(allSwitch == 'close'){
            openT = false;
        }else if(allSwitch == 'first'){
            openT = 'first';
        }

        //判断是否传入父级元素
        if(tParents == "" || tParents == 'undefined' || tParents == null || tParents == undefined){
        }else {
            catalogItem = tParents + ' ' + catalogItem;
        }

        var catalogDt = ".m-course-catalog dt";
        var catalogDd = ".m-course-catalog dd";

        $(".g-course-catalog").each(function(index){
            var $this = $(this);
            if(openT == true){
                $this.find(catalogDt).addClass('z-crt');
                $this.find(catalogDd).show();
            //全部默认关闭状态
            }else if(openT == false){
                $this.find(catalogDt).removeClass('z-crt');
                $this.find(catalogDd).hide();
            }else if(openT == 'first'){
                $this.find(catalogDt).removeClass('z-crt');
                $this.find(catalogDd).hide();
                console.log($this.first().html());
                $this.children().first().find(catalogDt).addClass('z-crt');
                $this.children().first().find(catalogDd).show();
            }
        });

        //点击打开或者关闭
        $('.g-course-catalog').on('click','.m-course-catalog dt',function(event){
            var $this = $(this);
            //兼容firefox和IE对象属性
            e = event || window.event;
            e.stopPropagation();
            //判断是否在打开状态
            if($this.hasClass('z-crt')){
                //关闭
                $this.removeClass('z-crt').nextAll('dd').hide();
            }else {
                //打开
                $this.addClass('z-crt').nextAll('dd').show();
            }
            courseLearningFn.sideFixed();
        });
    },
    //章节列表显示隐藏
    sectionCatalog : function(){
        //获取元素
        var $bindParent = $('#g-bd'),
            button = '.showAllSectionBtn',
            $maskLayer = $(".m-sectionLayer-mask"),
            $layers = $('#studyCatalogLayer'),
            $closeOtherLayerBtn = $layers.siblings('.closeStudyLayerBtn');
        //点击操作
        $bindParent.unbind('click');
        $bindParent.on('click',button,function(event){
            var $this = $(this);

            e = event || window.event;
            e.stopPropagation();
            //关闭
            if($this.hasClass('in')){

                closeFn($maskLayer,$layers,$this);
                
            //打开
            }else {
                $maskLayer.show();
                $layers.addClass('open');
                $this.addClass('in');
                $closeOtherLayerBtn.hide();
            }
        });
        //点击关闭按钮时关闭
        $layers.on('click','.closeSectionLayerBtn',function(){
            closeFn($maskLayer,$layers,$(button));
        });
        //选择章节
        $layers.find('.m-course-catalog .tt-s').on('click',function(){
            $this = $(this);
            //清除其他选中
            $layers.find('.m-course-catalog .tt-s').removeClass('z-crt');
            //当前选中
            $this.addClass('z-crt');
            //选择后关闭弹出框
            closeFn($maskLayer,$layers,$(button));

            
            //选中章节，面包屑替换文字
            selectCatalogTxt($this,'.g-studyF-layer');
            selectCatalogTxt($this,'.g-cl-boxP');

        });
        //章节面包屑点击全部效果
        selectSectionOpt('.m-layer-crm .all');
        selectSectionOpt('.m-catalog-crm .all');

        //关闭函数
        function closeFn(maskLayer,layers,openBtn){
            maskLayer.hide();
            layers.removeClass('open');
            openBtn.removeClass('in');
            $closeOtherLayerBtn.show();
        };

        
        //选中章节，面包屑替换文字
        function selectCatalogTxt(sltRow,boxs){
            //章节面包屑操作
            sltRow.parents(boxs).find('.m-layer-crm span, .m-catalog-crm span').remove();
            sltRow.parents(boxs).find('.m-layer-crm .all, .m-catalog-crm .all').removeClass('z-crt');
            sltRow.parents(boxs).find('.m-layer-crm, .m-catalog-crm').append('<span class="line">&gt;</span><span class="txt">'+sltRow.find('.txt').text()+'</span>');
        }

        //章节面包屑点击全部效果
        function selectSectionOpt(el){
            $bindParent.on('click',el,function(){
                var $this = $(this);
                if($this.hasClass('z-crt')){

                }else {
                    $this.addClass('z-crt').nextAll().remove();
                }                
            });
        }
    },
    //答案输入框展开收缩
    shrinkInput : function(){
        
        $(".m-shrink-ipt .u-textarea").on({
            focus : function(){
                $(this).parents(".m-shrink-ipt").addClass('open');
            },
            blur : function(){
                $this = $(this);
                if($.trim($this.val()) == ''){
                    $this.val('').parents(".m-shrink-ipt").removeClass('open');
                }
            }
        })
    },
    sideFixed : function(){
        //获取dom
        var $frameBox = $('.g-study-frame'),
            $sideBox = $frameBox.children('.g-study-sd'),
            $mainBox = $frameBox.children(".g-study-mn"),
            $changeBox = $("#studySelectAct"); 
        //获取高度
        var winHeight = $(window).height(),
            sideHeight = $sideBox.innerHeight(),
            offsetTop = $sideBox.offset().top;

        //设置主栏高度不小于侧边栏高度
        $mainBox.css('min-height',sideHeight + 'px');

        //console.log(winHeight + '+' + sideHeight);
        //console.log($sideBox.offset().top);

        //判断窗口高度是否大于侧边栏高度
        if(winHeight > sideHeight){
            //执行窗口滚动
            $(window).scroll(function(){
                //获取滚动的高度
                var scrollTop = $(window).scrollTop();
                //获取滚到主内容后，已经滚动的高度
                var beyondTop = scrollTop - offsetTop;
                //判断是否滚动到主内容的高度
                if(scrollTop >= offsetTop){
                    //配合css，设置定位
                    $frameBox.addClass('outrange');
                    $sideBox.css('top',beyondTop + 'px');
                    $changeBox.css('top',beyondTop + 'px');
                //滚动条没到达主内容高度时，还原定位
                }else {
                    $frameBox.removeClass('outrange');
                    $sideBox.css('top',0);
                    $changeBox.css('top',0);
                }
            });
        //判断窗口高度是否小于侧边栏高度
        }else {
            var sideTop = offsetTop + sideHeight + 180 - winHeight;
            //获取滚动的高度
            $(window).scroll(function(){
                //获取滚动的高度
                var scrollTop = $(window).scrollTop();
                //获取滚到主内容后，已经滚动的高度
                var beyondTop = scrollTop - offsetTop;
                //判断是否滚动到主内容的高度
                if(scrollTop >= offsetTop){
                    //配合css，设置定位
                    $frameBox.addClass('outrange');
                    $changeBox.css('top',beyondTop + 'px');
                //滚动条没到达主内容高度时，还原定位
                }else {
                    $frameBox.removeClass('outrange');
                    $changeBox.css('top',0);
                }
                //判断是否超出侧边栏内容高度
                if(scrollTop > sideTop){
                    $sideBox.css('top',scrollTop -  sideTop + 'px');
                }else {
                    $sideBox.css('top',0);
                }
                
            });
        };

        

    }
};
///<jscompress sourcefile="activity-common.js" />
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
///<jscompress sourcefile="activity-file.js" />
$(document).ready(function(){

	activityFile.fn.init();
})
//定义研修模块js
var activityFile = $(window).activityFile || {};

activityFile.fn = {
    init : function(){
        var _this = this;
        //显示隐藏文件夹操作功能,注：可以传入参数
        _this.show_file_opa();
        //判断文件类型，注：只能判断当前页面的文件类型，如果后来添加，则需要重新执行这个方法
         _this.file_type();
        //备课增加文件夹,注：可以传入参数
        _this.prepare_add_folder("#activityLessonFile");
        //备课文件重命名,注：可以传入参数
        _this.prepare_file_rename();
    },
    //显示隐藏文件夹操作功能
    show_file_opa : function(documentParents){   

        var show_file_part = ".am-file-lst";
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
        }else {
            show_file_part = documentParents;
        }
        //鼠标移动到文件模块时
        $(show_file_part).on('mouseenter','.am-file-block',function(){
            var $block = $(this),
                $opa = $block.find(".f-opa"), //操作按钮行
                $info = $block.find(".f-info"); //信息行
            //如果正在重命名，则隐藏操作按钮行和信息行，否则隐藏信息行，隐藏操作按钮行
            if($block.find(".rename-box").length != 0){
                $opa.hide();
                $info.hide();
            }else {
                $(this).find(".f-opa").show();
                $(this).find(".f-info").hide();
            };   
        });
        //鼠标移出到文件模块时
        $(show_file_part).on('mouseleave','.am-file-block',function(){
            var $block = $(this),
                $opa = $block.find(".f-opa"), //操作按钮行
                $info = $block.find(".f-info"); //显示信息行
            //如果正在重命名，则隐藏操作按钮行和信息行，否则隐藏操作按钮行，隐藏信息行
            if($block.find(".rename-box").length != 0){
                $opa.hide();
                $info.hide();
            }else {
                $opa.hide();
                $info.show();
            };
        });
    },
    //判断文件类型
    file_type : function(){
        var $file_block = $('.am-file-block');
        $file_block.each(function(){
            var $this = $(this),
                $file_name = $this.find('.f-name'),
                $file_ico = $this.find(".file-view").children();
            //获取文件名和后缀名
            var names = $file_name.find("span").text(),
                strings = names.split("."),
                s_length = strings.length,
                suffix = strings[s_length -1];

            //判断是否有后缀名
            if(s_length == 1){
                //alert(1);
            }else {
                if(suffix == "doc" || suffix == "docx"){
                    $file_ico.removeClass().addClass("au-file-word");
                    //alert(1);
                }else if(suffix == "xls" || suffix == "xlsx"){
                    $file_ico.removeClass().addClass("au-file-excel");
                }else if(suffix == "ppt" || suffix == "pptx"){
                    $file_ico.removeClass().addClass("au-file-ppt");
                }else if(suffix == "pdf"){
                    $file_ico.removeClass().addClass("au-file-pdf");
                }else if(suffix == "txt"){
                    $file_ico.removeClass().addClass("au-file-txt");
                }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
                    $file_ico.removeClass().addClass("au-file-pic");
                }else if(
                    suffix == "mp3"  ||
                    suffix == "mp4"  ||
                    suffix == "avi"  ||
                    suffix == "rmvb" ||
                    suffix == "rm"   ||
                    suffix == "asf"  ||
                    suffix == "divx" ||
                    suffix == "mpg"  ||
                    suffix == "mpeg" ||
                    suffix == "mpe"  ||
                    suffix == "wmv"  ||
                    suffix == "mkv"  ||
                    suffix == "vob"  ||
                    suffix == "3gp"
                    ){
                    $file_ico.removeClass().addClass("au-file-video");
                }else {
                    $file_ico.removeClass().addClass("au-file-other");
                }
            }
        });
    },
    //备课增加文件夹
    prepare_add_folder : function(documentParents){
        var outerPart = document,  //绑定事件父级
            add_folder_btn = ".au-add-folder",  //添加文件夹按钮
            file_lst_part = ".am-file-lst",  //文件夹列表
            onoff = true;
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定   
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
            
        }else {
            outerPart = documentParents;
            file_lst_part = documentParents + ' ' + file_lst_part;
        };

        //点击创建文件夹按钮
        $(outerPart).on("click",add_folder_btn,function(){
            //判断是否正在创建文件夹
            if(onoff){
                onoff = false;
                $(file_lst_part).prepend(
                    '<li id="theNewFolder">'+
                        '<div class="am-file-block am-file-folder">'+
                            '<div class="file-view">'+
                                '<div class="au-folder"></div>'+
                            '</div>'+
                            '<div class="add-rename-box" style="display: block">'+
                                '<input type="text" value="" class="rename-ipt">'+
                                '<div>'+
                                    '<a href="javascript:void(0);" class="confirm">创建</a>'+
                                    '<a href="javascript:void(0);" class="cancel">取消</a>'+
                                '</div>'+
                            '</div>'+
                        '</div>'+
                    '</li>'
                );
                //设置新建的文件夹
                var $new_folder = $("#theNewFolder"),
                    $add_rename_box = $new_folder.find(".add-rename-box"),
                    $rename_ipt = $add_rename_box.find(".rename-ipt"),
                    $found_btn = $add_rename_box.find(".confirm"),
                    $cancel_btn = $add_rename_box.find(".cancel");
                //输入框获取焦点和默认文件夹名字
                $rename_ipt.focus().val("新建文件夹");
                //取消创建文件夹
                $cancel_btn.on("click",function(){
                    $new_folder.remove();
                    onoff = true;
                });
                //创建文件夹
                $found_btn.on("click",function(){
                    //判断文件夹名字是否为空
                    if($rename_ipt.val() == ""){
                        alert("文件夹名字不能为空");
                        $rename_ipt.focus();
                    }else {
                        onoff = true;
                        var $add_rename_box = $(this).parents(".add-rename-box");
                        $add_rename_box.before(
                            '<b class="f-name"><span>'+$rename_ipt.val()+'</span><em>(0)</em></b>'+
                            '<div class="f-opa">'+
                                '<a href="javascript:void(0);" class="open">打开</a>'+
                                '<a href="javascript:void(0);" class="download">下载</a>'+
                                '<a href="javascript:void(0);" class="rename">重命名</a>'+
                                '<a href="javascript:void(0);" class="delete">删除</a>'+
                            '</div>'
                        );
                        $add_rename_box.prevAll(".f-opa").show();
                        $add_rename_box.remove();
                        $new_folder.attr('id','');
                        //执行文件夹显示操作方法
                        //activityFile.fn.show_file_opa();    
                    };

                });
            };
        });
       
    },
    //备课文件重命名
    prepare_file_rename : function(documentParents){

        var $rename_button = '.am-file-block .rename';
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
            
        }else {
            $rename_button = documentParents + ' ' + $rename_button;
        }
        //alert(documentParents);
        var renameHtml = '<div class="rename-box">'+
                            '<input type="text" class="rename-ipt">'+
                            '<div>'+
                                '<a href="javascript:void(0);" class="confirm">确定</a>'+
                                '<a href="javascript:void(0);" class="cancel">取消</a>'+
                            '</div>'+
                        '</div>';
        $(document).off('click',$rename_button).on('click',$rename_button,function(){
            var $this = $(this),
                $part = $this.parents('.am-file-block'),  //文件模块
                $siblings_part = $part.parents(".am-file-lst").find(".am-file-block"),
                $file_name = $part.find(".f-name"), //文件名字
                $file_info = $part.find(".f-info"), //文件信息块
                $file_opa = $this.parent(); //操作模块

            //获取后缀名
            var names = $file_name.find("span").text(),
                strings = names.split("."),
                //c = /\.[^\.]+$/.exec(files);
                s_length = strings.length,
                suffix = strings[s_length -1];


            //点击时删除其他所有重命名框
            $siblings_part.find(".rename-box").remove();
            $siblings_part.find(".f-name").show();
            $file_name.hide();
            $file_opa.hide().after(renameHtml); //插入重命名框

            //设置重命名框
            var $rename_box = $part.find(".rename-box"), //重命名模块
                $rename_ipt = $part.find(".rename-ipt"), //重命名输入框
                $rename_confirm = $part.find(".confirm"), //确定按钮
                $rename_cancel = $part.find(".cancel"); //取消按钮
            //重命名框获取文件名
            $rename_ipt.val(names.split(".")[0]).focus();

            //确定保存名字
            $rename_confirm.off().on("click",function(){
                if($rename_ipt.val() == ""){
                    alert("文件名不能为空");
                    $rename_ipt.focus();
                }else {
                    $file_name.show().children("span").text($rename_ipt.val());
                    if(strings.length == 1){
                       $file_name.show().children("span").text($rename_ipt.val());
                    }else {
                        $file_name.show().children("span").text($rename_ipt.val() + "." + suffix);
                    }
                    $file_opa.show();
                    $rename_box.remove();
                }
            })
            //取消重命名
            $rename_cancel.off().on("click",function(){
                $file_name.show();
                $file_opa.show();
                $rename_box.remove();

            })
            //失去焦点时，
            /*$rename_ipt.on("blur",function(){
                $rename_box.hide();
                $file_name.show().children("span").text($rename_ipt.val());
                $file_opa.show();
            })*/

        });

    }

};



///<jscompress sourcefile="evaluateStar.js" />
/*
----------------
use：star evaluate
edition：v.10
----------------
*/
;(function($){
    //插件名
    var pluginName = "evaluateStar";
    //默认配置项
    var defaults = {
        starName : '.star', //每个星星的选择器
        inClassName : 'z-in', //鼠标移动上去添加的类名
        crtClassName : 'z-crt' //鼠标点击添加的类名
    };
    //插件类
    function Plugin(element,options){
        //拿到dom元素，获得对应jq对象，要$(element)
        this.element = element;
        //拿到dom元素，获得对应jq对象，要$(element)
        this.options = $.extend({},defaults,options);
        //缓存配置项
        this._defaults = defaults;
        //缓存插件名字
        this._name = pluginName;
        //调用初始函数
        this.init();
    };
    //初始化
    Plugin.prototype.init = function(){
        //缓存本插件常用属性
        var _this = this;
        var $element = $(this.element),
            starName = this.options.starName,
            inClassName = this.options.inClassName,
            crtClassName = this.options.crtClassName;

        //执行事件
        $element.find(starName).on({
            mouseenter : function(){
                //获取
                var $this = $(this);
                var $star = $this.parent().children(starName);
                var indexs = $star.index($this);
                //鼠标移动上去点亮星星
                _this.addStar($star,indexs,inClassName);
            },
            click : function(){
                var $this = $(this);
                var $star = $this.parent().children(starName);
                var indexs = $star.index($this);
                //鼠标点击点亮星星
                _this.addStar($star,indexs,crtClassName);
                
                //修改总分
                var totalStar = $('.starBtn').length;
    			var lightStar = $('.starBtn.z-crt').length;
    			var maxScore = parseFloat($('#maxScore').text());
    			$('#totalScore').text((lightStar / totalStar * maxScore).toFixed(1));
            }
        });
        //鼠标移除清除星星
        $element.on('mouseleave',function(){
            var $this = $(this);
                $star = $this.find(starName);
            //清除
            $star.removeClass(inClassName);
        });
    };
    //添加清除星星函数
    Plugin.prototype.addStar = function(star,indexs,className){
        //清除
        star.removeClass(className);
        //点亮星星
        for(var i = 0; i <= indexs; i++){
            star.eq(i).addClass(className);
        };
    };

    $.fn[pluginName] = function(options){
        //each表示对多个元素调用，用return 是为了返回this，进行链式调用
        return this.each(function(){
            //判断有没有插件名字
            if(!$.data(this,'plugin_'+pluginName)){
                //生成插件类实例
                $.data(this,'plugin_'+pluginName,new Plugin(this,options));
            };
        });
    };

})(jQuery);
///<jscompress sourcefile="photoChange.js" />

var studySelectAct = $(window).studySelectAct || {};
//学习活动选择
studySelectAct = {

    star : function(indexs){

        var sltIndex = 0;
        var $optBox = $("#studySelectAct");

        //获取焦点列表
        var $indexBox = $optBox.children('.dd-box'),
            $indexItem = $indexBox.find('.t-list li');
        //获取活动列表
        var $actList = $optBox.find('.m-studyAct-lst'),
            $actItem = $actList.children();
        //获取做右切换那妞
        var $next = $optBox.find('.opt-box .next'),
            $prev = $optBox.find('.opt-box .prev');
        //获取长度
        var lengths = $actItem.length;
        //获取单个宽度
        var itemWidth = $actItem.first().innerWidth();


        //获取父级盒子宽度的一半

        var parent_allw = $actList.parent(".list-box").innerWidth();
        // alert(parent_allw)
        var parent_w = $actList.parent(".list-box").innerWidth()/2;
        $actList.parent(".list-box").width(parent_allw)




        //判断是否传入默认选中第几个
        if(indexs == '' || indexs == undefined || indexs == 'undefined' || indexs == null){
            //没传入index，默认第一个高亮
            $indexItem.first().addClass('z-crt');
            $actItem.first().addClass('z-crt');
        } else {
            //根据传入的index，高亮第index选项
            $indexItem.eq(indexs).addClass('z-crt');
            $actItem.eq(indexs).addClass('z-crt');
            //如果传入的index小于3，则滚动的索引等于0
            if(indexs < 3){
                sltIndex = 0;
            }else {
                sltIndex = indexs - 2;
            }
        }

        //判断个数，等于1时
        if(lengths == 1){
            $actList.css('width','auto');
            $actItem.addClass('onlyone');
            $actItem.find('.u-finish-con').addClass('Left-fin');
        }else if(lengths == 2){
            $actItem.css('width',parent_w + 'px');
            $actItem.addClass('onlytwo');   
            $actItem.find('.u-finish-con').addClass('Left-fin2');         
        }else {
            //重新设计单个活动宽度
            itemWidth = parent_allw/3;
            // alert(itemWidth)
            $actItem.width(itemWidth);
            //设置活动列表宽度
            $actList.css('width', lengths * itemWidth + 'px');
            //执行滚动函数
            actListAnimate();
        }
        
        //默认执行
        //crtState(sltIndex);
        cutDisabled(sltIndex);
        focusSlt();
        nextPrev();
        actSlt();
        
        //焦点选择
        function focusSlt(){

            $indexItem.on("click",function(){
                var $this = $this,
                    tIndex = $indexItem.index(this);

                //判断活动个数是否大于2个
                if(lengths > 3){
                    if(tIndex == lengths - 1 || tIndex == lengths - 2){
                        sltIndex = lengths - 3;
                    }else {
                        sltIndex = tIndex;
                    }    

                    //执行动画
                    actListAnimate();
                    //设置左右切换按钮的状态
                    cutDisabled(tIndex);
                }
                //选择当前状态                  
                crtState(tIndex);
                
            });
        };
        //active select 活动选择
        function actSlt(){

            $actItem.on('click',function(){
                var $this = $this,
                    tIndex = $actItem.index(this);

                crtState(tIndex);
            });
        }

        //左右切换
        function nextPrev(){
            //右切换
            $next.on('click',function(){
                //
                if(sltIndex < lengths - 3){

                    sltIndex++;
                    actListAnimate(true);
                    cutDisabled(sltIndex);
                    
                }
            });
            //左切换
            $prev.on('click',function(){
                //
                if(sltIndex > 0){
                    sltIndex--;
                    actListAnimate(true);
                    cutDisabled(sltIndex);
                }
            })
        }
        //设置左右切换按钮的状态
        function cutDisabled(index){
            //判断是否处于左右边
            if(index >= lengths - 3){
                $next.addClass('disabled');
            }else {
                $next.removeClass('disabled');
            }
            //判断是否处于最左边
            if(index == 0){
                $prev.addClass('disabled');
            }else {
                $prev.removeClass('disabled');
            }
        }
        //设置选中状态
        function crtState(index){
            //设置焦点选中状态
            $indexItem.removeClass('z-crt');
            $indexItem.eq(index).addClass('z-crt');
            //设置活动选中状态
            $actItem.removeClass('z-crt');
            $actItem.eq(index).addClass('z-crt');
        }
        //动画
        function actListAnimate(animation){

            //console.log(sltIndex);
            var lefts;
            //判断当前索引，计算left值
            if(sltIndex < lengths - 2){

                lefts = -itemWidth * sltIndex;
            }else {
                lefts = -itemWidth * (sltIndex - 1);
            }
            //判断是否执行动画
            if(animation){
                //执行动画
                $actList.stop().animate({
                    left: lefts
                },300);    
            }else {
                $actList.css('left',lefts + 'px');
            }
            

        };

    }
}
///<jscompress sourcefile="photoAlbum.js" />
//相片预览
var photoPreview = $(window).photoPreview || {};

photoPreview = {
    //这是初始索引
    p_index : 0,
    f_index: 0,
    element : {
        p_wrap : "#photoPreviewBd",
        layer : ".g-photoPreview-layer",
        big_list : ".m-preview-bList",
        small_list : ".m-preview-sList"
    },
    photo_area_height: null,

    init : function(index){

        var _this = this;
        //判断是否传入新的索引
        if(index === '' || index === undefined || index === 'undefined' || index === null){
        }else {
            //重置索引
           _this.p_index = index;

        }
        //执行相片预览区域显示函数
        _this.show();
        //关闭函数
        _this.close();
    },
    //打开相片预览
    show : function(){
        //获取预览区域
        var $photo_wrap = $(this.element.p_wrap);
        $photo_wrap.show();
        //获取相片预览区域的高度
        this.photo_area_height = parseInt($(this.element.layer).height() - 140);
        //打开相片预览，设置区域高度
        $photo_wrap.find(this.element.big_list).css('height', this.photo_area_height + 'px');
        //大图区域效果
        this.bigPhoto($photo_wrap);
        //小图区域效果
        this.smallPhoto($photo_wrap);
    },
    //关闭 
    close : function(){
        //点击关闭
        $(this.element.p_wrap).on('click','.close',function(){
            $(photoPreview.element.p_wrap).hide();
        });
    },
    bigPhoto : function(photo_wrap){
        //获取图片个数
        var photo_length = photo_wrap.find(this.element.big_list).children().length;

        //默认打开显示的图片
        photoPreview.photoChange(photo_wrap);
        //显示隐藏大图切换按钮
        photoPreview.hidePrevNextBtn();
        //左切换
        $('#photoPreiewPrev').off().on('click',function(){
            //右切换按钮显示
            $('#photoPreiewNext').show();
            //切换到最左边图片的时候，隐藏左切换按钮
            if(photoPreview.p_index === 1){
                $(this).hide();
            }
            //大图索引-1
            photoPreview.p_index--;
            //执行切换函数
            photoPreview.photoChange(photo_wrap);
            //执行焦点图翻页函数
            photoPreview.focusListChange(true);
        });
        //右切换
        $('#photoPreiewNext').off().on('click',function(){
            //左切换按钮显示
            $('#photoPreiewPrev').show();
            //切换到最左边图片的时候，隐藏左切换按钮
            if(photoPreview.p_index >= photo_length - 2){
                $(this).hide();
            }
            //大图索引+1
            photoPreview.p_index++;
            //执行切换函数
            photoPreview.photoChange(photo_wrap);
            //执行焦点图翻页函数
            photoPreview.focusListChange(true);
        }); 
    },
    //焦点图函数
    smallPhoto: function(photo_wrap){
        var $s_list = $(photoPreview.element.layer).find(photoPreview.element.small_list),//获取焦点图列表
            $s_item = $s_list.children(), //单个焦点图
            $focusPrevBtn = $("#photoPreiewFocusPrev"), //左翻页按钮
            $focusNextBtn = $("#photoPreiewFocusNext"); //游翻页按钮

        var item_length = $s_item.length, //焦点图个数
            item_width = $s_item.innerWidth(), //焦点图宽度
            item_margin = parseInt($s_item.css('marginRight')), //焦点图margin-right的值
            ofh_width = $s_list.parent().width(), //焦点图父级的宽度
            row_item_num = Math.round(ofh_width / (item_width + item_margin)), //焦点图一页图片的个数
            row_num = Math.ceil(item_length / row_item_num), //焦点图页数
            row_width = (item_width + item_margin) * row_item_num; //翻页的长度
        //重置焦点图翻页索引
        photoPreview.f_index = parseInt(photoPreview.p_index / row_item_num); //焦点图页码

        //焦点图点击
        $s_item.on('click.photoChange',function(){
            //获取点击的索引
            photoPreview.p_index = photo_wrap.find(photoPreview.element.small_list).children().index(this);
            //执行切换函数
            photoPreview.photoChange(photo_wrap);
            photoPreview.hidePrevNextBtn();
        });

        //焦点图左翻页
        $focusPrevBtn.off().on('click',function(){
            $focusNextBtn.show();
            if(photoPreview.f_index <= 1){
                $(this).hide();
            }
            photoPreview.f_index--;
            $s_list.stop().animate({
                'left': -row_width * photoPreview.f_index + 'px'
            },200);   
        });
        
        //焦点图右翻页
        $focusNextBtn.off().on('click',function(){
            $focusPrevBtn.show();
            if(photoPreview.f_index >= row_num - 2){
                $(this).hide();
            }
            photoPreview.f_index++;
            $s_list.stop().animate({
                'left': -row_width * photoPreview.f_index + 'px'
            },200);   
        });
        //执行焦点图翻页函数
        photoPreview.focusListChange(false);
    },
    //大图切换
    photoChange : function(photo_wrap){
        //获取图片列表
        var $photo_item = photo_wrap.find(photoPreview.element.big_list).children();
        //获取当前索引图片的高度
        var this_img_h = $photo_item.eq(photoPreview.p_index).children('img').height();
        //显示当前索引的图片
        $photo_item.removeClass('z-crt').eq(photoPreview.p_index).addClass('z-crt');
        //设置当前索引图片的top值
        $photo_item.eq(photoPreview.p_index).children('img').css('top', (photoPreview.photo_area_height - this_img_h) / 2 + 'px'); 
        //获取焦点图片列表
        var $focus_lst = photo_wrap.find(photoPreview.element.small_list);
        //显示当前索引的焦点图片
        $focus_lst.children().removeClass('z-crt').eq(photoPreview.p_index).addClass('z-crt');
        //索引等于0的时候，左切换按钮隐藏
    },
    //显示隐藏大图切换按钮函数
    hidePrevNextBtn : function(){
        //获取大图个数
        var photo_length = $(photoPreview.element.layer).find(photoPreview.element.big_list).children().length;
        //当前索引小于等于0的时候，隐藏大图的左切换按钮
        if(photoPreview.p_index <= 0){
            $('#photoPreiewPrev').hide();
        //或者如果当前索引小于图片总数的时候，显示左右切换按钮
        }else if(photoPreview.p_index < photo_length - 1){
            $('#photoPreiewPrev').show();
            $('#photoPreiewNext').show();
        //如果索引大于等于总数的时候，隐藏右切换按钮
        }else {
            $('#photoPreiewNext').hide();
        }
    },
    //焦点图列表翻页
    focusListChange : function(ifAnimate){
        var $s_list = $(photoPreview.element.layer).find(photoPreview.element.small_list),//获取焦点图列表
            $s_item = $s_list.children(),//获取单个焦点图
            $focusPrevBtn = $("#photoPreiewFocusPrev"), //左翻页按钮
            $focusNextBtn = $("#photoPreiewFocusNext"); //游翻页按钮

        var item_length = $s_item.length, //焦点图个数
            item_width = $s_item.innerWidth(), //焦点图宽度
            item_margin = parseInt($s_item.css('marginRight')), //焦点图margin-right的值
            ofh_width = $s_list.parent().width(), //焦点图父级的宽度
            row_item_num = Math.round(ofh_width / (item_width + item_margin)), //焦点图一页图片的个数
            row_num = Math.ceil(item_length / row_item_num); //焦点图页数
        //重置焦点图翻页索引
        photoPreview.f_index = parseInt(photoPreview.p_index / row_item_num); //焦点图页码

        $s_list.css('width', (item_width + item_margin) * item_length + 'px');
        //判断焦点图页数是否只有1页
        if(row_num <= 1){
            //如果是，隐藏焦点图左右翻页按钮
            $focusPrevBtn.hide();
            $focusNextBtn.hide();
        //页数超过一页
        }else {
            //如果页码为0
            if(photoPreview.f_index === 0){
                //隐藏左翻页按钮
                $focusPrevBtn.hide();
            //或者如果页码小于总页数
            }else if(photoPreview.f_index < row_num - 1){
                //显示左右翻页按钮
                $focusPrevBtn.show();
                $focusNextBtn.show();
            //如果页面等于总页数
            }else if(photoPreview.f_index == row_num - 1) {
                //隐藏右滚动按钮
                $focusNextBtn.hide();
            }
        }
        var page_slide_width = (item_width + item_margin) * row_item_num * photoPreview.f_index;
        //判断是否执行翻页动画
        if(ifAnimate){
            //翻页
            $s_list.stop().animate({'left': -page_slide_width + 'px'},200);
        }else {
            //翻页
            $s_list.css('left', -page_slide_width + 'px');
        }

    }
};
///<jscompress sourcefile="photo3d.js" />
//定义研修模块js
var photo3dJs = $(window).photo3dJs || {};

photo3dJs.fn = {
    init : function(){
        var _this = this;
        //发起辩论操作,  注：可以传入父级参数,如"#documentParent"
        _this.publish_argue();
        
    },
    /*-- 发起辩论操作 --*/
    publish_argue : function(documentParents){
        var pb_argue_parent = ".ag-pbac-lst";
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
        }else {
            pb_argue_parent = documentParents;
        }

        //获取元素           
        var $pb_parent = $(pb_argue_parent),  //外层父级
            pb_mod = ".m-add-opus-ct",  //模块
            vp_mod = ".am-pb-mod-vp",
            vptArr = ["正","反","甲","乙","丙","丁"],  //论点文字
            vp_length = 2;  //论点默认个数

        //添加论点
        add_viewpoint();
        //删除论点
        delete_viewpoint();
        //作品数量排序
        opus_num();


        /* 添加论点 */
        function add_viewpoint(){
            //论点模块html
            var epHtml ='<li class="m-add-opus-ct am-pb-mod-vp">'+
                            '<div class="m-add-opusTl">'+
                                '作品<span class="opus-num">1</span>'+
                            '</div>'+
                            '<div class="m-addElement-item">'+
                                '<div class="ltxt">作品名称：</div>'+
                                '<div class="c-center">'+
                                    '<div class="m-pbMod-ipt">'+
                                        '<input type="text" value="" placeholder="输入活动名称" class="u-pbIpt textInfoFileTitle">'+
                                    '</div>'+
                                '</div>'+
                            '</div>'+    
                            '<div class="m-addElement-item last">'+
                                '<div class="ltxt">上传作品：</div>'+
                                '<div class="photo_div c-center">'+
                                    '<div class="m-pbMod-udload">'+
                                        '<a href="javascript:void(0);" class="picker btn u-inverse-btn u-opt-btn"><i class="u-upload-ico"></i>上传压缩包</a>'+
                                    '</div>'+
                                    '<p class="m-addElement-ex">文件格式必须为zip，rar</p>'+
                                '</div>'+
                            '</div>'+ 
                            '<a href="javascript:void(0);" class="m-add-opus-del"><i class="u-delete-ico"></i></a>'+
                                            
                        '</li>'; 

            //添加论点
            $pb_parent.on("click",'.au-add-vp',function(){
                
                    //插入论点模块html
                    $(this).parents(pb_mod).before(epHtml);
                    //作品数量排序
                    opus_num();
                   
            
            });
        };

        /* 删除论点 */
        function delete_viewpoint(){
            //删除论点模块
            $pb_parent.on("click",'.m-add-opus-del',function(){
            	var index = $('.m-add-opus-del').length;
            	if(index == 1){
            		alert('至少需要上传一个作品');
            		return false;
            	}
            	var _ts = $(this);
            	confirm("确定要删除作品吗?", function(){
                     $vp_mod = _ts.parents(vp_mod);
                     //删除论点模块
                     $vp_mod.remove();
                     //作品数量排序
                     opus_num();
            	});
                
            });
        };
        function opus_num(){
	          $(vp_mod).each(function(i,k){
	              $(this).find(".m-add-opusTl .opus-num").text(i + 1);
	              $(this).find(".photo_div").attr('id', 'photo_div_' + i).attr('paramName', 'textInfo.textInfoFiles['+i+'].fileInfo');
	              $(this).find(".textInfoFileTitle").attr('name', 'textInfo.textInfoFiles['+i+'].name');
            	  initPhotoUploader('photo_div_' + i, 'textInfo.textInfoFiles['+i+'].fileInfo');
            	  initPhotoParam('photo_div_' + i, 'textInfo.textInfoFiles['+i+'].fileInfo');
	          });
        }
    }
};

function initPhotoUploader(divId, paramName){
	var photo_uploader = WebUploader.create({
		swf : '/ncts/js/webphoto_uploader/Uploader.swf',
		server : '/file/uploadTemp',
		pick : '#'+divId+' .picker',
		resize : true,
		duplicate : true,
		accept : {
		    extensions: 'zip,rar',
		}
	});
	// 当有文件被添加进队列的时候
	photo_uploader.on('fileQueued', function(file) {
		var fileNumLimit = 1;
		if(fileNumLimit != 0){
			var fileNum = $('#'+divId).find(".fileLi").length;
    		if(fileNum >= fileNumLimit){
    			alert('只允许上传'+fileNumLimit+'个附件');
    			photo_uploader.removeFile(file.id);
    			return false;
    		}
		}
		var $li = $('#photoLiTemplet').clone();
		$li.attr('id', file.id).addClass('fileItem').show();
		$li.find('.fileName').text(file.name);
		$('#'+divId).find('.m-pbMod-udload').remove();
		$('#'+divId).prepend($li);
		photo_uploader.upload();
	});
	// 文件上传过程中创建进度条实时显示。
	photo_uploader.on('uploadProgress', function(file, percentage) {
		var $li = $('#' + file.id), $bar = $li.find('.fileBar');
		// 避免重复创建
		/* if (!$percent.length) {
			$li.find('.state').html('<div class="sche">' + '<div class="bl">' + '<div class="bs" role="progressbar" style="width: 0%"></div>' + '</div>' + '<span class="num">' + '0%' + '</span>' + '<span class="status"></span>' + '</div>');
			$percent = $li.find('.sche');
		} */
		var progress = Math.round(percentage * 100);
		$bar.find('.barLength').css('width', progress + '%');
		$bar.find('.barNum').text(progress + '%');
		$bar.find('.barTxt').text('上传中');
	});
	photo_uploader.on('uploadSuccess', function(file, response) {
		if (response != null && response.responseCode == '00') {
			$('#' + file.id).find('.fileBar').addClass('finish');
			$('#' + file.id).find('.barTxt').text('上传成功');
			var fileInfo = response.responseData;
			$('#' + file.id).attr('fileId', fileInfo.id);
			$('#' + file.id).attr('url', fileInfo.url);
			$('#' + file.id).attr('fileName', fileInfo.fileName);
			$('#' + file.id).addClass('success');
			initPhotoParam(divId, paramName);
		}
	});
	photo_uploader.on('uploadError', function(file) {
		$('#' + file.id).find('.fileBar').addClass('error');
		$('#' + file.id).find('.barTxt').text('上传出错');
	});
	photo_uploader.on('uploadComplete', function(file) {
		$('#' + file.id).find('.progress').fadeOut();
	});
//	$('#uploadBtn').click(function() {
//		photo_uploader.upload();
//	});
	$('#'+divId).off('click', '.dlt');
	$('#'+divId).on('click', '.dlt', function() {
		var _this = $(this);
		confirm('是否确定删除该附件?',function(){
			if ($(this).parents('.fileLi').hasClass('fileItem')) {
				photo_uploader.removeFile($(this).parents('.fileLi').attr('id'));
			}
			$('#'+divId).find('.fileLi').remove();
			var div = '<div class="m-pbMod-udload">'+
			            '<a href="javascript:void(0);" class="picker btn u-inverse-btn u-opt-btn"><i class="u-upload-ico"></i>上传压缩包</a>'+
			          '</div>';
			$('#'+divId).prepend($(div));
			initPhotoUploader(divId, paramName);
			initPhotoParam(divId, paramName);
		});
	});
	photo_uploader.on('error', function(type) {
		if (type == 'Q_TYPE_DENIED') {
			alert('请检查上传的文件类型');
		}
	}); 
}

function initPhotoParam(divId, paramName) {
	var $list = $('#'+divId);
	$list.find('.fileParam').remove();
	$list.find('.fileLi.success').each(function(i) {
		var fileId = $(this).attr('fileId');
		var fileName = $(this).attr('fileName');
		var url = $(this).attr('url');
		$(this).append('<input class="fileParam" name="'+paramName+'.id" value="' + fileId + '" type="hidden"/>');
		$(this).append('<input class="fileParam" name="'+paramName+'.fileName" value="' + fileName + '" type="hidden"/>');
		$(this).append('<input class="fileParam" name="'+paramName+'.url" value="' + url + '" type="hidden"/>');	
	});
	initFileType($list);
}

function initFileType(obj){
	var $file_name_par = obj.find(".fileLi");
	$file_name_par.each(function(){
		var _ts = $(this);
		var $names = _ts.find(".fileName").text(); //文件名字
        var $file_ico = _ts.find(".fileIcon");
        var strings = $names.split(".");
        var s_length = strings.length;
        var suffix = strings[s_length -1];
        if(s_length == 1){
           
        }else {
            if(suffix == "doc" || suffix == "docx"){
            	$file_ico.addClass("doc");
            }else if(suffix == "xls" || suffix == "xlsx"){
            	$file_ico.addClass("excel");
            }else if(suffix == "ppt" || suffix == "pptx"){
            	$file_ico.addClass("ppt");
            }else if(suffix == "pdf"){
            	$file_ico.addClass("pdf");
            }else if(suffix == "txt"){
            	$file_ico.addClass("txt");
            }else if(suffix == "zip" || suffix == "rar"){
            	$file_ico.addClass("zip");
            }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
            	$file_ico.addClass("pic");
            }else if(
                suffix == "mp4" || 
                suffix == "avi" || 
                suffix == "rmvb" || 
                suffix == "rm" || 
                suffix == "asf" || 
                suffix == "divx" || 
                suffix == "mpg" || 
                suffix == "mpeg" || 
                suffix == "mpe" || 
                suffix == "wmv" || 
                suffix == "mkv" || 
                suffix == "vob" || 
                suffix == "3gp"
                ){
            	$file_ico.addClass("video");
            }else {
            	$file_ico.addClass("other");
            }
        }
	});
}

