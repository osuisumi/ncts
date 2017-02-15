<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<form id="noteForm" action="${ctx}/${cid}/study/note" method="get">
		<input id="relationType" type="hidden" name="relation.type" value="course">
		<input id="relationId" type="hidden" name="relation.id" value="${cid}">
		<input type="hidden" name="orders" value="UPDATE_TIME.DESC">
		<input type="hidden" name="creator.id">
		<input id="hiddenContent" type="hidden" name="content" value="">
		<div class="m-wk-test">
                <span class="u-arrow u-arrow-notes"></span>
                <div class="g-mn-mod">
                    <div class="m-community-box">
                        <div class="m-community-disc">
                            <div class="m-community-disc-txt m-com-wktxt">
                                <div class="m-pbMod-ipt">
                                    <textarea name="" id="noteContent"  class="u-textarea u-pbIpt-comm-dis u-pbIpt-comm" maxlength="1000" onkeyup="return isMaxLen(this)"></textarea>
                                </div> 
                            </div>  
                            <div class="m-commIpt-btn m-common-btn t-fr">
                                <button onclick="saveNote()" type="button" class="btn u-main-btn">发表</button>
                            </div>
                        </div>
                   		<h3 class="m-discu-wk-tl"><i class="notes"></i>共有<span id="noteCount">0</span>条笔记</h3>
           		        <div class="m-wk-discu">
                            <label class="m-radio-tick" onclick="searchNote('${cid!}','onlyMe')">
                                <strong>
                                    <i class="ico ico2"></i>
                                    <input type="radio" name="topic1"  value="">
                                    <span>只看我的</span>
                                </strong>
                                
                            </label>  
                            <label class="m-radio-tick" onclick="searchNote('${cid!}','all')">
                                <strong class="on">
                                    <i class="ico ico2"></i>
                                    <input type="radio" name="topic1" checked="checked" value="">
                                     <span>全部</span>
                                </strong>
                               
                            </label>                                                                      
                        </div>
						<div class="g-studyNote-lstBox">
							<div class="g-studyNote-box">
								<div class="g-studyNote-lstBox">
									<ul id="noteList" class="g-studyNote-lst">
									</ul>
								</div>
							</div>
						</div>
						<div id="myCoursePage" class="m-laypage3"></div>
					</div>
				</div>
			</div>
</form>
<script>
	$(function(){
		loadNotes();
		courseDisc_bg();
		$('input').bindCheckboxRadioSimulate();
	});

	//内容长度限制
	function isMaxLen(o) {
		var nMaxLen = o.getAttribute ? parseInt(o.getAttribute("maxlength")): "";
		if (o.getAttribute && o.value.length > nMaxLen) {
			o.value = o.value.substring(0, nMaxLen)
		}
	};
	
	function saveNote() {
		var content = $('#noteContent').val();
		content = content.trim();
		if (content == '') {
			alert('笔记内容为空');
		} else {
			$.post("${ctx}/${cid}/study/note", {
				'content' : content,
				'relation.id': '${cid}'
			}, function(response) {
				if (response.responseCode == '00') {
					alert('保存成功');
					clearNoteContent();
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
		$('#currentPage').val(1);
		$('#noteContent').val('');
	};
	
	//查询按钮事件
	function searchNote(id,type) {
		if(type == 'onlyMe'){
			$('#noteForm input[name="creator.id"]').val('${(Session.loginer.id)!''}');
		}
		if(type == 'all'){
			$('#noteForm input[name="creator.id"]').val('');
		}
		clearNoteContent();
		loadNotes();
	}
	
	function showSearchBoxAnimateForNote(){
	};
	
	function isChecked(){
	};
	
	function appendSectionCount(){
	}; 
	
	function isDisplayForLoadMoreNote(){
	}; 
	
	//评论框的聚焦失焦事件
	function courseDisc_bg(){ 
	    $(".m-community-disc-txt .u-textarea").val("请输入笔记内容...")
	    $(".m-community-disc-txt .u-pbIpt-comm").on("focus",function(){
	        var $this = $(this)
	        var discus_val = $this.val();
	        if($.trim(discus_val)=='主题'||$.trim(discus_val)=="请输入笔记内容..."){
	            $this.val("");
	            $this.removeClass('u-pbIpt-comm-dis').addClass('bg-no');
	            $this.parents(".m-community-disc-txt").addClass('m-com-txtpd');
	        }
	    });
	    $(".m-community-disc-txt .u-pbIpt").on("blur",function(){
	        var $this = $(this)
	        var discus_val = $this.val();
	        if($.trim(discus_val)==''){
	            $this.val("主题");
	            $this.addClass('u-pbIpt-comm-dis').removeClass('bg-no');
	            $this.parents(".m-community-disc-txt").removeClass('m-com-txtpd');          
	        }
	    });
	    $(".m-community-disc-txt .u-textarea").on("blur",function(){
	        var $this = $(this)
	        var discus_val = $this.val();
	        if($.trim(discus_val)==''){
	            $this.val("请输入笔记内容...");
	            $this.addClass('u-pbIpt-comm-dis').removeClass('bg-no');
	            $this.parents(".m-community-disc-txt").removeClass('m-com-txtpd');          
	        }
	    });   
	
	};
	
	//准备修改
	function got_textarea(){
		$(".m-wk-test .m-notes-dl").on("click",function(){
		    var $note_textarea = $(this).siblings('.m-discu-Pwktxt').find(".u-textarea");
		    var this_val = $(this).text();
		    $(this).css({"display":"none"});
		    $note_textarea.css({"display":"block"}).val(this_val).focus();
		});
		$(".m-wk-test .m-discu-Pwktxt .u-textarea").on("blur",function(){
		    var $m_notes_dl = $(this).parents(".m-discu-Pwktxt").siblings('.m-notes-dl');
		    this_val = $(this).val();
		    $m_notes_dl.css({"display":"block"}).text(this_val);
		    $(this).css({"display":"none"});
		    var noteId = $(this).closest('.m-discu-Pwktxt').prev('.m-notes-dl').attr('id');
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