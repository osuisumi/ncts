<#include "/ncts/make/include/layout.ftl"/>
<@layout>
	<#if sectionId??>
		<#assign sectionId = '${sectionId[0]}' />
		<#else>
		<#assign sectionId = '' />
	</#if>
	<@leadCourseContent courseId="${course.id!}">
		<input type="hidden" id="courseType" value="${course.type! }">
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
                        <div class="g-addCourse-frame f-cb">
                            <div class="g-addCourse-sd">
                                <h3 class="title">课程章节</h3>
                            	<#if (sections?size>0)>
                            		<ul class="m-courseSection-lst" id="sectionUl">   
	                            		<#list sections as section>	
			                                <li sectionId="${section.id!}" >
			                                    <a onclick="reload('${section.id!}')" href="javascript:void(0);" class="block" title="${section.title!}">
			                                        <span>${section.title!}</span>
			                                    </a>
			                                    <div class="optRow">
			                                        <a onclick="editSection('${section.id!}', '${section.title!}')" href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
			                                        <a onclick="deleteSection('${section.id!}')" href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
			                                    </div>
			                                </li>
			                            </#list>
		                            </ul>
		                            <#else>
		                            <script>
		                            	$(function(){
		                            		//创建章节指引html
										    var addSectionGuide = '<div class="m-guideShade"></div><div class="g-guide-hint section"><button type="button" class="confirm u-inverse-btn">我知道了</button></div>';
										    //执行创章节程提示指引
										    commonJs.fn.guideHint(addSectionGuide);
		                            	});
		                            </script>
								</#if>
                                <div class="m-addChapter-btnRow">
                                    <a onclick="createSection()" href="javascript:void(0);" class="u-addChapter-btn u-inverse-btn">+ 创建一个章</a>
                                </div>
                            </div>
                            <div id="sectionDiv" class="g-addCourse-mn">
                            	<#if (sections?size>0)>
                            		<#list sections as section>
                            			<div sectionId="${section.id!}" id="sectionId_${section.id!}" class="sectionDiv g-section-box" style="display:none">
		                                    <div class="g-section-tt">
		                                        <h3 class="m-section-tt">
		                                            <span>${section.title!}</span>
		                                        </h3>
		                                        <form id="updateSectionConfigForm_${section.id!}" action="${ctx}/make/section/${section.id!}/updateSectionConfig" method="put">
			                                        <div class="optRow">
			                                            <div class="setblock">
			                                                <label class="m-checkbox-tick1">
			                                                    <strong>
			                                                        <i class="ico"></i>
			                                                        <#if (section.isHidden)! = 'Y'>
			                                                        	<input type="checkbox" onclick="updateSection('isHidden', this)" checked="checked"/>
			                                                        <#else>
			                                                        	<input type="checkbox" onclick="updateSection('isHidden', this)"/>
			                                                        </#if>
			                                                    </strong>
			                                                    <span>对学生隐藏</span>
			                                                </label>
			                                            </div>
			                                        </div>
			                                	</form>
		                                    </div>
		                                    <div class="g-section-dt">
		                                    	<ul class="m-section-lst" id="courseSectionList">
		                                    		<#list section.childSections as childSection>
			                                            <li sectionId="${childSection.id}" class="m-section-item">
			                                                <div class="m-section-block">
			                                                	<a href="javascript:void(0);" class="u-opt u-sectionOpen"><i class="u-section-ico"></i><span class="tip">展开</span></a>
			                                                    <a href="javascript:void(0);" class="tt">${childSection.title!}</a>
			                                                    <a href="javascript:void(0);" class="u-addActive-btn u-inverse-btn">+添加活动</a>
			                                                    <div class="optRow">
			                                                        <a onclick="editSection('${childSection.id!}', '${childSection.title!}')" href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
			                                                        <a onclick="editSectionConfig('${childSection.id!}')" href="javascript:void(0);" class="u-opt u-setting"><i class="u-setting-ico"></i><span class="tip">设置</span></a>
			                                                        <a onclick="deleteSection('${childSection.id!}')" href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
			                                                    </div>    
			                                                </div>
			                                                <div id="activityUl_${childSection.id}"  class="g-sectionActive-box">
			                                                	
			                                                </div>
			                                            </li>
			                                            <br>
			                                		</#list>
			                                	</ul>
			                                	<div class="m-addSection-btnRow">
		                                            <a parentId="${section.id!}" href="javascript:void(0);" class="u-addSection-btn u-inverse-btn">+ 添加小节</a>
		                                        </div>
		                                    </div>
	                                	</div>
	                                </#list>
                            		<#else>
                            		<div class="g-noContent chapter">
                            			<p>暂无内容编辑！</p>
                            		</div>
                            	</#if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	</@leadCourseContent>
</@layout>
<script>
$(function(){
	//添加小节
	addSectionFn();
	//监听重置左右两边高度变化
    addSectionResize();
    //小节活动列表展开收缩
    activeListOpt();
    //显示添加活动框
    showActiveBoxFn();
	//checkbox模拟
    $('.m-checkbox-tick1 input').bindCheckboxRadioSimulate();

	if('${sectionId}' != ''){
		$('#sectionId_${sectionId}').show();
	}else{
		$('.sectionDiv:first').show();
	}
	
	$('.m-courseSection-lst li[sectionId="${sectionId}"]').addClass('z-crt');
	
	$('.m-section-lst').each(function(){
		 //章节拖拽排序
		var $courseSectionList = $(this);
		$courseSectionList.sortable({
	        containment: 'body',
	        opacity: 0.8,
	        placeholder: "ui-state-highlight",
	        stop: function(){
	        	var data = '';
	        	$(this).children('li').each(function(i){
	        		var sortNo = $courseSectionList.children('li').index($(this)) + 1;
	        		data += 'sections['+i+'].id='+$(this).attr('sectionId')+'&sections['+i+'].sortNo='+sortNo+'&';
	        	});
	        	$.put('${ctx}/${(CSAIdObject.getCSAIdObject().cid)!}/make/section/updateBatch', data);
	        	
	        }
	    }).disableSelection();
    });
	
});

function reload(sectionId){
	if(sectionId != null){
		window.location.href = '${ctx}/make/course/${(CSAIdObject.getCSAIdObject().cid)!}/editCourseContent?sectionId='+sectionId;
	}else{
		window.location.href = '${ctx}/make/course/${(CSAIdObject.getCSAIdObject().cid)!}/editCourseContent?sectionId=${sectionId!}';
	}
}

function reloadParent(sectionId){
	if(sectionId != null){
		parent.window.location.href = '${ctx}/make/course/${(CSAIdObject.getCSAIdObject().cid)!}/editCourseContent?sectionId='+sectionId;
	}else{
		parent.window.location.href = '${ctx}/make/course/${(CSAIdObject.getCSAIdObject().cid)!}/editCourseContent?sectionId=${sectionId!}';
	}
}

function createSection(){
	mylayerFn.open({
        type: 2,
        title: '添加章节',
        fix: false,
        area: [600, 300],
        content: '${ctx}${CSAIdObject.toPath()}/make/section/create'
    });
	
}

function editSection(id){
	mylayerFn.open({
        type: 2,
        title: '编辑章节',
        fix: false,
        area: [600, 300],
        content: '${ctx}/'+id+'/make/section/'+id+'/edit',
    });
}

function editSectionConfig(id){
	var param = '';
	if('self' == '${(course.type)!}'){
		param = '?type=self';
	}
	mylayerFn.open({
        type: 2,
        title: '发布设置',
        fix: false,
        area: [600, 420],
        content: '${ctx}/make/section/'+id+'/editSectionConfig'+param,
        shadeClose: false
    });
}

function deleteSection(id){
	confirm('确定要删除此章节吗?', function(){
		$.ajaxDelete('${ctx}/make/section/'+id, '', function(){
			reload();
		});
	});
}

function addSectionFn(){
    //添加开关，默认为可添加状态
    var onOff = true; 
    //点击插入添加框
    $('.u-addSection-btn').on('click',function(){
    	var parentId = $(this).attr('parentId');
    	//小节添加模块html段
    	var addSectionBoxHtml = 
    					'<form id="saveSectionForm" action="${ctx }${CSAIdObject.toPath()}/make/section" method="post">'+
    						'<input type="hidden" name="course.id" value="${CSAIdObject.getCSAIdObject().cid}">'+
    						'<input type="hidden" name="parentSection.id" value="'+parentId+'">'+
    						'<div class="g-addSection-box" id="addSectionBox">'+
                                '<div class="actionbox">'+
                                    '<div class="m-pbMod-ipt">'+
                                        '<input type="text" name="title" placeholder="小节名称" class="u-pbIpt">'+
                                    '</div>'+
                                    '<a href="javascript:void(0);" class="cancel">取消</a>'+
                                    '<button type="button" class="confirm">确定</button>'+  
                                '</div>'+
                                '<p class="m-addElement-ex">如：猿人起源说，尽量用描述性说明，不要用第一节这类名称</p>'+
                            '</div>'
                        '</form>';
        //判断是否可添加
        if(onOff) {
            //插入添加框
            $(this).parent().before(addSectionBoxHtml);
            onOff = false;
        }
        var $addSectionBox = $('#addSectionBox');
        var $addSectionIpt = $addSectionBox.find('.u-pbIpt');
        
        //添加小节输入框获取焦点
        $addSectionIpt.focus();
        //确定添加
        $addSectionBox.off().on('click','.confirm',function(){
            var iptVal = $.trim($addSectionIpt.val());
            //判断是否为空
            if(iptVal =='' || iptVal == null || iptVal == undefined){
            	alert('小节名称不能为空，请重新输入！', function(){
                    $addSectionIpt.focus();
                }); 
            }else {
                var data = $.ajaxSubmit('saveSectionForm');
                var json = $.parseJSON(data);
                if(json.responseCode == '00'){
                	reload();
                }
            }
        });
        //取消添加
        $addSectionBox.on('click','.cancel',function(){
            removeAddSectionBox();
        });
    });
    //移除小节添加框
    function removeAddSectionBox(){
        $('#addSectionBox').remove();
        onOff = true;
    };
};

/*-- add active method 显示添加活动框 --*/
function showActiveBoxFn(){
    
    // 是否在打开状态
    var ifShow = false;
    //添加活动html
    var addActiveHtml = '<div class="m-addactive-box" id="addActiveBox">'+
    						'<input type="hidden" id="activityRelationId">'+
                            '<i class="trg"></i>'+
                            '<div class="m-addActive-lst">'+
                                '<a onclick="addActivity(\'video\')" href="javascript:void(0);" class="addActiveModule-video"><span></span>视频</a>'+
                                '<a onclick="addActivity(\'html\')" href="javascript:void(0);" class="addActiveModule-HTML"><span></span>教学课件</a>'+
                                '<a onclick="addActivity(\'discussion\')" href="javascript:void(0);" class="addActiveModule-discuss"><span></span>主题研讨</a>'+
                                '<a onclick="addActivity(\'survey\')" href="javascript:void(0);" class="addActiveModule-survey"><span></span>问卷调查</a>'+
                                '<a onclick="addActivity(\'test\')" class="addActiveModule-test"><span></span>测验</a>'+
                                '<a onclick="addActivity(\'assignment\')" class="addActiveModule-task"><span></span>作业</a>'+
                            '</div>'+
                        '</div>'
    
    //点击按钮弹出
    $('#courseSectionList .u-addActive-btn').on('click',function(e){
    	//判断是否打开
    	var obj = $(this).parents('.m-section-block');
        if(!$(obj).hasClass('open')){
        	$(obj).addClass('open').find('.u-sectionOpen .tip').text('收起');
        	$(obj).next().addClass('open');
            //获取活动列表
            listActivity($(obj).parents('li').attr('sectionId'))
        }
        
        //获取点击的按钮
        var $this = $(this);
        //给html添加类名，用于绑定事件
        $this.parents('html').addClass('addSectionHtml');
        e.stopPropagation();
        //判断是否在打开状态
        if($this.hasClass('z-crt')){
            closeAddActiveBox($this);
            //修改打开状态
            ifShow = false;
        }else {
            //修改打开状态
            ifShow = true;
            //清除其他小节状态
            $('.u-addActive-btn').removeClass('z-crt').parent().removeClass('z-crt').nextAll(".m-addactive-box").remove();
            //增加正在添加状态
            $this.addClass('z-crt').parent().addClass('z-crt').after(addActiveHtml);
            //改变添加活动框的位置
            /*$addActiveBox.show().css({
                'top': $this.offset().top + 40 + 'px',
                'left': $this.offset().left -564 + 'px'
            });*/
            $('#activityRelationId').val($this.parents('li').attr('sectionId'));
        }
        //获取活动弹出框
        var $addActiveBox = $('#addActiveBox');
        //判断点击其他地方关闭
        $('.addSectionHtml').off().on("click",function(event){ 
            //兼容firefox和IE对象属性
            e = event || window.event;
            var target = $(e.target) || $(e.srcElement); 
            event.stopPropagation();
            if(ifShow){
                if(target.closest($addActiveBox).length == 0){ 
                    //执行关闭方法
                    closeAddActiveBox($this);
                }  
            }
        }); 
        //添加活动时关闭弹出框
        $addActiveBox.on('click','a',function(){
            //执行关闭方法
            closeAddActiveBox($this);
        });
        
    });
    //关闭添加活动弹出框
    function closeAddActiveBox($addActiveBtn){        
        //清除正在添加的状态
        $addActiveBtn.removeClass('z-crt').parent().removeClass('z-crt').nextAll(".m-addactive-box").remove();
        //还原位置
        //$addActiveBox.hide().css({top: '50%', left: -670 + 'px'});
        //关闭以后设置状态为隐藏
        ifShow = false;
    };
};

//监听重置左右两边高度变化
function addSectionResize(){
    var $sd = $('.g-addCourse-sd'),
        $mn = $('.g-addCourse-mn'),
        sdHeight = $sd.innerHeight(),
        mnHeight = $mn.innerHeight();
        //console.log(sdHeight);
    if(sdHeight >= mnHeight){
        $mn.css('min-height',sdHeight + 'px');
    }else {
       $sd.css('min-height',mnHeight + 'px'); 
    } 
};

//小节活动列表展开收缩
function activeListOpt(){
    //默认第一个小节活动列表为展开状态
    $('.m-section-lst').each(function(){
    	 var firstChild = $(this).find('li:first').find('.m-section-block');
    	 openFn(firstChild);
    });
   
    //点击图标操作
    $(".m-section-lst").on("click",".m-section-block .u-sectionOpen",function(event){
        event.stopPropagation();
        var $obj = $(this).parent();
        //判断是否打开
        if($obj.hasClass('open')){
            closeFn($obj);
        }else {
            openFn($obj);
        }
    });
    //双击整行操作
    /* $(".m-section-lst").on("dblclick",".m-section-block",function(){
        var $this = $(this);
        //判断是否打开
        if($this.hasClass('open')){
            closeFn($this);
        }else {
            openFn($this);
        }
    }); */
    //打开
    function openFn(obj){
        obj.addClass('open').find('.u-sectionOpen .tip').text('收起');
        obj.next().addClass('open');
        //获取活动列表
        listActivity(obj.parents('li').attr('sectionId'))
    }
    //关闭
    function closeFn(obj){
        obj.removeClass('open').find('.u-sectionOpen .tip').text('展开');
        obj.next().removeClass('open');
    }
};

function addActivity(type){
	var title;
	if(type == 'discussion'){
		title = '添加主题讨论';
	}else if(type == 'assignment'){
		title = '添加作业';
	}else if(type == 'html'){
		title = '添加HTML';
	}else if(type == 'video'){
		title = '添加视频';
	}else if(type == 'survey'){
		title = '添加问卷调查';
	}else if(type == 'test'){
		title = '添加测验';
	}
	var activityRelationId = $('#activityRelationId').val();
	mylayerFn.open({
		id: 'editActivityDiv',
        type: 2,
        title: title,
        fix: false,
        area: [870, $(window).height()*99/100],
        content: '${ctx}/'+activityRelationId+'/make/activity/create?type='+type+'&courseType=self',
        shadeClose: false
    });
}

function updateSection(type, obj){
	if(type == 'isHidden'){
		var value = $(obj).prop('checked');
		var isHidden = 'N';
		if(value){
			isHidden = 'Y';
		}
		var id = $(obj).parents('.sectionDiv').attr('sectionId');
		$.put('${ctx}/make/section/'+id, 'isHidden='+isHidden);
	}
}

function updateSectionConfig(sectionId){
	$.ajaxSubmit('updateSectionConfigForm_'+sectionId);
}

function clearSectionDate(sectionId){
	$('#hourSelect').simulateSelectBox();
	$('#minuteSelect').simulateSelectBox();
	$.ajaxSubmit('updateSectionConfigForm_'+sectionId);
}

function listActivity(sectionId){
	$('#activityUl_'+sectionId).load('${ctx}/'+sectionId+'/make/activity', 'relation.id='+sectionId+'&t' + new Date().getTime());
}
</script>