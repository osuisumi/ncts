<div class="g-addElement-lyBox">
	<form id="resourceLibForm" action="${ctx}/resource/lib">
		<input type="hidden" name="resourceRelations[0].relation.id" value="${(resource.resourceRelations[0].relation.id)!'' }">
		<input type="hidden" name="resourceRelations[0].relation.type" value="${(resource.resourceRelations[0].relation.type)!'' }">
		<input type="hidden" name="resourceExtend.stage" value="${(resource.resourceExtend.stage)!'' }">
		<input type="hidden" name="resourceExtend.subject" value="${(resource.resourceExtend.subject)!'' }">
		<div class="g-uploadFill">
			<div class="g-upload-tl">
				<h3>
					公共资源库
					<!-- <span>（已选 <ins class="num">0</ins> ）</span> -->
				</h3>
				<div class="m-selectbox m-selectbox-One">
                    <strong>
                        <span class="simulateSelect-text">全部</span>
                        <i class="trg"></i>
                    </strong>
                    <ul id="subjectSelect" class="m-zone-Sel" style="width: 110px;">
                        <li onclick="changeSubject(this)" value="">全部</li>
                    </ul>
                </div>      
				<div class="m-selectbox m-selectbox-Two">
                    <strong>
                        <span class="simulateSelect-text">全部</span>
                        <i class="trg"></i>
                    </strong>
                    <ul id="stageSelect" class="m-zone-Sel">
                        <li onclick="changeStage(this)" value="" class="crt">全部</li>
                    </ul>
                    <script>
				    	$(function(){
				    		$.get('${ctx }/textBook/getEntryList','textBookTypeCode=STAGE',function(data){
				    			$(data).each(function(){
				    				$('#stageSelect').append('<li onclick="changeStage(this)" value="'+this.textBookValue+'">'+this.textBookName+'</li>');
				    			});
				    			selectLi($('#stageSelect li[value="${((resource.resourceExtend.stage)!"")}"]'));
				    		});
				    	});
				    	
				    	$(function(){
				    		$.get('${ctx }/textBook/getEntryList','textBookTypeCode=SUBJECT',function(data){
				    			$(data).each(function(){
				    				$('#subjectSelect').append('<li onclick="changeSubject(this)" value="'+this.textBookValue+'">'+this.textBookName+'</li>');
				    			});
				    			selectLi($('#subjectSelect li[value="${((resource.resourceExtend.subject)!"")}"]'));
				    		});
				    	});
				    	
				    	function changeStage(obj){
			    			var value = $(obj).attr('value');
		    				var data = 'textBookTypeCode=SUBJECT&stage='+value;
				        	$.get('${ctx }/textBook/getEntryListByEntity',data,function(data){
				        		$('#subjectSelect').empty().append('<li value="">全部</li>');
				        		$(data).each(function(){
				        			$('#subjectSelect').append('<li onclick="changeSubject(this)" value="'+this.textBookValue+'">'+this.textBookName+'</li>');
				        		});
				    		});
				        	$('#resourceLibForm input[name="resourceExtend.stage"]').val(value);
				        	submitResourceLibForm();
			    		}
				    	
				    	function changeSubject(obj){
				    		var value = $(obj).attr('value');
				    		$('#resourceLibForm input[name="resourceExtend.subject"]').val(value);
				        	submitResourceLibForm();
				    	}
				    </script>
                </div>  
                <label class="m-srh">
                    <input name="title" id="resourceSearchTxt" value="${(resource.title)! }" type="text" class="ipt" placeholder="搜索"
                    	onkeydown='if(event.keyCode==13){return false;}'>
                    <i class="u-srh1-ico"></i>

                </label>           
				<script>
                	$(function(){
                		$('#resourceSearchTxt').keydown(function(e){
              				if(e.keyCode==13){
              					submitResourceLibForm();
              				}
              		    });
                	});
                </script>
			</div>
			<@resourcesDataDirective stage=(resource.resourceExtend.stage)!'' subject=(resource.resourceExtend.subject)!'' notExistsRelationType=(resource.resourceRelations[0].relation.type)!'' notExistsRelationId=(resource.resourceRelations[0].relation.id)!'' getFile=true title=(resource.title)!'' belong="public" page=pageBounds.page limit=5 orders="CREATE_TIME.DESC">
				<ul class="g-myCourse-lst g-manage-myCourse" id="manageRecycleList">
					<#list resources as resource>
						<li class="resourceLi m-fig-viewList">
							<label class="m-radio-tick">
		                        <strong class="on">
		                            <i class="ico"></i>
		                            <input type="radio" name="resource" class="resourceChoose" value="${(resource.id)! }">
		                        </strong>
		                    </label>
							<div class="mask"></div> 
							<div class="figure">
		                        <#if (FileTypeUtils.getFileTypeClass((resource.fileInfos[0].fileName)!, 'suffix')! != 'img')>
							   		<a class="u-file-type ${FileTypeUtils.getFileTypeClass((resource.fileInfos[0].fileName)!, 'resource') }" ></a>
							    <#else>
									<img src=${FileUtils.getFileUrl((resource.fileInfos[0].url)!)} class="u-file-type"/>
							    </#if>
		                    </div>
							<h3 class="tt">
								<a href="javascript:void(0);" class="name">${(resource.title)! }</a>
							</h3>
							<div class="m-btn">
								<a onclick="previewFile('${(resource.fileInfos[0].id)!}')" href="javascript:;" class="u-see"><i class="u-view-ico"></i>预览</a>
								<a onclick="downloadFile('${(resource.fileInfos[0].id)!}','${(resource.fileInfos[0].fileName)!}')" href="javascript:;" class="u-download"><i class="u-download-ico"></i>下载</a> 
							</div>
						</li>
					</#list>
				</ul>
				<div id="myResourcePage" class="m-laypage"></div>
	            <#import "/common/pagination-layer.ftl" as p/>
				<@p.paginationLayerFtl formId="resourceLibForm" divId="myResourcePage" paginator=paginator refreshDivId="resourceLibDiv" />
			</@resourcesDataDirective>
			<ul class="g-addElement-lst g-addCourse-lst">
				<li class="m-addElement-btn">
					<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a> 
					<a onclick="chooseResource()" href="javascript:void(0);" class="btn u-main-btn" id="confirmLayer">选择</a>
				</li>
			</ul>
		</div>
	</form>
</div>
<script type="text/javascript">
	$(function() {
		//多选按钮模拟
	    $('.m-radio-tick input').bindCheckboxRadioSimulate();
	    //addupFill_num();
	    
	    Sele_choose(".m-selectbox-Two"); //模拟select 选择
		Sele_choose(".m-selectbox-One"); //模拟select 选择
	});
	
	function submitResourceLibForm(){
		$('#resourceLibForm #currentPage').val(1);
		mylayerFn.refresh({
            id: 'resourceLibDiv',
            content: $('#resourceLibForm').attr('action') + '?' + $('#resourceLibForm').serialize()
        });
	}
	
	function chooseResource(){
		var count = $('#resourceLibForm .resourceChoose:checked').length;
		if(count > 0){
			var $check = $('#resourceLibForm .resourceChoose:checked');
			var id = $check.val();
			$.post('${ctx}/resource/relation', 
					'resource.id='+id+'&relation.id=${resource.resourceRelations[0].relation.id}&relation.type=${resource.resourceRelations[0].relation.type}',
					function(data){
						if(data.responseCode == '00'){
							submitListResourceForm();
							$('.mylayer-cancel').trigger('click');
						}
					}
			);
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
	function Sele_choose(selectbox){//模拟select 选择
	    var Sele=true;
	    $(""+selectbox).on('click','strong',function(event) {
	        if(Sele==true){
	            $(this).siblings('.m-zone-Sel').css({"display":"block"});
	            Sele=false;
	        }else{
	            $(this).siblings('.m-zone-Sel').css({"display":"none"});
	            Sele=true;
	        }
	        
	         $(document).on("click",function(e){
	             // alert(11)
	             var target = $(e.target);              
	            if(target.closest(selectbox).length == 0){
	                $(selectbox).children(".m-zone-Sel").css({"display":"none"});
	                Sele=true;

	            }
	         })
	        
	    });
	    $(".m-zone-Sel").on('click','li',function(event) {
	    	selectLi(this);
	    });
	}
	
	function selectLi(obj){
		var Sel_text = $(obj).text();
        $(obj).addClass('crt').siblings().removeClass('crt');
        $(obj).parents(".m-selectbox").find(".simulateSelect-text").text(Sel_text);
        $(obj).parents(".m-zone-Sel").css({"display":"none"});
        Sele=true;
	}
</script>