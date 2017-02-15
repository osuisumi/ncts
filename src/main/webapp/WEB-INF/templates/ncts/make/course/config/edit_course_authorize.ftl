<#macro editCourseAuthorizeFtl course courseAuthorizes> 
	<div class="g-cSet-lst">
        <div class="m-addPeople-fn">
            <div class="m-pbMod-ipt add-row">
                <input id="courseAuthorizeTxt" type="text" value="" placeholder="请输入授课教师用户名或者邮箱" class="u-pbIpt">
                <button type="button" class="btn u-main-btn" id="addPeopleBtn" onclick="addCourseAuthorize()">+添加</button>
            </div>
            <ul id="courseAuthorizeListUl" class="list">
            	<#list courseAuthorizes as courseAuthorize>
            		<li class="courseAuthorizeLi">
            			<span>${courseAuthorize.user.realName }</span>
            			<a onclick="deleteCourseAuthorize('${courseAuthorize.id}', this)" href="javascript:void(0);" class="delete">×</a>
            		</li>
            	</#list>
            </ul>
        </div>
    </div>
	<script>
		function addCourseAuthorize(){
			var value = $('#courseAuthorizeTxt').val();
			if(value.trim().length <= 0){
				alert('请输入用户名或邮箱再添加');
				return false;
			}
			$.post('${ctx}/make/course/authorize/${course.id}', 'role=teacher&userName='+value, function(data){
				if(data.responseCode == '00'){
					var id = data.responseData.id;
					var realName = data.responseData.user.realName;
					$('#courseAuthorizeListUl').append(
							'<li class="courseAuthorizeLi">'+
        						'<span>'+realName+'</span>'+
        						'<a onclick="deleteCourseAuthorize(\''+id+'\', this)" href="javascript:void(0);" class="delete">×</a>'+
        					'</li>');
				}else{
					if(data.responseMsg == 'user exists'){
						alert('不能重复授权同一位授课教师');
					}else{
						alert('该用户不存在或没有授课教师身份');
					}
				}
			});
		}
		
		function deleteCourseAuthorize(id, obj){
			confirm('确定要删除该授课教师吗?', function(){
				$.ajaxDelete('${ctx}/make/course/authorize/'+id, '', function(data){
					if(data.responseCode == '00'){
						alert('删除成功');
						$(obj).parents('.courseAuthorizeLi').remove();
					}	
				});
			});
		}
	</script>
</#macro>
