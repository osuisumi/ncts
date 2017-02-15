<#include "/ncts/make/include/layout.ftl"/>
<@layout>
	<@courseNum isTemplate='Y' courseAuthorizeType='branch' courseAuthorizeUserId=ThreadContext.getUser().id courseAuthorizeRole="maker">
		<#assign allNum=allNum> 
		<#assign editingNum=editingNum> 
		<#assign publishedNum=publishedNum> 
		<#assign deletedNum=deletedNum> 
	</@courseNum>
	<div id="g-bd">
        <div class="addCoursePage">
            <div class="g-innerAuto g-addCourse-cont">
                <div class="g-addcourse-dt">
                    <div class="g-CourseList-tp">
                        <h2 class="tt">课程制作<span>Course Making</span></h2>
                        <a onclick="goCreateCourse()" href="javascript:void(0);" class="u-addCourse-btn u-main-btn" id="addCourseBtn"><i class="u-adds-ico"></i>创建课程</a>
                        <a onclick="goCourseRecycle()" href="###" class="u-recycle-btn"><i class="u-trashCan-ico"></i>回收站<span class="tip">${deletedNum }</span></a>
                        <label class="m-srh">
                            <input id="searchTxt" type="text" value="${course.title! }" class="ipt" placeholder="搜索">
                            <i class="u-srh1-ico"></i>
                        </label>
                        <script>
                        	$(function(){
                        		$('#searchTxt').keydown(function(e){
                      				if(e.keyCode==13){
                      					$('#listCourseForm input[name="title"]').val($(this).val());
                      					$('#listCourseForm #currentPage').val(1);
                      					$('#listCourseForm').submit();
                      				}
                      		    });
                        	});
                        </script>
                    </div>
                    <div class="g-courseList-bd">
                        <div class="g-clist-optRow">
                            <div id="stateTab" class="m-clist-tabli">
                                <a state="" onclick="listCourse('')" href="javascript:void(0);" class="z-crt"><span>全部</span>（${allNum}）<i class="trg"></i></a>
                                <a state="published,pass" onclick="listCourse('published,pass')" href="javascript:void(0);"><span>已发布</span>（${publishedNum}）<i class="trg"></i></a>
                                <a state="editing,reject" onclick="listCourse('editing,reject')" href="javascript:void(0);"><span>未发布</span>（${editingNum}）<i class="trg"></i></a>
                            </div>
                            <script>
                            	$(function(){
                            		$('#stateTab a').removeClass('z-crt');
                            		$('#stateTab a[state="${course.state!}"]').addClass('z-crt');
                            	});
                            </script>
                            <div id="listModeBtn" class="m-viewMode">
                                <a listMode="list" class="u-view-list z-crt" title="列表模式"><i class="u-viewL-ico"></i></a>
                                <a listMode="flat" class="u-view-tiled" title="平铺模式"><i class="u-viewT-ico"></i></a>
                            </div>
                            <script>
                            	$(function(){
                            		$('#listModeBtn a').click(function(){
                            			var index = $('#listModeBtn a').index($(this));
                            			$('#listModeBtn a').removeClass('z-crt');
                            			$(this).addClass('z-crt');
                            			$('.courseUl').hide();
                            			$('.courseUl').eq(index).show();
                            			$('#listModeParam').val($(this).attr('listMode'));
                            			initUpload();
                            		});
                            		if('${listMode!}' == 'flat'){
                            			$('#listModeBtn a').eq(1).trigger('click');
                            		}
                            	});
                            </script>
                        </div>
                        <div class="g-clist-tabcon">
                            <div class="g-clist-cont">
                            	<@coursesDirective title=(course.title)!'' state=(course.state)!'' listMode=listMode!'' isTemplate='Y' courseAuthorizeType='branch' courseAuthorizeUserId=ThreadContext.getUser().id courseAuthorizeRole="maker" page=(pageBounds.page)!1 limit=(pageBounds.limit)!12 orders='CREATE_TIME.DESC' >
									<ul class="courseUl g-myCourse-lst">
										<#list courses as course>	
		                                    <li class="m-fig-viewList unissue">
		                                        <a courseId="${course.id! }" href="javascript:void(0);" class="figure picker picker_${course.id! }">
		                                        	<#import "/common/image.ftl" as image/>
													<@image.imageFtl url="${course.image! }" default="${app_path }/images/uploadCourseImg.png" />
		                                        </a>
		                                        <h3 class="tt"><a href="javascript:void(0);">${course.title!}</a></h3>
		                                        <p>
	                                            	<i class="u-sList-ico"></i>
	                                            	<span  class="txt">${course.code!}</span>
	                                            	<#if course.termNo??>
	                                            	 	<span class="link">/</span>
		                                            	<span class="txt">${course.termNo!}</span>
	                                            	</#if>
		                                        </p>
		                                        <!-- <p><i class="u-sTime-ico"></i><span class="txt">开课时间: 2015/12/12</span></p> -->
		                                        <div class="tagRow">
		                                            <span class="u-cTag type1">${course.organization!}</span>
		                                            <span class="u-cTag type1">
		                                            	<#if course.type == 'lead'>
															引领式
															<#elseif course.type == 'mic'>
															微课
															<#else>
															自主式
														</#if>
		                                            </span>
		                                            <span class="u-cTag type2">
		                                            	<#if course.state == 'editing'>
															未发布
															<#elseif course.state == 'pass'>
															已发布
															<#elseif course.state == 'published'>
															待审核
															<#else> 
															未通过
														</#if>
		                                            </span>
		                                        </div>
		                                        <div class="optRow">
		                                        	<#if SecurityUtils.getSubject().hasRole('course_maker_${course.id}')>
			                                            <a onclick="editCourseConfig('${course.id}')" class="u-opt u-setting"><i class="u-setting-ico"></i><span class="tip">设置</span></a>
			                                            <a onclick="previewCourse('${course.id}')" href="javascript:void(0);" class="u-opt u-view"><i class="u-view-ico"></i><span class="tip">预览</span></a>
			                                            <#if course.state! != 'pass' && course.creator.id == Session.loginer.id>
			                                            	<a onclick="deleteCourse('${course.id}')" href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
			                                            </#if>
	                                            		<!-- <a onclick="editCourse('${course.id}')" href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a> -->
	                                            		<a onclick="editCourseContent('${course.id}')" href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
			                                            <#if course.state! == 'editing' || course.state! == 'reject'>
			                                            	<a onclick='publishCourse("${course.id}", "${(course.type)!""}", this)' href="javascript:void(0);" class="u-opt u-issue"><i class="u-issue-ico"></i><span class="tip">发布</span></a>
			                                           		<input type="hidden" class="resultSettings" value='${(course.resultSettings)!}'>
			                                            </#if>
			                                        </#if>
		                                            <a onclick="listCourseBranch('${course.id}')" href="###" class="u-opt u-opening"><i class="u-opening-ico"></i><span class="tip">分支</span></a>
		                                        </div>
		                                    </li>
		                             	</#list>
									</ul>
									<ul class="courseUl g-fig-tiled" style="display:none;">
										<#list courses as course>	
	                                        <li>
	                                            <div class="m-fig-tiled unissue">
	                                                <a courseId="${course.id! }" href="javascript:void(0);" class="figure picker picker_${course.id! }">
	                                                    <#import "/common/image.ftl" as image/>
														<@image.imageFtl url="${course.image! }" default="/ncts/images/uploadCourseImg.png" />
	                                                    <span></span>
	                                                </a>
	                                                <h3 class="tt"><a href="javascript:void(0);">${course.title!}</a></h3>
	                                                <div class="tagRow">
	                                                    <span class="u-cTag type1">${course.organization!}</span>
	                                                    <span class="u-cTag type1">
	                                                    	<#if course.type == 'lead'>
																引领式
																<#elseif course.type == 'mic'>
																微课
																<#else>
																自主式
															</#if>
	                                                    </span>
	                                                    <span class="u-cTag type2">
	                                                    	<#if course.state == 'editing'>
																未发布
																<#elseif course.state == 'pass'>
																已发布
																<#elseif course.state == 'published'>
																待审核
																<#else> 
																未通过
															</#if>
	                                                    </span>
	                                                </div>
	                                                <div class="optRow">
	                                                    <#if SecurityUtils.getSubject().hasRole('course_maker_${course.id}')>
		                                                    <a onclick="editCourseConfig('${course.id}')" href="###" class="u-opt u-setting"><i class="u-setting-ico"></i><span class="tip">设置</span></a>
		                                                    <span class="line">|</span>
		                                                    <a onclick="previewCourse('${course.id}')" href="javascript:void(0);" class="u-opt u-view"><i class="u-view-ico"></i><span class="tip">预览</span></a>
		                                                    <#if course.state! != 'pass' && course.creator.id == Session.loginer.id>
		                                                    	<span class="line">|</span> 
		                                                    	<a onclick="deleteCourse('${course.id}')" href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
		                                                    </#if>
	                                                    	<span class="line">|</span>
	                                                    	<a onclick="editCourseContent('${course.id}')" href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
		                                                    <#if course.state! == 'editing' || course.state! == 'reject'>
		                                                    	<span class="line last">|</span>
		                                                   		<a onclick="publishCourse('${course.id}', '${(course.type)!""}', this)" href="javascript:void(0);" class="u-opt u-issue"><i class="u-issue-ico"></i><span class="tip">发布</span></a>
		                                                   		<input type="hidden" class="resultSettings" value='${(course.resultSettings)!}'>
		                                                    </#if>
		                                                    <span class="line last">|</span>
		                                                </#if>
	                                                    <a onclick="listCourseBranch('${course.id}')" href="###" class="u-opt u-opening"><i class="u-opening-ico"></i><span class="tip">分支</span></a>
	                                                </div>    
	                                            </div>
	                                        </li>
	                                	</#list>
                                    </ul>
                                    <form id="listCourseForm" action="${ctx}/make/course">	
                                    	<input type="hidden" name="title" value="${(course.title)! }">
										<input id="stateParam" type="hidden" name="state" value="${(course.state)! }">
										<input type="hidden" name="orders" value="${orders!'CREATE_TIME.DESC' }">
										<input id="listModeParam" type="hidden" name="listMode" value="${listMode! }">
	                                    <div id="myCoursePage" class="m-laypage"></div>
	                                    <#import "/common/pagination.ftl" as p/>
										<@p.paginationFtl formId="listCourseForm" divId="myCoursePage" paginator=paginator />
									</form>
								</@coursesDirective>
                            </div>    
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="previewId" type="hidden">
</@layout>
<script>
	$(function(){
		$('.picker').click(function(){
			$('#previewId').val($(this).attr('courseId'));
		});
		
		initUpload();
	});

	function initUpload(){
		var uploader = WebUploader.create({
    		swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
    		server : '${ctx}/file/uploadFileInfoRemote',
    		pick : '.picker',
    		resize : true,
    		duplicate : true,
    		accept : {
    		    extensions: 'jpg,jpeg,png'
    		}
    	});
    	// 当有文件被添加进队列的时候
    	uploader.on('fileQueued', function(file) {
    		uploader.upload();
    	});
    	// 文件上传过程中创建进度条实时显示。
    	uploader.on('uploadProgress', function(file, percentage) {
    		
    	});
    	uploader.on('uploadSuccess', function(file, response) {
    		if (response != null && response.responseCode == '00') {
   				var fileInfo = response.responseData;
   				$('.picker_'+$('#previewId').val()+' img').attr('src', '${FileUtils.getFileUrl("")}'+fileInfo.url);
   				$.put('${ctx}/make/course/'+$('#previewId').val(), '&image='+fileInfo.url);
    		}
    	});
    	uploader.on('uploadError', function(file) {
    		$('#' + file.id).find('.fileBar').addClass('error');
    		$('#' + file.id).find('.barTxt').text('上传出错');
    	});
    	uploader.on('error', function(type) {
    		if (type == 'Q_TYPE_DENIED') {
    			alert('不支持该类型的文件');
    		}
    	});
	}
	
	function goCreateCourse(){
		mylayerFn.open({
            type: 2,
            title: '创建课程',
            fix: false,
            area: [720, 580],
            content: '${ctx}/make/course/create',
            shadeClose: true
        });
	}
	
	function goCourseRecycle(){
		window.location.href = '${ctx}/make/course/course_recycle';
	}
	
	function listCourse(state){
		$('#listCourseForm #stateParam').val(state);
		$('#listCourseForm #currentPage').val(1);
		$('#listCourseForm').submit();
	}
	
	function editCourse(id){
		window.location.href = '${ctx}/'+id+'make/course/'+id+'/edit';
	}
	
	function deleteCourse(id){
		confirm('确定要把该课程放入回收站吗?', function(){
			$.ajaxDelete('${ctx}/make/course/deleteByLogic', 'id='+id, function(data){
				if(data.responseCode == '00'){
					alert('已放入回收站',function(){
						window.location.reload();
					});
				}	
			});
		});
	}
	
	function publishCourse(id, type, obj){
		if(type != null && type != 'lead'){
			var resultSettings = $(obj).siblings('.resultSettings').val();
			console.info(resultSettings)
			if(resultSettings == null || resultSettings == '' || resultSettings == '{}'){
				alert('微课和自主式课程必须先设置分值构成, 才能发布', null, 2500);
				return false;
			}
		}
		confirm('确定要发布该课程吗?', function(){
			$.put('${ctx}/make/course/'+id, 'state=published', function(data){
				if(data.responseCode == '00'){
					alert('发布成功',function(){
						window.location.reload();
					});
				}	
			});
		});
	}
	
	function editCourseContent(id){
		window.location.href = '${ctx}/make/course/'+id+'/editCourseContent';
	}
	
	function editCourseConfig(id){
		window.location.href = '${ctx}/make/course/'+id+'/editCourseConfig';
	}
	
	function previewCourse(id){
		window.open('${ctx}/make/course/'+id+'/preview');
	}
	
	function listCourseBranch(id){
		window.location.href = '${ctx}/make/course/'+id+'/listCourseBranch';
	}
</script>