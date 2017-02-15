<#global app_path=PropertiesLoader.get('app.ncts.path') >
<#if inCurrentDate[0] == 'true'>
	<#assign inCurrentDate=true>
<#else>
	<#assign inCurrentDate=false>
</#if>
<i class="ua-comment-trg"></i>
<ul class="aag-cmt-lst">
	<#list childPosts as childPost>
		<li class="am-cmt-block">
			<div class="c-info">
				<a class="au-cmt-headimg">
					<#import "/common/image.ftl" as image/>
					<@image.imageFtl url=(childPost.creator.avatar)! default="${app_path}/images/defaultAvatarImg.png" />
				</a>
				<p class="tp">
					<a class="name">${childPost.creator.realName }</a>
					<span class="time">${TimeUtils.prettyTime(childPost.createTime) }</span>
					<span class="m-discuss-com">
		                <!-- <a onclick="editDiscussionPost('${childPost.id}', '${childPost.mainPostId }')" href="javascript:void(0);" class="au-alter au-editComment-btn">
		                    <i class="au-alter-ico"></i>编辑
		                </a> -->
		                <i class="au-opa-dot"></i>
		                <a onclick="deletePost('${childPost.id}','${childPost.mainPostId }', this)" href="javascript:void(0);" class="au-dlt dis-dlt">
		                    <i class="au-dlt-ico"></i>删除
		                </a>
		            </span>
				</p>
				<p class="cmt-dt">${childPost.content }</p>
			</div>
		</li>
	</#list>
</ul>
<div class="am-isComment-box am-ipt-mod">
	<textarea name="content" class="au-textarea" placeholder="我也说一句" style="height:40px"></textarea>
	<#if (inCurrentDate)>
		<div class="am-cmtBtn-block f-cb" style="display: block;">  
			<a href="javascript:void(0);" class="au-cmtPublish-btn au-confirm-btn1" onclick="saveChildPost(this)">发表</a>
		</div>
	</#if>
</div>
