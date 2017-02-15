<div class="g-addElement-lyBox">
	<div class="g-addElement-tab">
		<div class="g-add-step">
            <ol class="m-add-step num3">
                <li class="step in">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">1</i></span>
                    	<br>
                        <span class="txt">视频</span>
                    </a>
                </li>
                <li class="step <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">2</i></span>
                    	<br>
                        <span class="txt">完成指标</span>
                    </a>
                </li>
                <li class="step last <#if activity.entityId??>yet</#if>">
                    <span class="line"></span>
                    <a href="javascript:void(0);">
                        <span class="ico"><i class="u-rhombus-ico">3</i></span>
                    	<br>
                        <span class="txt">活动设置</span>
                    </a>
                </li>
            </ol>
        </div>
        <br>
		<div id="tabListDiv" class="g-addElement-tabCont">
			<div class="g-addElement-tabList" style="display: block">
				<@video id="${activity.entityId! }">
					<#if (activity.id)??>
						<form id="saveActivityForm" action="${ctx }/make/activity/${activity.id!}" method="put">
							<input type="hidden" name="video.id" value="${video.id! }"> 
					<#else>
						<form id="saveActivityForm" action="${ctx }/${CSAIdObject.getCSAIdObject().scid }/make/activity" method="post">
							<input type="hidden" name="activity.relation.id" value="${CSAIdObject.getCSAIdObject().scid }"> 
							<input type="hidden" name="video.videoRelations[0].relation.id" value="${CSAIdObject.getCSAIdObject().cid }"> 
					</#if> 
							<input type="hidden" name="activity.type" value="${activity.type! }">
							<ul class="g-addElement-lst g-addCourse-lst chooseTickBox">
								<li class="m-addElement-item">
									<div class="ltxt">
										<em>*</em>视频名称：
									</div>
									<div class="center">
										<div class="m-pbMod-ipt">
											<input name="video.title" type="text" value="${video.title! }" placeholder="输入名称" class="u-pbIpt required">
										</div>
									</div>
								</li>
								<li class="m-addElement-item">
									<div class="ltxt">
										课前导读：
									</div>
									<div class="center">
										<div class="m-pbMod-ipt">
											<textarea rows="5" cols="30" name="video.summary" placeholder="输入课前导读" class="u-textarea">${video.summary! }</textarea>
										</div>
									</div>
								</li>
								<li class="m-addElement-item chooseTickItem">
									<div class="ltxt">
										<label class="m-radio-tick"> <strong> <i class="ico"></i> 
											<input type="radio" name="video.type" value="file" checked="checked" class="chooseTickUnit"></strong> 
											<span>本地上传视频：</span>
										</label>
									</div>
									<div id="videoDiv" class="center byChooseTick">
										<#import "/ncts/make/common/upload_file_list.ftl" as uploadFileList /> 
										<@uploadFileList.uploadFileListFtl relationId="${video.id!}" relationType="video" paramName="video.videoFiles" divId="videoDiv" btnTxt="上传视频" fileNumLimit=1 fileTypeLimit="mp3,mp4,flv,wav"/>
									</div>
								</li>
								<li class="m-addElement-row chooseTickItem">
									<ul id="videoUrlUl" class="m-addElement-innerLst">
										<#if (video.type)! == 'url'> 
											<#list video.urls?split(",") as url> 
												<#if url != ''> 
													<#if url_index == 0>
														<li class="m-addElement-item">
															<div class="ltxt">
																<label class="m-radio-tick"> 
																	<strong><i class="ico"></i><input type="radio" name="video.type" value="url" class="chooseTickUnit"></strong> 
																	<span>输入视频URL：</span>
																</label>
															</div>
															<div class="center byChooseTick">
																<div class="m-pbMod-ipt">
																	<input type="text" name="video.urls" value="${url }" placeholder="输入视频的链接地址" class="u-pbIpt disabled">
																</div>
																<p class="m-addElement-ex" id="CourseTypeExplain">视频的链接地址。后缀必须为.mp4,.flv,.wav等视频文件，并且能够通过internet访问。</p>
															</div>
														</li> 
													<#else>
														<!-- <li class="m-addElement-item">
															<div class="ltxt"></div>
															<div class="center byChooseTick">
																<div class="m-pbMod-ipt">
																	<input type="text" name="video.urls" value="${url }" placeholder="输入视频的备用地址" class="u-pbIpt disabled">
																</div>
															</div>
														</li>  -->
													</#if> 
												</#if> 
											</#list> 
										<#else>
											<li class="m-addElement-item">
												<div class="ltxt">
													<label class="m-radio-tick"> 
														<strong> <i class="ico"></i><input type="radio" name="video.type" value="url" class="chooseTickUnit"></strong> 
														<span>输入视频URL：</span>
													</label>
												</div>
												<div class="center byChooseTick">
													<div class="m-pbMod-ipt">
														<input type="text" name="video.urls" placeholder="输入视频的链接地址" class="u-pbIpt disabled">
													</div>
													<p class="m-addElement-ex" id="CourseTypeExplain">视频的链接地址。后缀必须为.mp4,.ogg,.webm等视频文件，并且能够通过internet访问。</p>
												</div>
											</li> 
										</#if>
										<!-- <li class="m-addElement-item">
											<div class="center">
												<div class="m-pbMod-udload byChooseTick">
													<button type="button" onclick="addVideoUrl(this)" class="btn u-inverse-btn u-opt-btn disabled">
														<i class="u-plus-ico"></i>添加备用地址
													</button>
												</div>
											</div>
										</li> -->
									</ul> 
								</li>
								<#if (PropertiesLoader.get('video.record.is.user') == 'true')>
									<li class="m-addElement-item chooseTickItem">
										<div class="ltxt">
											<label class="m-radio-tick"> <strong> <i class="ico"></i> 
												<input type="radio" name="video.type" value="record" class="chooseTickUnit"></strong> 
												<span>从视频库选择：</span>
											</label>
										</div>
										<div id="videoRecordDiv" class="center byChooseTick">
											<#import "/common/video/choose_video_from_lib.ftl" as cvfl /> 
											<@cvfl.chooseVideoFromLibFtl video=video divId="videoRecordDiv" btnTxt="选择视频"/>
	        							</div>
									</li>
								</#if>
								<script>
									$(function() {
										$('#saveActivityForm input[name="video.type"][value!="${(video.type)!}"]').parents('.chooseTickItem').find('a').addClass('disabled');
										$('#saveActivityForm input[name="video.type"][value="${(video.type)!}"]').trigger('click');
									});
								</script>
								<li class="m-addElement-item">
									<div class="m-high-switch">
										<a href="javascript:void(0);" class="switch" id="videoHighSetting">高级属性<i class="u-up-ico"></i></a>
									</div>
								</li>
							</ul>
							<ul class="g-addElement-lst g-addCourse-lst" id="videoHighSettingBox">
								<li class="m-addElement-item">
									<div class="ltxt">视频讲义：</div>
									<div id="fileDiv" class="center">
										<#import "/ncts/make/common/upload_file_list.ftl" as uploadFileList /> 
										<@uploadFileList.uploadFileListFtl relationId="${video.id!}" relationType="video_file" paramName="video.fileInfos" />
										<p class="m-addElement-ex" id="CourseTypeExplain">可提供视频对应的讲义，如PPT、PDF等供学员下载</p>
									</div>
								</li>
								<li class="m-addElement-item">
									<div class="ltxt">是否允许下载：</div>
									<div class="center">
										<div class="m-check-mod">
											<label class="m-radio-tick"> 
												<strong> <i class="ico"></i><input type="radio" name="video.allowDownload" checked="checked" value="Y"></strong> 
												<span>是</span>
											</label> 
											<label class="m-radio-tick">
												<strong><i class="ico"></i><input type="radio" name="video.allowDownload" value="N"></strong> 
												<span>否</span>
											</label>
										</div>
									</div> 
									<script>
										$(function() {
											$('#saveActivityForm input[name="video.allowDownload"][value="${(video.allowDownload)!}"]').trigger('click');
										});
									</script>
								</li>
								<#-- <li class="m-addElement-item">
									<div class="ltxt">视频开始时间：</div>
									<#assign startTime=(video.startTime)!?split(",") >
									<div class="center">
										<div class="m-slt-row date">
											<div class="block">
												<div class="m-selectbox style1">
													<strong><span class="simulateSelect-text">---</span><i class="trg"></i></strong> 
													<select id="startTimeHourSelect" name="video.startTime"> 
														<option value="">---</option> 
														<#list 0..23 as i>
															<option value="${i}">${i}</option> 
														</#list>
													</select>
													<#list startTime as s>
														<#if s_index == 0>
															<#assign hour=s>
														</#if>
													</#list>
													<script>
														$(function() {
															$('#startTimeHourSelect').simulateSelectBox({
																byValue : '${hour!}'
															});
														});
													</script>
												</div>
											</div>
											<div class="space">时</div>
											<div class="block">
												<div class="m-selectbox style1">
													<strong><span class="simulateSelect-text">---</span><i class="trg"></i></strong> 
													<select id="startTimeMinuteSelect" name="video.startTime"> 
														<option value="">---</option>
														<#list 0..59 as i>
															<option value="${i}">${i}</option> 
														</#list>
													</select>
													<#list startTime as s>
														<#if s_index == 1>
															<#assign minute=s>
														</#if>
													</#list>
													<script>
														$(function() {
															$('#startTimeMinuteSelect').simulateSelectBox({
																byValue : '${minute!}'
															});
														});
													</script>
												</div>
											</div>
											<div class="space">分</div>
											<div class="block">
												<div class="m-selectbox style1">
													<strong><span class="simulateSelect-text">---</span><i class="trg"></i></strong> 
													<select id="startTimeSecondSelect" name="video.startTime"> 
														<option value="">---</option>
														<#list 0..59 as i>
															<option value="${i}">${i}</option> 
														</#list>
													</select>
													<#list startTime as s>
														<#if s_index == 2>
															<#assign second=s>
														</#if>
													</#list>
													<script>
														$(function() {
															$('#startTimeSecondSelect').simulateSelectBox({
																byValue : '${second!}'
															});
														});
													</script>
												</div>
											</div>
											<div class="space">秒</div>
										</div>
										<p class="m-addElement-ex" id="CourseTypeExplain">如果不想播放所有视频，则设置视频开始时间。 将格式设置为 HH:MM:SS。</p>
									</div>
								</li>
								<li class="m-addElement-item">
									<div class="ltxt">视频结束时间：</div>
									<#assign endTime=(video.endTime)!?split(",") >
									<div class="center">
										<div class="m-slt-row date">
											<div class="block">
												<div class="m-selectbox style1">
													<strong><span class="simulateSelect-text">---</span><i class="trg"></i></strong> 
													<select id="endTimeHourSelect" name="video.endTime"> 
														<option value="">---</option>
														<#list 0..23 as i>
															<option value="${i}">${i}</option> 
														</#list>
													</select>
													<#list endTime as s>
														<#if s_index == 0>
															<#assign hour=s>
														</#if>
													</#list>
													<script>
														$(function() {
															$('#endTimeHourSelect').simulateSelectBox({
																byValue : '${hour!}'
															});
														});
													</script>
												</div>
											</div>
											<div class="space">时</div>
											<div class="block">
												<div class="m-selectbox style1">
													<strong><span class="simulateSelect-text">---</span><i class="trg"></i></strong> 
													<select id="endTimeMinuteSelect" name="video.endTime"> 
														<option value="">---</option>
														<#list 0..59 as i>
															<option value="${i}">${i}</option> 
														</#list>
													</select>
													<#list endTime as s>
														<#if s_index == 1>
															<#assign minute=s>
														</#if>
													</#list>
													<script>
														$(function() {
															$('#endTimeMinuteSelect').simulateSelectBox({
																byValue : '${minute!}'
															});
														});
													</script>
												</div>
											</div>
											<div class="space">分</div>
											<div class="block">
												<div class="m-selectbox style1">
													<strong><span class="simulateSelect-text">---</span><i class="trg"></i></strong> 
													<select id="endTimeSecondSelect" name="video.endTime"> 
														<option value="">---</option>
														<#list 0..59 as i>
															<option value="${i}">${i}</option> 
														</#list>
													</select>
													<#list endTime as s>
														<#if s_index == 2>
															<#assign second=s>
														</#if>
													</#list>
													<script>
														$(function() {
															$('#endTimeSecondSelect').simulateSelectBox({
																byValue : '${second!}'
															});
														});
													</script>
												</div>
											</div>
											<div class="space">秒</div>
										</div>
										<p class="m-addElement-ex" id="CourseTypeExplain">如果不想播放所有视频，则设置视频开始时间。 将格式设置为 HH:MM:SS。</p>
									</div>
								</li> -->
								<li class="m-addElement-btn">
									<a onclick="saveVideo()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">保存并下一步</a> 
									<a href="javascript:void(0);" class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
								</li>
							</ul>
							<!-- <li id="videoUrlLiTemplet" class="videoUrlLi m-addElement-item byChooseTick" style="display: none;">
								<div class="ltxt"></div>
								<div class="center">
									<div class="m-pbMod-ipt">
										<input type="text" name="video.urls" placeholder="输入视频的备用地址" class="u-pbIpt">
									</div>
								</div>
								<div class="lright">
									<div class="opt">
										<button type="button" onclick="deleteVideoUrl(this)" class="u-opt u-delete">
											<i class="u-delete-ico"></i><span class="tip">删除</span>
										</button>
									</div>
								</div>
							</li>  -->
						</form>
			</@video>
		</div>
		<div class="g-addElement-tabList">
			<#import "/ncts/make/activity/video/edit_video_activity_attribute.ftl" as eva /> 
			<@eva.editVideoActivityAttributeFtl activity=activity />
		</div>
		<div class="g-addElement-tabList">
			<#import "/ncts/make/activity/edit_activity.ftl" as ea /> 
			<@ea.editActivityFtl activity=activity courseType=(courseType[0])!'' />
		</div>
	</div>
	</div>
</div>
<script>
	function saveVideo() {
		if (!$('#saveActivityForm').validate().form()) {
			return false;
		}
		var type = $('#saveActivityForm input[name="video.type"]:checked').val();
		if (type == 'file') {
			if ($('#videoDiv').find('.fileParam').length == 0) {
				parent.alert('请先上传视频文件');
				return false;
			} else {
				submitForm();
			}
		}else if(type == 'url'){
			var urls = $('#saveActivityForm input[name="video.urls"]').val();
			if(urls.length == 0){
				alert('请先填写视频地址');
				return false;
			}
			submitForm();
		}else {
			if ($('#videoRecordDiv').find('.recordId').length == 0) {
				parent.alert('请先选择视频');
				return false;
			}else{
				submitForm();
			}
		}
	}

	function submitForm() {
		var data = $.ajaxSubmit('saveActivityForm');
		var json = $.parseJSON(data);
		if (json.responseCode == '00') {
			listActivity('${CSAIdObject.getCSAIdObject().scid }');
			var activity = json.responseData;
			if (activity != null) {
				refreshAndNextForm(activity.id, '${(courseType[0])!""}');
			}else{
				$('.m-add-step li').eq(1).trigger('click');
			}
		}
	}

	function addVideoUrl(obj) {
		var count = $('#videoUrlUl input[name="video.urls"]').length;
		if (count >= 3) {
			parent.alert('最多只允许输入2个备用地址');
		} else {
			$(obj).closest('li').before($('#videoUrlLiTemplet').clone().show())
		}
	}

	function deleteVideoUrl(obj) {
		$(obj).parents('.videoUrlLi').remove();
	}

	$(function() {
		//高级设置开关
		addCourseFn.settingSwitchFn($("#videoHighSetting"), $("#videoHighSettingBox"), true);
		// 清除 disabled
		addCourseFn.deleteDisabled();
	})
</script>
