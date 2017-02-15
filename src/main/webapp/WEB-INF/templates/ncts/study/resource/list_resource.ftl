<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<#assign scid=(CSAIdObject.getCSAIdObject().scid)!>
<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
<#if hasTeachRole>
	<#assign role='teach'>
	<#include "/ncts/teach/include/layout.ftl"/>
<#else>
	<#assign role='study'>
	<#include "/ncts/study/include/layout.ftl"/>
</#if>
<@layout>
<@resourceRelationsData courseId=cid! resource=resource! pageBounds=pageBounds>

<div class="g-cl-content">	
	<div class="g-cl-boxP g-cl-resource">
        <div class="g-sBox-tp">
            <div id="breadcrumb" class="row-t f-cb">
                <div class="m-catalog-crm">
                    <a onclick="searchResource('${cid}','course')" class="all z-crt">全部（<ii id="totalCount">${(paginator.totalCount)!'0'}</ii>）<i></i></a>
                	<span class="line">></span><span class="txt"></span>
                </div>
                <label class="m-srh">
	                <input id="searchTxt" type="text" vaule="" class="ipt" placeholder="搜索">
	                <i onclick="searchTxt(this)" class="u-srh1-ico"></i>
	                <script>
                    	$(function(){
                    		$('#searchTxt').keydown(function(e){
                  				if(e.keyCode==13){
                  					if($('#searchTxt').val().trim() == ''){
                  						searchResource('${cid}','course');
                  					}else{
                  						searchResource(0,'title');
                  					}
                  				}
                  		    });
                    	});
                    </script>
                </label>
            </div>
            <div class="row-b f-cb">
                <div class="fl">
                    <a class="btn u-inverse-btn showAllSectionBtn"><i class="u-iTxts-ico"></i>按章节查看资源</a>
                </div>
               	<#if hasTeachRole>
               		<div class="fl m-Stresouce-load">
               			<a class="btn u-inverse-btn upload"><i class="u-download-ico u-download-ico2"></i>上传资源</a>
               			<#if (PropertiesLoader.get('resource.public.lib.is.user') == 'true')>
               				<span style="margin-left: 16px;"></span>
               				<a onclick="openResourceLib()" class="btn u-inverse-btn"><i class="u-download-ico u-download-ico2"></i>从资源库选择</a>
               			</#if>
               		</div>
               	</#if>
                <div class="m-viewMode">
                    <a id="listDisplay" onclick="changeDisplay('list')" class="u-view-list z-crt" title="列表模式"><i class="u-viewL-ico"></i></a>
                    <a id="tiledDisplay" onclick="changeDisplay('tiled')" class="u-view-tiled" title="平铺模式"><i class="u-viewT-ico"></i></a>
                </div>
            </div>
        </div>
        <div class="g-fileType-box">
        	<#if (resourceRelations)?size gt 0>
	        	<div id="listDisplayDiv" style="display:block;">
	            <ul id="resourcesList" class="g-fileType-lst" >        
				<#list resourceRelations as resourceRelation>
					<#assign res=resourceRelation.resource>
					<li class="listDisplayLi" style="display:block;">
						<div class="m-fileType-block">
							<div class="u-file-box">
								<#if (FileTypeUtils.getFileTypeClass((res.fileInfos[0].fileName)!, 'resource')! != 'img')>
							   		<a class="${FileTypeUtils.getFileTypeClass((res.fileInfos[0].fileName)!, 'resource') }" ></a>
							    <#else>
									<img src=${FileUtils.getFileUrl((res.fileInfos[0].url)!)} class="u-file-type"/>
							    </#if>
						    </div>
						    <h3 class="tt"><a>${(res.title)!}</a></h3>
						    <#if (resourceRelation.relation.type)! == 'section'>
						    <div class="btn-row">
						        <a onclick="searchResource('${(resourceRelation.relation.id)!}','section')" class="u-view-btn btn">
						        <#if sectionTitles?exists>
									${sectionTitles[resourceRelation.relation.id]!}
								</#if>
						        </a>
						    </div>
						    </#if>
						    <span class="size">
						    	<#if (((res.fileInfos[0].fileSize /1024/1024)!0) > 0.01) >
						    		${(res.fileInfos[0].fileSize /1024/1024)!0}MB
						    	<#else>
						    		${(res.fileInfos[0].fileSize /1024)!0}KB
						    	</#if>
						    </span>
						    <span class="size" style="right: 90px;">
						    	上传者: ${(resourceRelation.creator.realName)! }
						    </span>
						    <div class="opt">
						      	<a onclick="previewFile('${(res.fileInfos[0].id)!}')" class="u-opt u-iView hov"><i class="u-iView-ico"></i><span class="tip">预览</span></a>
						        <a class="u-opt u-iDownload hov"><i class="u-bDownload-ico" onclick="downloadFile('${(res.fileInfos[0].id)!}','${(res.fileInfos[0].fileName)!}')"></i><span class="tip">下载</span></a>
						        <#if hasTeachRole && resourceRelation.creator.id == Session.loginer.id>
						        	<a class="u-opt u-iDownload alter hov" resourceId="${(res.id)!}" scid="${(resourceRelation.relation.id)!}"><i class="u-study-bedit-ico"></i><span class="tip">编辑</span></a>
						        </#if>
						        <#if hasTeachRole && resourceRelation.creator.id == Session.loginer.id>
						        	<a class="u-opt u-iDownload delete hov" resourceId="${(res.id)!}" resourceRelationId="${(resourceRelation.id)!}"><i class="u-study-bdel-ico"></i><span class="tip">删除</span></a>
						        </#if> 
						    </div>
						</div>
					</li>
					<li class="tiledDisplayLi"  style="display:none;">
		                <div class="m-ftTiled-block">
		                	<div class="u-file-box">
								<#if (FileTypeUtils.getFileTypeClass((res.fileInfos[0].fileName)!, 'resource')! != 'img')>
							   		<a class="${FileTypeUtils.getFileTypeClass((res.fileInfos[0].fileName)!, 'resource') }" ></a>
							    <#else>
									<#import "/common/image.ftl" as image/>
									<@image.imageFtl url=(res.fileInfos[0].url)! default="${app_path}/images/defaultAvatarImg.png" class="u-file-type"/>
							    </#if>
						    </div>	
		                    <h3 class="tt"><a href="javascript:void(0);">${(res.title)!}</a></h3>
		                    <div class="opt">
		                       	<a onclick="previewFile('${(res.fileInfos[0].id)!}')" class="u-opt u-view"><i class="u-view-ico"></i><span class="tip">预览</span></a>
		                        <span class="line">|</span>
		                        <a class="u-opt u-download"><i class="u-download-ico" onclick="downloadFile('${(res.fileInfos[0].id)!}','${(res.fileInfos[0].fileName)!}')"></i><span class="tip">下载</span></a>
		                   		<#if hasTeachRole && resourceRelation.creator.id == Session.loginer.id>
		                   			<span class="line">|</span>
			                   		<a class="u-opt u-iDownload alter hov" resourceId="${(res.id)!}" scid="${(resourceRelation.relation.id)!}"><i class="u-study-bedit-ico"></i><span class="tip">编辑</span></a>
		                   		</#if>
		                   		<#if hasTeachRole && resourceRelation.creator.id == Session.loginer.id>
		                            <span class="line">|</span>
		                            <a class="u-opt u-iDownload delete hov" resourceId="${(res.id)!}" resourceRelationId="${(resourceRelation.id)!}"><i class="u-study-bdel-ico"></i><span class="tip">删除</span></a>
		                   		</#if>
		                    </div>
		                </div>
		            </li>
				</#list>
	            </ul>
	            </div>
				<form id="listResourceForm"  method="post" action="${ctx!}/${cid!}/${role}/resource">	
					<input type="hidden" name="orders" value="${(order[0])!'CREATE_TIME.DESC'}">
					<input class="limit" type="hidden" name="limit" value="${(limit[0])!15}" >
					<input type="hidden" name="title" value="${(resource.title)!}" >
					<input type="hidden" name="_method" value="get" >
					<input id="relationId" type="hidden" name="resourceRelations[0].relation.id" value="${(resource.resourceRelations[0].relation.id)!}" >
					<input id="relationType" type="hidden" name="resourceRelations[0].relation.type" value="${(resource.resourceRelations[0].relation.type)!}">
					<input id="showType" type="hidden" name="showType" value="${(showType[0])!'list'}">
				    <div id="myCoursePage" class="m-laypage"></div>
				    <#import "/common/pagination.ftl" as p/>
					<@p.paginationFtl formId="listResourceForm" divId="myCoursePage" paginator=paginator />
				</form>
			<#else>
				<div class="g-no-notice-Con">
				    <p class="txt">目前还没有课程资源</p>
				</div>
	        </#if>
        </div>
        
        <div class="m-sectionLayer-mask"></div>
        <div class="g-studySection-layer" id="studyCatalogLayer">
            <a href="javascript:;" class="u-closeLayerBtn closeSectionLayerBtn"><span class="n1">章节</span><span class="n2">关闭</span><i class="u-iClose-ico"></i></a>
            <#list sections as section>
            <ul class="g-course-catalog">
                <li>
                    <dl class="m-course-catalog">
                        <dt class="z-crt">
                            <h3 class="tt-b"><i class="u-catalog-ico"></i>${section.title!}</h3>
                            <div class="tr"><a href="javascript:;" class="opt"></a></div>
                        </dt>
                        <#list section.childSections as childSection>
                        <dd>
                            <a href="javascript:;" class="tt-s <#if scid! == childSection.id>z-crt </#if>" onclick="searchResource('${childSection.id}','section')">
                                <span id="m-course-catalog_${childSection.id!}" class="txt">${childSection.title!}</span>
                                <span class="tr"><i class="u-iText-ico"></i></span>
                            </a>
                        </dd>
                        </#list>
                    </dl>
                </li>
            </ul>
            </#list>
        </div>
    </div>
</div>
</@resourceRelationsData>
</@layout>
<script type="text/javascript"> 
 $(function(){
	lightMenu('resource');
 	courseLearningFn.sectionCatalog();
 	showSearchBoxAnimate();
    showBreadcrumbNavigation();
    changeDisplay($('#showType').val());
    $('#searchTxt').val($('#listResourceForm input[name="title"]').val());
    
  //如果是预览, 去掉部分菜单栏
	if('${SecurityUtils.getSubject().hasRole("preview_"+cid)?string("Y","N")}' == 'Y'){
		$('.m-cl-menu a[item="discussion"]').remove();
		$('.m-cl-menu a[item="progess"]').remove();
		$('.m-cl-menu a[item="schedule"]').remove();
	}
    
    //新增资源
    $(".btn.u-inverse-btn.upload").on("click",function(){    
        mylayerFn.open({
        type: 2,
        title: '上传资源',
        fix: false,
        area: [800, 650],
        content: '${ctx!}/${cid!}/${role}/resource/create',
        shadeClose: true,
        offset:[$(document).scrollTop()]
    	});
    });
    
    //修改资源
    $(".u-opt.alter").on("click",function(){
        mylayerFn.open({
        type: 2,
        title: '编辑资源',
        fix: false,
        area: [800, 650],
        content: '${ctx!}/'+$(this).attr('scid')+'/${role}/resource/'+$(this).attr('resourceId')+'/edit',
        shadeClose: true,
        offset:[$(document).scrollTop()]
    	});
    });
    
    //删除资源
    $(".u-opt.delete").on("click",function(){
    	var data = 'id='+$(this).attr('resourceId');
    	data = data + '&resourceRelations[0].id=' + $(this).attr('resourceRelationId'); 
    	var _this = $(this);
	    mylayerFn.confirm({
	        content: "确定删除？",
	        icon: 3,
	        yesFn: function(){
				$.ajaxDelete('${ctx!}/${role}/resource',data,function(response){
			    	if(response.responseCode == '00'){
			    		alert('删除成功');
						_this.closest('li').remove();
						$('#totalCount').text(parseInt($('#totalCount').text())-1);
			    	}
		    	}); 
	        }
	    });
    });
});

//显示面包屑
function showBreadcrumbNavigation(){
    var sectionTitle = $('#m-course-catalog_${scid!}').text();
  	var type =$('#listResourceForm #relationType').val();
    if(sectionTitle.length > 0 && type == 'section'){
    	$('#breadcrumb span').show();
		$('#breadcrumb span:eq(1)').text(sectionTitle);
    }else{
    	$('#breadcrumb span').hide();
    }
}

//搜索框动画
function showSearchBoxAnimate(){
    $(".m-srh .ipt").on('blur',function(){
		var $this = $(this),
		    icon = $this.next();
		//如果value值为空，执行缩回动画，反之不执行
		if($this.val() == ''){
		    $this.stop().animate({
		        'width' : 60 + 'px',
		        'padding-left' : 98 + 'px'
		    },500);
		    icon.stop().animate({
		        'right': 100 + 'px'
		    },500);
		    searchResource('${cid}','course');
		}
    }); 
}

function searchResource(id,type){
	if(type == 'title'){
		$('#listResourceForm input[name="title"]').val($.trim($('#searchTxt').val()));
		$('#listResourceForm #relationId').val('${cid!}');
		$('#listResourceForm #relationType').val('course');
	}else{	
		$('#listResourceForm #relationId').val(id);
		$('#listResourceForm #relationType').val(type);
		$('#listResourceForm input[name="title"]').val('');
	}
	var url = '${ctx!}/${cid!}/${role}/resource';
	if(type == 'section'){
		url = '${ctx!}/${cid!}/'+id+'/${role}/resource';
	}
	$('#listResourceForm').attr('action',url);
	$('#listResourceForm #currentPage').val(1);
	submitListResourceForm();
}

function submitListResourceForm(){
	$('#listResourceForm').submit();
}

//根据搜索框内容查询
function searchTxt(o){
	if($(o).parent().hasClass('hasValue') == true){
		if($.trim($('#searchTxt').val()) == ''){
			searchResource('${cid}','course');
		}else{
			searchResource(0,'title');
		}
	}
}
                    	
//显示模式 
function changeDisplay(type){
	if(type == 'list'){
		$('#resourcesList').attr('class','g-fileType-lst');
		$('.listDisplayLi').show();
		$('.tiledDisplayLi').hide();
		$('#listDisplay').addClass('z-crt');
		$('#tiledDisplay').removeClass('z-crt');
		$('#showType').val('list');
	}
	if(type == 'tiled'){
		$('#resourcesList').attr('class','g-ftTiled-lst');
		$('.listDisplayLi').hide();
		$('.tiledDisplayLi').show();
		$('#listDisplay').removeClass('z-crt');
		$('#tiledDisplay').addClass('z-crt');
		$('#showType').val('tiled');
	}
}

function openResourceLib(){
	var data = '';
	if('${scid!""}' != ''){
		$('#openResourceLibForm input[name="resourceRelations[0].relation.id"]').val('${scid}');
		$('#openResourceLibForm input[name="resourceRelations[0].relation.type"]').val('section');
	}else{
		$('#openResourceLibForm input[name="resourceRelations[0].relation.id"]').val('${cid}');
		$('#openResourceLibForm input[name="resourceRelations[0].relation.type"]').val('course');
	}
	mylayerFn.open({
		id: 'resourceLibDiv',
        type: 2,
        title: '公共资源库',
        fix: false,
        area: [$(window).width()*90/100, $(window).height()*99/100],
        content: '${ctx}/resource/lib?'+$('#openResourceLibForm').serialize(),
        shadeClose: true
    });
}
</script>