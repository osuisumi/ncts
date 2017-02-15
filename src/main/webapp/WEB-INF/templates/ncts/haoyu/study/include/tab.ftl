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
            <a item="study" href="${ctx}/study/course/${cid!}" class="nav1 z-crt"><i class="u-ico-book"></i>课程学习</a>
            <a item="resource" href="${ctx}/${cid!}/study/resource" class="nav2"><i class="u-ico-res"></i>课程资源</a>
            <a item="discussion" class="nav3" href="${ctx}/${cid!}/study/course/discussion?limit=10&paramMap[relationId]=${cid!}&paramMap[relationType]=courseStudy&orders=CREATE_TIME.DESC"><i class="u-ico-discuss"></i>课程讨论</a>
            <a item="progess" class="nav4" href="${ctx}/${cid!}/study/course/progess"><i class="u-ico-progress"></i>学习进度</a>
            <a item="schedule" class="nav5" href="${ctx}/${cid!}/study/schedule/my"><i class="u-ico-plan"></i>学习计划</a>
        </div>
    </div>
    <script>
    	function lightMenu(item){
    		$('.m-cl-menu a').removeClass('z-crt');
		    $('.m-cl-menu a[item='+item+']').addClass('z-crt');
    	}
    </script>
</#macro>