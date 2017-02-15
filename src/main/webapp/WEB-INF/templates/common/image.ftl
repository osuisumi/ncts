<#macro imageFtl url default userId='' userName='' class=''>
	<#if url != ''>
		<img src=${FileUtils.getFileUrl(url)} userId="${userId!}" userName="${userName!}" ctx="${ctx}" loginId="${ThreadContext.getUser().getId()}" class=${class}>
		<#else>
		<img src=${default} userId="${userId!}" userName="${userName!}" ctx="${ctx!}" loginId="${ThreadContext.getUser().getId()}" class="${class}">
	</#if>
</#macro>