<@leadCourseContent courseId=cid>
	<#assign sections=sections>
</@leadCourseContent>

<script>
	$(function(){
	
		$(".m-selectbox select").simulateSelectBox();
	
		$("#studyNoteLayer").myTab({
	        pars    : '#studyNoteLayer',
	        tabNav  : '.m-studyF-tabli',
	        li      : 'a',       //标签
	        tabCon  : '.g-studyF-tabcont',
	        tabList : '.g-studyF-tablist',
	        cur     : 'z-crt',
	        page    : 0
	    });
	    courseLearningFn.sectionCatalog();
	    appendSectionCount();
	    
	});
	
	function noteContentDisplay(type){
		if(type == 'none'){
			$('#editNoteDiv').hide();
		}else if(type == 'block'){
			$('#editNoteDiv').show();
		}
	};
	
	//内容长度限制
	function isMaxLen(o) {
		var nMaxLen = o.getAttribute ? parseInt(o.getAttribute("maxlength")): "";
		if (o.getAttribute && o.value.length > nMaxLen) {
			o.value = o.value.substring(0, nMaxLen)
		}
		var curLength=o.value.length;
		$("#contentLength").html(curLength);
	};
	
	function saveNote() {
		var content = $('#noteContent').val();
		content = content.trim();
		if (content == '') {
			alert('笔记内容为空');
		} else {
			$.post("${ctx}/${sid}/${cid}/study/note", {
				'content' : content,
				'relation.id':$("#selectRelationId").val()
			}, function(response) {
				if (response.responseCode == '00') {
					alert('保存成功');
					clearNoteContent();
					$("#contentLength").html(0);
					loadNotes();
				}
			});
		}
	};
	
	//加载
	function loadNotes() {
		$.ajaxQuery('noteForm', 'noteList');
	};
	
	//清空
	function clearNoteContent() {
		$('#noteContent').val('');
		$("#contentLength").html(0);
		$('#saveNoteBtn').css('display','block');
		$('#updateNoteBtn').css('display','none');
	};
	
	//查询按钮事件
	function searchNote(id,type) {
		//清除分页信息
		var page = $('#page');
		page.val(1);
		
		//只按搜索框内容搜索
		if(type == 'content'){
			var searchContent = $('#searchContent').val();
			searchContent = searchContent.trim();
			if(searchContent != ''){
				$('#hiddenContent').val(searchContent);
				$('#relationType').val('course');
				$('#relationId').val('${cid}');
			}
		}
		//按节搜索
		if(type == 'section'){
			$('#relationId').val(id);
			$('#relationType').val('section');
			$('#hiddenContent').removeAttr('value');
		}
		//按课搜索
		if(type == 'course'){
			$('#relationId').val(id);
			$('#relationType').val('course');
			$('#hiddenContent').removeAttr('value');
		}
		clearNoteContent();
		loadNotes();
	}
	
	//把笔记数拼到章节的后面
	function appendSectionCount(){
		var sc = $('#sectionCountsList > div');
		var ico = $('.sectionCounts');
		$(sc).each(function(i,e){
			$(ico).each(function(){
				if($(e).attr('value') == $(this).attr('value')){
					$(this).html($(e).text());
				}
			});
		});
	};
		
	//搜索框动画
	function showSearchBoxAnimateForNote(){
	    var $ipts = $(".showSearchBox .ipt");
	    //获取焦点和失去焦点时执行动画
	    $ipts.on({
	        focus : function(){
	            $(this).parent().addClass('in');
	        },
	        blur : function(){
	            var $this = $(this);
	            //判断输入是否为空，不为空则不执行收回动画
	            if($.trim($this.val()) == ''){
	            	$this.parent().removeClass('in');
	            	searchNote('${cid}','course');
	            } 
	        }
	    });
	};
	
	//按搜索框内容查询
	function searchContent(){
		var searchContent = $('#searchContent').val().trim();
		if(searchContent != ''){
			searchNote(0,'content');
		}else{
			searchNote('${cid}','course');
		}
	}
	
	//只查询当前节
	function sectionOnly(chk){
		var strong = $(chk).closest('strong');
		var strongClass = strong.attr('class');
		if(strongClass != 'on'){
			searchNote('${sid}','section');
		}else{
			searchNote('${cid}','course');
		}
	};
	
	//加载更多
	function loadMoreNote(a) {
		$('#sectionCountsList').remove();
		var page = $('#page');
		page.val(parseInt(page.val()) + 1);
		var param = $('#noteForm').serialize();
		$.get('${ctx}/${sid}/${cid}/study/note?' + param, {}, function(response) {
			$('#noteList').append(response);
		});
		isDisplayForLoadMoreNote();
	};
	
	//判断加载更多按钮是否显示
	function isDisplayForLoadMoreNote(){
		var limit = $('#limit').val();
		var totalCount = $('#totalCount').val();
		var page = $('#page').val();
		if(parseInt(limit) * parseInt(page) >= parseInt(totalCount)){
			$('#loadMoreNote').css('display','none');
		}else{
			$('#loadMoreNote').css('display','block');
		}
	}
	
	//新查询后判断是否按节查询勾选单选框
	function isChecked(){
		if($('#relationType').val() == 'section'){
			$('#curSectioncheckbox').attr('checked','checked');
			$('#curSectioncheckbox').closest('strong').attr('class','on');
		}else{
			$('#curSectioncheckbox').attr('checked','');
			$('#curSectioncheckbox').closest('strong').attr('class','');
		}
	};
	
	//准备修改
	function got_textarea(){
		$(".m-notes-dl").on("click",function(){
		    var $note_textarea = $(this).siblings('.m-discu-Pwktxt').find(".u-textarea");
		    var this_val = $(this).text();
		    $(this).css({"display":"none"});
		    $note_textarea.css({"display":"block"}).val(this_val).focus();
		});
		$(".m-discu-Pwktxt .u-textarea").on("blur",function(){
		    var $m_notes_dl = $(this).parents(".m-discu-Pwktxt").siblings('.m-notes-dl');
		    this_val = $(this).val();
		    $m_notes_dl.css({"display":"block"}).text(this_val);
		    $(this).css({"display":"none"});
		    var noteId = $(this).closest('.txt-block').find('.m-notes-dl').attr('id');
			updateNote(noteId,this_val);
		});
	};
	
	//修改
	function updateNote(id,content){
		content = content.trim();
		if (content == '') {
			alert('笔记内容为空');
			return;
		}
		var data = 'id='+id+'&content='+content;
		$.ajax({
		     type : "post",
		     url : "${ctx!}/${cid!}/study/note/update?_method=PUT&" + data,
		     success : function(response) {
		     	 if (response.responseCode == '00') {
						//loadNotes();
					}
		     }
		}); 
	};
</script>

<#if sid! != ''>
	<form id="noteForm" action="${ctx!}/${sid!}/study/note" method="get">	
<#else>
	<form id="noteForm" action="${ctx!}/${cid!}/study/note" method="get">
</#if>
	<input id="relationType" type="hidden" name="relation.type" value="course">
	<input id="relationId" type="hidden" name="relation.id" value="${cid}">
	<input type="hidden" name="orders" value="UPDATE_TIME.DESC">
	<input id="hiddenContent" type="hidden" name="content" value="">	
	<a href="javascript:;" class="u-closeLayerBtn closeStudyLayerBtn"><span class="n1">笔记</span><span class="n2">关闭</span><i class="u-iClose-ico"></i></a>
	<div class="g-studyF-tab">
		<div class="g-studyF-tabli">
			<div class="m-studyF-tabli">
				<a href="javascript:;" onclick="noteContentDisplay('block')" class="item1 z-crt">写笔记</a> 
				<a href="javascript:;" onclick="noteContentDisplay('none')" class="item2">所有笔记</a>
			</div>
		</div>
		<div class="g-studyF-tabcont">
			<div class="g-studyF-tablist">
				<div id="editNoteDiv"  class="g-studyIpt-box">
					<div class="m-studyIpt-block">
						<div class="t-row">
							<div class="tl">笔记内容：</div>
							<div class="tr">
								<span class="txt-num"><span id="contentLength">0</span> / 1000</span>
							</div>
						</div>
						<div class="m-pbMod-ipt">
							<textarea name="" id="noteContent" class="u-textarea" placeholder="请输入笔记内容..." maxlength="1000" onkeyup="return isMaxLen(this)"></textarea>
						</div>
					</div>
					<div class="m-studyIpt-block">
						<div class="t-row">
							<div class="tl">节点：</div>
						</div>
						<div class="m-selectbox style1">
						<strong><span class="simulateSelect-text"></span><i class="trg"></i></strong> 
						<select id="selectRelationId" name="">
							<#list sections as section>
								<#list section.childSections as childSection> 
									<option value="${(childSection.id)!}">${(childSection.title)!}</option>
								</#list>
							</#list>
						</select>
						</div>
					</div>
					<div class="m-studyIpt-btn m-common-btn t-fr">
						<button id="saveNoteBtn" type="button" onclick="saveNote()" class="btn u-main-btn">完成</button>
						<button id="updateNoteBtn" type="button" class="btn u-main-btn" style="display:none;">修改</button>
						<button type="button" onclick="clearNoteContent()" class="btn u-inverse-btn">重置</button>
					</div>
				</div>
				
				<div class="m-frameT-opt">
					<div class="m-frameT-srh">
						<div class="tl">
							<div class="m-layer-crm">
								<a class="all z-crt">全部（<span id="noteCount">0</span>）<i></i></a>
							</div>
						</div>
						<div class="tr">
							<div class="srh showSearchBox">
								<i id="searchNote" class="t-ico" onclick="searchContent()"></i> <input id="searchContent" type="text" value="" class="ipt" placeholder="输入搜索内容...">
							</div>
						</div>
					</div>
					<div class="f-cb b-row">
						<div class="fl">
							<a href="javascript:;" class="btn u-inverse-btn showAllSectionBtn"><i class="u-iTxts-ico"></i>按章节查看笔记</a>
						</div>
						<div class="fr">
							<label class="m-checkbox-tick"> 
								<strong class=""> 
								<i class="ico"></i> 
								<input id="curSectioncheckbox" type="checkbox" onclick="sectionOnly(this)" >
							</strong> <span>只看当前节点</span>
							</label>
						</div>
					</div>
				</div>					
				
			<div class="g-studyNote-lstBox">
				<div class="g-studyNote-box">
					<div class="g-studyNote-lstBox">
						<ul id="noteList" class="g-studyNote-lst">
						</ul>
					</div>
				</div>
			</div>
			
			<div class="m-common-btn t-fc m-loadMore-btn" id="loadMoreNote">
				<input id="page" class="page" type="hidden" name="page" value="" />
				<input id="limit" class="limit" type="hidden" name="limit" value="" />
				<input id="totalCount" class="totalCount" type="hidden" name="totle" value="">
				<a href="javascript:;" onclick="loadMoreNote(this);"  class="btn u-inverse-btn">查看更多笔记</a>
			</div>
			<div id="myCoursePage" style="display:none;"></div>
		</div>
		<script>
			$(function(){
				loadNotes();
			})
		</script>
	</div>

</form>
	 <div class="m-sectionLayer-mask" style="display: none;"></div>
		<div class="g-studySection-layer" id="studyCatalogLayer">
			<a href="javascript:;" class="u-closeLayerBtn closeSectionLayerBtn"><span class="n1">章节</span><span class="n2">关闭</span><i class="u-iClose-ico"></i></a>
			<#list sections as section>
			<ul id="sectionList" class="g-course-catalog">
				<li>
					<dl class="m-course-catalog">
						<dt class="z-crt">
							<h3 class="tt-b">
								<i class="u-catalog-ico"></i>${section.title!}
							</h3>
							<div class="tr">
								<a href="javascript:;" class="opt"></a>
							</div>
						</dt>
						<#list section.childSections as childSection> 
							<#if sid! == '' && section_index == 0 && childSection_index == 0> 
								<#assign sid=(childSection.id)!> 
							</#if>
						<dd>
							<a id="${(childSection.id)!}" href="javascript:;"  onclick="searchNote('${(childSection.id)!}','section')"
							class="tt-s <#if sid == childSection.id>z-crt </#if>"> 
								<span class="txt">${(childSection.title)!}</span> 
								<span class="tr"><i class="u-iText-ico"></i>
								<i class="sectionCounts" value="${(childSection.id)!}" >0</i></span>
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

