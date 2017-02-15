$(document).ready(function(){
    activityCalenda.init();
});

var activityCalenda = $(window).activityCalenda || {};

activityCalenda = {
		clickDate:'',
		dayScheduleIds:'',
		sectionListDl:'',

        init : function(){
        	sectionListDl = $('.m-add-l dl').clone(true);
            var _this= this;

            //添加计划弹出框的课程内容是否展开部分 
            _this.addPlayshowing();
            // 添加当天计划
            _this.td_play();
            // 鼠标移上日历dd里计划的样式
            _this.dd_p_mouse_style();
            //在dd里删除的计划
            //_this.dd_btn_dl_p();
             // 第二种添加计划出现及弹击
            _this.add_plan_two_way();
            // 计划完成例子 
            //_this.dd_finish_plan();
            _this.addPrevAndNextListener();


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
            //获取日期为了后面日期过去时的判断
            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth()+1;
            var m_m=date.getMonth()+1;
            var y = date.getFullYear();
            var tdnumT=0;
            var mm=m;
            var yt=0;
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
            // 确定在td中添加计划内容	//点击完成按钮
            $(".g-add .m-add-tl .u-add-f").click(function(event) {
            	var prepareAdd = $('.u-add-r-ct .u-add-r-plan i');
            	var from = $('#saveSchedulesForm');
            	var paramDiv = from.find('#param');
            	var courseId = $('#courseId').val();
            	$.each(prepareAdd,function(i,n){
            		var title = $(n).text().trim();
            		var relationId = $(n).attr('id');
            		var url = $('#ctx').val()+'/'+relationId+'/study/course/' + courseId;
            		paramDiv.append('<input type="hidden" name="schedules['+i+'].title" value="'+title+'" />');
            		paramDiv.append('<input type="hidden" name="schedules['+i+'].url" value="'+url+'"/>');
            		paramDiv.append('<input type="hidden" name="schedules['+i+'].type" value="course_study" />');
            		paramDiv.append('<input type="hidden" name="schedules['+i+'].scheduleRelation.relation.id" value="'+relationId+'" />');
            		paramDiv.append('<input type="hidden" name="schedules['+i+'].scheduleRelation.timePeriod.startTime" value="'+activityCalenda.clickDate+'" />');
            		paramDiv.append('<input type="hidden" name="schedules['+i+'].scheduleRelation.timePeriod.endTime" value="'+activityCalenda.clickDate+'" />');
            		paramDiv.append('<input type="hidden" name="schedules['+i+'].scheduleRelation.relation.type" value="section" />');
            	});
            	
            	var response = $.ajaxSubmit('saveSchedulesForm');
            	paramDiv.empty();
            	response = $.parseJSON(response);
            	if(response.responseCode == '00'){
					var td_addbg = $('<p class="td-add-bg"></p>');
					var uadd_dl = $('<span scheduleId="'+response.responseData.id+'" onclick="deleteSchedule(this)" class="td-add-dl">X</span>');
					var uadd_right = $('<span class="td-add-right"></span>');
					var plength = $(this).parent().parent().find(".u-add-r-plan").length;
					var lengthtd = $(".datein").find(".u-add-r-plan").length;
					if (plength > 0) {
						$(".datein").css({
							"background" : "#fcf"
						})
						$(".datein").append(td_addbg)
						$(".datein").find(".fc-day-number").parent().css({
							"display" : "inline"
						})//因为此插件的每行第一个td里的此标签有高度，目的去除高度
						if (lengthtd == 0) {
							$(".td-add-bg").addClass('td-add-bg01');
							//添加每天未完成计划背景
						}
						$("td .fc-day-number").css({
							"position" : "relative",
							"z-index" : "1"
						});
						var cloneSection = $(".u-add-r-ct").children().clone(true);
						$.each(cloneSection,function(i,n){
							$(n).attr('onclick','jump(this)');
						});
						$(".datein").append(cloneSection);
						$(".datein .u-add-r-plan").append(uadd_dl);
						$(".datein .u-add-r-plan").append(uadd_right);
						// alert($(".u-add-r-ct").children().text())
						$(".u-add-r-plan").addClass('u-add-r-planbg');
						//添加背景
						$(".u-add-r-plan-mov").text("")
	
						$(".u-add-r-plan-mov").addClass('u-add-r-plan-movbg');
						//添加背景
						$(".datein .fc-day-content").addClass('fc-day-content-dot');
						//添加虚线
						// $("td").removeClass('datein');
	
					};
					if (yt < y) {
						$(".td-add-bg").addClass('td-add-bg02');
						//换背景
	
					} else if (yt == y) {
						if (mm < m_m) {
	
							$(".td-add-bg").addClass('td-add-bg02');
							//换背景
						} else if (mm == m_m && tdnumT < d) {
	
							$(".datein").children('.td-add-bg').addClass('td-add-bg02');
							//换背景
							event.stopPropagation();
	
						}
					}
					$("td").removeClass('datein');
	              	$('.m-add-l').empty();
              		$('.m-add-l').append(sectionListDl.clone(true));
					offadd(); 

            	}
            	
            });

            // 计划添加表里取消添加计划内容	取消按钮
            $(".g-add").on("click", ".m-add-tl .u-add-d", function(event){ 
               //重置待添加列表的按钮和样式
              	$('.m-add-l').empty();
              	$('.m-add-l').append(sectionListDl.clone(true));
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
                 	activityCalenda.clickDate = date.format('yyyy-MM-dd');
                    offadd();                               //每次点击去除添加计划弹出框里的信息
                    var planLength = $(this).children(".u-add-r-plan").length;
                    var tdnum=parseInt($(this).children().children('.fc-day-number').text());
                    tdnumT=tdnum //获取当天日期
                    // alert(tdnumT)
                    $("#calendar tbody td").removeClass('datein'); 
                    $(this).addClass('datein');              //点击后为td加类为在添加内容时用
                    // $(this).find(".u-td-pic").remove();
                    // $(this).css({"background-color":"rgba(0,0,0,0)"});
                    if(planLength==0){                      //当日历的有内容不弹出添加计划表
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
                           $(".add-bg").css({"display":"none"})
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
                    if($(this).is(".fc-other-month")){
                        $(".g-add").css({"display":"none"});
                        $(".add-bg").css({"display":"none"})                               
                    }
                   //td中计划若完成某计划弹出的添加计划的完成样式

                        $('.td-add-f').css({'display':'block'});
                        // $('.td-add-f').parent("dd").children('p').addClass('dd-p-f-color');
                        // $('.td-add-f').siblings('.u-add-btn').remove();


                 },


                 viewDisplay: function (view) {
                    var viewt = $('#calendar').fullCalendar('getView'); 
                    // alert("The view's title is " + viewt.title);
                    var tdYear=parseInt(view.title)
                    // alert(tdYear)
                    yt=tdYear;//获取表头的年份



                 },

            }); /* calendar 插件部分结束 */
           
            var hh=$("body").height()
            $(".add-bg").height(hh)  //日历内容出来后弹出计划的背景层高度
            var plan_two=$('<div class="plan-two-way">+ 添加计划</div>');
             $("#calendar").on("mouseenter", ".fc-day", function(event){ 

                var tdtx=parseInt($(this).text());
                 // console.log(tdtx)
                 tdnumT=tdtx //获取当天日期
                var tdtype=typeof(tdtx)
                // console.log(tdtype)
                var planLength = $(this).children(".u-add-r-plan").length;
                  if(tdtype=="number"){
                     
                    var addpic=$('<img src="/ncts/js/fullcalendar-2.6.1/images/tdpic.png"  class="u-td-pic" />');
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
		//底部的添加计划
            $("#calendar").on("click", ".plan-two-way", function(event){    //点击第二种计划弹出添加计划
            	var view = $(this).closest('td');
            	var addedSchedules = view.find('.u-add-r-plan');
            	$.each(addedSchedules,function(i,n){
            		//去掉已当天添加过的章节的添加按钮
            		var relationId = $(n).attr('relationId');
            		var btn = $('.m-add-l button[btnvalue="'+relationId+'"]');
            		btn.closest('dd').children('p').addClass('dd-p-f-color');
            		btn.remove();
            	});
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
        
        add_schedule:function(schedule){
        	var flg = compareWithToday(schedule.scheduleRelation.timePeriod.startTime);
        	var scheStart = (new Date(schedule.scheduleRelation.timePeriod.startTime)).format('yyyy-MM-dd');
        	var view = $('.fc-day[data-date="'+scheStart+'"]');
        	//背景色
        	var bg = view.find('.td-add-bg');
        	//头部下滑虚线
        	var dot = view.find('.fc-day-content-dot');
        	
        	if(dot.size()<=0){
        		view.find('.fc-day-content').addClass('fc-day-content-dot');
        	};
        	
        	if(schedule.state == 'finish'){
        		addFinishSchedule(view,schedule);
        	}else{
        		addUnFinishSchedule(view,schedule);
        	};
        	
        	function addFinishSchedule(view,schedule){
        		if(bg.size()<=0){
        			view.append('<p class="td-add-bg td-add-bg01 td-add-bg02"></p>');
	        	};
	        	
	        	var prepareAdd = '<p class="u-add-r-plan u-add-r-planbg tx-under-no" style="text-decoration: none;"><i class="btn-left0">'+schedule.title+'</i> <span class="u-add-r-plan-mov u-add-r-plan-movbg" style="display: none;"></span><span class="td-add-right td-add-f td-add-right-finish"></span></p>';
	        	view.append(prepareAdd);
        		
        	}
        	
        	function addUnFinishSchedule(view,schedule){
	      		if(bg.size()<=0){
	      			if(flg>0){
	      				view.append('<p class="td-add-bg td-add-bg01"></p>');
	      			}else{
	      				view.append('<p class="td-add-bg td-add-bg01 td-add-bg02"></p>');
	      			}
        			
	        	};
	        	
	        	var prepareAdd = '<p url="'+schedule.url+'" onclick="jump(this)" type="'+schedule.type+'" id="'+schedule.id+'" relationId="'+schedule.scheduleRelation.relation.id+'" class="u-add-r-plan u-add-r-planbg tx-under-no"><i style="cursor:pointer" class="btn-left1">'+schedule.title+'</i> <span class="u-add-r-plan-mov u-add-r-plan-movbg"></span><span class="td-add-dl" scheduleId="'+schedule.id+'" onclick="deleteSchedule(this)" style="display: none;">X</span><span class="td-add-right"></span></p>';
	        	view.append(prepareAdd);
        	}
        	
        	function compareWithToday(longtime){
        		return longtime - (new Date()).getTime();
        		
        	}
        },
        addPrevAndNextListener:function(){
        	$('.fc-button-prev').on('click',function(){
        		loadSchedules();
        	});
        	
        	$('.fc-button-next').on('click',function(){
        		loadSchedules();
        	});
        	
        	$('.fc-button-today').on('click',function(){
        		loadSchedules(window.location.reload());
        	});
        },
        
};

	function deleteSchedule(btn){
		cancelBubble();
		confirm("确定删除该计划?",function(){
			var p = $(btn).closest('p');
			var scheduleId = p.attr('relationId');
			var day = $(btn).closest('td').attr('data-date');
			$.ajaxDelete($('#ctx').val() + 'study/schedule/delete/'+$(btn).attr('scheduleId'),null,function(response){
				if(response.responseCode == '00'){
					alert('删除成功');
					var pLength = $(btn).parent().siblings(".u-add-r-plan").length;
					var btndl_Class = $(btn).siblings('i').attr("class");
					var addbtn_left = $('<button class="u-add-btn">+&nbsp;&nbsp;添加</button>')
					$(".add-bg").css({
						"display" : "none"
					})
					if (pLength == 0) {
						$(btn).parent().siblings('.td-add-bg').css({
							"display" : "none"
						})
						$(btn).parent().siblings('div').children('.fc-day-content').css({
							"border" : "none"
						})
						$(btn).parent().siblings('.plan-two-way').remove() //  移除第二种添加计划标签
					}
					$(btn).parent().remove(); 
	
				}else{
					alert('删除失败');
				}
			});
		});
	}

	//添加列表添加按钮的事件
	function addSectionToPrepareDiv(btn){
		var clickDate = activityCalenda.clickDate;
		//根据section时间和clickDate判断能不能添加(尚未添加该功能)
		var uaddrct=$(".u-add-r-ct");
		var tx=$(btn).siblings('p').text();
        var sectionId = $(btn).siblings('p').attr('id');
       	var btnValue = $(btn).attr('btnValue');
       	var courseId = $('#courseId').val();
       	var url = $('#ctx').val()+'/'+sectionId+'/study/course/' + courseId;
        var addplayct=$(' <p type="course_study" url="'+url+'" relationId="'+sectionId+'" class="u-add-r-plan"><i style="cursor:pointer" id="'+sectionId +'">'+tx+'</i> <span onclick="removeSectionFromPrepareDiv(this,event)" btnValue="'+sectionId+'" class="u-add-r-plan-mov">x&nbsp;移除</span></p>');
        uaddrct.append(addplayct);
        $(btn).siblings('p').addClass('dd-pcolor-t').removeClass('dd-pcolor');
        $(btn).remove();
        //设置待添加列表的统计
        var num = parseInt($(".u-add-r-numbg span").text().trim());
        num = num +1;
        $(".u-add-r-numbg span").text(num);
        $(".u-add-r-numbg").css({"display":"block"});
	}
	
	//添加列表移除按钮的事件
	function removeSectionFromPrepareDiv(btn,event){
		event.stopPropagation();
		var sectionId = $(btn).attr('btnValue');
		var section = $('.m-add-l #'+sectionId);
        var addbtn_left = $('<button onclick="addSectionToPrepareDiv(this)" btnvalue="'+sectionId+'" class="u-add-btn">+&nbsp;&nbsp;添加</button>') ;
        $(btn).parent().remove();
        //还原对应章节的按钮样式
        section.removeClass('dd-pcolor-t');
       	section.closest('dd').append(addbtn_left);
       	//设置待添加列表的统计
       	var num = parseInt($(".u-add-r-numbg span").text().trim());
        num = num -1;
        $(".u-add-r-numbg span").text(num);
	}
	
	Date.prototype.format = function(format) {
		var date = {
			"M+" : this.getMonth() + 1,
			"d+" : this.getDate(),
			"h+" : this.getHours(),
			"m+" : this.getMinutes(),
			"s+" : this.getSeconds(),
			"q+" : Math.floor((this.getMonth() + 3) / 3),
			"S+" : this.getMilliseconds()
		};
		if (/(y+)/i.test(format)) {
			format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
		}
		for (var k in date) {
			if (new RegExp("(" + k + ")").test(format)) {
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
			}
		}
		return format;
	}
	
	//阻止事件冒泡，兼容ie和ff
	//得到事件
	function getEvent(){
	     if(window.event)    {return window.event;}
	     func=getEvent.caller;
	     while(func!=null){
	         var arg0=func.arguments[0];
	         if(arg0){
	             if((arg0.constructor==Event || arg0.constructor ==MouseEvent
	                || arg0.constructor==KeyboardEvent)
	                ||(typeof(arg0)=="object" && arg0.preventDefault
	                && arg0.stopPropagation)){
	                 return arg0;
	             }
	         }
	         func=func.caller;
	     }
	     return null;
	}
	//阻止冒泡
	function cancelBubble()
	{
	    var e=getEvent();
	    if(window.event){
	        //e.returnValue=false;//阻止自身行为
	        e.cancelBubble=true;//阻止冒泡
	     }else if(e.preventDefault){
	        //e.preventDefault();//阻止自身行为
	        e.stopPropagation();//阻止冒泡
	     }
	}

