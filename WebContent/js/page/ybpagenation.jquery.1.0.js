/**  
 * Created by mrbean on 2017/2/24.  
 * @suport IE6+  
 * 分页按钮选中样式为active  
 * 本插件 适合通过 ajax获取数据的方式  
 * 存放分页按钮的容器选择器    '#mypagenation'  
 * @param showBtnsFirst boolean类型 ,默认为false;  是否显示 '首页' '尾页' 按钮;非必须  
 * @param totalCount number类型 ,必须为数字  
 * @param callback function类型,点击某个page按钮之后的回调, 该函数返回当前点击的页码,从1开始  
 * @param showCount number类型, 每页显示多少条数据?  
 * @param showBtnsCount number类型, 一共显示多少个数字按钮  
 * */  
  
(function($) {  
    $.fn.extend({  
        initPagenation: function (config) {  
            var $pageBox = this;  
            if (!$pageBox.length) {  
                console.log('======= 选择器错误, 没有找到该元素! =======');  
                return this;  
            }  
            var myPageConfig = {  
                htmlTemp: [  
                    '<span class="link-wrapper">',  
                    '<span class="pre-page text">上一页</span>',  
                    '<span class="first-page text">首页</span>',  
                    '<span class="last-page text">尾页</span>',  
                    '<span class="next-page text">下一页</span>',  
                    '</span>'  
                ].join(''),  
                $pageBox: $pageBox,  
                pageIndex: 1,  
                totalCount: 0,  
                pagesCount: 1,  
                SHOW_COUNT: 10,  
                showBtnsCount: config.showBtnsCount || 10,  
                _useLink: true,  
                data: null,  
                callback: config.callback, /*接口暴露*/  
                showBtnFirst: config.showBtnFirst, /*是否显示首页,尾页*/  
                init: function (pagesInfo) {  
                    var count = pagesInfo.totalCount;  
                    if (!pagesInfo || !count) {  
                        $pageBox.hide();  
                        return;  
                    }  
                    $pageBox.append(this.htmlTemp);  
                    this.totalCount = parseInt(count);  
                    this.SHOW_COUNT = pagesInfo.showCount || 10;  
                    this.showBtnsCount = pagesInfo.showBtnsCount || 10;  
                    this.callback = pagesInfo.callback;  
                    if (!this.totalCount) {  
                        console.log('============= 数据不正确,分页器初始化错误! ==========');  
                        return;  
                    }  
                    this.pagesCount = Math.ceil(count / this.SHOW_COUNT);  
                    this.initBtns();  
                },  
                initBtns: function () {  
                    var count = this.totalCount,  
                        pages = Math.ceil(count / this.SHOW_COUNT),  
                        btnsCount = pages <= this.showBtnsCount ? pages : this.showBtnsCount,  
                        docFragment = document.createDocumentFragment();  
                    this.pagesCount = pages;  
                    for (var i = 1; i <= btnsCount; i++) {  
                        var aNode = document.createElement('a');  
                        aNode.setAttribute('href', 'javascript:;');  
                        aNode.setAttribute('id', 'pageNum');  
                        aNode.innerHTML = i + '';  
                        docFragment.appendChild(aNode);  
                        if (i === 1) {  
                            aNode.setAttribute('class', 'active');  
                        }  
                    }  
                    $pageBox.find('.first-page').after(docFragment);  
                    this.bindEvents();  
                },  
                bindEvents: function() {  
                    var callback = this.callback,  
                        that = this,  
                        $pagenation = $pageBox;  
                    $pagenation.on('click', 'a', function () {  
                        $(this).addClass('active').siblings('a').removeClass('active');  
                        var index = window.parseInt(this.innerHTML);  
                        that.pageIndex = index;  
                        callback && callback(index);  
                        that.handleIndex(index);  
                    });  
                    $pagenation.on('click', '.pre-page', function () {  
                    	if($(".active").prev().html() != "首页"){
                    		var prevPage = $(".active").prev();
                        	prevPage.addClass('active');
                        	prevPage.siblings('a').removeClass('active');
                    	}
                    
                        var index = that.pageIndex;  
                        index--;  
                        index = index < 1? 1 : index;  
                        that.switchIndex(index);  
                    });  
                    $pagenation.on('click', '.next-page', function () { 
                	    var index = that.pageIndex;  
                        index++;  
                        index = index > that.pagesCount? that.pagesCount : index;  
                     
                        var aa = index - 1;
                        var currentPage = $('[id=pageNum]').eq(aa);		 
                        currentPage.addClass('active');
                        currentPage.siblings('a').removeClass('active');
                    	
                        that.switchIndex(index);  
                    });  
                    if (this.showBtnFirst) {  
                        $pagenation.on('click', '.first-page', function () { 
                        	if($(".active").prev().html()!="首页"){
                        		var all = $(".active").siblings('a');
                            	var first = all.eq(0);
                            	first.addClass("active");
                            	first.siblings('a').removeClass('active');
                            }
                            that.switchIndex(1);  
                        });  
                        $pagenation.on('click', '.last-page', function () { 
                        	if($(".active").siblings('a').last().html() == that.pagesCount){  
                        		var all = $(".active").siblings('a');
                            	var next = all.last();
                            	next.addClass("active"); 
                            	next.siblings('a').removeClass('active');
                        	}
                            that.switchIndex(that.pagesCount);  
                        });  
                    } else {  
                        $pagenation.find('.first-page, .last-page').hide();  
                    }  
                    this.switchIndex(1);  
                },  
                switchIndex: function (index) {  
                    this.pageIndex = index;  
                    this.callback && this.callback(index);  
                    this.handleIndex(index);  
                },  
                handleIndex: function (index) {  
                    var pagesCount = this.pagesCount,  
                        startIndex = 0,  
                        endIndex = 0,  
                        rightCount = parseInt(this.showBtnsCount / 2),  
                        showBtnsCount = this.showBtnsCount,  
                        $pageItems = $pageBox.find('a');  
                    if (pagesCount > showBtnsCount) {//核心思想在此  
                        if (index + rightCount <= pagesCount) {  
                            endIndex = index + rightCount;  
                        } else {  
                            endIndex = pagesCount;  
                        }  
                        endIndex = endIndex < showBtnsCount ? showBtnsCount : endIndex;//左侧开始的负数  
                        startIndex = endIndex - showBtnsCount + 1;  
                        $pageItems.each(function (index2) {  
                            $(this).html(startIndex + index2);  
                            if (startIndex + index2 ===  index) {  
                                $(this).addClass('active').siblings('a').removeClass('active');  
                            }  
                        });  
                    }  
                }  
            };  
            myPageConfig.init({  
                totalCount: config.totalCount,  
                callback: config.callback,  
                showCount: config.showCount,  //可选配置,一次显示多少页,默认是显示 1 ~ 10页  
                showBtnsCount: config.showBtnsCount  
            });  
            return $pageBox;  
        }  
    });  
})(jQuery); 