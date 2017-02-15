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