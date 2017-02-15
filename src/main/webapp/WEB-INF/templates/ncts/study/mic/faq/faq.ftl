<#assign cid=CSAIdObject.getCSAIdObject().cid>
<form id="faqForm" action="${ctx}/study/faq_question">
	<input type="hidden" name="relation.type" value="course_study">
	<input type="hidden" name="orders" value="CREATE_TIME.DESC">
	<input type="hidden" id="queryType" name="queryType" value="${(faqQuestion.queryType)!}">
	<input type="hidden" id="relationId" name="relation.id" value="${(cid)!}">
	<input type="hidden" name="loginerId" value="${(Session.loginer.id)!}">
					<div class="m-wk-test">
						<span class="u-arrow u-arrow-ans"></span>
                        <div class="g-mn-mod">
                            <div class="m-community-box">
                                <div class="m-community-disc">
                                    <div class="m-community-disc-txt m-com-wktxt">
                                        <div class="m-pbMod-ipt">
                                            <textarea id="questionContent" name="" class="u-textarea u-pbIpt-comm" placeholder="请输入你要询问的问题..."></textarea>
                                        </div> 
                                    </div>  
                                   <div class="m-commIpt-btn m-common-btn t-fr">
                                        <button onclick="saveQuestion()" type="button" class="btn u-main-btn">发表</button>
                                   </div>

                                </div>
                                <div class="g-studyQa-box g-weike-answer">
                                    <div class="m-frameT-srh m-ans-srh">
                                        <div class="tl">
                                            <div class="m-layer-crm">
                                                <i class="answer"></i>
                                                <a href="javascript:void(0);" class="all z-crt">全部（<span id="faqCount">0</span>）</a>
                                            </div>
                                        </div>
                                        <div class="tr">
                                            <div class="srh showSearchBox">
                                                <i onclick="searchFaqQuestion()" class="t-ico"></i>
                                                <input type="text" id="searchContent" name="content" class="ipt" placeholder="输入搜索内容..." value="${(faqQuestion.content)!}">
                                            </div>
                                        </div>
                                    </div>
									<div  class="g-studyQa-lstBox">
										<ul id="faqQuestionList" class="g-studyQa-lst">
											
										</ul>
										<div class="m-common-btn t-fc m-loadMore-btn">
											<input class="page" type="hidden" name="page" value="" />
											<input class="limit" type="hidden" name="limit" value="" />
											<input class="totalCount" type="hidden" name="totle" value="">
											<a href="javascript:;" onclick="loadMoreFaqQuestion(this)" class="btn u-inverse-btn">查看更多问答</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
</form>
<script>
	$(function() {
		//搜索框动画
		showSearchBoxAnimate();
		setFollowStat();
		
		loadFaqQuestions();
	});

	$(function() {
		$("#studyQaLayer").myTab({
			pars : '#studyQaLayer',
			tabNav : '.m-studyF-tabli',
			li : 'a', //标签
			tabCon : '.g-studyF-tabcont',
			tabList : '.g-studyF-tablist',
			cur : 'z-crt',
			page : 0
		});
	});
	//关注部分js开始
	//异步加载是否关注
	function setFollowStat() {
		var faqs = $('.g-studyQa-lst .question');
		var ids = '';
		$(faqs).each(function(i) {
			//如果已经加载过是否关注  则不处理
			var followDiv = $(this).find('.b-row').eq(0);//关注部分的div
			if(followDiv.find('a').size()<1){
				var id = $(this).attr('id');
				if (ids == '') {
					ids = id;
				} else {
					ids = ids + ',' + id;
				}
			}
		});
		if(ids == ''){
			return ;
		}
		$.get('${ctx}/follows/isFollow', {
			'userId' : '${(Session.loginer.id)!}',
			'relationIds' : ids,
			'type' : 'course_study_question'
		}, function(response) {
			$.each(response, function(key, value) {
				var state;
				var question = $('#' + key);
				if (value == true) {
					addUnfollowBtn(question);
				} else {
					addFollowBtn(question);
				}
			})
		});
	}
	
	//关注按钮点击事件
	function follow(a) {
		var question = a.closest('li');
		$.post('${ctx}/follows', {
			'followEntity.id' : $(question).attr('id'),
			'followEntity.type' : 'course_study_question'
		}, function(response) {
			if (response.responseCode == '00') {
				$(a).remove();
				addUnfollowBtn(question);
			}
		});
	}

	//添加关注按钮
	function addFollowBtn(question) {
		//若已经添加过
		var followDiv = $(question).find('.b-row').eq(0);//关注部分的div
		if (followDiv.find('a').size() >= 1) {
			return;
		} else {
			$(followDiv).find('.time').before('<a href="javascript:void(0);" onclick="follow(this)" class="u-love"><i class="u-iLove-ico"></i>关注</a>');
		}
	}

	//添加已关注按钮
	function addUnfollowBtn(question) {
		var followDiv = $(question).find('.b-row').eq(0);//关注部分的div
		if (followDiv.find('a').size() >= 1) {
			return;
		} else {
			$(followDiv).find('.time').before('<a href="javascript:void(0);" onclick="unfollow(this)" class="u-love z-crt"><i class="u-iLove-ico"></i>已关注</a>');
		}
	}
	//关注部分js结束

	function saveQuestion() {
		var content = $('#questionContent').val();
		content = content.trim();
		if (content == '') {
			alert('提问内容为空');
		} else {
			$.post("${ctx}/study/faq_question", {
				'content' : content,
				'relation.type' : 'course_study',
				'relation.id':'${cid!}'
			}, function(response) {
				if (response.responseCode == '00') {
					alert('保存成功');
					loadFaqQuestions();
					clearQuestionContent();
				}
			});
		}
	}

	//重新加载
	function loadFaqQuestions() {
		$.ajaxQuery('faqForm', 'faqQuestionList', setFollowStat);
	}

	//查询按钮事件
	function searchFaqQuestion() {
		loadFaqQuestions();
	}

	//清空查询框
	function clearQuestionContent() {
		$('#questionContent').val('');
	}

	
	//加载更多提问
	function loadMoreFaqQuestion(a) {
		//判断是否已经到底
		var limit = $(a).closest('div').find('.limit');
		var totalCount = $(a).closest('div').find('.totalCount');
		var page = $(a).closest('div').find('.page');
		if(parseInt(limit.val()) * parseInt(page.val()) >= parseInt(totalCount.val())){
			alert('到底了');
			return;
		}
		page.val(parseInt(page.val()) + 1);
		var param = $('#faqForm').serialize();
		
		$.get('${ctx}/study/faq_question?'+param,{},function(response){
			$('#faqQuestionList').append(response);
			setFollowStat();
		});		
	}


	function reloadByQueryType(radio, queryType) {
		//清除分页信息
		var page = $('#faqQuestionList .page');
		page.val(1);
		//如果已经选中 取消选中 清除参数
		var strong = $(radio).closest('strong');
		var strongClass = strong.attr('class');
		if (strongClass == 'on') {	
			$(radio).prop('checked',false);
			$('#queryType').val('');
		} else {
			$('#queryType').val(queryType);
		}
		loadFaqQuestions();
	}
	
	function questionContentDisplay(type){
		if(type == 'none'){
			$('#editQuestionDiv').hide();
		}else if(type == 'block'){
			$('#editQuestionDiv').show();
		}
	}
	
	function saveAnswer(a){
		var textArea = $(a).closest('div').find('textarea');
		if(textArea.val().trim()){
			var questionId = $(a).closest('li').attr('id');
			$.post('${ctx}/study/faq_answer',{
				'questionId':questionId,
				'content':textArea.val(),
				'creator':'${(Session.loginer.id)!}'
			},function(response){
				if(response.responseCode == '00'){
					loadFaqQuestions();
				}
			});
		}
	}
</script>