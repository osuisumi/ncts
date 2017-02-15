<#macro viewDiscussionFtl discussionId aid relationId>
	<#assign cid=(CSAIdObject.getCSAIdObject().cid)!>
	<#assign hasTeachRole=SecurityUtils.getSubject().hasRole('course_teacher_'+cid)>
	<#if hasTeachRole>
		<#assign role='teach'>
	<#else>
		<#assign role='study'>
	</#if>
	<@discussionUser discussionId=discussionId! activityId=aid! relationId=relationId>
		<#assign discussionRelation=discussion.discussionRelations[0]>
		<#assign inCurrentDate=TimeUtils.inCurrentDate((activity.timePeriod)!'', (course.timePeriod)!'')>	
		<div class="g-study-dt">
			<#if !hasTeachRole>
				<div class="g-study-prompt">
					<p>
						<#assign main_post_num=(activity.attributeMap['main_post_num'].attrValue)!'0'>
						<#assign sub_post_num=(activity.attributeMap['sub_post_num'].attrValue)!'0'>
						<#if main_post_num == ''>
							<#assign main_post_num='0'>
						</#if>
						<#if sub_post_num == ''>
							<#assign sub_post_num='0'>
						</#if>
						<#if (main_post_num?number == 0 && sub_post_num?number == 0)>
							要求完成任意 <span>1</span>个回复或子回复
						<#else>
							要求完成 <span>${main_post_num }</span>个回复，
							 <span>${sub_post_num }</span>个子回复
						</#if>
						<i>/</i>
						您已完成 <span>${(activityResult.detailMap['main_post_num'])!0 }</span>个回复，
						 <span>${(activityResult.detailMap['sub_post_num'])!0 }</span>子回复
					</p>
	            	<i class="close">X</i>
	            </div>
			</#if>
			<div class="com">
				<div id="ag-bd">
					<div class="ag-activity">
						<div class="ag-activity-bd">
							<div class="ag-cMain" style="min-height: 330px;">
								<div class="ag-main-hd">
									<div class="am-title">
										<h2>
											<!-- <span class="aa-type-txt">【研讨】</span>  -->
											<span class="txt">${discussion.title }</span>
										</h2>
									</div>
									<div class="am-title-info f-cb">
										<div class="c-infor">
											<!-- <span class="txt">发起人：卢佳慧</span> 
											<span class="line">|</span>  
											<span class="txt">参与人数：${discussionRelation.participateNum }</span> 
											<span class="line">|</span> 
											<span class="txt">被阅读数：${discussionRelation.browseNum }</span>-->
										</div>
										<div class="am-mnTag-lst">
											<span class="au-tag-type type1"> 
												<i class="au-bulb-ico"></i>活动
											</span> 
											<#list tags as tag>
												<span class="au-tt-type">${tag.name }</span> 
											</#list>
										</div>
									</div>
									<div class="am-main-r">
										<#assign timePeriods=[]>
										<#assign timePeriods = timePeriods + [(activity.timePeriod)!]>
										<#assign timePeriods = timePeriods + [(course.timePeriod)!]>
										<#import "/ncts/study/common/show_time.ftl" as st /> 
										<@st.showTimeFtl timePeriods=timePeriods label="活动" /> 
									</div>
									<div class="ag-detail-txt ag-detail-txt1">
										<div class="cont-txt">${discussion.content! }</div>
									</div>
								</div>
								<#if (discussion.fileInfos?size>0)>
									<div class="ag-adjunct-cont">
										<div class="am-mod-tt">
											<h3 class="t1">附件</h3>
										</div>
										<div class="ag-adjunct-dt">
											<ul class="am-file-lst f-cb" id="activityFileList">
												<#list discussion.fileInfos as file>
													<li>
														<div class="am-file-block am-file-word">
															<div class="file-view">
																<div class="${FileTypeUtils.getFileTypeClass(file.fileName, 'study') }">
																	<#if FileTypeUtils.getFileTypeClass(file.fileName, 'study') == 'img'>
																		<img src="${FileUtils.getFileUrl(file.url) }" >
																	</#if>
																</div>
															</div>
															<b class="f-name"><span>${file.fileName }</span></b>
															<div class="f-info">
																<!-- <span class="u-name">${file.creator.realName! }</span>  -->
																<span class="time">${TimeUtils.formatDate(file.createTime, 'yyyy/MM/dd') }</span>
															</div>
															<div class="f-opa">
																<a onclick="previewFile('${file.id}')" href="javascript:void(0);" >预览</a> 
																<a onclick="downloadFile('${file.id}', '${file.fileName }')" href="javascript:void(0);" class="download">下载</a> 
																<!-- <a href="javascript:void(0);" class="move">移动</a> 
																<a href="javascript:void(0);" class="rename">重命名</a> 
																<a href="javascript:void(0);" class="delete">删除</a> -->
															</div>
														</div>
													</li>
												</#list>
											</ul>
										</div>
									</div>
								</#if>
								<div class="am-comment-box am-ipt-mod">
									<!-- <span class="aau-comment-trg"></span> -->
									<label> <span class="comment-placeholder"></span> 
										<textarea id="postContent" class="au-textarea"></textarea>
									</label>
									<#if (inCurrentDate)>
										<div class="am-cmtBtn-block f-cb">
											<!-- <a href="javascript:void(0);" class="au-face"></a>  -->
											<a onclick="savePost()" href="javascript:void(0);" class="au-cmtPublish-btn au-confirm-btn1">发表</a>
										</div>
									</#if>
								</div>
							</div>
							<@discussionPostsDirective discussionRelationId=discussion.discussionRelations[0].id page=pageBounds.page!1 limit=10 orders=(orders[0])!'CREATE_TIME.DESC'>
								<#assign discussionPosts=discussionPosts>
								<#assign paginator=paginator>
							</@discussionPostsDirective>
							<div class="ag-comment-layout">
								<div class="am-coment-tp">
									<div class="c-sttc1">
										已有&nbsp;<strong id="totalPostNum">${(paginator.totalCount)!0 }</strong>&nbsp;条回复
									</div>
									<div class="am-slt-sort">
										<a orders="CREATE_TIME.DESC" href="javascript:void(0);">时间</a> 
										<a orders="CHILD_POST_COUNT.DESC" href="javascript:void(0);">回复数</a> 
										<a orders="SUPPORT_NUM.DESC" href="javascript:void(0);">点赞数</a>
									</div>
									<script>	
										$(function(){
											$('.am-slt-sort a[orders="${(orders[0])!}"]').addClass('z-crt');
											$('.am-slt-sort a').click(function(){
												$('#viewDiscussionForm input[name="orders"]').val($(this).attr('orders'));
												$('#viewDiscussionForm #currentPage').val(1);
												$('#viewDiscussionForm').submit();
											});
										});
									</script>
								</div>
								<div class="ag-comment-main">
									<#if (discussionPosts?size>0) >
										<ul class="ag-cmt-lst ag-cmt-lst-p">
											<#list discussionPosts as post>
												<li class="am-cmt-block">
													<div class="c-info">
														<a href="#" class="au-cmt-headimg"> 
															<#import "/common/image.ftl" as image/>
															<@image.imageFtl url=(post.creator.avatar)! default="${app_path}/images/defaultAvatarImg.png" />
														</a>
														<p class="tp">
															<a class="name">${post.creator.realName }</a>
															<span class="time">${TimeUtils.prettyTime(post.createTime) }</span>
														</p>
														<p class="cmt-dt">${post.content! }</p>
														<div class="ag-opa">
															<a <#if ThreadContext.getUser().getId() != post.creator.id>onclick="attitude_support('${post.id}')"<#else>onclick="alert('不能赞自己')"</#if> href="javascript:void(0);" class="au-praise"> <i class="au-praise-ico"></i>赞同<b>（<span id="supportNum_${post.id}">${post.supportNum }</span>）</b></a>
															<i class="au-opa-dot"></i> 
															<a onclick="if(!$(this).hasClass('z-crt')){listChildPost('${post.id}');}" class="au-comment"><i class="au-comment-ico"></i>回复<b>（<span id="childPostCount_${post.id}">${post.childPostCount }</span>）</b></a> 
						                                    <!-- <#if post.creator.id == (Session.loginer.id)!>
						                                    	<i class="au-opa-dot"></i> 
																<a onclick="editDiscussionPost('${post.id}', '')" href="javascript:void(0);" class="au-alter au-editComment-btn"> <i class="au-alter-ico"></i>编辑</a> 
						                                    </#if> -->
						                                    <#if (post.creator.id == (Session.loginer.id)! || hasTeachRole)>
						                                    	<i class="au-opa-dot"></i> 
							                                    <a onclick="deletePost('${(post.id)!}','${(post.mainPostId)! }', this)" class="au-dlt"> 
							                                    	<i class="au-dlt-ico"></i>删除
							                                    </a>
						                                    </#if> 
						                                </div>
						                                <div class="ag-is-comment">
							                                <div id="listChildPostDiv_${post.id }" class="listChildPostDiv" mainPostId="${post.id }">
							                                
							                                </div>
							                            </div>   
													</div>
												</li>
											</#list>
										</ul>
										<form id="viewDiscussionForm" action="${ctx}/${aid }/${role}/course/${CSAIdObject.getCSAIdObject().cid}">	
											<input type="hidden" name="orders" value="${(orders[0])!'CREATE_TIME.DESC' }">
		                                    <div id="discussionPostPage" class="m-laypage"></div>
		                                    <#import "/common/pagination.ftl" as p/>
											<@p.paginationFtl formId="viewDiscussionForm" divId="discussionPostPage" paginator=paginator />
										</form>
									<#else>
										<div class="ag-no-content ag-no-comment">
                                            <p>还没有其他观点，快成为第一个提出观点的人~</p>
                                        </div>
									</#if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<form id="saveDiscussionPostForm" action="${ctx }/${aid}/${role }/unique_uid_${Session.loginer.id }/discussion/post/save">
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
		//发表研讨主贴
		function savePost(){
			var content = $('#postContent').val();
			if(content == ''){
				alert('发表的内容不能为空!');
				return false;
			}
			if(content.indexOf('<!DOCTYPE html>') >= 0){
				alert('内容不合法!');
				return false;
			}
			$('#saveDiscussionPostForm input[name="content"]').val(content);
			$.ajax({
				url: $('#saveDiscussionPostForm').attr('action'),
				type: 'post',
				data: $('#saveDiscussionPostForm').serialize(),
				success: function(data){
					if (typeof data != 'object'){
						$('body').html($(data));
					}else{
						if(data.responseCode == '00'){
							alert('发表成功', function(){
								$('#postContent').val('');
								window.location.reload();
							});
						} 
					}
				}
			});
		}
		
		//发表回复
		function saveChildPost(obj){
			var _parent = $(obj).parents('.listChildPostDiv');
			var content = _parent.find('.au-textarea').val();
			if(content == ''){
				alert('发表的内容不能为空!');
				return false;
			}
			if(content.indexOf('<!DOCTYPE html>') >= 0){
				alert('内容不合法!');
				return false;
			}
			var mainPostId = _parent.attr('mainPostId');
			$('#saveDiscussionPostForm input[name="content"]').val(content);
			$('#saveDiscussionPostForm input[name="mainPostId"]').val(mainPostId);
			$.ajax({
				url: $('#saveDiscussionPostForm').attr('action'),
				type: 'post',
				data: $('#saveDiscussionPostForm').serialize(),
				success: function(data){
					if (typeof data != 'object'){
						$('body').html($(data));
					}else{
						if(data.responseCode == '00'){
							alert('发表成功', function(){
								//var totalCount = $('#totalPostNum').text();
								var count = $('#childPostCount_'+mainPostId).html();
								//$('#totalPostNum').text(parseInt(totalCount) + 1);
								$('#childPostCount_'+mainPostId).text(parseInt(count) + 1);
								listChildPost(mainPostId);
							});
						}
					}
				}
			});
		}
		
		function deletePost(id, mainPostId, obj){
			confirm('是否删除此回复?',function(){
				$('#deletePostForm input[name="mainPostId"]').val(mainPostId);
				$('#deletePostForm').attr('action','${ctx}/discussion/post/'+id);
				var data = $.ajaxSubmit('deletePostForm');
				if (!isMatchJson(data)){
					$('body').html($(data));
				}else{
					var json = $.parseJSON(data);
					if(json.responseCode == '00'){
						if(mainPostId == null || mainPostId == '' || mainPostId == 'null'){
							var totalCount = $('#totalPostNum').text();
							//var childCount = $('#childPostCount_'+id).html();
							$('#totalPostNum').text(parseInt(totalCount) - 1);
						}else{
							//var totalCount = $('#totalPostNum').text();
							var childCount = $('#childPostCount_'+mainPostId).html();
							//$('#totalPostNum').text(parseInt(totalCount) - 1);
							$('#childPostCount_'+mainPostId).text(parseInt(childCount) - 1);
						}
						$(obj).closest('li').remove();
					} 
				}
			});
		}
		
		function listChildPost(mainPostId){
			$('#listChildPostDiv_'+mainPostId).load('${ctx}/ncts/discussion/post/child'
					,'inCurrentDate=${inCurrentDate?string("true", "false")}&orders=CREATE_TIME.ESC&paramMap[mainPostId]='+mainPostId+'&paramMap[relationId]=${discussionRelation.relation.id }'
			);
		}
		
		function attitude_support(postId){
			$.post("${ctx}/attitudes",{
				"attitude":"support",
				"relation.id":postId,
				"relation.type":"discussion_post"
			},function(response){
				if(response.responseCode == '00'){
					var count = $('#supportNum_'+postId).text();
					$('#supportNum_'+postId).text(parseInt(count) + 1);
					alert('点赞成功');
				}else{
					alert('已经赞过');
				}
			});
		}
		
		function editDiscussionPost(postId, mainPostId){
			mylayerFn.open({
		        type: 2,
		        title: '编辑评论',
		        fix: true,
		        area: [600, 300],
		        content: '${ctx}/${aid}/${role}/ncts/discussion/post/'+postId+'/edit?mainPostId='+mainPostId,
		    });
		}
	</script>
	</@discussionUser>
</#macro>
