<#macro editTagFtl relationId paramPrefix>  
	<#if relationId??>
		<script>
			$.get('/tags','relation.id=${relationId}',
				function(data) {
					if (data != null) {
						var $tag_lst = $("#tagList");
						$.each(data, function(i, tag) {
							$tag_lst.append('<li id="'+tag.id+'" class="tagLi">'
												+ '<span class="txt">'+ tag.name+ '</span>'
												+ '<a href="javascript:void(0);" class="dlt" title="删除标签">×</a>'
											+ '</li>');
							});
					}
					commonJs.tag.init('${paramPrefix}');
				});
		</script>
	</#if>
	<div class="m-tagipt m-pbMod-ipt">
	    <input id="tagText" type="text" placeholder="添加标签，如：教案" value="" class="u-pbIpt">
	    <a id="addTagBtn" href="javascript:void(0);" class="u-add-tag u-opt-btn"><i class="u-plus-ico"></i>添加</a>
	    <div class="l-slt-lst">
	        <i class="trg"></i>
	        <i class="trgs"></i>
	        <div id="tagSelect" class="lst">
	            
	        </div>
	    </div>
	</div>
	<ul id="tagList" class="m-tag-lst">
		
	</ul>
</#macro>