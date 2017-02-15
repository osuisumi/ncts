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