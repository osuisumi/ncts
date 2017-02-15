$(document).ready(function(){

	activityFile.fn.init();
})
//定义研修模块js
var activityFile = $(window).activityFile || {};

activityFile.fn = {
    init : function(){
        var _this = this;
        //显示隐藏文件夹操作功能,注：可以传入参数
        _this.show_file_opa();
        //判断文件类型，注：只能判断当前页面的文件类型，如果后来添加，则需要重新执行这个方法
         _this.file_type();
        //备课增加文件夹,注：可以传入参数
        _this.prepare_add_folder("#activityLessonFile");
        //备课文件重命名,注：可以传入参数
        _this.prepare_file_rename();
    },
    //显示隐藏文件夹操作功能
    show_file_opa : function(documentParents){   

        var show_file_part = ".am-file-lst";
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
        }else {
            show_file_part = documentParents;
        }
        //鼠标移动到文件模块时
        $(show_file_part).on('mouseenter','.am-file-block',function(){
            var $block = $(this),
                $opa = $block.find(".f-opa"), //操作按钮行
                $info = $block.find(".f-info"); //信息行
            //如果正在重命名，则隐藏操作按钮行和信息行，否则隐藏信息行，隐藏操作按钮行
            if($block.find(".rename-box").length != 0){
                $opa.hide();
                $info.hide();
            }else {
                $(this).find(".f-opa").show();
                $(this).find(".f-info").hide();
            };   
        });
        //鼠标移出到文件模块时
        $(show_file_part).on('mouseleave','.am-file-block',function(){
            var $block = $(this),
                $opa = $block.find(".f-opa"), //操作按钮行
                $info = $block.find(".f-info"); //显示信息行
            //如果正在重命名，则隐藏操作按钮行和信息行，否则隐藏操作按钮行，隐藏信息行
            if($block.find(".rename-box").length != 0){
                $opa.hide();
                $info.hide();
            }else {
                $opa.hide();
                $info.show();
            };
        });
    },
    //判断文件类型
    file_type : function(){
        var $file_block = $('.am-file-block');
        $file_block.each(function(){
            var $this = $(this),
                $file_name = $this.find('.f-name'),
                $file_ico = $this.find(".file-view").children();
            //获取文件名和后缀名
            var names = $file_name.find("span").text(),
                strings = names.split("."),
                s_length = strings.length,
                suffix = strings[s_length -1];

            //判断是否有后缀名
            if(s_length == 1){
                //alert(1);
            }else {
                if(suffix == "doc" || suffix == "docx"){
                    $file_ico.removeClass().addClass("au-file-word");
                    //alert(1);
                }else if(suffix == "xls" || suffix == "xlsx"){
                    $file_ico.removeClass().addClass("au-file-excel");
                }else if(suffix == "ppt" || suffix == "pptx"){
                    $file_ico.removeClass().addClass("au-file-ppt");
                }else if(suffix == "pdf"){
                    $file_ico.removeClass().addClass("au-file-pdf");
                }else if(suffix == "txt"){
                    $file_ico.removeClass().addClass("au-file-txt");
                }else if(suffix == "jpg" || suffix == "jpeg" || suffix == "png" || suffix == "gif"){
                    $file_ico.removeClass().addClass("au-file-pic");
                }else if(
                    suffix == "mp3"  ||
                    suffix == "mp4"  ||
                    suffix == "avi"  ||
                    suffix == "rmvb" ||
                    suffix == "rm"   ||
                    suffix == "asf"  ||
                    suffix == "divx" ||
                    suffix == "mpg"  ||
                    suffix == "mpeg" ||
                    suffix == "mpe"  ||
                    suffix == "wmv"  ||
                    suffix == "mkv"  ||
                    suffix == "vob"  ||
                    suffix == "3gp"
                    ){
                    $file_ico.removeClass().addClass("au-file-video");
                }else {
                    $file_ico.removeClass().addClass("au-file-other");
                }
            }
        });
    },
    //备课增加文件夹
    prepare_add_folder : function(documentParents){
        var outerPart = document,  //绑定事件父级
            add_folder_btn = ".au-add-folder",  //添加文件夹按钮
            file_lst_part = ".am-file-lst",  //文件夹列表
            onoff = true;
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定   
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
            
        }else {
            outerPart = documentParents;
            file_lst_part = documentParents + ' ' + file_lst_part;
        };

        //点击创建文件夹按钮
        $(outerPart).on("click",add_folder_btn,function(){
            //判断是否正在创建文件夹
            if(onoff){
                onoff = false;
                $(file_lst_part).prepend(
                    '<li id="theNewFolder">'+
                        '<div class="am-file-block am-file-folder">'+
                            '<div class="file-view">'+
                                '<div class="au-folder"></div>'+
                            '</div>'+
                            '<div class="add-rename-box" style="display: block">'+
                                '<input type="text" value="" class="rename-ipt">'+
                                '<div>'+
                                    '<a href="javascript:void(0);" class="confirm">创建</a>'+
                                    '<a href="javascript:void(0);" class="cancel">取消</a>'+
                                '</div>'+
                            '</div>'+
                        '</div>'+
                    '</li>'
                );
                //设置新建的文件夹
                var $new_folder = $("#theNewFolder"),
                    $add_rename_box = $new_folder.find(".add-rename-box"),
                    $rename_ipt = $add_rename_box.find(".rename-ipt"),
                    $found_btn = $add_rename_box.find(".confirm"),
                    $cancel_btn = $add_rename_box.find(".cancel");
                //输入框获取焦点和默认文件夹名字
                $rename_ipt.focus().val("新建文件夹");
                //取消创建文件夹
                $cancel_btn.on("click",function(){
                    $new_folder.remove();
                    onoff = true;
                });
                //创建文件夹
                $found_btn.on("click",function(){
                    //判断文件夹名字是否为空
                    if($rename_ipt.val() == ""){
                        alert("文件夹名字不能为空");
                        $rename_ipt.focus();
                    }else {
                        onoff = true;
                        var $add_rename_box = $(this).parents(".add-rename-box");
                        $add_rename_box.before(
                            '<b class="f-name"><span>'+$rename_ipt.val()+'</span><em>(0)</em></b>'+
                            '<div class="f-opa">'+
                                '<a href="javascript:void(0);" class="open">打开</a>'+
                                '<a href="javascript:void(0);" class="download">下载</a>'+
                                '<a href="javascript:void(0);" class="rename">重命名</a>'+
                                '<a href="javascript:void(0);" class="delete">删除</a>'+
                            '</div>'
                        );
                        $add_rename_box.prevAll(".f-opa").show();
                        $add_rename_box.remove();
                        $new_folder.attr('id','');
                        //执行文件夹显示操作方法
                        //activityFile.fn.show_file_opa();    
                    };

                });
            };
        });
       
    },
    //备课文件重命名
    prepare_file_rename : function(documentParents){

        var $rename_button = '.am-file-block .rename';
        //判断传入的父级参数是否存在，存在则用传入参数绑定事件，不存在则用默认父级绑定
        if(documentParents == "" || documentParents == 'undefined' || documentParents == null || documentParents == undefined) {
            
        }else {
            $rename_button = documentParents + ' ' + $rename_button;
        }
        //alert(documentParents);
        var renameHtml = '<div class="rename-box">'+
                            '<input type="text" class="rename-ipt">'+
                            '<div>'+
                                '<a href="javascript:void(0);" class="confirm">确定</a>'+
                                '<a href="javascript:void(0);" class="cancel">取消</a>'+
                            '</div>'+
                        '</div>';
        $(document).off('click',$rename_button).on('click',$rename_button,function(){
            var $this = $(this),
                $part = $this.parents('.am-file-block'),  //文件模块
                $siblings_part = $part.parents(".am-file-lst").find(".am-file-block"),
                $file_name = $part.find(".f-name"), //文件名字
                $file_info = $part.find(".f-info"), //文件信息块
                $file_opa = $this.parent(); //操作模块

            //获取后缀名
            var names = $file_name.find("span").text(),
                strings = names.split("."),
                //c = /\.[^\.]+$/.exec(files);
                s_length = strings.length,
                suffix = strings[s_length -1];


            //点击时删除其他所有重命名框
            $siblings_part.find(".rename-box").remove();
            $siblings_part.find(".f-name").show();
            $file_name.hide();
            $file_opa.hide().after(renameHtml); //插入重命名框

            //设置重命名框
            var $rename_box = $part.find(".rename-box"), //重命名模块
                $rename_ipt = $part.find(".rename-ipt"), //重命名输入框
                $rename_confirm = $part.find(".confirm"), //确定按钮
                $rename_cancel = $part.find(".cancel"); //取消按钮
            //重命名框获取文件名
            $rename_ipt.val(names.split(".")[0]).focus();

            //确定保存名字
            $rename_confirm.off().on("click",function(){
                if($rename_ipt.val() == ""){
                    alert("文件名不能为空");
                    $rename_ipt.focus();
                }else {
                    $file_name.show().children("span").text($rename_ipt.val());
                    if(strings.length == 1){
                       $file_name.show().children("span").text($rename_ipt.val());
                    }else {
                        $file_name.show().children("span").text($rename_ipt.val() + "." + suffix);
                    }
                    $file_opa.show();
                    $rename_box.remove();
                }
            })
            //取消重命名
            $rename_cancel.off().on("click",function(){
                $file_name.show();
                $file_opa.show();
                $rename_box.remove();

            })
            //失去焦点时，
            /*$rename_ipt.on("blur",function(){
                $rename_box.hide();
                $file_name.show().children("span").text($rename_ipt.val());
                $file_opa.show();
            })*/

        });

    }

};


