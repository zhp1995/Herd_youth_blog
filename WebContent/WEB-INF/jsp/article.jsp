<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页博文</title>

<link rel="stylesheet" href="${path}/css/article.css" />
<script type="text/javascript" src="${path}/js/page/ybpagenation.jquery.1.0.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/js/page/mypagenation.css" />
</head>
<body>
	
	<!--blog start-->
	<div id="blogPage">
		 
		<!-- article --> 
		<div id="articles"></div> 
		 
		<!-- 页码 -->
		<div class="mypagenation" id="mypagenation" style="margin-top: 20px"></div>  
		
	</div>
	
</body>
<script> 
   

	var total;
	var pageSize;
	
	//加载文章
	function loadArticles(pageIndex,recordCount){
		   $.ajax("${path}/article/selectArticle.shtml", {
				type : "get",
				data : "pageIndex="+pageIndex+"&recordCount="+recordCount,
				dataType : "json",
				async : false,
				success : function(data) {
					
					//加载总页数
					total = $(data).attr("total");	
					pageSize = $(data).attr("pageSize");	
					
					//加载文章
					var articles = $(data).attr("list");
					$.each(articles, function(i,item) {
						 var split = item.date.split("T");
						 var date = split[0];
						 var time = split[1].substring(0,5);
						 var datetime = date + " " + time;  
						 
						 var content =  "<div class=\"row \">\n" +
						 "	<div class=\"blog\">\n" +
						 "		<span class=\"label label-primary\">"+item.catelogy+"</span>\n" +
						 "		<div class=\"col-lg-4 col-md-4 col-sm-5 col-xs-4\">\n" +
						 "			<div class=\"pic\">\n" +
						 "				<img src=\"${path}/getPic.shtml?picName="+item.pic+"\" alt=\"pic\" />\n" +
						 "			</div>\n" +
						 "		</div>\n" +
						 "		<div onClick=\"toDetail(\'"+item.article_id+"\');\" class=\"col-lg-8 col-md-8 col-sm-7  col-xs-8 textbox\" >\n" +
						 "			<h5>\n" + 
						 "				<a href=\"#\">"+item.title+"</a>\n" +  
						 "			</h5>\n" +
						 "			<ul class=\"author-info\">\n" +
						 "				<li>发布时间："+datetime+" </li>\n" +
						 "				<li><span class=\"glyphicon glyphicon-fire\" id=\"heat\"></span>阅读量："+item.readSum+"</li>\n" +
						 "			</ul>\n" +
						 "			<p class=\"blog-info\">"+item.introduction+"</p>\n" +
						 "		</div>\n" +
						 "	</div>\n" +
						 "</div>";
						 $("#articles").append(content);
					});
					 
				},
				error : function() {
					alert("加载数据失败");
				}
			});
	}

	// 首次访问初始化页码
	loadArticles(1,0);
	//分页
	$('#mypagenation').initPagenation({  
	    totalCount: total,      //数据总个数  
	    showBtnFirst: true,     //是否显示 首页按钮  
	    showCount: pageSize,    //每页显示多少个,默认10个  
	    showBtnsCount: 8,      //数字按钮数量,最多10个,默认10个  
	    callback: function(pageIndex) { 
	    	$("#articles").html("");
	    	loadArticles(pageIndex,total);
	    }
	}); 
	
 
	
	//进入详情
	function toDetail(article_id) {
	   location.href = '${path}/article/toDetails.shtml?article_id='+article_id;
	};   
	   
	
</script> 
 

</html>