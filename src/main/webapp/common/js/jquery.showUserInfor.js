;(function($){
    //插件名
    var pluginName = "showUserInfor";
    //默认配置项
    var defaults = {
        offset : 'top' //默认显示位置 还有right bottom left
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
            showOffset = this.options.offset;

        var userInformationHtml = '<div id="showUserInformation" style="position: absolute; z-index: 99999; width: 224px; height: 128px; background-color: #fff; border: 1px solid #e1e1e1;" data-in="false">'+
                                        '<div class="info" style="position: relative; padding: 22px 12px 0 88px; height: 66px;">'+
                                            '<span class="fig" style="display: block; overflow: hidden; position: absolute; top: 14px; left: 14px; width: 60px; height: 60px; background-color: #e1e1e1; border-radius: 5px;">'+
                                                '<img src="images/headimg/headImg2.jpg" alt="" style="width: 60px; height: 60px; border-radius: 5px;">'+
                                            '</span>'+
                                            '<strong class="name" style="font-size: 18px; font-weight: 400; color: #272b39;">李莉娜</strong>'+
                                        '</div>'+
                                        '<div class="opt" style="height: 40px; line-height: 40px; border-top: 1px solid #e1e1e1; text-align: center;">'+
                                            '<div class="messageDiv" style="float: left; width: 48%; text-align: center;"></div>'+
                                            '<span class="line" style="dispaly: block; float: left; width: 4%; font-size: 18px; color: #ebebeb;">|</span>'+
                                            '<div style="float: left; width: 48%; text-align: center;"><a onclick="goUserCenter(this)" href="javascript:void(0);" class="ue">进入Ta的空间</a></div>'+
                                        '</div>'+
                                    '</div>';

        //执行事件
        $element.on('mouseenter',function(){
            var $this = $(this), //获取当前鼠标移动上去的元素
                offsetTop = $this.offset().top, //获取元素距离顶部的值
                offsetLeft = $this.offset().left, //获取元素距离左边的值
                t_width = $this.width(), //获取元素的宽度
                t_height = $this.height();//获取元素的高度
                userId = $(this).attr('userId')||'',
                userName = $(this).attr('userName')||'',
                ctx = $(this).attr('ctx')||'',
                loginId = $(this).attr('loginId')||'';
            //插入用户资料模块
            $this.parents('body').append(userInformationHtml);
            //获取新增的用户资料模块
            var $userInformation = $("#showUserInformation"),
                m_width = $userInformation.outerWidth(), //获取新增用户资料卡的宽度
                m_height = $userInformation.outerHeight(); //获取新增用户资料卡的高度
            //判断是否在上边显示
            if(showOffset === 'top' || showOffset === 'right'){
                //设置显示位置的距离
                $userInformation.css({
                    top: offsetTop - m_height + t_height/3,
                    left: offsetLeft + t_width/3*2
                });
            }else if(showOffset === 'bottom'){
                //设置显示位置的距离
                $userInformation.css({
                    top: offsetTop + t_height/3*2,
                    left: offsetLeft + t_width/3*2
                });
            }else if(showOffset === 'left'){
                //设置显示位置的距离
                $userInformation.css({
                    top: offsetTop - m_height + t_height/3,
                    left: offsetLeft - m_width + t_width/3
                });
            }
            //获取头像路径并设置
            $userInformation.find('.fig img').prop('src',$this.prop('src'));
            //设置用户姓名
            $userInformation.find('.name').text(userName);
            //设置用户id
            $userInformation.find('.opt .ue').attr('userId',userId);
            //设置请求前缀
            $userInformation.find('.opt .ue').attr('ctx',ctx);
            //小纸条
            var messageDiv = $userInformation.find('.messageDiv');
            //设置用户id和登录人id
            messageDiv.attr('userId',userId);
            messageDiv.attr('loginId',loginId);
            messageDiv.attr('userName',userName);
            messageDiv.attr('ctx',ctx);
            if(userId != loginId){
            
				addSendMessageBtn(messageDiv);
            }
            //用户资料卡添加鼠标移进属性
            $userInformation.hover(function(){
                $(this).attr('data-in',true);
            //鼠标移出删除用户资料卡
            },function(){
                $(this).attr('data-in',false).remove();
            });
        });
        //鼠标移出
        $element.on('mouseleave',function(){
            //设置时间,异步后判断
            setTimeout(function(){
                //判断鼠标r如果没有移进用户资料卡
                if($("#showUserInformation").attr('data-in') === 'false'){
                    //删除用户资料卡
                    $("#showUserInformation").remove();
                }
            },10);
        });
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

function goUserCenter(a){
	var userId = $(a).attr('userId');
	var ctx = $(a).attr('ctx');
	window.open(ctx+"/userCenter/zone/index?userId="+userId);
}

function addSendMessageBtn(div){
	$(div).append('<a onclick="openMessageWindow(this)" href="javascript:void(0);" class="uf">发送小纸条</a>');
}

function openMessageWindow(a){
	var messageDiv = $(a).closest('div');
	var userId = messageDiv.attr('userId');
	var loginId = messageDiv.attr('loginId');
	var ctx = messageDiv.attr('ctx');
	$('#showUserInformation').attr('data-in',false).remove();
	mylayerFn.open({
		type : 2,
		title : '发送小纸条',
		bgcolor : '#fff',
		fix : true,
		area : [510, 400],
		content : ctx + '/message/create?id='+userId+'&realName='+userName,
		shadeClose: true
	});
}



