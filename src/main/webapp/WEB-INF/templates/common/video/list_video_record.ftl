<div class="g-addElement-lyBox">
	<form id="listVideoRecordForm" action="${ctx}/video/record">
		<input type="hidden" name="parentCategory" value="${(parentCategory[0])! }">	
		<div class="g-uploadFill">
			<div class="g-upload-tl">
				<h3>
					视频列表
					<!-- <span>（已选 <ins class="num">0</ins> ）</span> -->
				</h3>
				<div class="m-selectbox">
					<strong> 
						<span class="simulateSelect-text">全部</span> 
						<i class="trg"></i>
					</strong>
					<ul id="categoryParam" class="m-zone-Sel" style="width: 115px">
						<li class="crt">全部科目</li>
						<@videoRecordCategoriesDirective> 
							<#if categories??>
								<#list categories as category>
									<li value="${category.key }">${category.value }</li>
								</#list>
							</#if>
						</@videoRecordCategoriesDirective> 
					</ul>
					<script>
						$('#categoryParam li').removeClass('.crt');
						$('#categoryParam li[value="${(parentCategory[0])!}"]').addClass('.crt');
						$('#categoryParam li').click(function(){
							$('#listVideoRecordForm input[name="parentCategory"]').val($(this).attr('value'));
							submitListVideoRecordForm();
						});
					</script>
				</div>
				<label class="m-srh"> 
					<input id="searchTxt" type="text" name="name" value="${(name[0])! }" class="ipt" placeholder="搜索视频名称" 
						onkeydown='if(event.keyCode==13) return false;'> 
					<i class="u-srh1-ico"></i>
				</label>
				<script>
                	$(function(){
                		$('#searchTxt').keydown(function(e){
              				if(e.keyCode==13){
              					$('#listVideoRecordForm input[name="name"]').val($(this).val());
              					submitListVideoRecordForm();
              				}
              		    });
                	});
                </script>
			</div>
			<@videoRecordsDirective parentCategory=(parentCategory[0])!'' name=(name[0])!'' page=pageBounds.page limit=5>
				<ul class="g-myCourse-lst g-manage-myCourse" id="manageRecycleList">
					<#if videoRecords??>
						<#list videoRecords as videoRecord>
							<li class="videoLi m-fig-viewList">
								<label class="m-radio-tick">
			                        <strong class="on">
			                            <i class="ico"></i>
			                            <input type="radio" name="videoRecord" class="videoRecordChoose" value="${(videoRecord.guid)! }">
			                        </strong>
			                    </label>
								<div class="mask"></div> 
								<a href="javascript:void(0);" class="figure"> 
									<img src="${(videoRecord.imgUrl)! }" alt="">
								</a>
								<h3 class="tt">
									<a href="javascript:void(0);" class="name">${(videoRecord.name)! }</a>
								</h3>
								<div class="m-btn">
									<a onclick="viewVideoRecored('${(videoRecord.guid)!}')" href="javascript:;" class="u-see"><i class="u-view-ico"></i>观看</a> 
								</div>
							</li>
						</#list>
					</#if>
				</ul>
				<div id="myVideoRecordPage" class="m-laypage"></div>
	            <#import "/common/pagination-layer.ftl" as p/>
				<@p.paginationLayerFtl formId="listVideoRecordForm" divId="myVideoRecordPage" paginator=paginator! refreshDivId="videoLibDiv" />
			</@videoRecordsDirective>
			<ul class="g-addElement-lst g-addCourse-lst">
				<li class="m-addElement-btn">
					<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a> 
					<a onclick="chooseVideoRecord()" href="javascript:void(0);" class="btn u-main-btn" id="confirmLayer">选择</a>
				</li>
			</ul>
		</div>
	</form>
</div>
<script type="text/javascript">
	$(function() {
		//多选按钮模拟
	    $('.m-radio-tick input').bindCheckboxRadioSimulate();
	    addupFill_num();
		Sele_choose(); //模拟select 选择
	});
	
	function viewVideoRecored(id){
		$.get('${ctx}/video/record/'+id+'/entity', '', function(result){
			if(result != null){
				if(result.message != null && result.message != ''){
					alert(result.message);
					return false;
				}
				window.open(result.data.nr.replace('9300','9301'));
			}
		});
	}
	
	function submitListVideoRecordForm(){
		$('#listVideoRecordForm #currentPage').val(1);
		mylayerFn.refresh({
            id: 'videoLibDiv',
            content: $('#listVideoRecordForm').attr('action') + '?' + $('#listVideoRecordForm').serialize()
        });
	}
	
	function chooseVideoRecord(){
		var count = $('#listVideoRecordForm .videoRecordChoose:checked').length;
		if(count > 0){
			var $check = $('#listVideoRecordForm .videoRecordChoose:checked');
			var id = $check.val();
			var name = $check.parents('.videoLi').find('.name').text()
			chooseVideoFromLib(id, name);
			$('#listVideoRecordForm .mylayer-cancel').trigger('click');
		}
	}
	
	function addupFill_num() {//资源库列表添加个数
		var num = 0;
		$(".g-uploadFill .m-radio-tick input").click(function(event) {
			var input_type = $(this).parent("strong").attr("class");
			if (input_type == "on") {
				num = num + 1

			} else {
				num = num - 1	

			}
			$(this).parents(".g-uploadFill").find(".num").text(num);

		});

	}
	function Sele_choose() {
		var Sele = true;
		$(".m-selectbox strong").click(function(event) {
			if (Sele == true) {
				$(this).siblings('.m-zone-Sel').css({
					"display" : "block"
				});
				Sele = false;
			} else {
				$(this).siblings('.m-zone-Sel').css({
					"display" : "none"
				});
				Sele = true;
			}

			$(document).on("click", function(e) {
				// alert(11)
				var target = $(e.target);
				if (target.closest(".m-selectbox").length == 0) {
					$(".m-zone-Sel").css({
						"display" : "none"
					});
					Sele = true;

				}
			})

		});
		$(".m-zone-Sel li").click(function(event) {
			var Sel_text = $(this).text();
			$(this).addClass('crt').siblings().removeClass('crt');
			$(this).parents(".m-selectbox").find(".simulateSelect-text").text(Sel_text);
			$(".m-zone-Sel").css({
				"display" : "none"
			});
			Sele = true;
		});
	}
</script>