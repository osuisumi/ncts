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
            <a item="study" href="${ctx}/study/course/${cid!}" class="z-crt">课程学习</a>
            <a item="resource" href="${ctx}/${cid!}/study/resource">课程资源</a>
            <a item="discussion" href="${ctx}/${cid!}/study/course/discussion?limit=10&paramMap[relationId]=${cid!}&paramMap[relationType]=courseStudy&orders=CREATE_TIME.DESC">课程讨论</a>
            <a item="progess" href="${ctx}/${cid!}/study/course/progess">学习进度</a>
            <a item="schedule" href="${ctx}/${cid!}/study/schedule/my">学习计划</a>
        </div>
    </div>
    <script>
    	function lightMenu(item){
    		$('.m-cl-menu a').removeClass('z-crt');
		    $('.m-cl-menu a[item='+item+']').addClass('z-crt');
    	}
    </script>
</#macro>