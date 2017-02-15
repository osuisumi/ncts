/*! mylayer 弹层组件  verselet */


var mylayerFn = $(window).mylayerFn || {};

//
mylayerFn = {
    //
    /*-- mylayer open 打开弹出框 --*/
    open : function(settings){
        //default settings
        var defaults = {
            id: 111,
            type: 0,
            title: '提示',
            content: '',
            area: 'auto',
            offset: 'auto',
            icon: 0,
            closeIcon: true,
            closeBtn: '',
            shade: [0.6],
            shadeClose: false,
            time: '',
            fix: false,
            scrollbar: true,
            zIndex: 9999,
            success: null,
            yes: {
                close: true,
                btnName: '.mylayer-confirm',
                yesFn : null
            },
            cancel: null,
            end: null
        };

        var opts=$.fn.extend({},defaults,settings);
        var _this = this;
        
        var zIndex = opts.zIndex;
        //alert(1); 
        
        var layerLength = $(".mylayer-wrap").length;

        zIndex = zIndex + layerLength * 2;

        //console.log(layerLength);

        zIndex++;
        //创建开关
        var onOff = true;
        //判断是否存在这个弹出框
        $('.mylayer-wrap').each(function(){
            //根据id判断
            if($(this).attr('data-id') == opts.id){
                //改为不可创建状态
                onOff = false;
            }
        });
        //content为必填，如果没有内容，则不创建弹出层
        if(opts.content === '' || opts.content === undefined || opts.content === 'undefined' || opts.content === null){

        }else {
            //判断是否可以创建
            if(onOff === true){
                //创建默认类型：提示
                if(opts.type == 0){
                    _this.type0(opts,zIndex);

                }else if(opts.type == 1){
                    //创建页面层
                    _this.type1(opts,zIndex);

                }else if(opts.type ==2){
                    //创建iframe层
                    _this.type2(opts,zIndex);
                };    
            }
            //创建成功执行回调
            _this.success(opts.success);

            _this.ok(opts);
            //点击关闭
            /*$('.mylayer-closeico,.mylayer-cancel').on('click',function(){
                _this.closelayer($(this),opts.cancel);
            });*/
            //点击关闭
            $('.mylayer-wrap').on('click','.mylayer-closeico,.mylayer-cancel',function(){
                _this.closelayer($(this),opts.cancel);
            });

            //判断是否点击遮罩层关闭
            if(opts.shadeClose){

                $('.mylayer-shade').on('click',function(){
                    _this.closelayer($(this),opts.cancel);
                });
            };
        }
        //添加样式
        _this.style(opts,zIndex);
        
      //return index;            
      
        
    },
    /*-- 默认层（信息提示） --*/
    type0 : function(opts,zIndex){

        $('body').append(
            '<div class="mylayer-wrap"data-id="'+opts.id+'" data-type="'+opts.type+'" data-index="'+zIndex+'">'+
                '<div class="mylayer-shade"></div>'+
                '<div class="mylayer-layer">'+
                    '<div class="mylayer-title">'+
                        '<h3 class="title">'+opts.title+'</h3>'+
                        '<a href="javascript:;" class="mylayer-closeico"></a>'+
                    '</div>'+
                    '<div class="mylayer-content mylayer-padding"><i class="mylayer-ico mylayer-ico'+opts.icon+'"></i>'+opts.content+'</div>'+
                    '<div class="mylayer-footer">'+
                        '<button type="button" class="mylayer-btn mylayer-confirm">确定</button>'+
                        '<button type="button" class="mylayer-btn mylayer-cancel">取消</button>'+
                    '</div>'+
                '</div>'+
            '</div>'
        );
    },
    /*-- 页面层 --*/
    type1 : function(opts,zIndex){

        $('body').append(
            '<div class="mylayer-wrap" data-id="'+opts.id+'" data-type="'+opts.type+'" data-index="'+zIndex+'">'+
                '<div class="mylayer-shade"></div>'+
                '<div class="mylayer-layer">'+
                    '<div class="mylayer-title">'+
                        '<h3 class="title">'+opts.title+'</h3>'+
                        '<a href="javascript:;" class="mylayer-closeico"></a>'+
                    '</div>'+
                    '<div class="mylayer-content">'+opts.content+'</div>'+
                '</div>'+
            '</div>'
        );
    },
    /*-- iframe层 --*/
    type2 : function(opts,zIndex){

        $('body').append(
            '<div class="mylayer-wrap" data-id="'+opts.id+'" data-type="'+opts.type+'" data-index="'+zIndex+'">'+
                '<div class="mylayer-shade"></div>'+
                '<div class="mylayer-layer">'+
                    '<div class="mylayer-title">'+
                        '<h3 class="title">'+opts.title+'</h3>'+
                        '<a href="javascript:;" class="mylayer-closeico"></a>'+
                    '</div>'+
                    '<div class="mylayer-content"><div class="mylayer-loading">正在加载中...</div></div>'+
                '</div>'+
            '</div>'
        );

        $('.mylayer-wrap').each(function(index){
            //获取当前弹框
            if(parseInt($(this).attr('data-index')) == zIndex){
                //layer content 添加iframe内容
                $(this).find('.mylayer-content').load(opts.content);
            };
        });

    },
    /*-- 定义弹出层样式 --*/
    style: function(opts,zIndex){
        //定义宽高
        var layerArea = {
            width: 250,
            height: 'auto'
        };
        //位置
        var layerOffset = {
            top: 'auto',
            left: 'auto'
        };
        //定义是否固定定位
        var layerFix;

        //判断传入参数是否为空或者默认
        if(opts.area === undefined || opts.area === 'undefined' || opts.area === null || opts.area === ''  || opts.area == 'auto'){

        }else {
            //获取宽度
            layerArea.width = opts.area[0];
            //判断是否传入height值，或者height值是否为空
            if(opts.area[1] === undefined || opts.area[1] === 'undefined' || opts.area[1] === null || opts.area[1] === '' || opts.area[1] === 'auto'){

            }else {
                //获取高度
                layerArea.height = opts.area[1];
            };
        };
        //判断传入参数是否为空或者默认
        if(opts.offset === undefined || opts.offset === 'undefined' || opts.offset === null || opts.offset === ''  || opts.offset === 'auto'){

        }else {
            //获取top值
            layerOffset.top = opts.offset[0];
            //判断是否传入left值，或者left值是否为空
            if(opts.offset[1] === undefined || opts.offset[1] === 'undefined' || opts.offset[1] === null || opts.offset[1] === '' || opts.offset[1] === 'auto'){

            }else {
                //获取left值
                layerOffset.left = opts.offset[1];
            };
        };
        //判断弹出框定位
        if(opts.fix === undefined || opts.fix === 'undefined' || opts.fix === null || opts.fix === '' || opts.fix == false){
            //没传入参数或者默认为绝对定位
            layerFix = false;
        }else if(opts.fix == true) {
            //固定定位
            layerFix = true;                
        };
        

        //获取弹出框盒子
        var $layerWrap = $('.mylayer-wrap');
        //定义弹框高度、top值、left值
        var layerHeight,layerTop,layerLeft,contentHeight;

        //判断是否为默认高度
        if(layerArea.height == 'auto'){
            layerHeight = 'auto';
            contentHeight = 'auto';
        }else {
            //不是则为设定高度
            layerHeight = layerArea.height + 'px';
            contentHeight = layerArea.height - $('.mylayer-title').innerHeight();
        };
        //设置加载遮罩层透明度
        var shadeColor = '#000';
        //判断是否传入遮罩层的颜色
        if(opts.shade[1] === '' || opts.shade[1] === null || opts.shade[1] === 'undefined' || opts.shade[1] === undefined){
        }else {
            //设置遮罩层颜色
            shadeColor = opts.shade[1];
        }
        //判断是否隐藏关闭图标
        if(opts.closeIcon === false){
            //设置为false的时候，隐藏图标
            $layerWrap.children('.mylayer-layer').find('.mylayer-closeico').hide();  
        };

        //判断是否为默认左右居中
        if(layerOffset.left == 'auto'){
            //设置居中
            leyerLeft = parseInt(($(window).width() - layerArea.width) / 2);
        }else {
            //获取传入的left值
            layerLeft = layerOffset.left;
        };
        //获取所有弹框的盒子
        $layerWrap.each(function(index){
            var $this = $(this),
                //获取遮罩层
                $layerShade = $this.children('.mylayer-shade'),
                //获取弹框
                $layerBox = $this.children('.mylayer-layer'),

                $contentBox = $layerBox.children('.mylayer-content');

            //计算弹出框的高度
            var thisHeights = $layerBox.children('.mylayer-title').innerHeight() + $layerBox.children('.mylayer-content').innerHeight() + $layerBox.children('.mylayer-footer').innerHeight();
            //设置默认定位
            var layerPosition = 'absolute';
            //判断是否为默认上下居中
            if(layerOffset.top == 'auto'){
                //判断弹框高度是否大于窗口高度
                if(thisHeights >= $(window).height() - 100){
                    //设置默认top值为100
                    layerTop = 100;
                }else {
                    //判断是否设置了高度
                    if(layerArea.height == 'auto'){
                        //计算top值
                        layerTop = parseInt(($(window).height() - thisHeights) / 2);
                    }else {
                        //计算top值
                        layerTop = parseInt(($(window).height() - layerArea.height) / 2);
                    };   
                };
                

            }else {
                //获取传入的top值
                layerTop = layerOffset.top;
            };
            
            if(layerFix){
                if(thisHeights < $(window).height() - 100){
                    layerPosition = 'fixed';
                };
            };
            //判断弹框高度是否大于窗口高度
            if(thisHeights >= $(window).height() - 100){
                //如果设定为固定定位，则强制改为绝对定位
                if(layerFix){
                    layerFix == false;
                };

            };
            //获取当前弹层
            if(parseInt($this.attr('data-index')) == zIndex){
                //设置当前遮罩层样式
                $layerShade.css({
                    'z-index': zIndex,
                    'background-color': shadeColor,
                    'opacity': opts.shade[0]
                });
                //设置当前弹层样式
                $layerBox.css({
                    position: layerPosition,
                    top: layerTop + 'px',
                    left: leyerLeft + 'px',
                    width: layerArea.width + 'px',
                    height: layerHeight,
                    'z-index': zIndex + 1
                });

                $contentBox.css({height: contentHeight + 'px'});
            };
        });


        //console.log(zIndex);

        //console.log('width:'+layerArea.width+',height:'+layerArea.height+',top:'+layerOffset.top+',left:'+layerOffset.left);
        
    },

    /*-- 创建层成功 --*/
    success : function(successFn){
        //执行成功回调
        this.callbackFn(successFn);
    },
    /*-- 确定执行执行 --*/
    ok : function(opts){

        var confirmBtn = null;
        //判断是否自定义确定按钮
        if(opts.yes.btnName === null || opts.yes.btnName === undefined || opts.yes.btnName === 'undefined' || opts.yes.btnName === ''){
            //不传入自定义确定按钮，使用默认
            confirmBtn = '.mylayer-confirm';
        }else {
            confirmBtn = opts.yes.btnName;
        };
        //确定按钮
        $('.mylayer-wrap').on('click',confirmBtn,function(){
            //判断点击确定按钮是关闭
            if(opts.yes.close){
                //close属性为true，关闭弹框
                $(this).parents('.mylayer-wrap').remove();
            };
            //执行回调
            mylayerFn.callbackFn(opts.yes.yesFn);
        })
    },
    /*-- 关闭弹出层 --*/
    closelayer : function(el,cancelFn){
        //关闭
        el.parents('.mylayer-wrap').remove();
        //执行关闭回调
        this.callbackFn(cancelFn);
            
                       
    },
    /*-- 回调函数执行 --*/
    callbackFn : function(fn){
        //判断是否传入回调函数
        if(fn === null || fn === '' || fn === undefined || fn === 'undefined'){

        }else {
            //执行函数
            fn();
        };
    },

    /*-- 刷新弹出框 --*/
    refresh : function(settings){

        var refresh = {
            id: 111,
            title: '',
            content: '',
            refreshFn: function(){

            }
        };

        var reopts = $.fn.extend({},refresh,settings);

        var newTitle,newContent;


        if(reopts.title === '' || reopts.title === 'undefined' || reopts.title === undefined || reopts.title === null){
            newTitle = false;
        }else {
            newTitle = reopts.title;
        };

        if(reopts.content === '' || reopts.content === 'undefined' || reopts.content === undefined || reopts.content === null){
            newContent = false;
        }else {
            newContent = reopts.content;
        };

        //遍历弹框，获取当前需要操作的弹框
        $('.mylayer-wrap').each(function(){

            var $this = $(this),
                t_id = $this.attr('data-id'),
                t_type = $this.attr('data-type');

            //根据id获取当前弹框  
            if(t_id == reopts.id){
                //获取元素
                var $layer = $this.children('.mylayer-layer'),
                    $title = $layer.children('.mylayer-title'),
                    $content = $layer.children('.mylayer-content');

                //判断是否需要刷新标题
                if(!newTitle){
                    
                }else {
                    $title.children('.title').text(newTitle);
                }
                //判断是否需要刷新内容
                if(!newContent){

                //修改内容  
                }else {
                    //判断弹框类型
                    if(t_type == 2){
                        
                        $content.load(reopts.content,'',function(){
                            //执行刷新回调
                            reopts.refreshFn();
                        });

                    }else {

                        $content.html(reopts.content);
                        //执行刷新回调
                        reopts.refreshFn();
                    };
                    
                };
            };

        });

    },
    /*-- alert 弹框 --*/
    alert : function(settings){
        //默认设置
        var defaults = {
            content: '',
            icon: null,
            fn : function(){
                
            }
        };
        var opts = $.fn.extend({},defaults,settings);
        //添加alert提示框
        $('body').append(
            '<div class="mylayer-wrap">'+
                '<div class="mylayer-shade" style="z-index: 999998"></div>'+
                '<div class="mylayer-layer mylayer-alert" style="z-index: 999999">'+
                    '<div class="mylayer-title">'+
                        '<h3 class="title">信息</h3>'+
                        '<a href="javascript:;" class="mylayer-closeico"></a>'+
                    '</div>'+
                    '<div class="mylayer-content"><i class="mylayer-ico"></i>'+opts.content+'</div>'+
                    '<div class="mylayer-footer">'+
                        '<button type="button" class="mylayer-btn mylayer-confirm">确定</button>'+
                    '</div>'+
                '</div>'+
            '</div>'
        );

        var $this_layer = $(".mylayer-wrap").last().children('.mylayer-layer');
        $this_layer.addClass('zoomIn');
        //设置样式属性
        mylayerFn.alertStyle($this_layer,opts);
        
        //关闭
        $this_layer.find('.mylayer-closeico').on('click',function(){
            //执行关闭函数
            mylayerFn.closelayer($(this));
        });
        //确定按钮关闭
        $this_layer.find('.mylayer-confirm').on('click',function(){
            //执行关闭函数
            mylayerFn.closelayer($(this));
            //判断是否为函数，为函数才执行回调函数
            if (typeof opts.fn == 'function'){
                //执行回调
                opts.fn();
            }
        });
    },
    /*-- layer confirm --*/
    confirm : function(settings){

        //默认设置
        var defaults = {
            title: '提示',
            content: '',
            icon: null,
            yesFn : function(){
                
            },
            cancelFn : function(){

            }
        };
        var opts = $.fn.extend({},defaults,settings);

        //获取最后一个layer
        var $last_mylayer = $('.mylayer-wrap').last();
        var zIndex = 200000;
        //判断最后一个layer是否存在
        if($last_mylayer.length === 1) {
            //增加层级
            zIndex = parseInt($last_mylayer.attr('data-index')) + 2;
        }
        //插入confirm弹出框
        $('body').append(
            '<div class="mylayer-wrap" data-index="'+zIndex+'">'+
                '<div class="mylayer-shade" style="z-index:'+zIndex+'"></div>'+
                '<div class="mylayer-layer mylayer-alert" style="z-index:'+(zIndex + 1)+'">'+
                    '<div  class="mylayer-title">'+
                        '<h3 class="title">'+opts.title+'</h3>'+
                        '<a href="javascript:;" class="mylayer-closeico"></a>'+
                    '</div>'+
                    '<div class="mylayer-content"><i class="mylayer-ico"></i>'+opts.content+'</div>'+
                    '<div class="mylayer-footer">'+
                        '<button type="button" class="mylayer-btn mylayer-confirm">确定</button>'+
                        '<button type="button" class="mylayer-btn mylayer-cancel">取消</button>'+
                    '</div>'+
                '</div>'+
            '</div>'
        );

        var $this_layer = $(".mylayer-wrap").last().children('.mylayer-layer');
        //$this_layer.addClass('zoomIn');
        //设置样式属性
        mylayerFn.alertStyle($this_layer,opts);

        //关闭
        $this_layer.find('.mylayer-closeico').on('click',function(){
            //执行关闭函数
            mylayerFn.closelayer($(this));
        });
        //确定按钮关闭
        $this_layer.find('.mylayer-confirm').on('click',function(){
            //执行关闭函数
            mylayerFn.closelayer($(this));
            //判断是否为函数，为函数才执行回调函数
            if (typeof opts.yesFn == 'function'){
                //执行回调
                opts.yesFn();
            }
        });
        //取消按钮关闭
        $this_layer.find('.mylayer-cancel').on('click',function(){
            //执行关闭函数
            mylayerFn.closelayer($(this));
            //判断是否为函数，为函数才执行回调函数
            if (typeof opts.cancelFn == 'function'){
                //执行回调
                opts.cancelFn();
            }
        });
    },
    /*-- layer btns --*/
    btns : function(settings){

        //默认设置
        var defaults = {
            title: '提示',
            content: '',
            icon: null,
            btns:[
                {content:"按钮", classname:'mylayer-btn1', type:0, close: true, fn:''},
            ]
        };
        var opts = $.fn.extend({},defaults,settings);

        //获取最后一个layer
        var $last_mylayer = $('.mylayer-wrap').last();
        var zIndex = 200000;
        var btns = opts.btns;
        //判断最后一个layer是否存在
        if($last_mylayer.length === 1) {
            //增加层级
            zIndex = parseInt($last_mylayer.attr('data-index')) + 2;
        }
        //插入confirm弹出框
        $('body').append(
            '<div class="mylayer-wrap" data-index="'+zIndex+'">'+
                '<div class="mylayer-shade" style="z-index:'+zIndex+'"></div>'+
                '<div class="mylayer-layer mylayer-openBtns" style="z-index:'+(zIndex + 1)+'">'+
                    '<div  class="mylayer-title">'+
                        '<h3 class="title">'+opts.title+'</h3>'+
                        '<a href="javascript:;" class="mylayer-closeico"></a>'+
                    '</div>'+
                    '<div class="mylayer-content"><i class="mylayer-ico"></i><div>'+opts.content+'</div></div>'+
                    '<div class="mylayer-footer">'+
                        
                    '</div>'+
                '</div>'+
            '</div>'
        );
        var $this_layer = $(".mylayer-wrap").last().children('.mylayer-layer');

        //$this_layer.addClass('zoomIn');
        //设置样式属性

        for(var i = 0; i < btns.length; i++){

            $this_layer.children('.mylayer-footer').append('<button type="button" class="mylayer-btn">'+btns[i].content+'</button>');

            if(btns[i].classname === null || btns[i].classname === 'undefined' || btns[i].classname === undefined || btns[i].classname === '' ){

            }else {
                $this_layer.find('.mylayer-btn').eq(i).addClass(btns[i].classname);
            }
            if(btns[i].type === null || btns[i].type === 'undefined' || btns[i].type === undefined || btns[i].type === '' ){

            }else {
                $this_layer.find('.mylayer-btn').eq(i).addClass('type' + btns[i].type);
            }
        }
        $this_layer.find('.mylayer-btn').each(function(index){
            var $this = $(this);
            $this.on('click',function(){
                if(btns[index].close) {
                    mylayerFn.closelayer($(this));
                };
                if(typeof btns[index].fn == 'function'){

                    btns[index].fn();
                }
                
            });
        });

        mylayerFn.alertStyle($this_layer,opts);
        $this_layer.css('padding-bottom','12px');
        //关闭
        $this_layer.find('.mylayer-closeico').on('click',function(){
            //执行关闭函数
            mylayerFn.closelayer($(this));
        });
    },
    //alert layer style
    alertStyle : function(layer,opts){
        //获取当前弹出框
        var $layer_content = layer.children('.mylayer-content'),
            $layer_ico = layer.find('.mylayer-ico');
        //获取弹出框的属性
        var l_height = layer.children('.mylayer-title').innerHeight() + $layer_content.innerHeight() + layer.children('.mylayer-footer').innerHeight(),
            l_left = ($(window).width() - layer.innerWidth()) / 2,
            l_top = ($(window).height() - l_height) / 2;
        //设置样式
        layer.css({
            position: 'fixed',
            width: 360 + 'px',
            height: l_height + 'px',
            top: l_top + 'px',
            left: l_left + 'px'
        });

        //判断是否需要icon
        if(opts.icon === null || opts.icon === 'undefined' || opts.icon === undefined || opts.icon === ''){
        }else {
            //设置图标
            $layer_ico.show().addClass('mylayer-ico'+opts.icon);
            $layer_content.addClass('has-icon');
        }
    },
    //
    msg : function(message,settings,fn){

        //获取最后一个layer
        var $last_mylayer = $('.mylayer-wrap').last();
        var zIndex = 100000;
        //判断最后一个layer是否存在
        if($last_mylayer.length === 1) {
            //增加层级
            zIndex = parseInt($last_mylayer.attr('data-index')) + 2;
        }
        //设置默认
        var defaults = {
            icon: null,
            time: 1500
        };
        //设置关闭回调为空
        var endFn = function(){

        };
        //判断传入的第二个参数是否为对象类型
        if(typeof settings == 'object'){
            //设置默认图标
            defaults.icon = settings.icon;
            //判断传入的fn参数是否为函数类型
            if(typeof fn == 'function'){
                //设置关闭回调函数
                endFn = fn;
            }
        //如果传入的第二个参数为函数类型
        }if(typeof settings == 'function') {
            //则设置关闭回调函数等于第二个参数
            endFn = settings;

        };

        //插入message弹出框
        $('body').append(
            '<div class="mylayer-wrap" data-index="'+zIndex+'">'+
                '<div class="mylayer-shade1" style="z-index:'+zIndex+'"></div>'+
                '<div class="mylayer-layer mylayer-layer-msg" style="z-index:'+(zIndex + 1)+'">'+
                    '<div class="mylayer-content"><i class="mylayer-ico"></i>'+message+'</div>'+
                '</div>'+
            '</div>'
        );
        //获取message弹出框
        var $tlayer = $('.mylayer-wrap').last().children('.mylayer-layer');
        //获取高度和宽度
        var twidth = $tlayer.children().innerWidth(),
            tHeight = $tlayer.children().innerHeight(),
            tTop = ($(window).height() - tHeight) / 2,
            tLeft = ($(window).width() - twidth) / 2;

        //设置样式
        $tlayer.css({
            top: tTop + 'px',
            left: tLeft + 'px',
            width: twidth + 'px',
            height: tHeight + 'px'
        });
        //判断是否传入icon图标
        if(defaults.icon === undefined || defaults.icon === 'undefined' || defaults.icon === null || defaults.icon === ''){
            //没出入图标使用默认样式
            $tlayer.addClass('mylayer-layer-hui');
        }else {
            //使用图标样式
            $tlayer.removeClass('mylayer-layer-hui');
            //添加图标
            $tlayer.find('.mylayer-ico').addClass('mylayer-ico'+settings.icon);
        };
        //判断是否传入关闭时间
        if(settings.time === undefined || settings.time === 'undefined' || settings.time === null || settings.time === ''){
        }else {
            //获取关闭时间
            defaults.time = settings.time;
        };
        //自动关闭弹出框
        var closeTime = setTimeout(function(){
            //关闭
            mylayerFn.closelayer($tlayer);
            //执行关闭回调
            endFn();
            //清除清时期
            clearTimeout(closeTime);
        },defaults.time);

    },
    //正在加载函数
    loading : function(settings){

        //默认设置
        var defaults = {
            id: '',
            content: '正在加载中...',
            zIndex: 100000,
            shade: [0.1,'#fff']        
        };
        var opts = $.fn.extend({},defaults,settings);

        //插入loading弹出框
        $('body').append(
            '<div class="mylayer-wrap" data-id="'+opts.id+'" data-type="loading" data-index="'+opts.zIndex+'">'+
                '<div class="mylayer-shade1" style="z-index:'+opts.zIndex+'"></div>'+
                '<div class="mylayer-layer-loading" style="z-index:'+(opts.zIndex + 1)+'">'+
                    '<div class="mylayer-content">'+
                        '<div class="mylayer-loading-an">'+
                            '<div class="ll-child ll-child1"></div>'+
                            '<div class="ll-child ll-child2"></div>'+
                        '</div>'+
                        '<div class="mylayer-loading">'+opts.content+'</div>'+
                    '</div>'+
                '</div>'+
            '</div>'
        );

        var $loadingLayer = $(".mylayer-wrap").last().children('.mylayer-layer-loading'),
            $loadingShade = $(".mylayer-wrap").last().children().first();
        //设置加载遮罩层透明度
        $loadingShade.css('opacity',opts.shade[0]);
        //判断是否传入遮罩层的颜色
        if(opts.shade[1] === '' || opts.shade[1] === null || opts.shade[1] === 'undefined' || opts.shade[1] === undefined){

        }else {
            //设置遮罩层颜色
            $loadingShade.css('background-color',opts.shade[1]);
        }
    },
    close : function(layer){
        //判断输入的id，关闭layer
        $(".mylayer-wrap").each(function(){
            //根据传入id关闭
            if(layer == $(this).attr('data-id')){
                $(this).remove();
            }
        });
    }
    
};

