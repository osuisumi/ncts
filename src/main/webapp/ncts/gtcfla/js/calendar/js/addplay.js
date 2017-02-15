$(document).ready(function(){
    cactivityCalenda.init();
});

var activityCalenda = $(window).activityCalenda || {};

cactivityCalenda = {


        init : function(){
            var _this= this;

            //添加计划弹出框的课程内容是否展开部分
            _this.addPlayshowing();
            // 添加当天计划
            _this.td_play();
            // 鼠标移上日历dd里计划的样式
            _this.dd_p_mouse_style();
            //在dd里删除的计划
            _this.dd_btn_dl_p();
             // 第二种添加计划出现及弹击
            _this.add_plan_two_way();
            // 计划完成例子 
            _this.dd_finish_plan();


        },

        /* 添加计划弹出框的课程内容是否展开部分 */
        addPlayshowing : function(){
            //默认全部有该类
            $("dt .u-add-conr").addClass('m-add-show');
            $("dt .u-add-conr").on("click",function(){
                var $this = $(this),
                    $thisPb = $(this).parent().siblings('dd')
                if($this.hasClass("m-add-show")){
                    $this.addClass('u-conr-up');
                    $thisPb.stop().slideUp(300);
                    $this.removeClass('m-add-show');

                }else{
                    $this.removeClass('u-conr-up');
                    $thisPb.stop().slideDown(300);
                    $this.addClass('m-add-show');
                }

            });
        },


        // 添加当天计划
        td_play : function(){
            var uaddrct=$(".u-add-r-ct");
            var addnum=0; 
            var addnumtwo;
            var btnnum=0; //为了添加计划添加个数起关联
            var btnnumtwo=btnnum;
            //获取日期为了后面日期过去时的判断
            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth()+1;
            var m_m=date.getMonth()+1;
            var y = date.getFullYear();
            var tdnumT=0;
            var mm=m;
            var yt=0;
            // 在弹出框左边添加当天计划
            $(".m-add-l dd").on("click", ".u-add-btn", function(event){ 
                addnum++;
                btnnum++;
                var tx=$(this).siblings('p').text();
                // alert(tx)
                // alert(addnum)
                var addplayct=$(' <p class="u-add-r-plan"><i class="btn-left'+btnnum+'">'+tx+'</i> <span class="u-add-r-plan-mov">x&nbsp;移除</span></p>');
                // $(this).siblings('.u-add-con2').css({"display":"block"});
                uaddrct.append(addplayct);
                $(".u-add-r-numbg").css({"display":"block"});
                $(".u-add-r-numbg span").text(addnum);
                // $(this).siblings('p').addClass('dd-pcolor-t').removeClass('dd-pcolor');
                $(this).siblings('p').addClass("btn-left"+btnnum+""); //添加类是为了当移除计划的时候起关联作用
                // $(this).remove();
                addnumtwo=addnum;
                btnnumtwo=btnnum;
                 // alert(btnnumtwo)
                 // alert(btnnum)

            });

            //在弹出框右边每个计划下取消计划
            $(".u-add-r-ct").on("click", ".u-add-r-plan-mov", function(event){             
                var btn_Class = ($(this).siblings('i').attr("class"));
                var addbtn_left = $('<button class="u-add-btn">+&nbsp;&nbsp;添加</button>') 
                // alert(btn_Class)
                
                $(this).parent().remove();
                addnumtwo--;
                $(".u-add-r-numbg span").text(addnumtwo);
                if(addnumtwo==0){
                    $(".u-add-r-numbg").css({"display":"none"});
                }
                // $(".m-add-l ."+btn_Class+"").parent().append(addbtn_left); //btn_Class 是上次关联的类
                // $(".m-add-l ."+btn_Class+"").addClass('dd-pcolor').removeClass('dd-pcolor-t');
                addnum=addnumtwo;
                // alert(btnnumtwo)

            });

            // 获取当前日历表年月日
            function am(){
                $("#calendar").on("click", ".fc-button-next.fc-corner-right", function(event){  
                    m++; 
                    if(m>12){
                        m=1
                    } 
                   // alert(m)
                mm=m //取得表头的月份
                });
                $("#calendar").on("click", ".fc-button-prev.fc-corner-left", function(event){  
                    m--; 
                    if(m<0){
                        m=12
                    } 
                   // alert(m)
                mm=m //取得表头的月份
                });
                $("#calendar").on("click", ".fc-button-today.fc-corner-left", function(event){  
                    m=date.getMonth()+1;
                    // alert(m)
                mm=m //取得表头的月份
                });


            }  
            am();
            //关闭弹出计划表清空里面添加的计划内容
            function offadd(){
                $(".add-bg").css({"display":"none"});
                addnum=0;
                addnumtwo=0;
                $(".u-add-r-numbg").css({"display":"none"});
                $(".u-add-r-numbg span").text(addnum);
                $(".u-add-r-ct").children().remove();
                $(".u-add-con2").css({"display":"none"});
                // $(".m-add-l dl dd p").addClass('dd-pcolor').removeClass('dd-pcolor-t');

            }
            // 确定在td中添加计划内容
            $(".g-add .m-add-tl .u-add-f").click(function(event) {
                var td_addbg=$('<p class="td-add-bg"></p>');
                var uadd_dl=$('<span class="td-add-dl">X</span>');
                var uadd_right=$('<span class="td-add-right"></span>');
                var plength = $(this).parent().parent().find(".u-add-r-plan").length;
                var lengthtd = $(".datein").find(".u-add-r-plan").length;
                if(plength>0){
                    $(".datein").css({"background":"#fcf"})
                    $(".datein").append(td_addbg)
                    $(".datein").find(".fc-day-number").parent().css({"display":"inline"})  //因为此插件的每行第一个td里的此标签有高度，目的去除高度
                    if(lengthtd==0){
                        $(".td-add-bg").addClass('td-add-bg01'); //添加每天未完成计划背景
                    }
                    $("td .fc-day-number").css({"position":"relative","z-index":"1"})     
                    $(".datein").append($(".u-add-r-ct").children().clone(true));
                    $(".datein .u-add-r-plan").append(uadd_dl);   
                    $(".datein .u-add-r-plan").append(uadd_right);   
                    // alert($(".u-add-r-ct").children().text())
                    $(".u-add-r-plan").addClass('u-add-r-planbg');  //添加背景
                    $(".u-add-r-plan-mov").text("")

                    $(".u-add-r-plan-mov").addClass('u-add-r-plan-movbg'); //添加背景
                    $(".datein .fc-day-content").addClass('fc-day-content-dot');  //添加虚线
                    // $("td").removeClass('datein');

                };
                if(yt<y){
                    $(".td-add-bg").addClass('td-add-bg02');  //换背景

                }else if(yt==y){
                    if( mm<m_m){
          
                        $(".td-add-bg").addClass('td-add-bg02');//换背景      
                    }else if(mm==m_m && tdnumT<d){
                        
                        $(".datein").children('.td-add-bg').addClass('td-add-bg02');//换背景
                        event.stopPropagation(); 

                    }else if(mm==m_m && tdnumT==d){
                        $(".datein").children('.td-add-bg').addClass('td-add-bg03');//换背景
                    }              
                }
                $("td").removeClass('datein');
                // console.log(mm)
                // console.log(yt)
                 // alert(tdnumT)
                 // alert(d)             
                offadd();
                        

            });

            // 计划添加表里取消添加计划内容
            $(".g-add").on("click", ".m-add-tl .u-add-d", function(event){ 
                // alert(btn_Class)
                $(".u-add-r-ct").children().each(function() { //遍历出u-add-r-plan，为了下面遍历出u-add-r-plan里的class="btn-left'+btnnum+'"

                    var btnF_Class =$(this).attr("class");
                    // alert(btnF_Class)
                    $("."+btnF_Class+"").parent('.u-add-r-ct').children(".u-add-r-plan").children('i').each(function() { 
                        //遍历出u-add-r-plan里的class="btn-left'+btnnum+'"，为了清除样式
                       var i_Class=$(this).attr("class");
                       var addbtn_left = $('<button class="u-add-btn">+&nbsp;&nbsp;添加</button>') 
                       // alert(i_Class)
                       // $("."+i_Class+"").parent("dd").children("."+i_Class+"").removeClass('dd-pcolor-t').addClass('dd-pcolor');
                       // $("."+i_Class+"").parent("dd").find(".u-add-btn").remove(); //因为此方法button会添加2次，删除1次
                       // $("."+i_Class+"").parent("dd").append(addbtn_left);

                    });
                    
                    
                });
                offadd();
            
            });

        /* calendar 插件部分 */   

            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                firstDay:0,

                 dayClick: function(date, allDay, jsEvent, view) {
                    var power = $("#calendar").attr("data-power");
                    if(power=="false"){
                        return false;
                    }
                    offadd();                               //每次点击去除添加计划弹出框里的信息
                    var planLength = $(this).children(".u-add-r-plan").length;
                    var tdnum=parseInt($(this).children().children('.fc-day-number').text());
                    tdnumT=tdnum //获取当天日期
                    // alert(tdnumT)
                    $("#calendar tbody td").removeClass('datein'); 
                    $(this).addClass('datein');              //点击后为td加类为在添加内容时用
                    // $(this).find(".u-td-pic").remove();
                    // $(this).css({"background-color":"rgba(0,0,0,0)"});
                    if(planLength==0){                    //当日历的有内容不弹出添加计划表
                        $(".g-add").css({"display":"block"});
                        // $(this).css({"background":"#f1efe8"})
                        $(".add-bg").css({"display":"block"});
                    }

                    if(yt<y){                              //当日期过时不可弹出添加计划表
                            $(".g-add").css({"display":"none"});
                            $(".add-bg").css({"display":"none"});

                    }else if(yt==y){
                         if( mm<m_m){
                            $(".g-add").css({"display":"none"});
                           $(".add-bg").css({"display":"none"});
                        }else if(mm==m_m && tdnumT<d){
                            $(".g-add").css({"display":"none"});
                            $(".add-bg").css({"display":"none"})
                             event.stopPropagation(); 
                       }              
                    }
                    if($(this).is(".fc-other-month")){
                        $(".g-add").css({"display":"none"});
                        $(".add-bg").css({"display":"none"})                               
                    }
                   //td中计划若完成某计划弹出的添加计划的完成样式

                        $('.td-add-f').css({'display':'block'});
                        // $('.td-add-f').parent("dd").children('p').addClass('dd-p-f-color');
                        // $('.td-add-f').siblings('.u-add-btn').remove();
                    var hh=$("body").height();
                    $(".add-bg").height(hh)  //日历内容出来后弹出计划的背景层高度

                 },


                 viewDisplay: function (view) {
                    var viewt = $('#calendar').fullCalendar('getView'); 
                    // alert("The view's title is " + viewt.title);
                    var tdYear=parseInt(view.title)
                    // alert(tdYear)
                    yt=tdYear;//获取表头的年份



                 },


            }); /* calendar 插件部分结束 */
            // alert()
            // var hh=$("body").height()
            // alert(hh)
            // $(".add-bg").height(hh)  //日历内容出来后弹出计划的背景层高度

            var plan_two=$('<div class="plan-two-way">+ 添加计划</div>');
             $("#calendar").on("mouseenter", ".fc-day", function(event){ 

                var power = $("#calendar").attr("data-power");
                if(power!="false"){
                    var tdtx=parseInt($(this).text());
                     // console.log(tdtx)
                     tdnumT=tdtx //获取当天日期
                    var tdtype=typeof(tdtx)
                    // console.log(tdtype)
                    var planLength = $(this).children(".u-add-r-plan").length;

                    var power = $("#calendar").attr("data-power");
                      if(tdtype=="number"){
                         
                        var addpic=$('<img src="../../js/library/fullcalendar-2.6.1/images/tdpic.png"  class="u-td-pic" />');
                        // $(this).css({"background-color":"rgba(0,0,0,0.4)"});
                        // $(this).prepend(addpic);            
                        if(yt>y){
                             $(this).css({"background-color":"rgba(0,0,0,0.4)"});
                             $(this).prepend(addpic);
                         }else if(yt==y){
                        
                             if( mm>m_m){
                                  $("#calendar").find(".fc-day").css({"background-color":"rgba(0,0,0,0)"})
                                  $(this).css({"background-color":"rgba(0,0,0,0.4)"});
                                  $(this).prepend(addpic);

                              }
                              if(mm==m_m){
                                    
                                    if(tdnumT>=d){
                                        // alert()
                                        $(this).css({"background-color":"rgba(0,0,0,0.4)"});
                                        $(this).prepend(addpic);                        
                                 }                            
                               }               
                          }
                       }
                    if($(this).is(".fc-other-month")){
                        $(this).css({"background-color":"rgba(0,0,0,0"});
                        $(this).find(".u-td-pic").remove();                                      
                    } 
                    if(planLength>0){                      //当日历的有内容鼠标移上出现第二种添加计划
                         // $(this).prepend(plan_two);

                        if(yt>y){                       //当日期过时不可弹出添加计划表
                             $(this).prepend(plan_two);


                        }else if(yt==y){
                         
                                  if( mm>m_m){
                                     $(this).prepend(plan_two);
                                }  
                        }
                         if(yt==y&&mm==m_m && tdnumT>=d){
                                
                                 $(this).prepend(plan_two);
                         }
                    }
                     // alert(tdnumT)
                     // alert(d)
                }

             });

        },

        // 鼠标移上日历dd里计划的样式
        dd_p_mouse_style : function(){

            $("#calendar").on("mouseenter", "td .u-add-r-plan", function(event){ 
                $(this).removeClass('tx-under-no').addClass('tx-under');
                $(this).children('.td-add-dl').css({"display":"block"});

            });

            $("#calendar").on("mouseleave", "td .u-add-r-plan", function(event){ 
                $(this).removeClass('tx-under').addClass('tx-under-no');
                $(this).children('.td-add-dl').css({"display":"none"});

            });
        },
        //在dd里删除的计划
        dd_btn_dl_p : function(){
            $("#calendar").on("click", ".td-add-dl", function(event){ 
                
                var pLength = $(this).parent().siblings(".u-add-r-plan").length;
                var btndl_Class = $(this).siblings('i').attr("class");   
                var addbtn_left = $('<button class="u-add-btn">+&nbsp;&nbsp;添加</button>')       
                $(".add-bg").css({"display":"none"})
                if(pLength==0){     
                    $(this).parent().siblings('.td-add-bg').css({"display":"none"})
                    $(this).parent().siblings('div').children('.fc-day-content').css({"border":"none"})
                    $(this).parent().siblings('.plan-two-way').remove()     //  移除第二种添加计划标签
                }
                // $(".m-add-l ."+btndl_Class+"").addClass('dd-pcolor').removeClass('dd-pcolor-t'); //清除计划弹出表p的选中样式
                // $(".m-add-l ."+btndl_Class+"").parent("dd").append(addbtn_left); //加添加按钮


                $(this).parent().remove();


            });
        },
        // 第二种添加计划出现及弹击
        add_plan_two_way : function(){
            $("#calendar").on("mouseleave", ".fc-day", function(event){ 

                $(this).children('img').remove();
                $(this).css({"background-color":"transparent"});
                $(this).removeClass('bgmove');
                $(this).children('.plan-two-way').remove();         //当日历的有内容鼠标移出第二种添加计划移除

            });

            $("#calendar").on("click", ".plan-two-way", function(event){    //点击第二种计划弹出添加计划
                $(".g-add").css({"display":"block"});
                $(".add-bg").css({"display":"block"});
            });
        },


        /* 计划完成例子 */
        dd_finish_plan : function(){
            var mydate= jQuery(".fc-state-highlight").data('date');
            var date_last = jQuery(".fc-state-highlight").siblings().eq(1)
            var padd_finish = $('<p class="u-add-r-plan u-add-r-planbg"><i class="btn-left0">教育调查二</i> <span class="u-add-r-plan-mov u-add-r-plan-movbg"></span><span class="td-add-dl">X</span><span class="td-add-right td-add-f"></span></p>')
            var padd_finisht = $('<p class="u-add-r-plan u-add-r-planbg"><i class="btn-left0">教育系统突简介</i> <span class="u-add-r-plan-mov u-add-r-plan-movbg"></span><span class="td-add-dl">X</span><span class="td-add-right td-add-f"></span></p>')
            var td_addbg=$('<p class="td-add-bg"></p>');
            date_last.append(td_addbg);
            $(".td-add-bg").addClass('td-add-bg01').addClass('td-add-bg02'); 
            $("td .fc-day-number").css({"position":"relative","z-index":"1"})                 
            // console.log(mydate);
            $(".datein").find(".fc-day-number").parent().css({"display":"inline"})  //因为此插件的每行第一个td里的此标签有高度，目的去除高度    
            date_last.find(".fc-day-content").addClass('fc-day-content-dot')
            date_last.append($(".u-add-r-ct").children().clone(true));
            date_last.append(padd_finish);
            date_last.append(padd_finisht);
            date_last.find(".td-add-right").addClass('td-add-right-finish');
            date_last.find(".u-add-r-plan-mov").css({"display":"none"})
            $(".td-add-f").siblings('.td-add-dl').remove(); //清除完成计划的‘X’按钮
            $(".td-add-f").parent('.u-add-r-plan').css({"text-decoration":"none"}); //清除完成计划的‘X’按钮

        },

};

