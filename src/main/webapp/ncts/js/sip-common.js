String.prototype.trim= function(){  
    return this.replace(/(^\s*)|(\s*$)/g, "");  
};
String.prototype.equalsIgnoreCase = function(str){
	return this.toLowerCase() == str.toLowerCase();
}
$.extend({
	ajaxQuery:function(formId,divId,callback,type){
		if(type == null || type == ''){
			type = 'get';
		}
		$.ajax({
			url:$("#"+formId).attr("action"),
			data:$("#"+formId).serialize(),
			type:type,
			success:function(data){
				$("#"+divId).html(data);
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback();
				}
			}
		});		
	},
	ajaxSubmit:function(formId){
		var data = $("#"+formId).serialize();
		var method = $("#"+formId).attr("method");
		if (method == 'delete' || method == 'DELETE' || method == 'put' || method == 'PUT') {
			data = '_method='+method+'&'+data;
		}
		var rData = $.ajax({
			url:$("#"+formId).attr("action"),
			data:data,
			type:'post',
			async:false,
			beforeSend:function(){
				ajaxLoading();
			},
			success:function(data){
				 
			},
			complete:function(){
				ajaxEnd();
			}
		}).responseText;
		return rData;
	},
	ajaxDelete:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=DELETE&'+data,
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			}
		});
	},
	put:function(url, data, callback){
		$.ajax({
			url:url,
			type:'post',
			data:'_method=PUT&'+data,
			success:function(data){
				if(callback!=undefined){
					var $callback = callback;
					if (! $.isFunction($callback)) $callback = eval('(' + callback + ')');
					$callback(data);
				}
			}
		});
	}
});

function ajaxLoading(){
    mylayerFn.loading({
        id: 999,
        content: '正在加载中...',
        shade: [0.4,"#ccc"]
    });
}

function ajaxEnd(){
	 mylayerFn.close(999);
}

function assignParam(formId,objectId){
	$.each($('#'+formId+' :input'),function(){
		$(this).val($('#'+$(this).attr('id')+'_'+objectId).text());
	});
}

function checkAllBox(formId, obj){
	$(obj).click(function(){
		if($(this).prop("checked")){
			$('#'+formId+' :checkbox').each(function(){
				$(this).prop("checked",true);			
			});
		}else{
			$('#'+formId+' :checkbox').each(function(){
				$(this).prop("checked",false);			
			});
		}
	});
}

//txt:鏂囨湰妗唈query瀵硅薄
//limit:闄愬埗鐨勫瓧鏁�
//isbyte:true:瑙唋imit涓哄瓧鑺傛暟锛沠alse:瑙唋imit涓哄瓧绗︽暟
//cb锛氬洖璋冨嚱鏁帮紝鍙傛暟涓哄彲杈撳叆鐨勫瓧鏁�
function initLimit(txt,limit,isbyte,cb){
	txt.keyup(function(){
		var str=txt.val();
		var charLen;
		var byteLen=0;
		if(isbyte){
			for(var i=0;i<str.length;i++){
				if(str.charCodeAt(i)>255){
					byteLen+=2;
				}else{
					byteLen++;
				}
			}
			charLen = Math.floor((limit-byteLen)/2);
		}else{
			byteLen=str.length;
			charLen=limit-byteLen;
		}
		cb(charLen);
	});	
}

function guid(){
	var guid = (G() + G() + "" + G() + "" + G() + "" + 
			G() + "" + G() + G() + G()).toUpperCase();
	return guid;
}
function G() {
	return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
}

function hintJumpLayer(){
	$('.m-blackbg').show();
	var layer = $('.g-layer-warning');
	var width = layer.innerWidth(),
    height = layer.innerHeight();
    layer.show().css({'margin-top':-height/2+'px','margin-left':-width/2+'px'});
}

/*window.msg = function(txt, confirmFn){
	layer.msg(txt, {time: 1500}, confirmFn);
};*/

window.alert = function(txt, confirmFn, time){
	//layer.alert(txt, confirmFn);
	if(time == null || time == ''){
		time = 1500;
	}
	mylayerFn.msg(txt, {time: time}, confirmFn);
};

window.confirm = function(txt, confirmFn, cancelFn){
	mylayerFn.confirm({
        content: txt,
        icon: 3,
        yesFn: confirmFn,
        cancelFn: cancelFn
    });
};

function getByteLength(value){
	var length = value.trim().length; 
    for(var i = 0; i < value.length; i++){      
        if(value.charCodeAt(i) > 127){      
        	length = length+2;      
        }      
    }
    return length;
}

function getSuffix(fileName){
	var index = fileName.lastIndexOf(".");
	return fileName.substring(index+1,fileName.length);
}

function getOuterHtml(obj) {
    var box = $('<div></div>');
    for (var i = 0; i < obj.length; i ++) {
        box.append($(obj[i]).clone());
    }
    return box.html();
}

function isMatchJson(data){
	if(data.match("^\{(.+:.+,*){1,}\}$")){
		return true;
	}else{
		return false;
	}
}