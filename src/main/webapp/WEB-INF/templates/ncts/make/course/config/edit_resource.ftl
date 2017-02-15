<#macro editResourceFtl course> 
	<div id="listResourceDiv">
		<script>
			$('#listResourceDiv').load('${ctx}/${course.id}/make/course/listResource');
		</script>
	</div>
</#macro>