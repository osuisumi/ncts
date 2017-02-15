<#macro editMicVideoFtl id>
	<@video id="${id!}">
		<ul class="g-addElement-lst g-addCourse-lst chooseTickBox">
			<input type="hidden" name="video.id" value="${(video.id)! }">
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
	        <!-- <li class="m-addElement-item">
				<div class="ltxt">
					课前导读：
				</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<textarea rows="5" cols="30" name="video.summary" placeholder="输入课前导读" class="u-textarea">${video.summary! }</textarea>
					</div>
				</div>
			</li> -->
	        <li class="m-addElement-item chooseTickItem">
                <div class="ltxt">
                    <label class="m-radio-tick">
                        <strong>
                            <i class="ico"></i>
                            <input type="radio" name="video.type" value="file" checked="checked" class="chooseTickUnit">
                        </strong>
                        <span>本地上传视频：</span>
                    </label>
                </div>
                <div id="videoDiv" class="center byChooseTick">
	                <#import "/ncts/make/common/upload_file_list.ftl" as uploadFileList /> 
					<@uploadFileList.uploadFileListFtl relationId="${video.id!}" relationType="video" paramName="video.videoFiles" divId="videoDiv" btnTxt="上传视频" fileNumLimit=1 fileTypeLimit="mp4,flv,wav"/>
                </div>
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
					$('#saveMicVideoForm input[name="video.type"][value!="${(video.type)!}"]').parents('.chooseTickItem').find('a').addClass('disabled');
					$('#saveMicVideoForm input[name="video.type"][value="${(video.type)!}"]').trigger('click');
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
	            <div class="ltxt">
	               	视频讲义：
	            </div>
	            <div id="fileDiv" class="center">
	                <#import "/ncts/make/common/upload_file_list.ftl" as uploadFileList /> 
					<@uploadFileList.uploadFileListFtl relationId="${video.id!}" relationType="video_file" paramName="video.fileInfos" />
					<p class="m-addElement-ex" id="CourseTypeExplain">可提供视频对应的讲义，如PPT、PDF等供学员下载</p>
	            </div>
	        </li>
	        <li class="m-addElement-item">
	            <div class="ltxt">
	               	是否允许下载：
	            </div>
	            <div class="center">
	                <div class="m-check-mod">
	                    <label class="m-radio-tick">
	                        <strong>
	                            <i class="ico"></i>
	                            <input type="radio" name="video.allowDownload" checked="checked" value="Y">
	                        </strong>
	                        <span>是</span>
	                    </label>
	                    <label class="m-radio-tick">
	                        <strong>
	                            <i class="ico"></i>
	                            <input type="radio" name="video.allowDownload" value="N">
	                        </strong>
	                        <span>否</span>
	                    </label>
	                </div>
	            </div>
	            <script>
	            	$(function(){
	            		$('#saveActivityForm input[name="video.allowDownload"][value="${(video.allowDownload)!}"]').trigger('click');
	            	});
	            </script>
	        </li>
	        <li class="m-addElement-item">
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
			</li>
	        <li class="m-addElement-btn">
				<a onclick="saveMicVideo()" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">提交</a>
	        </li>
	    </ul>
	    <li id="videoUrlLiTemplet" class="videoUrlLi m-addElement-item byChooseTick" style="display: none;">
            <div class="ltxt">
            </div>
            <div class="center">
                <div class="m-pbMod-ipt">
                    <input type="text" name="video.urls" placeholder="输入视频的备用地址" class="u-pbIpt">
                </div>
            </div>
            <div class="lright">
                <div class="opt">
                    <button type="button" onclick="deleteVideoUrl(this)" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></button>
                </div>
            </div>
        </li>
		<script>
			function saveMicVideo(){
				if(!$('#saveMicVideoForm').validate().form()){
					return false;
				}
				var type = $('#saveMicVideoForm input[name="video.type"]:checked').val();
				if (type == 'file') {
					if ($('#videoDiv').find('.fileParam').length == 0) {
						parent.alert('请先上传视频文件');
						return false;
					} else {
						submitSaveForm();
					}
				} else {
					if ($('#videoRecordDiv').find('.recordId').length == 0) {
						parent.alert('请先选择视频');
						return false;
					}else{
						submitSaveForm();
					}
				}
			}
			
			function submitSaveForm(){
				var data = $.ajaxSubmit('saveMicVideoForm');
				var json = $.parseJSON(data);
				if(json.responseCode == '00'){
					alert('提交成功', function(){
						window.location.reload();
					});
				}
			}
			
			function addVideoUrl(obj){
				var count = $('#videoUrlUl input[name="video.urls"]').length;
				if(count >= 3){
					parent.alert('最多只允许输入2个备用地址');
				}else{
					$(obj).closest('li').before($('#videoUrlLiTemplet').clone().show())
				}	
			}
			
			function deleteVideoUrl(obj){
				$(obj).parents('.videoUrlLi').remove();
			}
			
			$(function(){
				//高级设置开关
			    addCourseFn.settingSwitchFn($("#videoHighSetting"),$("#videoHighSettingBox"),true);
			    // 清除 disabled
			    addCourseFn.deleteDisabled();
			    //radio
			    $('.m-radio-tick input').bindCheckboxRadioSimulate();
			})
		</script>
	</@video>
</#macro>