
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