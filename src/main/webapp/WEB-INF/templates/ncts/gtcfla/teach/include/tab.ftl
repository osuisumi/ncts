 <#macro tabFtl>
 	<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
	<#assign sid=(CSAIdObject.getCSAIdObject().scid)!>
	<#assign aid=(CSAIdObject.getCSAIdObject().aid)!>
	<@courseDirective id=cid>
		<#assign course=courseModel>
	</@courseDirective>
	<div class="g-cl-menu">
		<p class="u-tit"><i class="u-ico-book"></i><span class="topCourseName">${course.title}</span></p>
            <a item="teach" href="${ctx}/teach/course/${cid!}" class="z-crt">课程辅导</a>
            <a item="resource" href="${ctx}/${cid!}/teach/resource">课程资源</a>
            <a item="discussion" href="${ctx}/${cid!}/teach/course/discussion?limit=10&paramMap[relationId]=${cid!}&paramMap[relationType]=courseStudy&orders=CREATE_TIME.DESC">课程讨论</a>
            <a item="assignment" href="${ctx}/${cid!}/teach/assignment/biz/listAssignmentUser">作业批阅</a>
            <a item="statistic" href="${ctx}/${cid!}/teach/course/statistic">课程统计</a>
        </div>
    </div>
    <script>
    	function lightMenu(item){
    		$('.m-cl-menu a').removeClass('z-crt');
		    $('.m-cl-menu a[item='+item+']').addClass('z-crt');
    	}
    </script>
</#macro> 