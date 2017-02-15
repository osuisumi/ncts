//定义研修模块js
var photo3dJs = $(window).photo3dJs || {};

photo3dJs.fn = {
    init : function(){
        var _this = this;
        //发起辩论操作,  注：可以传入父级参数,如"#documentParent"
        _this.publish_argue();
        
    },
    /*-- 发起辩论操作 --*/
    publish_argue : function(documentParents){
        var pb_argue_parent = ".ag-pbac-lst";
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
        }else {
            pb_argue_parent = documentParents;
        }

        //获取元素           
        var $pb_parent = $(pb_argue_parent),  //外层父级
            pb_mod = ".m-add-opus-ct",  //模块
            vp_mod = ".am-pb-mod-vp",
            vptArr = ["正","反","甲","乙","丙","丁"],  //论点文字
            vp_length = 2;  //论点默认个数

        //添加论点
        add_viewpoint();
        //删除论点
        delete_viewpoint();
        //作品数量排序
        opus_num();


        /* 添加论点 */
        function add_viewpoint(){
            //论点模块html
            var epHtml ='<li class="m-add-opus-ct am-pb-mod-vp">'+
                            '<div class="m-add-opusTl">'+
                                '作品<span class="opus-num">1</span>'+
                            '</div>'+
                            '<div class="m-addElement-item">'+
                                '<div class="ltxt">作品名称：</div>'+
                                '<div class="c-center">'+
                                    '<div class="m-pbMod-ipt">'+
                                        '<input type="text" value="" placeholder="输入活动名称" class="u-pbIpt textInfoFileTitle">'+
                                    '</div>'+
                                '</div>'+
                            '</div>'+    
                            '<div class="m-addElement-item last">'+
                                '<div class="ltxt">上传作品：</div>'+
                                '<div class="photo_div c-center">'+
                                    '<div class="m-pbMod-udload">'+
                                        '<a href="javascript:void(0);" class="picker btn u-inverse-btn u-opt-btn"><i class="u-upload-ico"></i>上传压缩包</a>'+
                                    '</div>'+
                                    '<p class="m-addElement-ex">文件格式必须为zip，rar</p>'+
                                '</div>'+
                            '</div>'+ 
                            '<a href="javascript:void(0);" class="m-add-opus-del"><i class="u-delete-ico"></i></a>'+
                                            
                        '</li>'; 

            //添加论点
            $pb_parent.on("click",'.au-add-vp',function(){
                
                    //插入论点模块html
                    $(this).parents(pb_mod).before(epHtml);
                    //作品数量排序
                    opus_num();
                   
            
            });
        };

        /* 删除论点 */
        function delete_viewpoint(){
            //删除论点模块
            $pb_parent.on("click",'.m-add-opus-del',function(){
            	var index = $('.m-add-opus-del').length;
            	if(index == 1){
            		alert('至少需要上传一个作品');
            		return false;
            	}
            	var _ts = $(this);
            	confirm("确定要删除作品吗?", function(){
                     $vp_mod = _ts.parents(vp_mod);
                     //删除论点模块
                     $vp_mod.remove();
                     //作品数量排序
                     opus_num();
            	});
                
            });
        };
        function opus_num(){
	          $(vp_mod).each(function(i,k){
	              $(this).find(".m-add-opusTl .opus-num").text(i + 1);
	              $(this).find(".photo_div").attr('id', 'photo_div_' + i).attr('paramName', 'textInfo.textInfoFiles['+i+'].fileInfo');
	              $(this).find(".textInfoFileTitle").attr('name', 'textInfo.textInfoFiles['+i+'].name');
            	  initPhotoUploader('photo_div_' + i, 'textInfo.textInfoFiles['+i+'].fileInfo');
            	  initPhotoParam('photo_div_' + i, 'textInfo.textInfoFiles['+i+'].fileInfo');
	          });
        }
    }
};

function initPhotoUploader(divId, paramName){
	var photo_uploader = WebUploader.create({
		swf : '/ncts/js/webphoto_uploader/Uploader.swf',
		server : '/file/uploadTemp',
		pick : '#'+divId+' .picker',
		resize : true,
		duplicate : true,
		accept : {
		    extensions: 'zip,rar',
		}
	});
	// 当有文件被添加进队列的时候
	photo_uploader.on('fileQueued', function(file) {
		var fileNumLimit = 1;
		if(fileNumLimit != 0){
			var fileNum = $('#'+divId).find(".fileLi").length;
    		if(fileNum >= fileNumLimit){
    			alert('只允许上传'+fileNumLimit+'个附件');
    			photo_uploader.removeFile(file.id);
    			return false;
    		}
		}
		var $li = $('#photoLiTemplet').clone();
		$li.attr('id', file.id).addClass('fileItem').show();
		$li.find('.fileName').text(file.name);
		$('#'+divId).find('.m-pbMod-udload').remove();
		$('#'+divId).prepend($li);
		photo_uploader.upload();
	});
	// 文件上传过程中创建进度条实时显示。
	photo_uploader.on('uploadProgress', function(file, percentage) {
		var $li = $('#' + file.id), $bar = $li.find('.fileBar');
		// 避免重复创建
		/* if (!$percent.length) {
			$li.find('.state').html('<div class="sche">' + '<div class="bl">' + '<div class="bs" role="progressbar" style="width: 0%"></div>' + '</div>' + '<span class="num">' + '0%' + '</span>' + '<span class="status"></span>' + '</div>');
			$percent = $li.find('.sche');
		} */
		var progress = Math.round(percentage * 100);
		$bar.find('.barLength').css('width', progress + '%');
		$bar.find('.barNum').text(progress + '%');
		$bar.find('.barTxt').text('上传中');
	});
	photo_uploader.on('uploadSuccess', function(file, response) {
		if (response != null && response.responseCode == '00') {
			$('#' + file.id).find('.fileBar').addClass('finish');
			$('#' + file.id).find('.barTxt').text('上传成功');
			var fileInfo = response.responseData;
			$('#' + file.id).attr('fileId', fileInfo.id);
			$('#' + file.id).attr('url', fileInfo.url);
			$('#' + file.id).attr('fileName', fileInfo.fileName);
			$('#' + file.id).addClass('success');
			initPhotoParam(divId, paramName);
		}
	});
	photo_uploader.on('uploadError', function(file) {
		$('#' + file.id).find('.fileBar').addClass('error');
		$('#' + file.id).find('.barTxt').text('上传出错');
	});
	photo_uploader.on('uploadComplete', function(file) {
		$('#' + file.id).find('.progress').fadeOut();
	});
//	$('#uploadBtn').click(function() {
//		photo_uploader.upload();
//	});
	$('#'+divId).off('click', '.dlt');
	$('#'+divId).on('click', '.dlt', function() {
		var _this = $(this);
		confirm('是否确定删除该附件?',function(){
			if ($(this).parents('.fileLi').hasClass('fileItem')) {
				photo_uploader.removeFile($(this).parents('.fileLi').attr('id'));
			}
			$('#'+divId).find('.fileLi').remove();
			var div = '<div class="m-pbMod-udload">'+
			            '<a href="javascript:void(0);" class="picker btn u-inverse-btn u-opt-btn"><i class="u-upload-ico"></i>上传压缩包</a>'+
			          '</div>';
			$('#'+divId).prepend($(div));
			initPhotoUploader(divId, paramName);
			initPhotoParam(divId, paramName);
		});
	});
	photo_uploader.on('error', function(type) {
		if (type == 'Q_TYPE_DENIED') {
			alert('请检查上传的文件类型');
		}
	}); 
}

function initPhotoParam(divId, paramName) {
	var $list = $('#'+divId);
	$list.find('.fileParam').remove();
	$list.find('.fileLi.success').each(function(i) {
		var fileId = $(this).attr('fileId');
		var fileName = $(this).attr('fileName');
		var url = $(this).attr('url');
		$(this).append('<input class="fileParam" name="'+paramName+'.id" value="' + fileId + '" type="hidden"/>');
		$(this).append('<input class="fileParam" name="'+paramName+'.fileName" value="' + fileName + '" type="hidden"/>');
		$(this).append('<input class="fileParam" name="'+paramName+'.url" value="' + url + '" type="hidden"/>');	
	});
	initFileType($list);
}

function initFileType(obj){
	var $file_name_par = obj.find(".fileLi");
	$file_name_par.each(function(){
		var _ts = $(this);
		var $names = _ts.find(".fileName").text(); //文件名字
        var $file_ico = _ts.find(".fileIcon");
        var strings = $names.split(".");
        var s_length = strings.length;
        var suffix = strings[s_length -1];
        if(s_length == 1){
           
        }else {
            if(suffix == "doc" || suffix == "docx"){
            	$file_ico.addClass("doc");
            }else if(suffix == "xls" || suffix == "xlsx"){
            	$file_ico.addClass("excel");
            }else if(suffix == "ppt" || suffix == "pptx"){
            	$file_ico.addClass("ppt");
            }else if(suffix == "pdf"){
            	$file_ico.addClass("pdf");
            }else if(suffix == "txt"){
            	$file_ico.addClass("txt");
            }else if(suffix == "zip" || suffix == "rar"){
            	$file_ico.addClass("zip");
            }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
            	$file_ico.addClass("pic");
            }else if(
                suffix == "mp4" || 
                suffix == "avi" || 
                suffix == "rmvb" || 
                suffix == "rm" || 
                suffix == "asf" || 
                suffix == "divx" || 
                suffix == "mpg" || 
                suffix == "mpeg" || 
                suffix == "mpe" || 
                suffix == "wmv" || 
                suffix == "mkv" || 
                suffix == "vob" || 
                suffix == "3gp"
                ){
            	$file_ico.addClass("video");
            }else {
            	$file_ico.addClass("other");
            }
        }
	});
}
