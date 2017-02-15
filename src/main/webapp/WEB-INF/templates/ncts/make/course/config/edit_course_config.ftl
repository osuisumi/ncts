<#include "/ncts/make/include/layout.ftl"/>
<@layout>
	<@courseConfig courseId="${(course.id)!}">
		<div id="g-bd">
            <div class="addCoursePage">
                <div class="g-innerAuto g-addCourse-cont">
                    <div class="g-crm c1">
                        <span>当前位置：</span>
                        <a onclick="createCourseIndex()" title="首页" class="">首页</a>
                        <span class="line">&gt;</span>
                        <strong>课程设置</strong>
                    </div>
                    <div class="g-addcourse-dt">
                        <!--begin course setting box -->
                        <div class="g-cSet-layout">
                            <div class="g-addElement-tab">
                                <div class="g-addElement-tabli g-addElement-layerTab">
                                    <div class="m-addElement-tabli">
                                        <a href="javascript:void(0);" class="z-crt"><span>课程团队管理</span><i></i></a>
                                        <a href="javascript:void(0);"><span>课程分值构成</span><i></i></a>    
                                        <!-- <#if ('lead' == (course.type)!'')> 
                                        	<a href="javascript:void(0);"><span>授课教师</span><i></i></a>
                                        </#if> -->
                                        <a href="javascript:void(0);"><span>常见问题</span><i></i></a>    
                                        <a href="javascript:void(0);"><span>资源列表</span><i></i></a>    
                                    </div>                
                                </div>
                                <div class="g-addElement-tabCont">
                                    <div class="g-addElement-tabList">
                                    	<form id="saveCourseForm" action="${ctx!}/make/course/${(course.id)!}" method="put">
	                                        <div class="g-cSet-lst">
	                                            <ul class="g-addElement-lst">
	                                                <li class="m-addElement-item">
	                                                    <div class="ltxt">课程描述：</div>
	                                                    <div class="center">
	                                                        <div class="m-pbMod-ipt">
	                                                            <input type="text" maxlength="256" name="description" value="${(course.description)!}" placeholder="输入课程描述" class="u-pbIpt">
	                                                        </div>
	                                                    </div>
	                                                </li>
	                                                <li class="m-addElement-item">
	                                                    <div class="ltxt">课程简介：</div>
	                                                    <div class="center">
	                                                        <div class="m-pbMod-ipt">
	                                                            <textarea name="summary" maxlength="64" placeholder="输入课程描述" class="u-textarea">${(course.summary)!}</textarea>
	                                                        </div>
	                                                    </div>
	                                                </li>
	                                                <!--  <#if course.type != 'mic'>
	                                                	<li class="m-addElement-item">
		                                                    <div class="ltxt">课程章节介绍：</div>
		                                                    <div class="center">
		                                                        <script id="editor" type="text/plain" style="height: 200px; width: 100%"></script>
																<input id="courseContent" name="content" type="hidden">
		                                                    </div>
		                                                </li>
	                                                </#if> -->
	                                                <li class="m-addElement-item">
	                                                    <div class="ltxt">学时：</div>
	                                                    <div class="center">
	                                                        <div class="m-pbMod-ipt">
	                                                            <input type="text" maxlength="4" onkeyup="value=value.replace(/[^\d]/g,'')" name="studyHours" value="${(course.studyHours)!}" placeholder="" class="u-pbIpt">
	                                                        </div>
	                                                    </div>
	                                                </li>
	                                                <li class="m-addElement-item">
	                                                    <div class="ltxt">学科：</div>
	                                                    <div class="center">
	                                                        <div class="m-check-mod">
	                                                        	<#list TextBookUtils.getEntryList('SUBJECT') as dictEntry>
	                                                        		<label class="m-checkbox-tick">
		                                                                <strong>
		                                                                    <i class="ico"></i>
		                                                                    <#if (course.subject!?split(','))?seq_contains(dictEntry.textBookValue)>
																				<input type="checkbox" name="subject" value="${(dictEntry.textBookValue)!}" checked="checked">
																				<#else>
																				<input type="checkbox" name="subject" value="${(dictEntry.textBookValue)!}">
																			</#if>
		                                                                </strong>
		                                                                <span>${(dictEntry.textBookName)!}</span>
		                                                            </label>
																</#list>
																<div onclick="addDictEntry('SUBJECT', this)" class="m-setCou-add">+</div>
	                                                        </div>
	                                                    </div>
	                                                </li>
	                                                <li class="m-addElement-item">
	                                                    <div class="ltxt">学段：</div>
	                                                    <div class="center">
	                                                        <div class="m-check-mod">
	                                                        	<#list TextBookUtils.getEntryList('STAGE') as dictEntry>
	                                                        		<label class="m-checkbox-tick">
		                                                                <strong class="on">
		                                                                    <i class="ico"></i>
		                                                                    <#if (course.stage!?split(','))?seq_contains(dictEntry.textBookValue)>
																				<input type="checkbox" name="stage" value="${(dictEntry.textBookValue)!}" checked="checked">
																				<#else>
																				<input type="checkbox" name="stage" value="${(dictEntry.textBookValue)!}">
																			</#if>
		                                                                </strong>
		                                                                <span>${(dictEntry.textBookName)!}</span>
		                                                            </label>
																</#list>
																<div onclick="addDictEntry('STAGE', this)" class="m-setCou-add">+</div>
	                                                        </div>
	                                                    </div>
	                                                </li>
	                                                <!-- <li class="m-addElement-item">
	                                                    <div class="ltxt">学时时长：</div>
	                                                    <div class="center">
	                                                        <div class="m-pbMod-ipt">
	                                                            <input type="text" maxlength="4" onkeyup="value=value.replace(/[^\d]/g,'')" name="hourLength" value="${(course.hourLength)!}" placeholder="如：10小时/周" class="u-pbIpt">
	                                                        </div>
	                                                    </div>
	                                                </li> -->
	                                                <li class="m-addElement-btn hasborder">
	                                                    <a href="javascript:void(0);" data-href="section.html" class="btn u-main-btn" onclick="saveCourse()">保存</a>
	                                                    <a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn" onclick="reload('${(course.id)!}')">取消</a>
	                                                </li>
	                                            </ul>
	                                        </div>    
	                                	</form>
                                    </div>
                                    <div class="g-addElement-tabList">
                                        <#import "edit_course_result_settings.ftl" as ecrs />
										<@ecrs.editCourseResultSettingsFtl course=course />
                                    </div>
                                    <!-- <#if ('lead' == (course.type)!'')> 
                                    	<div class="g-addElement-tabList">
	                                        <#import "edit_course_authorize.ftl" as eca />
											<@eca.editCourseAuthorizeFtl course=course courseAuthorizes=courseAuthorizes />
	                                    </div>
                                    </#if> -->
                                    <div class="g-addElement-tabList">
                                        <#import "edit_faq.ftl" as ef />
										<@ef.editFaqFtl course=course faqQuestions=faqQuestions />
                                    </div>
                                    <div class="g-addElement-tabList">
                                        <#import "edit_resource.ftl" as lr />
										<@lr.editResourceFtl course=course />
                                    </div>
                                </div>
                            </div>                                   
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
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
			});
			
			function callbackFunction(){
				
			}
			
		  	//添加学科弹出框
			function addDictEntry(dictTypeCode, obj){
		  		var title = '';
		  		if(dictTypeCode == 'SUBJECT'){
		  			title = '添加学科';
		  			callbackFunction = function(dictValue, dictName){
		  				$(obj).before('<label class="m-checkbox-tick">'+
		                                '<strong><i class="ico"></i><input type="checkbox" name="subject" value="'+dictValue+'"></strong>'+
		                            	'<span>'+dictName+'</span>'+
		                        	'</label>');
		  				//多选按钮模拟
				  	    $('.m-checkbox-tick input').bindCheckboxRadioSimulate();
		  			}
		  		}else{
		  			title = '添加学段';
		  			callbackFunction = function(dictValue, dictName){
		  				$(obj).before('<label class="m-checkbox-tick">'+
		                                '<strong><i class="ico"></i><input type="checkbox" name="stage" value="'+dictValue+'"></strong>'+
		                            	'<span>'+dictName+'</span>'+
		                        	'</label>');
		  				//多选按钮模拟
				  	    $('.m-checkbox-tick input').bindCheckboxRadioSimulate();
		  			}
		  		}
		  		
		  		mylayerFn.open({
		            type: 2,
		            title: title,
		            fix: false,
		            bgcolor: '#fff',
		            area: [400, 250],
		            content: '${ctx}/text_book_entry/create?textBookTypeCode='+dictTypeCode
		        });	
		  	}
			
			function saveCourse(){
				if(!$('#saveCourseForm').validate().form()){
					return false;
				}
				/**if('${(course.type)!}' == 'mic'){
					var content = ue.getContent();
					$('#courseContent').val(content);
				}*/
				var data = $.ajaxSubmit('saveCourseForm');
				var json = $.parseJSON(data);
				if(json.responseCode == '00'){
					alert('提交成功');
				}
			}
			
			function reload(id){
				window.location.href = '${ctx!}/make/course/'+id+'/editCourseConfig';
			}
			</script>
	</@courseConfig>
</@layout>