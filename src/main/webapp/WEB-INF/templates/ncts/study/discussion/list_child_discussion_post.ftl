<#global app_path=PropertiesLoader.get('app.ncts.path') >
<#import "/common/image.ftl" as image/>
<i class="au-comment-trg" style="left: 679px;"></i>
<ul class="aag-cmt-lst">
	<#list childPosts as childPost>
		<li class="am-cmt-block clearfix">
			<div class="c-info">
				<a href="#" class="au-cmt-headimg"> <@image.imageFtl url=(discussionPost.creator.avatar)! default="${app_path}/images/defaultAvatarImg.png" /> </a>
				<p class="tp">
					<a href="#" class="name">${(childPost.creator.realName)!}</a>
					<span class="m-discuss-com "> 
						<#if (Session.loginer.id)! == (childPost.creator.id)!>
							<!-- <a onclick="editDiscussionPost('${childPost.id}','${(childPost.mainPostId)!"" }')" href="javascript:void(0);" class="au-alter au-editComment-btn"><i class="au-alter-ico"></i>编辑 </a> --> 
							<i class="line">|</i> 
							<a onclick="deleteDiscussionChildPost('${childPost.id}','${childPost.mainPostId }',this)" href="javascript:void(0);" class="au-dlt dis-dlt"> <i class="au-dlt-ico"></i>删除 </a> 
						</#if>
					</span>
				</p>
				<p class="cmt-dt">
					${(childPost.content)!}
				</p>
				<span class="time">${TimeUtils.prettyTime(childPost.createTime)}</span>
			</div>
		</li>
	</#list>
</ul>
<!--
<div class="am-unfold-block">
	<a href="javascript:void(0);" class="au-unfold"> 展开全部评论<i class="au-ico"></i> </a>
</div>
-->
<div class="am-isComment-box am-ipt-mod">
	<textarea id="" class="au-textarea childPostTextarea" placeholder="我也说一句"></textarea>
	<div class="am-cmtBtn-block f-cb">
		<#--<a class="au-face" href="javascript:void(0);"></a>-->
		<a onclick="saveChildDiscussionPost(this)" href="javascript:void(0);" class="au-cmtPublish-btn au-confirm-btn1">发表</a>
	</div>
</div>

<script>
	$(function(){
		activityJs.fn.commentOpa('.am-isComment-box');
	})

	function deleteDiscussionChildPost(id,mainPostId,a){
		deletePost(id,mainPostId,$(a));
	}
	
</script>
