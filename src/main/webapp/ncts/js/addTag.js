var addTagfn = $(window).addTagfn || {};

addTagfn = {
    init: function(){
        //添加标签
        this.set_tag();
    },
    /*-------添加标签-----------*/
    set_tag : function(){
        var $tag_parents = $(".m-add-tag");
        $tag_parents.each(function(){

            var _ts = $(this);
                $ipt_parents = _ts.find(".m-tagipt"),
                $ipt = $ipt_parents.find(".u-pbIpt"),
                $hint_lst = $ipt_parents.find(".l-slt-lst"),
                $add_btn = _ts.find(".u-add-tag"),
                $tag_lst = _ts.find(".m-tag-lst");

            //显示标签提示框  
            addTagfn.tag_hint_show($ipt,$hint_lst);  
            addTagfn.add_tag($ipt,$add_btn,$tag_lst);  
            addTagfn.delete_tag($tag_lst);  
        })
        
        
    },
    //显示标签提示框
    tag_hint_show : function($ipt,$hint_lst){
        //输入框获取焦点
        $ipt.on("focus",function(){
            if( !$(this).val()=="" ){

                $hint_lst.show();
                
            }

        })
        $ipt.on("keyup",function(){

            //判断输入文字是，提示框显示
            if( !$(this).val()=="" ){

                $hint_lst.show();

            }else {
                
                $hint_lst.hide();
            }
        })


        this.tag_hint_hide($ipt,$hint_lst);
    },
    //关闭标签提示框
    tag_hint_hide : function($ipt,$hint_lst){
        //获取
        $(document).on("click",function(e){
            var target = $(e.target); 
            //判断是否点击的是标签提示框和输入框，如果不是，隐藏标签提示框
            if(target.closest($hint_lst).length == 0 && target.closest($ipt).length == 0){ 

                $hint_lst.hide();
            }

        }); 
        //选择提示框选项关闭提示框
        $hint_lst.on("click","a",function(){

            $hint_lst.hide();
            $ipt.val($(this).text());
        })

    },
    //添加标签
    add_tag : function($ipt,$add_btn,$tag_lst){
        $add_btn.on("click",function(){
            var ss = false;
            var lengths = $tag_lst.children().length;
            //判断输入框是否为空
            if($ipt.val() != ""){
               //遍历标签列表
                for(var i = 0; i < lengths; i++){
                    //如果已有相同标签
                    if($ipt.val() == $tag_lst.children().eq(i).find(".txt").text()){
                        alert("已有相同标签");
                        $ipt.val('');
                        $ipt.focus();
                        ss = true;
                    }

                }
                //如果没有相同标签，添加新的标签
                if(!ss){
                    $tag_lst.append(
                        '<li>'+
                            '<span class="txt">'+$ipt.val()+'</span>'+
                            '<a href="javascript:void(0);" class="dlt" title="删除标签">×</a>'+
                        '</li>'
                    );
                    //添加标签后，清除输入框中的文字
                    $ipt.val("");
                }
            }
        })

    },
    //删除标签
    delete_tag : function($tag_lst){
        $tag_lst.on("click",".dlt",function(){
            $(this).parent().remove();
        })
    }
};