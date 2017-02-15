<#include "/ncts/make/include/layout.ftl" />
<@layout title='学习平台' isVisitor='Y'>
	<div id="g-bd">
        <div class="g-register-box g-auto">
            <h2 class="u-tt">绑定账号</h2>
            <div class="m-con f-cb">
                <div class="g-register-con">
                    <div class="m-register">
                        <div class="hd-info">
                            <span class="img"><img src="${app_path}/images/defaultAvatarImg.png" alt=""></span>
                            <span class="name">${realName!}</span>
                        </div>
                        <form id="saveUserForm" action="/nea/user/save_user" method="post">
							<input type="hidden" name="user.id" value="${userId!}"> 
							<input type="hidden" name="user.department.deptName" value="${deptName!}"> 
							<input type="hidden" name="user.realName" value="${realName!}"> 
							<input type="hidden" name="user.paperworkNo" value="${paperworkNo!}"> 
	                        <ul>
	                           <li class="m-reg-mod">
	                               <span class="ltxt">账号：</span>
	                               <div class="center">
	                                   <input id="userName" type="text" name="userName" class="ipt required" placeholder="设置在本平台的登录账号">
	                               </div>
	                           </li>
	                           <li class="m-reg-mod">
	                               <span class="ltxt">手机号：</span>
	                               <div class="center">
	                                   <input type="text" name="user.phone" class="ipt" value="${mobilePhone!}" placeholder="请输入您的手机号">
	                               </div>
	                           </li>
	                           <li class="m-reg-mod">
	                               <span class="ltxt">密码：</span>
	                               <div class="center">
	                                   <input id="password" type="password" name="password" class="required ipt" placeholder="请输入密码">
	                               </div>
	                           </li>
	                           <li class="m-reg-mod">
	                               <span class="ltxt">确认密码：</span>
	                               <div class="center">
	                                   <input id="repassword" type="password" class="required ipt" placeholder="请确认密码">
	                               </div>
	                           </li>
	                           <li class="m-reg-mod">
	                               <div class="center">
	                                   <a href="javascript:;" class="u-btn-theme" onclick="saveUser()">提交</a>
	                               </div>
	                           </li>
	                        </ul>
	                	</form>
                    </div>
                </div>
                <#--<div class="m-login">
                    <p>已经有账号？</p>
                    <a href="bind.html" class="u-btn-reverse">登录并绑定账号</a>
                </div>-->
            </div>
        </div>
    </div>
</@layout>
<script>
$(function(){
	$('#saveUserForm').validate({
		rules : {
			userName : {
				required : true,
				remote : {
					url :  '/accounts/countForValidUserNameIsExist', 
                    type : "get", 
                    dataType : "text",
					data :  {
						userName : function() {   
		                    return $("#userName").val();   
		                }
					},
					dataFilter : function (result,type) {
						return parseInt(result) > 0 ? false : true;
					} 
				}
			},
			repassword : {
				required: true,
		        minlength: 6,
		        equalTo: "#password"
			}
		},
		messages : {
			userName : {
				required : '必填',
				remote : '用户名已存在'
			},
			password : {
				required : '必填',
			},
			repassword : {
				required : '必填',
				equalTo: "两次密码输入不一致"
			}
		}
	});
});
	
function saveUser() {
	if(!$('#saveUserForm').validate().form()){
		return false;
	}
	$('#saveUserForm').submit();
}
</script>