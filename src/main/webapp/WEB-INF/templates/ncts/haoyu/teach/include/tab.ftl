 <#macro tabFtl>
 	<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
	<#assign sid=(CSAIdObject.getCSAIdObject().scid)!>
	<#assign aid=(CSAIdObject.getCSAIdObject().aid)!>
	<@courseDirective id=cid>
		<#assign course=courseModel>
	</@courseDirective>
	<div class="g-cl-menu">
		<p class="u-tit"><i class="u-ico-book"></i><span class="topCourseName">${course.title}</span></p>
        <div class="m-cl-menu">
            <a item="teach" href="${ctx}/teach/course/${cid!}" class="nav1 z-crt"><i class="u-ico-book"></i>课程辅导</a>
            <a item="resource" href="${ctx}/${cid!}/teach/resource" class="nav2"><i class="u-ico-res"></i>课程资源</a>
            <a item="discussion" class="nav3" href="${ctx}/${cid!}/teach/course/discussion?limit=10&paramMap[relationId]=${cid!}&paramMap[relationType]=courseStudy&orders=CREATE_TIME.DESC"><i class="u-ico-discuss"></i>课程讨论</a>
            <a item="assignment" class="nav4" href="${ctx}/${cid!}/teach/assignment/biz/listAssignmentUser"><i class="u-ico-plan"></i>作业批阅</a>
            <a item="statistic" class="nav5" href="${ctx}/${cid!}/teach/course/statistic"><i class="u-ico-progress"></i>课程统计</a>
        </div>
    </div>
    <script>
    	function lightMenu(item){
    		$('.m-cl-menu a').removeClass('z-crt');
		    $('.m-cl-menu a[item='+item+']').addClass('z-crt');
    	}
    </script>
</#macro> 