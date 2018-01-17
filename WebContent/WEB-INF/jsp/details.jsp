<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="utf-8">
<title>博客详情</title>
<link href="${path}/bootstrap3.2.0/front/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/animate.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" href="${path}/css/index.css" />
<link rel="stylesheet" href="${path}/css/header.css" />
<link rel="stylesheet" href="${path}/css/blogs.css" />
<script src="${path}/bootstrap3.2.0/front/js/jquery-1.11.0.min.js"></script>
<script src="${path}/bootstrap3.2.0/front/js/bootstrap.js"></script>
<script type="text/javascript" src="${path}/js/lib/layer/2.4/layer.js"></script>
<script src="${path}/js/common.js"></script>
<script src="${path}/js/wow.min.js"></script>
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
			<div  id="newbox"  class="container wow fadeIn" data-wow-delay="0.5s" data-wow-duration="0.8s">
				<h1 class="t_nav">
					<p><a href="${path}/index.jsp">首页</a>&nbsp;&nbsp;>&nbsp;&nbsp;<a href="${path}/article/toCatelogy.shtml">技术博客</a>&nbsp;&nbsp;>&nbsp;&nbsp;
						<span id="directory"><a href="${path}/article/getCatelogyArticle.shtml?catelogy=${article.catelogy}" >${article.catelogy }</a></span>
					</p> 
				</h1>  
				<div class="content">
					<h2>${article.title }</h2>
					<p class="status">
						<span>发布时间：<time><tjz:date value="${article.date }"/></time></span>
						<span>浏览量：${article.readSum }</span>
						<span>点赞数：${article.goodSum }</span>
					</p>
					<ul class="infos">
						${article.content } 
					</ul> 
					<div class="interact">
						<span class="article-up"> 
							<span class="icon">
								<div class="icon-anim"></div>
							</span> 
							<span class="text">点个赞</span>
						</span> 
						
						<span class="article-reword"> 
							<span class="icon">
								<div class="icon-anim"></div>
							</span> 
							<span class="text">打赏</span>
						</span> 
						
						<span class="article-comment"> 
							<span class="icon">
								<div class="icon-anim"></div>
							</span> 
							<span class="text">评论</span>
						</span>
						<div class="reword"><img src="${path}/images/money.jpg"></div>
					</div>
					
				   <div id="tiaozhuan"></div>
				   
				   <!--PC版-->
                   <div id="SOHUCS" sid="${article.article_id}"></div>
                   <script charset="utf-8" type="text/javascript" src="https://changyan.sohu.com/upload/changyan.js" ></script>
                   <script type="text/javascript">
                    window.changyan.api.config({
                    appid: 'cyt2w4o0G',
                    conf: 'prod_561d95e2be02702992c7116b92bd63ea'
                    });
                   </script>
					
					
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
	</div>
	
    <!-- 点赞打赏评论 -->
	<script type="text/javascript">
		$(function() {
			var i = 0;
			var z = 0;
			
			// 点赞
			$('.article-up ').click(function() {
				if(z % 2 == 0) {
					$('.article-up .icon').css('background', 'url(${path}/images/zan02.png) no-repeat 50%');
					//点赞
					zan(1);
				}
				if(z % 2 != 0) 	{
					$('.article-up .icon').css('background', 'url(${path}/images/zan01.png) no-repeat 50%');
					//取消赞
					zan(2);
				}
				z++;
			});
			
			// 打赏
			$('.article-reword').click(function(e) {
				$('.reword').toggle();
				e.stopPropagation();
				$(document).click(function(){
					$('.reword').hide(1000);
				}); 
			});
			
			// 评论
			$('.article-comment').click(function() {
				window.location.href = "#tiaozhuan";
			}); 
					
			
			// ajax请求点赞
			function zan(flag){
				var article_id = '${article.article_id}'
				$.ajax("${path}/article/zan.shtml",{
					type:"get",
					data:"article_id="+article_id+"&flag="+flag,
					success:function(data){
						if(flag==1){
							layer.msg('点赞成功，谢谢支持');	
						}else{
							layer.msg('取消赞成功，怪我魅力不够噢，我会继续努力的');	
						}
						
					},
					error:function(){
						layer.msg('操作失败！');	
					}
				})
			}
						
		});
		
	 
	</script>	

</body>
</html>