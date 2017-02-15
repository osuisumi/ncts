<#global app_path=PropertiesLoader.get('app.ncts.path') >
<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<div class="m-wk-test">
	<span class="u-arrow u-arrow-disc"></span>
	<div class="g-mn-mod">
		<div class="m-community-box">
			<form id="saveCourseStudyDiscussionForm" action="${ctx}/${cid!}/study/course/discussion" method="post">
				<input type="hidden" name="discussionRelations[0].relation.id" value="${cid}">
				<input type="hidden" name="discussionRelations[0].relation.type" value="courseStudy">
				<div class="m-community-disc">
					<a href="javascript:;" class="u-commu-pic">
						<#import "/common/image.ftl" as image/>
						<@image.imageFtl url=(Session.loginer.avatar)! default="${app_path}/images/defaultAvatarImg.png" />
					</a>
					<div class="m-community-disc-txt">
						<div class="m-pbMod-ipt">
							<input style="color:black" type="text" name="title" placeholder="主题" placeholdertext="主题"  required class="u-pbIpt u-pbIpt-comm-dis u-pbIpt-comm" />
						</div>
					</div>
					<div class="m-community-disc-txt">
						<div class="m-pbMod-ipt">
							<textarea style="color:black" name="content" placeholder="描述" placeholdertext="描述" required class="u-textarea u-pbIpt-comm-dis u-pbIpt-comm"></textarea>
						</div>
					</div>
					<div class="m-commIpt-btn m-common-btn t-fr">
						<a onclick="saveCourseDiscussion()" type="button" class="btn u-main-btn">
							发表
						</a>
					</div>
				</div>
			</form>
			<!-- <h3 class="m-community-disc-tl">课程讨论<span>（12，258）</span></h3> -->
			<h3 class="m-discu-wk-tl">
				<!-- <i class="discuss"></i>共有1256条讨论 -->
			</h3>
	        <!-- <div class="m-wk-discu">
	            <label class="m-radio-tick">
	                <strong>
	                    <i class="ico ico2"></i>
	                    <input type="radio" name="topic1"  value="">
	                    <span>只看我的</span>
	                </strong>
	                
	            </label>  
	            <label class="m-radio-tick">
	                <strong class="on">
	                    <i class="ico ico2"></i>
	                    <input type="radio" name="topic1" checked="checked" value="">
	                     <span>全部</span>
	                </strong>
	               
	            </label>                                                                      
	        </div> -->
			<div class="g-mn-dt">
				<@courseStudyDiscussion searchParam=searchParam pageBounds=pageBounds>
					<div id="listCourseStudyDiscussionDiv" class="m-community-con">
						<ul class="u-con-ul course-discuss z-crt">
							<#list discussions as discussion>
							<li>
								<a href="javascript:;" class="u-commu-pic">
									<@image.imageFtl url=(discussion.creator.avatar)! default="${app_path}/images/defaultAvatarImg.png" />
								</a>
								<div class="u-fon-fir">
									<h3 class="m-course-discList-tl">
										<a onclick="viewCourseStudyDiscussion('${discussion.id}')">${(discussion.title)!}</a>
										<!--<i class="u-small-ico u-hot">热</i><i class="u-small-ico u-top">顶</i><i class="u-small-ico u-nice">精</i>-->
									</h3>
										${(discussion.content)!}
									<div class="u-btn-info">
										<p class="u-lt">
											<a class="u-name" href="javascript:void(0);">${(discussion.creator.realName)!}</a>
											发表于${TimeUtils.formatDate(discussion.createTime,'yyyy-MM-dd HH:mm:ss')}
											<a href="javascript:;" class="u-comList-icon"><i></i>${(discussion.discussionRelations[0].replyNum)!}</a>
										</p>
									</div>
								</div>
							</li>
							</#list>
						</ul>
					</div>
					<form id="listCourseStudyDiscussionForm" action="${ctx}/${cid! }/study/course/mic/listDiscussion">
						<input type="hidden" name="orders" value="${orders!}">
						<input type="hidden" name="paramMap[relationId]" value="${(searchParam.paramMap.relationId)!}">
						<input type="hidden" name="paramMap[relationType]" value="${(searchParam.paramMap.relationType)!}">
						<input type="hidden" name="limit" value="${limit!}" >
						<div id="courseStudyDiscussionPage" class="m-laypage"></div>
						<#import "/common/pagination-ajax.ftl" as p/>
						<@p.paginationAjaxFtl formId="listCourseStudyDiscussionForm" divId="courseStudyDiscussionPage" paginator=paginator refreshDivId="micContentDiv" />
					</form>
				</@courseStudyDiscussion>
			</div>
		</div>
	</div>
</div>
<script>
	$(function(){
		courseDisc_bg();
	})
	function viewCourseStudyDiscussion(id){
		$('#micContentDiv').load('${ctx}/${cid!}/study/course/mic/'+id+'/viewDiscussion');
	}
	
	function courseDisc_bg(){ //评论框的聚焦失焦事件
	    //$(".m-community-disc-txt .u-textarea").val("描述")
	    $(".m-community-disc-txt .u-pbIpt-comm").on("focus",function(){
	        var $this = $(this)
	        var discus_val = $this.val();
	        if($.trim(discus_val)==''||$.trim(discus_val)==""){
	            $this.attr("placeholder",'');
	            $this.removeClass('u-pbIpt-comm-dis').addClass('bg-no');
	            $this.parents(".m-community-disc-txt").addClass('m-com-txtpd');
	        }
	    });
	    $(".m-community-disc-txt .u-pbIpt").on("blur",function(){
	        var $this = $(this)
	        var discus_val = $this.val();
	        if($.trim(discus_val)==''){
	            var placeholdertext = $this.attr('placeholdertext');
	            $this.attr('placeholder',placeholdertext);
	            $this.addClass('u-pbIpt-comm-dis').removeClass('bg-no');
	            $this.parents(".m-community-disc-txt").removeClass('m-com-txtpd');          
	        }
	    });
	    $(".m-community-disc-txt .u-textarea").on("blur",function(){
	        var $this = $(this)
	        var discus_val = $this.val();
	        if($.trim(discus_val)==''){
	           	var placeholdertext = $this.attr('placeholdertext');
	            $this.attr('placeholder',placeholdertext);
	            $this.addClass('u-pbIpt-comm-dis').removeClass('bg-no');
	            $this.parents(".m-community-disc-txt").removeClass('m-com-txtpd');          
	        }
	    }); 

 };
 
 function saveCourseDiscussion(){
		if(!$('#saveCourseStudyDiscussionForm').validate().form()){
			return false;
		}
	 	var response = $.ajaxSubmit('saveCourseStudyDiscussionForm');
	 	response = $.parseJSON(response);
	 	if(response.responseCode == '00'){
	 		alert('发表成功');
	 		$('.u-pbIpt').val('');
	 		$('.u-textarea').val('');
	 		$.ajaxQuery('listCourseStudyDiscussionForm', 'micContentDiv');
	 	}
	 }
</script>
