<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>

	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1" charset="utf-8">
		<title>个人博客</title>
		<link href="${path}/bootstrap3.2.0/front/css/bootstrap.css" rel='stylesheet' type='text/css' />
		<link href="${path}/css/animate.css" rel="stylesheet" type="text/css" media="all">
		<link href="${path}/css/index.css" rel='stylesheet' type='text/css' />
		

	</head>

	<body>
		<div class="bg">
			<!--header  -->
			<%@include file="header.jsp" %>
			<!--- article --->
			<div id="article" class="wow slideInUp" data-wow-delay="0.3s" data-wow-duration="0.8s">
				<div id="pagination" class="container" >
					<!--首页-->
					<div id="index" class="row" style="display:">
						<div class="col-lg-8 col-md-8 col-sm-7 col-xs-8 left_box">
							<%@include file="article.jsp" %>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-5 col-xs-4 right_box">
							<div class="row">
								<%@include file="aside.jsp" %>
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
			<footer class="footer-wrap wow fadeIn" >
				<p>Copyright © 2017 Herd_youth  粤ICP备17048822号</p>
			</footer>
		</div>
	
		<script src="${path}/bootstrap3.2.0/front/js/bootstrap.js"></script>
		<script type="text/javascript" src="${path}/js/common.js"></script>
		<script src="${path}/js/wow.min.js"></script>
		<script type="text/javascript">
			$(function(){
				new WOW().init();
				$('#indexPage a').css('color','#fff');
			})
		</script>
	</body>
</html>