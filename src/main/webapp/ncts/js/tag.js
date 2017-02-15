commonJs.tag = {
	/*-------添加标签-----------*/
	init : function(paramPrefix) {
		commonJs.tag.init_tag_param(paramPrefix);
		var $tag_parents = $(".m-add-tag");
		$tag_parents.each(function() {

			var _ts = $(this);
			$ipt_parents = _ts.find(".m-tagipt"), 
			$ipt = $ipt_parents.find(".u-pbIpt"), 
			$hint_lst = $ipt_parents.find(".l-slt-lst"), 
			$add_btn = _ts.find(".u-add-tag"), 
			$tag_lst = _ts.find(".m-tag-lst");

			// 显示标签提示框
			commonJs.tag.tag_hint_show($ipt, $add_btn, $hint_lst);
			commonJs.tag.add_tag($ipt, $add_btn, $tag_lst, paramPrefix);
			commonJs.tag.delete_tag($tag_lst, paramPrefix);
		})

	},
	// 显示标签提示框
	tag_hint_show : function($ipt, $add_btn, $hint_lst) {
		// 输入框获取焦点
		$ipt.on("focus", function() {
			if (!$(this).val() == "") {

				$hint_lst.show();

			}

		})
		$ipt.on("keyup", function() {

			// 判断输入文字是，提示框显示
			if (!$(this).val() == "") {
				$.get('/tags', 'tag.name=' + $(this).val(), function(data) {
					if (data != null) {
						var nameArray = data;
						if ($(nameArray).length > 0) {
							$hint_lst.find('.lst').empty();
							$(nameArray).each(function() {
								$hint_lst.find('.lst').append('<a href="###" id="' + this.id + '" title="' + this.name + '">' + this.name + '</a>');
							});
							$hint_lst.show();
						}
					}
				});
			} else {
				$hint_lst.hide();
			}
		})

		commonJs.tag.tag_hint_hide($ipt, $hint_lst);
	},
	// 关闭标签提示框
	tag_hint_hide : function($ipt, $hint_lst) {
		// 获取
		$(document).on("click", function(e) {
			var target = $(e.target);
			// 判断是否点击的是标签提示框和输入框，如果不是，隐藏标签提示框
			if (target.closest($hint_lst).length == 0 && target.closest($ipt).length == 0) {
				$hint_lst.hide();
				
			}

		});
		// 选择提示框选项关闭提示框
		$hint_lst.on("click", "a", function() {

			$hint_lst.hide();
			$ipt.val($(this).text());
			$add_btn.trigger('click');
		})

	},
	// 添加标签
	add_tag : function($ipt, $add_btn, $tag_lst, paramPrefix) {
		$add_btn.on("click", function() {
			var ss = false;
			var lengths = $tag_lst.children().length;
			// 判断输入框是否为空
			if ($ipt.val() != "") {
				// 遍历标签列表
				for (var i = 0; i < lengths; i++) {
					// 如果已有相同标签
					if ($ipt.val() == $tag_lst.children().eq(i).find(".txt").text()) {
						alert("已有相同标签");
						$ipt.val('');
						$ipt.focus();
						ss = true;
					}

				}
				// 如果没有相同标签，添加新的标签
				if (!ss) {
					var id = '';
					var name = '';
					var $match = $hint_lst.find('.lst').find('a[title="'+$ipt.val()+'"]');
					if($match.length == 0){
						$.ajax({
							url: '/tags',
							data: 'name='+$ipt.val(),
							type: 'post',
							async: false,
							success: function(data){
								if(data.responseCode == '00' ){
									var label = data.responseData;
									id = label.id;
									name = label.name;
								}	
							}
						});
					}else{
						id = $match.attr('id');
						name = $match.attr('title');
					}
					$tag_lst.append('<li class="tagLi" id="'+id+'" >' 
							+ '<span class="txt">' + name + '</span>' 
							+ '<a href="javascript:void(0);" class="dlt" title="删除标签">×</a>' 
						+ '</li>');
					// 添加标签后，清除输入框中的文字
					$ipt.val("");
					//更新参数
					commonJs.tag.init_tag_param(paramPrefix);
				}
			}
		})

	},
	// 删除标签
	delete_tag : function($tag_lst, paramPrefix) {
		$tag_lst.on("click", ".dlt", function() {
			$(this).parent().remove();
			commonJs.tag.init_tag_param(paramPrefix);
		})
	},
	init_tag_param: function(paramPrefix){
		var $form = $('#tagList').closest('form');
		$form.find('.tagParam').remove();
		$('#tagList').find('.tagLi').each(function(i) {
			var id = $(this).attr('id');
			$form.append('<input class="tagParam" name="'+paramPrefix+'tags[' + i + '].id" value="' + id + '" type="hidden"/>');	
		});
	}
}