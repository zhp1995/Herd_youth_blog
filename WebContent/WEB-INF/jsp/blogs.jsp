<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="utf-8">
<title>同类文章</title>
<link href="${path}/bootstrap3.2.0/front/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/animate.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" href="${path}/css/animate.css" />
<link rel="stylesheet" href="${path}/css/index.css" />
<link rel="stylesheet" href="${path}/css/header.css" />
<link rel="stylesheet" href="${path}/css/article.css" />
<link rel="stylesheet" href="${path}/css/blogs.css" />

<script src="${path}/bootstrap3.2.0/front/js/jquery-1.11.0.min.js"></script>
<script src="${path}/bootstrap3.2.0/front/js/bootstrap.js"></script>
<script src="${path}/js/common.js"></script>
<script src="${path}/js/wow.min.js"></script>
<script type="text/javascript" src="${path}/js/page/ybpagenation.jquery.1.0.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/js/page/mypagenation.css" />
<script>new WOW().init();</script>

</head>

<body>
	<div class="bg">
		<!--header  -->
		<header>
			<div id="home" class="header wow bounceInDown navbar-fixed-top"
				data-wow-delay="0.4s">
				<div class="top-header">
					<div class="container">
						<div class="row">
							<div class="navback">
								<div class="logo">
									<a href="#"><img src="${path}/images/logo1.png" title="dreams" /></a>
								</div>
								<a class="login" href="${path}/admin/toLogin.shtml">登录后台</a>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</header>
		<!-- new-->
		<div id="new">
			<div id="newbox" class="container wow fadeIn" data-wow-delay="0.5s">
				<h1 class="t_nav">
					<p>
						<a href="${path}/index.jsp">首页</a>&nbsp;&nbsp;>&nbsp;&nbsp; <span
							id="directory"> <a href="${path}/article/toCatelogy.shtml">技术博客</a>&nbsp;&nbsp;>&nbsp;&nbsp;
							<a id="cl" href="">${catelogy}</a>
						</span>
					</p>
				</h1>
				<div class="content">
					<div id="index" class="row" >
						<div class="col-lg-8 col-md-8 col-sm-7">
							<div id="blogPage">
								 
								<!-- article --> 
		                        <div id="articles"></div> 
								
								<!-- 页码 -->
	                            <div class="mypagenation" id="mypagenation" style="margin-top: 20px"></div> 
							</div>
						</div>
						
						<div class="col-lg-4 col-md-4 col-sm-5">
							<div class="row">
								<%@include file="aside.jsp"%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
 
	<!-- 返回顶部 -->
	<div class="sidebar">
		<a class=" wx-share"><span class="glyphicon glyphicon-qrcode"></span></a>
		<a class=" return-top"><span class="glyphicon glyphicon-chevron-up"></span></a>
	</div>
	<div class="QR-code"><img src="${path}/images/weixin.jpg" alt="" /></div>	
	
	<!--footer  -->
	<footer class="footer-wrap  wow fadeIn">
		<p>Copyright © 2017 Herd_youth  粤ICP备17048822号</p>
	</footer>	
	 
</body>
<script type="text/javascript">
	var total;
	var pageSize;
	var catelogy = encodeURIComponent(document.getElementById('cl').innerText);
	
	//加载文章
	function loadArticles(pageIndex,recordCount,catelogy){
		   $.ajax("${path}/article/selectArticle.shtml", {
				type : "get",
				data : "pageIndex="+pageIndex+"&recordCount="+recordCount+"&catelogy="+catelogy,
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
						 "		<div class=\"col-lg-4 col-md-4 col-sm-5\">\n" +
						 "			<div class=\"pic\">\n" +
						 "				<img src=\"${path}/getPic.shtml?picName="+item.pic+"\" alt=\"pic\" />\n" +
						 "			</div>\n" +
						 "		</div>\n" +
						 "		<div onclick=\"toDetail(\'"+item.article_id+"\');\" class=\"col-lg-8 col-md-8 col-sm-7 textbox\"  >\n" +
						 "			<h5>\n" +
						 "				<a href=\"#\">"+item.title+"</a>\n" +
						 "			</h5>\n" +
						 "			<ul class=\"author-info\">\n" +
						 "				<li>发布时间：<time>"+datetime+"</time></li>\n" +
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
	loadArticles(1,0,catelogy);
 
	//分页
	$('#mypagenation').initPagenation({  
	    totalCount: total,      //数据总个数  
	    showBtnFirst: true,     //是否显示 首页按钮  
	    showCount: pageSize,    //每页显示多少个,默认10个  
	    showBtnsCount: 8,      //数字按钮数量,最多10个,默认10个  
	    callback: function(pageIndex) { 
	    	$("#articles").html("");
	    	loadArticles(pageIndex,total,catelogy);
	    }	   
	});   
	
	 //进入详情
	 function toDetail(article_id) {
	    location.href = '${path}/article/toDetails.shtml?article_id='+article_id;
	 };  
	
</script> 
</html>