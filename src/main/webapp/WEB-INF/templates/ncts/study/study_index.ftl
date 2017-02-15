<#include "/ncts/make/include/layout.ftl"/>
<@layout>
                            	<@courseRegistersDataDirective courseRegister=courseRegister! pageBounds=pageBounds!>
									<ul class="courseUl g-myCourse-lst">
										<#list courseRegisters as cr>	
											<#assign course=cr.course>
		                                    <li class="m-fig-viewList unissue">
		                                        <a courseId="${course.id! }" href="javascript:void(0);" class="figure picker picker_${course.id! }">
		                                        </a>
		                                        <h3 class="tt"><a href="javascript:void(0);">${course.title!}</a></h3>
		                                        <p>
		                                            <i class="u-sList-ico"></i>
		                                            <span class="txt">${course.code!}</span>
		                                            <span class="link">/</span>
		                                            <span class="txt">${course.termNo!}</span>
		                                        </p>
		                                        <!-- <p><i class="u-sTime-ico"></i><span class="txt">开课时间: 2015/12/12</span></p> -->
		                                        <div class="optRow">
		                                            <a onclick="studyCourse('${course.id}', '${(cr.relation.id)! }')" href="javascript:void(0);" class="u-opt u-view"><i class="u-view-ico"></i><span class="tip">进入学习</span></a>
		                                        </div>
		                                    </li>
		                             	</#list>
									</ul>
								</@courseRegistersDataDirective>
    <form id="studyCourseForm">
    </form>
</@layout>
<script>
	function studyCourse(courseId, relationId){
		$('#studyCourseForm').attr('action', '${ctx}/study/course/'+courseId+'?relationId='+relationId);
		$('#studyCourseForm').submit();
	}
</script>