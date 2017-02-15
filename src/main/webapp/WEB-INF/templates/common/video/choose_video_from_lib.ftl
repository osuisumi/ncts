<#macro chooseVideoFromLibFtl video divId="videoRecordDiv" btnTxt="选择视频">
	<div class="m-pbMod-udload">
        <a onclick="openVideoLib()" href="javascript:void(0);" class="btn u-inverse-btn u-opt-btn"><i class="u-upload-ico"></i>${btnTxt }</a>
    </div>
    <ul class="fileList m-sfile-lst">
    	<li id="videoRecordLi" class="fileLi" style="display: none;">
    		<input class="recordId" name="video.recordId" type="hidden"/>
	        <i class="fileIcon u-sfile-ico video"></i>
	        <a class="name" style="max-width: 70%"></a>
	    </li>
    </ul>
    <#if ((video.urlsMap)?size > 0)>
		<script>
			var $li = $('#videoRecordLi').show();
			$li.find('.recordId').val('${video.recordId}');
			$li.find('.name').text('${(video.urlsMap.name)!}');
		</script>
	</#if>
    <script>
		function openVideoLib(){
			mylayerFn.open({
				id: 'videoLibDiv',
		        type: 2,
		        title: '视频资源库',
		        fix: false,
		        area: [$(window).width()*90/100, $(window).height()*99/100],
		        content: '${ctx}/video/record',
		        shadeClose: true
		    });
		}
		
		function chooseVideoFromLib(id, name){
			var $li = $('#videoRecordLi').show();
			$li.find('.recordId').val(id);
			$li.find('.name').text(name);
		}
    </script>
</#macro>