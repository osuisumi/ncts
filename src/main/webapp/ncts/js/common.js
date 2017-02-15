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