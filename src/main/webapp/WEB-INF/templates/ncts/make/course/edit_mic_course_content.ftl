<#include "/ncts/make/include/layout.ftl"/>
<@layout>
	<@micCourseContent courseId="${course.id!}">
		<div id="g-bd">
            <div class="addCoursePage">
                <div class="g-innerAuto g-addCourse-cont">
                    <div class="g-crm c1">
                        <span>当前位置：</span>
                        <a onclick="createCourseIndex()" title="首页" class="">首页</a>
                        <span class="line">&gt;</span>
                        <strong>${course.title! }</strong>
                    </div>
                    <div class="g-addcourse-dt">
                        <div class="g-addElement-tab">
                            <div class="g-addElement-tabli g-addElement-layerTab">
                                <div class="m-addElement-tabli">
                                    <a href="javascript:void(0);" class="z-crt"><span>微视频</span><i></i></a>
                                    <a href="javascript:void(0);"><span>课程测验</span><i></i></a>    
                                </div>                
                            </div>
                            <div class="g-addElement-tabCont">
                                <div class="g-addElement-tabList">
									<form id="saveMicVideoForm" action="${ctx }/make/activity/${video_activity.id!}" method="put">
                                		<input type="hidden" name="activity.type" value="video">
                                		
										<#import "/ncts/make/activity/video/edit_mic_video.ftl" as editMicVideo />
										<@editMicVideo.editMicVideoFtl id="${(video_activity.entityId)! }" />
									</form>
                                </div>
                                <div class="g-addElement-tabList">
                                   	<#import "/ncts/make/activity/test/edit_test_question.ftl" as editQuestion/>
									<@editQuestion.editQuestionFtl test=test courseType='mic' />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
			$(function(){
			    $(".g-addElement-tab").myTab({
			        pars    : '.g-addElement-tab',
			        tabNav  : '.m-addElement-tabli',
			        li      : 'a',       //标签
			        tabCon  : '.g-addElement-tabCont',
			        tabList : '.g-addElement-tabList',
			        cur     : 'z-crt',
			        page    : 0
			    });
			
			    //发布设置
			    $(".addTopicBtn,.addToNext").on("click",function(){
			        layer.open({
			            type: 2,
			            title: '添加题目',
			            fix: false,
			            area: ['740px', '910px'],
			            //offset: '100px',
			            content: 'addTopic-layer.html'
			        });
			    });
			
			    //高级设置开关
			    addCourseFn.settingSwitchFn($("#videoHighSetting"),$("#videoHighSettingBox"),true);
			    // 清除 disabled
			    addCourseFn.deleteDisabled();
			
			    //启用题目答案列表拖拽
			    /* $(".g-topic-lst").sortable({
			        placeholder: "ui-state-highlight",
			        containment: "body",
			        start: function(event,ui){
			            topicDragStart();
			        },
			        stop: function(event,ui){
			            topicDragStop();
			        }
			
			    }).disableSelection(); */
			    
			    
			});
			//题目开始拖拽排序执行函数
			function topicDragStart(){
			    
			};
			//题目拖拽排序完毕执行函数
			function topicDragStop(){
			    //重置题目排序
			    $("#topicList>li").each(function(index){
			        var $this = $(this);
			        var itemNum = index + 1;
			        //重置排序
			        $this.find('.item-num').html(itemNum + '、');
			    });
			};
		</script>
	</@micCourseContent>
</@layout>