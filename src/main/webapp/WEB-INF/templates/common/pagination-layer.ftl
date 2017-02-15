<#macro paginationLayerFtl formId divId paginator refreshDivId>
	<input id="currentPage" type="hidden" name="page" value="${paginator.page!1}" />
	<script>
		$(function(){
			laypage({
	            cont: '${divId}', 
	            pages: '${(paginator.totalPages)!0}', //通过后台拿到的总页数
	            curr: '${(paginator.page)!1}', //当前页
	            jump: function(obj, first){ //触发分页后的回调
	                if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
	                    $('#${formId}').find('#currentPage').val(obj.curr);
	                    mylayerFn.refresh({
				            id: '${refreshDivId}',
				            content: $('#${formId}').attr('action') + '?' + $('#${formId}').serialize()
				        });
	                }
	            }
	        });
		});
	</script>
</#macro>