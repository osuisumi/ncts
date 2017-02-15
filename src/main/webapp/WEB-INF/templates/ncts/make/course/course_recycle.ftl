<#include "/ncts/make/include/layout.ftl"/>
<@layout>
	<div id="g-bd">
        <div class="addCoursePage">
            <div class="g-innerAuto g-addCourse-cont">
                <div class="g-crm c1">
                    <span>当前位置：</span>
                    <a onclick="createCourseIndex()" title="首页" class="">首页</a>
                    <span class="line">&gt;</span>
                    <strong>回收站</strong>
                </div>
                <@coursesDirective title=course.title! isDeleted='Y' creator=Session.loginer.id page=(pageBounds.page)!1 limit=(pageBounds.limit)!5 orders='UPDATE_TIME.DESC'>
	                <div class="g-addcourse-dt">
	                    <div class="g-recycle-box">
	                        <div class="m-manage-opt">
	                            <div class="c1 f-cb">
	                                <a href="javascript:void(0);" class="btn u-main-btn" id="manageRecycleBtn"><i class="u-setting-ico"></i>管理</a>
	                                <label class="m-srh">
	                                    <input id="searchTxt" type="text" value="${course.title! }" class="ipt" placeholder="搜索">
	                                    <i class="u-srh1-ico"></i>
	                                </label>    
	                                <script>
			                        	$(function(){
			                        		$('#searchTxt').keydown(function(e){
			                      				if(e.keyCode==13){
			                      					$('#courseRecycleForm input[name="title"]').val($(this).val());
			                      					$('#courseRecycleForm #currentPage').val(1);
			                      					$('#courseRecycleForm').submit();
			                      				}
			                      		    });
			                        	});
			                        </script>
	                            </div>
	                            <div class="c2 f-cb">
	                                <a href="javascript:void(0);" class="btn u-default-btn" id="cancleManageRecycleBtn"><i class="u-delete-ico2"></i>取消</a>
	                                <a onclick="deleteCourse()" href="javascript:void(0);" class="btn u-minor-btn"><i class="u-delete-ico"></i>删除</a>
	                                <a onclick="retrieveCourse()" href="javascript:void(0);" class="btn u-right-btn"><i class="u-refresh-ico"></i>恢复</a>     
	                            </div>
	                        </div>
	                        <div class="m-allManage-row" id="manageCheckAllBox">
	                            <label class="m-checkbox-tick">
	                                <strong>
	                                    <i class="ico"></i>
	                                    <input type="checkbox" name="myCourseManage1" value="" id="courseManageCheckAll">
	                                </strong>
	                                <span>全选</span>
	                            </label>
	                        </div>
	                        <form id="listCourseForm">
	                        	<ul class="g-myCourse-lst g-manage-myCourse" id="manageRecycleList">
		                        	<#list courses as course>	
			                            <li class="m-fig-viewList">
			                                <label class="m-checkbox-tick">
			                                    <strong>
			                                        <i class="ico"></i>
			                                        <input type="checkbox" name="id" value="${course.id}">
			                                    </strong>
			                                    <span></span>
			                                </label>
			                                <div class="mask"></div>
			                                <a href="javascript:void(0);" class="figure">
			                                    <#import "/common/image.ftl" as image/>
												<@image.imageFtl url="${course.image! }" default="${app_path }/images/defaultCourseImg.png" />
			                                </a>
			                                <h3 class="tt"><a href="javascript:void(0);">${course.title!}</a></h3>
			                                <p>
			                                    <i class="u-sList-ico"></i>
			                                    <span class="txt">${course.code!}/${course.termNo!}</span>
			                                </p>
			                                <!-- <p><i class="u-sTime-ico"></i><span class="txt">开课时间: 2015/12/12</span></p> -->
			                                <div class="tagRow">
			                                    <span class="u-cTag type1">${course.organization!}</span>
			                                    <span class="u-cTag type1">
			                                    	<#if course.type! == 'lead'>
														引领式
														<#elseif course.type! == 'mic'>
														微课
														<#else>
														自主式
													</#if>
			                                    </span>
			                                </div>
			                                <div class="optRow">
			                                    <!-- <a href="javascript:void(0);" class="u-opt u-view"><i class="u-view-ico"></i><span class="tip">预览</span></a> -->
			                                    <a onclick="deleteCourse('${course.id}')" href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
			                                    <a onclick="retrieveCourse('${course.id}')" href="javascript:void(0);" class="u-opt u-refresh"><i class="u-refresh-ico"></i><span class="tip">恢复</span></a>
			                                </div>
			                            </li>
			                    	</#list>
		                        </ul>
	                        </form>
	                        <form id="courseRecycleForm" action="${ctx}/make/course/course_recycle" >	
								<input type="hidden" name="isDeleted" value="Y">
								<input type="hidden" name="title" value="">
								<input type="hidden" name="orders" value="${orders!'CREATE_TIME.DESC' }">
	                        	<div id="myCoursePage" class="m-laypage"></div>
	                        	<#import "/common/pagination.ftl" as p/>
								<@p.paginationFtl formId="courseRecycleForm" divId="myCoursePage" paginator=paginator />
	                        </form>
	                    </div>
	                </div>
		        </@coursesDirective>
            </div>
        </div>
    </div>
</@layout>
<script>
	function retrieveCourse(courseId){
		var data = $('#listCourseForm').serialize();
		if(courseId != null && courseId != ''){
			data = 'id='+courseId;
		}
		confirm('确定要恢复选中课程吗?', function(){
			$.put('${ctx}/make/course/retrieve', data, function(data){
				if(data.responseCode == '00'){
					alert('恢复成功',function(){
						window.location.reload();
					});
				}	
			});
		});
	}
	
	function deleteCourse(courseId){
		var data = $('#listCourseForm').serialize();
		if(courseId != null && courseId != ''){
			data = 'id='+courseId;
		}
		confirm('确定要永久删除选中课程吗? 一旦确定将无法恢复', function(){
			$.ajaxDelete('${ctx}/make/course/deleteByPhycics', data, function(data){
				if(data.responseCode == '00'){
					alert('删除成功',function(){
						window.location.reload();
					});
				}	
			});
		});
	}
	
	$(function(){
		//回收站管理
	    manageRecycleFn();
	});
	
	/* 回收站管理 */
	function manageRecycleFn(){
	    var switchs = false,
	        $bindParent = $('#g-bd'),
	        $manageOpt = $('.m-manage-opt'),
	        $manageCheckAllBox = $('#manageCheckAllBox'),
	        $manageRecycleList = $('#manageRecycleList'),
	        $hasCheckboxUnit = $manageRecycleList.find('.m-checkbox-tick input');

	    //点击管理
	    $bindParent.on('click','#manageRecycleBtn',function(){
	        optFn();
	    });
	    //点击取消
	    $bindParent.on('click','#cancleManageRecycleBtn',function(){
	        optFn();
	    });
	    //打开关闭函数
	    function optFn(){
	        //判断是否在打开状态
	        if(switchs){
	            //关闭
	            $manageRecycleList.children().removeClass('opt-this');
	            $manageOpt.children('.c2').hide().siblings('.c1').show();
	            $manageCheckAllBox.hide();
	            switchs = false;
	            //清除管理选中状态
	            $hasCheckboxUnit.prop('checked',false).parent().removeClass('on');
	            $("#courseManageCheckAll").prop('checked',false).parent().removeClass('on');
	        }else {
	            //打开
	            $manageRecycleList.children().addClass('opt-this');
	            $manageOpt.children('.c2').show().siblings('.c1').hide();
	            $manageCheckAllBox.show();
	            switchs = true;
	        }
	    }
	    //回收站全选
	    courseManageCheck($bindParent,$hasCheckboxUnit);
	}
	//管理回收站选择管理
	function courseManageCheck($bindParent,$hasCheckboxUnit){
	    //点击全选按钮执行函数
	    $bindParent.on('change','#courseManageCheckAll',function(event){
	        var $this = $(this);
	        //兼容firefox和IE对象属性
	        e = event || window.event;
	        e.stopPropagation();
	        //判断全选按钮是否选中改变状态
	        if($this.is(":checked")){
	            $hasCheckboxUnit.prop('checked',true).parent().addClass('on');
	        }else {
	            $hasCheckboxUnit.prop('checked',false).parent().removeClass('on');
	        }
	    });
	}
</script>