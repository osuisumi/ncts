(function($) {

    $.fn.extend({
        dsTab: function(opts) {
            _this = this;
            this.each(function(index, El) {
                new dsTab(opts, _this.eq(index));
            });
        },
        pos: function(index) {
            return this.change(this.opts.index);
        }
    });

    function dsTab(opts, target) {
       
        this.opts = {};
        //默认参数
        this.defaults = {
            itemEl: '.content a',
            btnElName: 'btns',
            btnItem: 'li a',
            prev:'',
            next:'',
            play: '', //开始暂停按钮
            currentClass: 'current', //按钮当前样式
            autoCreateTab: true,
            btnItemHtml: '<li class="btn@index"><a href="javascript:void(0)">@index</a></li>',
            index: 0,
            oldIndex: -1,
            size: 3,
            maxSize: 5, //最大个数
            action: 'mouseover', //默认切换动作
            mouseTime: '150',
            playOnOff: false, //暂停开关，默认开始
            playClass: 'stop', //暂停开关类名
            overStop: true,
            change: true,
            changeType: 'normal',
            changeTime: 5000 //自动切换时间,
        };
        this.tab = target;
        this.ch = null;
        this.contentItem = null; //内容Item
        this.btnItem = null; //按钮Item
        this.intervalProcess = null;
        this.init(opts);
        this.callback = this.opts.callback || function() {};
    }


    //初始化
    dsTab.prototype.init = function(opts) {
        //覆盖默认参数
        this.opts = $.extend({}, this.defaults, opts || {});
        this.contentItem = this.tab.find(this.opts.itemEl);
        //铰接为空时，无点击动作
        this.contentItem.each(function() {
            _this = this.tagName == 'A' ? $(this) : $(this).parents('a');
            if (_this.length) {
                var href = _this.attr('href');
                if (typeof(href) == 'undefined' || href == '#') {
                    _this.css('cursor', 'default').click(function() {
                        return false
                    });
                }
            }
        });
        //获取个数
        this.opts.size = this.contentItem.size();
        if (this.opts.size <= 1) {
            return; //如果个数不大于1个时,不显示按钮
        }
        if (this.opts.maxSize != -1 && this.opts.size > this.opts.maxSize) {
            this.opts.size = this.opts.maxSize;
        }
        //初始化prev,next 按钮
         if(this.opts.prev != ''){
            this.prev = this.tab.find(this.opts.prev);
        }
        if(this.opts.next != ''){
            this.next = this.tab.find(this.opts.next);
        }
        if(this.opts.play != ''){
            this.play = this.tab.find(this.opts.play);
        }
        //自动生成tab按钮
        if (this.opts.autoCreateTab == true) {
            var btnsHtml = '';
            for (var i = 1; i <= this.opts.size; i++) {
                var li = this.opts.btnItemHtml;
                li = li.replace(/@index/g, i);
                btnsHtml += li;
            }
            var btns = this.tab.find(' .' + this.opts.btnElName);
            if (btns.length >= 1) {
                btns.eq(0).html('<ul>' + btnsHtml + '<ul>');
            } else {
                this.tab.append('<div class="' + this.opts.btnElName + '"><ul>' + btnsHtml + '</ul></div>');
            }
        }
        this.btnItem = this.tab.find('.' + this.opts.btnElName + ' ' + this.opts.btnItem);
        this.bind(); //绑定操作    
        this.change_handle();
        if (this.opts.change == true) {
            this.start();
        }
    }
    //绑定操作            
    dsTab.prototype.bind = function() {
        var _this = this;
        //鼠标移上后停止切换动作
        if (this.opts.change == true && this.opts.overStop == true) {
            this.tab.hover(function() {
                _this.stop();
            }, function() {
                if(_this.opts.playOnOff == true){
                    _this.start();
                }
            });
        }

        //prev切换动作
        if(this.prev){
            this.prev.click(function(){              
                _this.stop(); 
                _this.opts.index -=2;
                if(_this.opts.index < 0){
                    _this.opts.index = _this.opts.size -1;
                }
                _this.change_handle(_this.opts.index);

                if(_this.opts.playOnOff == true){
                    _this.start();
                }
                /*var btns = 
                var index = _this.btnItem.index(btns);
                    _this.opts.index = parseInt(index)+1;
                    _this.change_handle();*/
                
            });
        }
        //next切换动作
        if(this.next){
            this.next.click(function(){    
                _this.stop();              
                _this.change_handle(_this.opts.index);
                if(_this.opts.playOnOff == true){
                    _this.start();
                }
                
            });
        }
        //开始暂停
        if(this.play){
            
            this.play.click(function(){
                if(_this.opts.playOnOff == true){
                    $(this).addClass(_this.opts.playClass);
                    _this.opts.playOnOff = false;
                    _this.stop();
                }else {
                    $(this).removeClass(_this.opts.playClass);
                    _this.opts.playOnOff = true;
                    _this.start();
                }
            })
        }


        //切换动作
        if (this.opts.action == 'mouseover') {
            this.btnItem.mouseover(function() {
                var btns = this;
                _this.ch = setTimeout(function() {
                    var index = _this.btnItem.index(btns);
                    _this.opts.index = parseInt(index);
                    _this.change_handle();
                }, _this.opts.mouseTime);
            });
            this.btnItem.mouseout(function() {
                clearTimeout(_this.ch);
            });
        } else {
            this.btnItem.bind(this.opts.action, function() {
                var index = _this.btnItem.index(this);
                _this.opts.index = parseInt(index);
                _this.change_handle();
                this.blur();
            });
        }
    }
    dsTab.prototype.start = function() {
        var _this = this;
        clearInterval(this.intervalProcess);
        this.intervalProcess = setInterval(function() {
            _this.change_handle();
        }, this.opts.changeTime);
        if(this.opts.playOnOff == false){
            clearInterval(this.intervalProcess);
        }
    }
    dsTab.prototype.stop = function() {
        clearInterval(this.intervalProcess);
    }
    dsTab.prototype.change_handle = function() {
        if (this.opts.index > this.opts.size - 1) {
            this.opts.index = 0;
        }
        this.change(this.opts.index);
        this.opts.index += 1;
    }
    dsTab.prototype.change = function(index) {
        if (this.opts.oldIndex == index) {
            return;
        }
        this.opts.oldIndex = index;
        this.btnItem.removeClass(this.opts.currentClass);
        this.btnItem.eq(index).addClass(this.opts.currentClass);
        if (this.opts.changeType == 'normal') {
            this.contentItem.hide();
            this.contentItem.eq(index).show();
        } else if (this.opts.changeType == 'fade') {
            this.contentItem.fadeOut();
            this.contentItem.eq(index).fadeIn();
        }
        this.callback(index);
        return;
    }
    dsTab.prototype.callback = function(index, el) {

        this.opts.oldIndex = index;
        return index;
    }
})(jQuery);