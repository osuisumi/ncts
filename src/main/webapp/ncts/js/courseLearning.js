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