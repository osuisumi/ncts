<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<#assign sid=(CSAIdObject.getCSAIdObject().scid)!>
<@notes note=note pageBounds=pageBounds courseId=cid>
	<div id="sectionCountsList" style="display:none;">
	<#if sectionCounts?exists>
		<#list sectionCounts?keys as key>
			<div value="${key}">
			${sectionCounts[key]!'0'}
			</div>
		</#list>
	</#if>
	</div>
	<#list notes as note>
		<li>
			<div class="box">
				<div class="time-blcok">
				<span class="time">${note.updateTime?number_to_datetime?string("HH:mm")!}</span> 
				<span class="date">${note.updateTime?number_to_datetime?string("yyyy.MM.dd")!}</span>						
			    </div>
				<div class="txt-block">
					<p class="m-notes-dl" id="${note.id}" >${note.content!}</p>
					<#if sectionTitles?? && (sectionTitles?size>0)>
						<a href="javascript:;" class="btn" onclick="searchNote('${(note.relation.id)!}','section')">
							${(sectionTitles[note.relation.id])!''}
						</a>
					</#if>
                    <div class="m-community-disc-txt m-discu-Pwktxt">
                        <div class="m-pbMod-ipt">
                            <textarea name="" class="u-textarea u-pbIpt-comm-dis u-pbIpt-comm" style="display: none;"></textarea>
                        </div> 
                    </div> 
				</div>
			</div>
		</li>
	</#list>
	<#import "/common/pagination-ajax.ftl" as p/>
	<@p.paginationAjaxFtl formId="noteForm" divId="myCoursePage" refreshDivId="noteList" paginator=paginator />
</@notes>
<script language="javascript" type="text/javascript">
	$(function(){
		//搜索框有内容不缩回
		$('#searchContent').val($('#hiddenContent').val());
		if($.trim($('#searchContent').val()) != ''){
			$('#searchContent').parent().addClass('in');
		};
		
		//搜索框动画
	    showSearchBoxAnimateForNote();
	    
    	$('.m-layer-crm .all').html('全部（<span id="noteCount">'+${(paginator.totalCount)!'0'}+'</span>）');
    	$('#noteCount').text('${(paginator.totalCount)!}');
		$('#page').val('${(paginator.page)!1}');
		$('#limit').val('${(paginator.limit)!}');
		$('#totalCount').val('${(paginator.totalCount)!}');
		
		$('#searchContent').bind('keydown',function(event){
            if(event.keyCode == "13")    
            {
            	return false;
            }
        });
        
        isChecked();
		appendSectionCount();
		isDisplayForLoadMoreNote();
		got_textarea();
	});
</script>