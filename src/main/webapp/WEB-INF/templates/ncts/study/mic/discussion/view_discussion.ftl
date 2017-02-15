<#global app_path=PropertiesLoader.get('app.ncts.path') >
<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
<@discussionUser pageBounds=pageBounds discussionId="${discussionId}" relationId=cid>
<#import "/common/image.ftl" as image/>
<#assign discussionRelation=discussion.discussionRelations[0]>
<div id="courseLearning">
	<div class="f-auto">
		<div class="g-frame ">
			<div class="g-mn-mod">
				<div class="m-community-box">
                    <div class="m-community-disc m-community-disc-dtl">
						<a onclick="listDiscussion()" class="m-back-comList">返回列表&gt;</a>
					</div>
					<div class="u-con-ul m-course-detail-cont ">
						<h2 class="m-course-detail u-course-det-ico">
							<p>
								${(discussion.title)!}
							</p>
							<!--<i class="u-small-ico u-hot"><ins></ins><span>热</span></i><i class="u-small-ico u-top"><ins class="u-course-det-ico02"></ins><span>顶</span></i><i class="u-small-ico u-nice"><ins class="u-course-det-ico03"></ins><span>精</span></i>-->
						</h2>
						<div class="u-btn-info">
							<p class="u-lt">
								<a class="u-name" href="javascript:void(0);">${(discussion.creator.realName)!}</a>
								发表于${TimeUtils.formatDate(discussion.createTime,'yyyy-MM-dd HH:mm')}&nbsp;&nbsp;&nbsp;&nbsp;浏览次数：
								<span>${(discussion.discussionRelations[0].browseNum)!}</span>
							</p>
							<span class="u-name-fr">楼主</span>
						</div>
						<p class="m-course-detail-txt">
							${(discussion.content)!}
						</p>
						<p class="u-cou-det-res">
							<span><a style="color:#828282" <#if ThreadContext.getUser().getId() != discussion.creator.id>onclick="attitude_support('${discussion.id}','discussion',this)"<#else>onclick="alert('不能赞自己')"</#if> href="javascript:void(0);" class="au-praise z-crt"> 
								<i class="au-praise-ico"></i>
								赞同<b>（<span id="sup_num" class="sup_num">${(discussion.discussionRelations[0].supportNum)!}</span>）</b> </a>
							</span>
							<span class="u-line">|</span>
							<span><i id="totalPostNum">${(discussion.discussionRelations[0].replyNum)!}</i>条回复</span>
						</p>
					</div>
					<div class="m-dis-det-spok">
						<div class="am-comment-box am-ipt-mod">
							<label> <span class="comment-placeholder" style="opacity: 1; display: block;"></span> 
								<textarea id="postTextarea" class="au-textarea" style="height: 22px;"></textarea>
							</label>
							<div class="am-cmtBtn-block f-cb" style="display: none;">
								<#--<a class="au-face" href="javascript:void(0);"></a>-->
								<a onclick="saveDiscussionPost()" href="javascript:void(0);" class="au-cmtPublish-btn au-confirm-btn1">发表</a>
							</div>
						</div>
					</div>
					<div class="m-dis-det-cont-box">
						<div class="am-coment-tp">
							<div class="c-sttc1">
								<strong>讨论</strong><!--（12，258）-->
							</div>
							<div class="am-slt-sort">
								<a onclick="rankPost('surpport')" href="javascript:void(0);" <#if orders??><#if orders == "SUPPORT_NUM.DESC">class="z-crt"</#if></#if> >点赞数</a>
								<a onclick="rankPost('createTime')" href="javascript:void(0);" <#if orders??><#if orders == "CREATE_TIME.DESC">class="z-crt"</#if><#else>class="z-crt"</#if> >时间</a>
							</div>
						</div>
						<div class="ag-comment-main">
							<ul class="ag-cmt-lst ag-cmt-lst-p">
								<#list discussionPosts as discussionPost>
									<li class="am-cmt-block">
										<div class="c-info">
											<a href="#" class="au-cmt-headimg"> <@image.imageFtl url=(discussionPost.creator.avatar)! default="${app_path}/images/defaultAvatarImg.png" /> </a>
											<p class="tp">
												<a href="#" class="name">${(discussionPost.creator.realName)!}</a>
											</p>
											<p class="cmt-dt">
												${discussionPost.content}
											</p>
											<div class="ag-opa">
												<span class="time">${TimeUtils.prettyTime(discussionPost.createTime)}</span>
												<div class="reslut">
													<a <#if ThreadContext.getUser().getId() != discussionPost.creator.id>onclick="attitude_support('${discussionPost.id}','discussionPost',this)"<#else>onclick="alert('不能赞自己')"</#if> href="javascript:void(0);" class="au-praise z-crt"> 
														<i class="au-praise-ico"></i>
														赞同<b>（<span id="sup_num" class="sup_num">${discussionPost.supportNum}</span>）</b>
													</a>
													<i class="line">|</i>
													<a onclick="if(!$(this).hasClass('z-crt')){loadChildPost('${discussionPost.id}')}" href="javascript:void(0);" class="au-comment"> <i class="au-comment-ico"></i>回复<b>（<span id="childPostCount_${discussionPost.id}">${discussionPost.childPostCount}</span>）</b> </a>
													<#if (Session.loginer.id)! == (discussionPost.creator.id)!>
														<!-- <i class="line">|</i>
														<a onclick="editDiscussionPost('${discussionPost.id}','')" href="javascript:void(0);" class="au-alter au-editComment-btn"> <i class="au-alter-ico"></i>编辑 </a> -->
														<i class="line">|</i>
														<a onclick="deletePost('${discussionPost.id}','${(discussionPost.mainPostId)!"" }', this)" href="javascript:void(0);" class="au-dlt"> <i class="au-dlt-ico"></i>删除 </a>
													</#if>
												</div>
											</div>
										</div>
										<div class="ag-is-comment childPostDiv" mainPostId="${discussionPost.id}" id="listChildPostDiv_${discussionPost.id}" style="display: none;">
											
										</div>
									</li>
								</#list>
							</ul><!--end .aag-cmt-lst 讨论列表-->
						</div><!--end .ag-comment-main -->
					</div>
					<form id="viewDiscussionForm" action="${ctx}/${cid!}/study/course/mic/${discussionId}/viewDiscussion">
						<input type="hidden" name="limit" value="${limit!}">	
						<input type="hidden" name="orders" value="${orders!'CREATE_TIME.DESC' }">
                                 <div id="discussionPostPage" class="m-laypage"></div>
                                 <#import "/common/pagination-ajax.ftl" as p/>
								 <@p.paginationAjaxFtl formId="viewDiscussionForm" divId="discussionPostPage" paginator=paginator refreshDivId="micContentDiv" />
					</form>
				</div><!--end community box -->
			</div><!--end main module -->
		</div>
	</div>
</div>
<form id="saveDiscussionPostForm" action="${ctx }/${cid }/study/discussion/post/save">
	<input type="hidden" name="discussionUser.discussionRelation.id" value="${discussionRelation.id }">
	<input type="hidden" name="discussionUser.discussionRelation.discussion.id" value="${discussion.id }">
	<input type="hidden" name="discussionUser.discussionRelation.relation.id" value="${discussionRelation.relation.id }">
	<input type="hidden" name="mainPostId">
	<input type="hidden" name="content">
</form>

<form id="deletePostForm" method="delete">
	<input type="hidden" name="discussionUser.discussionRelation.id" value="${discussionRelation.id }">
	<input type="hidden" name="discussionUser.discussionRelation.discussion.id" value="${discussion.id }">
	<input type="hidden" name="discussionUser.discussionRelation.relation.id" value="${discussionRelation.relation.id }">
	<input type="hidden" name="mainPostId">
</form>


<script>
	 $(function(){
		activityJs.fn.commentOpa(".am-comment-box");
		activityJs.fn.commentShow();
        showReply();  
        function showReply(){           //显示回复内容
            var btn = $(".second-reply .reply");
            var con = $(".pop_reply");
            btn.on('click',function(){
                var _this = $(this);
                var pop_reply = _this.parent().siblings(".pop_reply");
                if(!_this.hasClass("cur")){
                    btn.removeClass("cur");
                    con.hide();
                    _this.addClass("cur");
                    _this.parent().siblings(".pop_reply").show();
                }else{
                    _this.removeClass("cur");
                    _this.parent().siblings(".pop_reply").hide();
                }                
            });
        }
	});

	function saveDiscussionPost(){
		//var content=ue.getContent();
		var content = $('#postTextarea').val();
		if(content.trim() == ''){
			alert('内容不能为空');
			return false;
		}
		$.post("${ctx}/${cid}/study/discussion/post/save",{
			"discussionUser.discussionRelation.discussion.id":"${discussion.id}",
			"discussionUser.discussionRelation.relation.id":"${discussion.discussionRelations[0].relation.id}",
			"discussionUser.discussionRelation.id":"${discussion.discussionRelations[0].id}",
			"content":content,
		},function(response){
			if(response.responseCode == '00'){
				//ue.setContent('');
				alert('操作成功');
				$.ajaxQuery('viewDiscussionForm', 'micContentDiv')
			}
		});
	}
	
	function saveChildDiscussionPost(btn){
		var mainPostId = $(btn).closest('.childPostDiv').attr('mainPostId');
		var content = $(btn).closest('.childPostDiv').find('.childPostTextarea').eq(0).val();
		if(content.trim() == ''){
			alert('发表内容不能为空');
			return false;
		}
		$('#saveDiscussionPostForm input[name="content"]').val(content);
		$('#saveDiscussionPostForm input[name="mainPostId"]').val(mainPostId);
		$.ajax({
				url: $('#saveDiscussionPostForm').attr('action'),
				type: 'post',
				data: $('#saveDiscussionPostForm').serialize(),
				success: function(data){
					if(data.responseCode == '00'){
						alert('发表成功', function(){
							var count = $('#childPostCount_'+mainPostId).html();
							var totalCount = $('#totalPostNum').text();
							$('#totalPostNum').text(parseInt(totalCount) + 1);
							$('#childPostCount_'+mainPostId).text(parseInt(count) + 1);
							loadChildPost(mainPostId);
						});
					} 
				}
			});
	}
	
	function loadChildPost(postId){
		//$('#listChildPostDiv'+postId).load('${ctx}/board/discussion/post/child?paramMap[mainPostId]='+postId+'&paramMap[relationId]=searchParam.paramMap.relationId');
		$('#listChildPostDiv_'+postId).load('${ctx}/${cid}/study/course/discussion/post/child?paramMap[mainPostId]='+postId);
	}
	
	function rankPost(param){
		if(param =='createTime'){
			$('#viewDiscussionForm input[name=orders]').val('CREATE_TIME.DESC');
		}else{
			$('#viewDiscussionForm input[name=orders]').val('SUPPORT_NUM.DESC');
		}
		$('#viewDiscussionForm #currentPage').val(1);
		$.ajaxQuery('viewDiscussionForm', 'micContentDiv')
	}
	/*
	function goPage(page){
		window.location.href = '${ctx}/study/discussion/${discussionId}?page='+page;
	}
	
	function prevPage(){
		var page = "${paginator.page}";
		page = parseInt(page);
		if(page<=1){
			alert('已经是第一页');
		}else{
			goPage(page-1);
		}
	}
	
	function nextPage(){
		var limit = "${paginator.limit}";limit = parseInt(limit);
		var page = "${paginator.page}";page = parseInt(page);
		var totalCount = "${paginator.totalCount}";totalCount = parseInt(totalCount);
		if(page*limit<totalCount){
			goPage(page+1);
		}else{
			alert('已经是最后一页');
		}
	}
	*/
	function attitude_support(id,type,a,attitude){
		if(!attitude){
			var attitude = 'support';
		}
		$.post("${ctx}/attitudes",{
			"attitude":attitude,
			"relation.id":id,
			"relation.type":type
		},function(response){
			if(response.responseCode == '00'){
				var numSpan = $(a).find('.sup_num');
				numSpan.text(parseInt(numSpan.text())+1);
				alert('操作成功');
				if(attitude == 'vote'){
					$(a).after('<p class="u-yt z-crt">已投票</p>').hide();
				}
			}else{
				if(attitude == 'vote'){
					alert('已投票');
				}else{
					alert('已经赞过');
				}
			}
		})
	}
	
	function editDiscussionPost(postId, mainPostId){
		mylayerFn.open({
	        type: 2,
	        title: '编辑回复',
	        fix: true,
	        area: [600, 300],
	        content: '${ctx}${cid}/study/course/discussion/post/'+postId+'/edit?mainPostId='+mainPostId,
	    });
	}
	
	function deletePost(id, mainPostId, obj){
		confirm('是否删除此回复?',function(){
			$('#deletePostForm input[name="mainPostId"]').val(mainPostId);
			$('#deletePostForm').attr('action','${ctx}/${cid}/study/discussion/post/'+id);
			var data = $.ajaxSubmit('deletePostForm');
			var json = $.parseJSON(data);
			if(json.responseCode == '00'){
				if(mainPostId == null || mainPostId == '' || mainPostId == 'null'){
					var totalCount = $('#totalPostNum').text();
					var childCount = $('#childPostCount_'+id).html();
					$('#totalPostNum').text(parseInt(totalCount) - parseInt(childCount) - 1);
				}else{
					var totalCount = $('#totalPostNum').text();
					var childCount = $('#childPostCount_'+mainPostId).html();
					$('#totalPostNum').text(parseInt(totalCount) - 1);
					$('#childPostCount_'+mainPostId).text(parseInt(childCount) - 1);
				}
				$(obj).closest('li').remove();
			} 
		});
	}
	
</script>
</@discussionUser>