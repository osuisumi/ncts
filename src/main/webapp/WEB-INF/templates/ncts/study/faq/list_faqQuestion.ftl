<#global app_path=PropertiesLoader.get('app.ncts.path') >
<#import "/common/image.ftl" as image/>
<@faqs faqQuestion=faqQuestion pageBounds=pageBounds>
<#list faqQuestions as faq>
	<li id="${faq.id}" class="question">
		<div class="box">
			<a href="javascript:;" class="user"> 
				<@image.imageFtl url="${(faq.creator.avatar)!}" default="${app_path}/images/defaultAvatarImg.png" userId=(faq.creator.id)! userName=(faq.creator.realName)! />
				<span>${(faq.creator.realName)!}</span>
			</a>
			<div class="q-block">
				<h3 class="tt">${faq.content}</h3>
				<i class="q-ico"></i>
				<div class="b-row">
					<span class="time">${TimeUtils.formatDate(faq.createTime,'yyyy-MM-dd')}</span>
				</div>
			</div>
			<div class="m-shrink-ipt m-pbMod-ipt">
				<label> <span class="u-placeholder">我有更好的答案~</span>
				<textarea name="" class="u-textarea"></textarea> </label>
				<a href="javascript:void(0);" onclick="saveAnswer(this)" class="btn u-main-btn confirm">
					发表
				</a>
			</div>
			<ul class="m-studyA-lst">
				<#list faq.faqAnswers as answer>
					<li>
						<div class="a-block">
							<div class="sign">
								<span>答</span>
							</div>
							<p class="a-txt">
								${answer.content}
							</p>
						</div>
						<div class="b-row">
							<span class="time">${TimeUtils.formatDate(answer.createTime,'yyyy-MM-dd')}</span>
						</div>
					</li>
				</#list>
			</ul>
		</div>
	</li>
</#list>
</@faqs>

<script>
	$(function() {
		courseLearningFn.shrinkInput();
		$('#faqCount').text('${(paginator.totalCount)!}');
		var warpDiv = $('#faqQuestionList').closest('div');
		var page = $(warpDiv).find('.page').eq(0);
		var limit = $(warpDiv).find('.limit').eq(0);
		var totalCount = $(warpDiv).find('.totalCount').eq(0);
		page.val('${(paginator.page)!1}');
		limit.val('${(paginator.limit)!}');
		totalCount.val('${(paginator.totalCount)!}');
		
		//设置个人图标
		$('#faqQuestionList li .user img').showUserInfor();
	})
</script>
