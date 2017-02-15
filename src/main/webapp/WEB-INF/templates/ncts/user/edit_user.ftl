<#global app_path=PropertiesLoader.get('app.ncts.path') >
<@userInfoDirective id=Session.loginer.id>
	<#assign userInfo=userInfo>
</@userInfoDirective>
<#if app_path = '/ncts/lego'>
	<form id="updateUserForm" action="/lego/user/save_user" method="put">
	<@userRegionsDirective userId=(userInfo.id)!''>
		<#assign userRegions=userRegions!>
	</@userRegionsDirective>
<#else>
	<form id="updateUserForm" action="/ncts/users" method="put">
</#if>
	<input id="userId" name="id" type="hidden" value="${(userInfo.id)!}">
    <div class="g-user-add">
        <ul>
            <li class="m-addElement-item">
                <div class="m-user-name">
                    <a userId="${(userInfo.id)!}" href="javascript:void(0);" class="figure picker_${(userInfo.id)!}">
                    	<#import "/common/image.ftl" as image/>
						<@image.imageFtl url="${(userInfo.avatar)!}" default="${app_path }/images/defaultAvatarImg.png" />
                    </a>
                    <div class="m-user-picM">
                        <a href="javascript:;" class="user-modify figure picker"><i></i>修改头像</a>  
                        <input name="avatar" type="hidden">              
                    </div>
                </div>
            </li>
            <li class="m-addElement-item">
                <div class="ltxt ltxt2">
					姓名：
                </div>
                <div class="center">
                    <div class="m-pbMod-ipt">
                        <input name="realName" type="text" value="${(userInfo.realName)!}" placeholder="请输入姓名" class="u-pbIpt">
                    </div>
                </div>
            </li>  
            <li class="m-addElement-item">
                <div class="ltxt ltxt2">
					邮箱：
                </div>
                <div class="center">
                    <div class="m-pbMod-ipt">
                        <input name="email" type="email" value="${userInfo.email!}" placeholder="请输入邮箱" class="u-pbIpt">
                    </div>
                </div>
            </li>   
            <#if app_path = '/ncts/lego'>
            	<li class="m-addElement-item">
                    <div class="ltxt ltxt2"><em>*</em>区域：</div>
                    <div class="center">
                        <div class="m-slt-row space">
                            <div class="block">
                                <div class="m-selectbox style1">
                                    <strong><span class="simulateSelect-text">请选择省</span><i class="trg"></i></strong>
                                    <select id="province" name="userRegions.province">
                                    	<option class="static" value="">请选择省</option>
                                    	${RegionsUtils.getEntryOptionsSelected('1', (userRegions.province)!'')}
                                    </select>
                                </div>
                            </div>
                            <div class="space"></div>
                            <div class="block">
                                <div class="m-selectbox style1">
                                    <strong><span class="simulateSelect-text">请选择市</span><i class="trg"></i></strong>
                                    <select id="city" name="userRegions.city">
                                    	<option class="static" value="">请选择市</option>
                                    	<#if (userRegions.province)??>
											${RegionsUtils.getEntryOptionsSelected('2',userRegions.province,(userRegions.city)!)}
										</#if>
                                    </select>
                                </div>
                            </div>
                           	<br><br>
                            <div class="block">
                                <div class="m-selectbox style1">
                                    <strong><span class="simulateSelect-text">请选择区</span><i class="trg"></i></strong>
                                    <select id="area" name="userRegions.counties">
                                    	<option class="static" value="">请选择区</option>
                                        <#if (userRegions.city)??>
											${RegionsUtils.getEntryOptionsSelected('3',userRegions.city,(userRegions.counties)!)}
										</#if>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="m-addElement-item">
                    <div class="ltxt ltxt2"><em>*</em>单位：</div>
                    <div class="center">
                        <div class="m-pbMod-ipt">
                            <input type="text" name="department.deptName" value="${(userInfo.department.deptName)!''}" class="u-pbIpt required">
                        </div>
                    </div>
                </li>
                <li class="m-addElement-item">
                    <div class="ltxt ltxt2"><em>*</em>学科：</div>
                    <div class="center">
                        <div class="m-slt-row section">
                            <div class="block">
                                <div class="m-selectbox style1">
                                    <strong><span class="simulateSelect-text">请选择学科</span><i class="trg"></i></strong>
                                    <select id="subject" name="subject">
                                    	<option class="static" value="">请选择学科</option>
                                    	<#list TextBookUtils.getEntryList('SUBJECT') as entry>
                                    		<#if entry.textBookName != '全学科'>
                                    			<option value="${entry.textBookValue}" <#if entry.textBookValue=(userInfo.subject)!''>selected="selected"</#if>>${entry.textBookName}</option>
                                    		</#if>
                                    	</#list>
                                    </select>
                                </div>
                            </div>
                            <div class="space"></div>
                        </div>
                    </div>
                </li>
                <li class="m-addElement-item">
                    <div class="ltxt ltxt2">学段：</div>
                    <div class="center">
                        <p class="txt">${TextBookUtils.getEntryName('STAGE', (userInfo.stage!''))}</p>
                    </div>
                </li>
                <script>
	                $(function(){
	                	//模拟下拉框
					    $('#province').simulateSelectBox({
						    byValue: "${(userRegions.province)!}"
						});	
						$('#city').simulateSelectBox({
						    byValue: "${(userRegions.city)!}"
						});	
						$('#area').simulateSelectBox({
						    byValue: "${(userRegions.counties)!}"
						});	
						$('#subject').simulateSelectBox({
						    byValue: "${(userInfo.subject)!}"
						});	
	                });
	            </script>
            <#else>
	            <li class="m-addElement-item">
	                <div class="ltxt ltxt2">
						电话：
	                </div>
	                <div class="center">
	                    <div class="m-pbMod-ipt">
	                        <input name="phone" type="tel" value="${(userInfo.phone)!}" placeholder="${(userInfo.phone)!}" class="u-pbIpt">
	                    </div>
	                </div>
	            </li>   	
	            <li class="m-addElement-item">
	                <div class="ltxt ltxt2">简介：</div>
	                <div class="center">
	                    <div class="m-pbMod-ipt">
	                        <textarea name="summary" id="" placeholder="请输入个人简介" class="u-textarea">${(userInfo.summary)!}</textarea>
	                    </div>
	                </div>
	            </li>
	        </#if>
            <li class="m-addElement-item">
                <div class="m-addElement-btn g-addCourse-lst2">
                    <a onclick="cancle()" href="javascript:void(0);" class="btn u-inverse-btn mylayer-cancel" id="confirmLayer">取消</a>
                    <a onclick="updateUser()" href="javascript:void(0);" class="btn u-main-btn u-cancelLayer-btn">保存</a>
                </div>                 
            </li>
        </ul>
    </div>
</form>
<script>

$(function(){
	initUpload();
});

function initUpload(){
	var uploader = WebUploader.create({
		swf : $('#ctx').val() + '/js/webuploader/Uploader.swf',
		server : '${ctx!}/file/uploadFileInfoRemote',
		pick : '.picker',
		resize : true,
		duplicate : true,
		accept : {
		    extensions: 'jpg,jpeg,png'
		}
	});
	// 当有文件被添加进队列的时候
	uploader.on('fileQueued', function(file) {
		uploader.upload();
	});
	// 文件上传过程中创建进度条实时显示。
	uploader.on('uploadProgress', function(file, percentage) {
		
	});
	uploader.on('uploadSuccess', function(file, response) {
		if (response != null && response.responseCode == '00') {
			var fileInfo = response.responseData;
			$('.picker_'+$('#userId').val()+' img').attr('src', '${FileUtils.getFileUrl("")}'+fileInfo.url);
			$('#updateUserForm input[name="avatar"]').val(fileInfo.url);
		}
	});
	uploader.on('uploadError', function(file) {
		$('#' + file.id).find('.fileBar').addClass('error');
		$('#' + file.id).find('.barTxt').text('上传出错');
	});
	uploader.on('error', function(type) {
		if (type == 'Q_TYPE_DENIED') {
			alert('不支持该类型的文件');
		}
	});
};

//省市区联动
$('#province').on('change',function(){
	var _this = $(this);
	$.get('${ctx}/regions/entities',{
		"level":'2',
		"parentCode":_this.val(),
	},function(regions){
		$('#city option').not('.static').remove();
		$('#city .static').attr('selected','selected');
		$('#city').parent().find('.simulateSelect-text').text($('#city').find('option:selected').text());
		$('#city').trigger('change');
		$.each(regions,function(i,n){
			$('#city').append('<option class="cityOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
		});
	});
});

$('#city').on('change',function(){
	var _this = $(this);
	$.get('${ctx}/regions/entities',{
		"level":'3',
		"parentCode":_this.val(),
	},function(regions){
		$('#area option').not('.static').remove();
		$('#area .static').attr('selected','selected');
		$('#area').parent().find('.simulateSelect-text').text($('#area').find('option:selected').text());
		$.each(regions,function(i,n){
			$('#area').append('<option class="areaOption" value="'+n.regionsCode+'" >'+n.regionsName+'</option>');
		});
	});
});
	
function updateUser(){
	if (!$('#updateUserForm').validate().form()) {
		return false;
	}
	<#if app_path = '/ncts/lego'>
		var province = $('#province').val();
		if(province.length == 0){
			alert('请选择省份');
			return false;
		}
		var subject = $('#subject').val();
		if(subject.length == 0){
			alert('请选择学科');
			return false;
		}
	</#if>
	var data = $.ajaxSubmit('updateUserForm');
	var json = $.parseJSON(data);
	if(json.responseCode == '00'){
		alert('修改成功', window.location.reload());
	}
};

function cancle(){
	$('.mylayer-wrap').remove();
};
</script>