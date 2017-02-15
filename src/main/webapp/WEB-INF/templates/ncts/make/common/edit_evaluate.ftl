<#macro editEvaluateFtl relationId type>
	<@evaluateRelation relationId=relationId type=type>
		<#assign evaluate=evaluateRelation.evaluate>
		<ul class="g-addElement-lst g-addCourse-lst">
			<li class="m-addElement-item">
                <div class="ltxt">添加评分项：</div>
                <div class="center">
                    <div class="m-ltxt-box txtitemBox">
                        <ul id="evaluateItemUl" class="m-ltxt-lst">
                        	<#list evaluate.evaluateItems as evaluateItem>
	                            <li class="l-item" itemId="${evaluateItem.id }">
	                                <span class="txt" title="${(evaluateItem.content)! }">${(evaluateItem.content)! }</span>
	                                <div class="opt1">
	                                    <a href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
	                                    <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
	                                </div>
	                            </li>
	                        </#list>
                        </ul>
                        <a href="javascript:;" class="u-inverse-btn u-opt-btn addTxtitemBtn">+添加评分项</a>    
                    </div>
                </div>
            </li>
            <li class="m-addElement-btn">
				<a onclick="checkEvaluateAndNextForm(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn" id="confirmLayer">下一步</a> 
				<a onclick="prevForm(this)" href="javascript:void(0);" data-href="index1.html" class="btn u-main-btn">上一步</a> 
				<a class="btn u-inverse-btn u-cancelLayer-btn mylayer-cancel">取消</a>
			</li>
        </ul>
        <div class="cloneWrap">
	        <ul>
	            <li class="l-item" id="cloneTxtitem">
	                <span class="txt">评分项标题</span>
	                <div class="opt1">
	                    <a href="javascript:void(0);" class="u-opt u-alter"><i class="u-alter-ico"></i><span class="tip">编辑</span></a>
	                    <a href="javascript:void(0);" class="u-opt u-delete"><i class="u-delete-ico"></i><span class="tip">删除</span></a>
	                </div>
	            </li>
	        </ul>
	        <div class="m-actionIpt-box" id="cloneTxtitemInput">
	            <div class="m-pbMod-ipt"><input type="text" value="" placeholder="请输入评分项" class="u-pbIpt title-input"></div>
	            <a href="javascript:void(0);" class="cancel">取消</a>
	            <button type="submit" class="confirm">确定</button>
	        </div>
	    </div>
	    <form id="createEvaluateItemForm" action="${ctx }/${CSAIdObject.getCSAIdObject().aid!}/mark/evaluate/item"  method="post">
	    	<input type="hidden" name="evaluate.id" value="${evaluate.id }">
	    	<input type="hidden" name="content">
	    </form> 
	    <form id="updateEvaluateItemForm" action="${ctx }/${CSAIdObject.getCSAIdObject().aid!}/mark/evaluate/item/"  method="put">
	    	<input type="hidden" name="content">
	    </form> 
	</@evaluateRelation>
	<script>
		function checkEvaluateAndNextForm(obj){
			var count = $('#evaluateItemUl li').length;
			if(count == 0){
				alert('请至少添加一个评分项');
				return false;
			}
			nextForm(obj);
		}
	
		$(function(){
		    //添加评分项
		    txtitemOpreation();
		    
		  //章节活动拖拽排序
			$("#evaluateItemUl").sortable({
		        containment: 'body',
		        placeholder: "ui-state-highlight",
		        stop: function(){
		        	var data = '';
		        	$('#evaluateItemUl li').each(function(i){
		        		var sortNo = $('#evaluateItemUl li').index($(this)) + 1;
		        		data += 'evaluateItems['+i+'].id='+$(this).attr('itemId')+'&evaluateItems['+i+'].sortNo='+sortNo+'&';
		        	});
		        	$.put('${ctx}/${CSAIdObject.getCSAIdObject().aid!}/mark/evaluate/item', data);
		        }
		    }).disableSelection();
		});
		//添加评分项
		function txtitemOpreation(bindParent){
		    //设置可添加编辑状态为true
		    var oning = true;
	
		    var addTxtitemInput = 'addTxtitemInput';
		    //判断是否已有条数，修改class
		    $('.txtitemBox .m-ltxt-lst').each(function(){
		        var $this = $(this);
		        if($this.children().length <= 0){
		            $this.addClass('nocont');  
		        }else {
		            $this.removeClass('nocont');
		        };
		    });
	
		    //判断是否输入绑定的父级
		    if(bindParent === '' || bindParent === null || bindParent === 'undefined' || bindParent === undefined){
		        //点击添加
		        $('.txtitemBox').on('click','.addTxtitemBtn',function(){
		            //执行添加函数
		            addOpt($(this));
		        });
		        //点击修改
		        $('.txtitemBox').on('click','.m-ltxt-lst .u-alter',function(){
		            //执行修改函数
		           alterOpt($(this));
		        });
		        //点击删除
		        $('.txtitemBox').on('click','.m-ltxt-lst .u-delete',function(){
		        	var $this = $(this);
		        	var itemId = $(this).parents('li').attr('itemId');
		        	//删除数据
		        	confirm('确定要删除此评分项吗?' , function(){
			            $.ajaxDelete('${ctx }/${CSAIdObject.getCSAIdObject().aid!}/make/evaluate/item/'+itemId, '', function(data){
			            	if(data.responseCode == '00'){
			            		var itemNum = $this.parents('.m-ltxt-lst').children().length;
			 		            if(itemNum <= 1){
			 		            	$this.parents('.m-ltxt-lst').addClass('nocont');
			 		            }
			 		            $this.parents('.l-item').remove();
			                }
			            });
		        	});
		        });
		    //传入父级，用父级绑定
		    }else {
		        //点击添加
		        $(bindParent).on('click','.txtitemBox .addTxtitemBtn',function(){
		            //执行添加函数
		            addOpt($(this));
		        });
		        //点击修改
		        $(bindParent).on('click','.txtitemBox .m-ltxt-lst .u-alter',function(){
		            //执行修改函数
		            alterOpt($(this));
		        });
		        //点击删除
		        $(bindParent).on('click','.txtitemBox .m-ltxt-lst .u-delete',function(){
		            //删除
		            var itemNum = $(this).parents('.m-ltxt-lst').children().length;
		            if(itemNum <= 1){
		                $(this).parents('.m-ltxt-lst').addClass('nocont');
		            }
		            $(this).parents('.l-item').remove();
		        });
		    }
		    //新增函数
		    function addOpt(optbtn){
		        //判断是否处于编辑状态
		        if(oning){
		            //隐藏添加按钮               
		            optbtn.hide();
		            //插入添加输入框
		            addInput(optbtn,'add');
		            //设置为在编辑状态，也就是false
		            oning = false;
		        }else {
		            //如果在编辑状态，则提示
		            mylayerFn.confirm({
		                content: '您正在编辑中，是否取消？',
		                yesFn : function(){
		                    //移除其他正在添加的输入框
		                    optbtn.parents('.txtitemBox').find('.m-ltxt-lst .l-item').removeClass('edit');
		                    $('#'+addTxtitemInput).remove();
		                    optbtn.hide();
		                    //插入新的编辑框
		                    addInput(optbtn,'add');
		                    oning = false;
		                },
		                cancelFn : function(){
		                    //获取焦点
		                    $('#'+addTxtitemInput).find('.u-pbIpt').focus();
		                }
		            });
		        };
		    }
		    //修改函数
		     function alterOpt(optbtn){
		        //获取当前编辑的条目
		        var $item = optbtn.parent().parent();
		        //判断是否在编辑状态
		        if(oning){
		            //添加正在编辑中的class
		            $item.addClass('edit')
		            //插入编辑框
		            addInput($item,'alter');
		            //获取需要编辑的文字
		            $('#'+addTxtitemInput).find('.title-input').val(optbtn.parent().siblings('.txt').text());
		            oning = false;
		        }else {
		            //如果在编辑状态，则提示
		            mylayerFn.confirm({
		                content: '您正在编辑中，是否取消？',
		                yesFn : function(){
		                    //移除其他正在添加的输入框
		                    $("#addTxtitemInput").remove();
		                    $item.parents(".txtitemBox").find('.addTxtitemBtn').show();
		                    $item.siblings().removeClass('edit');
		                    $item.addClass('edit');
		                    //插入新的编辑框
		                    addInput($item,'alter');
		                    $('#'+addTxtitemInput).find('.title-input').val(optbtn.parent().siblings('.txt').text());
		                    oning = false;
		                },
		                cancelFn : function(){
		                    //获取焦点
		                    $('#'+addTxtitemInput).find('.u-pbIpt').focus();
		                }
		            });
		        };
		    }
	
		    //插入编辑框
		    function addInput(addSite,addType){
		        //新增
		        if(addType == 'add'){
		            //插入克隆的输入框
		            addSite.before($("#cloneTxtitemInput").clone());
		            //修改输入框的id
		            $("#cloneTxtitemInput").attr('id','addTxtitemInput');
		            //获取输入框
		            var $addTxtitemInput = $('#'+addTxtitemInput);
		            //输入框获取焦点
		            $addTxtitemInput.find('.title-input').focus();
		            //点击取消
		            $addTxtitemInput.on('click','.cancel',function(){
		                //显示新增按钮
		                $addTxtitemInput.next().show();
		                //移除输入框
		                $addTxtitemInput.remove();
		                //设置为可编辑状态
		                oning = true;
		            });
		            //点击确定
		            $addTxtitemInput.on('click','.confirm',function(){
		                var $this = $(this);
		                if($this.parents('.txtitemBox').find('input:text').val().length == 0){
		                	alert('请输入评分项内容');
		                	return false;
		                }
	                    //获取列表
	                    $itemLst = $this.parents('.txtitemBox').find('.m-ltxt-lst'),
	                    //获取编辑框中的vaule值
	                    txt = $.trim($addTxtitemInput.find('.title-input').val());
		                
		                //插入数据
		                $('#createEvaluateItemForm input[name="content"]').val(txt);
		                var data = $.ajaxSubmit('createEvaluateItemForm');
		                var json = $.parseJSON(data);
		                if(json.responseCode == '00'){
		                	var itemId = json.responseData.id
		                	//显示新增按钮
			                $addTxtitemInput.next().show();
			                //在列表中插入新的条目
			                $itemLst.append($('#cloneTxtitem').clone());
			                //修改新增条目的内容和输入
			                $itemLst.removeClass('nocont').children().last().attr('id','').attr('itemId', itemId).show().find('.txt').html(txt);
			                //移除输入框
			                $addTxtitemInput.remove();
			                //设置为可编辑状态
			                oning = true;
		                }
		                
		            });
	
		        //修改
		        } else if(addType == 'alter'){
		            //插入克隆的输入框
		            addSite.append($("#cloneTxtitemInput").clone());
		            //修改输入框的id
		            $("#cloneTxtitemInput").attr('id','addTxtitemInput');
		            //获取输入框
		            var $addTxtitemInput = $('#'+addTxtitemInput);
		            //输入框获取焦点
		            $addTxtitemInput.find('.title-input').focus();
		            //点击取消输入
		            $addTxtitemInput.on('click','.cancel',function(){
		                $(this).parents('.l-item').removeClass('edit');
		                $('#'+addTxtitemInput).remove();
		                oning = true;
		            });
		            //点击确定修改
		            $addTxtitemInput.on('click','.confirm',function(){
		                var $this = $(this),
	                    //获取编辑框中的vaule值
	                    txt = $.trim($addTxtitemInput.find('.title-input').val());
		                
		             	//修改数据
		             	var itemId = addSite.attr('itemId');
		             	var action = $('#updateEvaluateItemForm').attr('action');
		             	$('#updateEvaluateItemForm').attr('action', action+itemId);
		                $('#updateEvaluateItemForm input[name="content"]').val(txt);
		                var data = $.ajaxSubmit('updateEvaluateItemForm');
		                var json = $.parseJSON(data);
		                if(json.responseCode == '00'){
		                	$('#updateEvaluateItemForm').attr('action', action);
		                	//修改文字
			                $this.parents('.l-item').removeClass('edit').find('.txt').html(txt);
			                //移除输入框
			                $addTxtitemInput.remove();
			                //设置为可编辑状态
			                oning = true;
		                }
		            });
		        };
		    }
	
		}
	</script>
</#macro>