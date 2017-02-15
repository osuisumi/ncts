<form id="changePasswordForm" action="${ctx!}/ncts/account/update_password" method="put">
	<input id="userId" name="id" type="hidden" value="${(user.id)!}">
	<div class="g-user-add">
		<ul>
			<li class="m-addElement-item">
				<div class="ltxt ltxt2" style="width:60px">
					原密码：
				</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input required name="oldPassword" type="password"  class="u-pbIpt">
					</div>
				</div>
			</li>
			<li class="m-addElement-item">
				<div class="ltxt ltxt2" style="width:60px">
					新密码：
				</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input required id="newPassword" name="newPassword" type="password"  class="u-pbIpt">
					</div>
				</div>
			</li>
			<li class="m-addElement-item">
				<div class="ltxt ltxt2" style="width:60px">
					确认：
				</div>
				<div class="center">
					<div class="m-pbMod-ipt">
						<input required name="comfirmPassword" type="password" class="u-pbIpt">
					</div>
				</div>
			</li>
			<li class="m-addElement-item">
				<div class="m-addElement-btn g-addCourse-lst2">
					<a onclick="cancle()" href="javascript:void(0);" class="btn u-inverse-btn mylayer-cancel" id="confirmLayer">取消</a>
					<a onclick="changePassword()" href="javascript:void(0);" class="btn u-main-btn u-cancelLayer-btn">保存</a>
				</div>
			</li>
		</ul>
	</div>
</form>
<script>
	$(function(){
		$('#changePasswordForm').validate({
			rules:{
				comfirmPassword:{
					equalTo: "#newPassword",
					
				}
			},
			message:{
				comfirmPassword:{
					equalTo:'两次密码输入不一致'
				}
			}
		});
	});
	
	function changePassword(){
		if(!$('#changePasswordForm').validate().form()){
			return false;
		}
		
		var response = $.ajaxSubmit('changePasswordForm');
		response = $.parseJSON(response);
		if(response.responseCode == '00'){
			alert('修改成功',function(){
				mylayerFn.closelayer($('#changePasswordForm'));
			});
		}else{
			if(response.responseMsg){
				var msg = '';
				if(response.responseMsg == 'error old password'){
					msg = '旧密码不正确';
				}else if(response.responseMsg == 'new password is empty'){
					msg = '密码不能为空';
				}
				alert(msg,function(){
					$('#changePasswordForm').get(0).reset();
				});
			}else{
				alert('修改失败',function(){
					$('#changePasswordForm').get(0).reset();
				});
			}
		}
		
	}
	
</script>