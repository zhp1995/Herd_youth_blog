<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="utf-8">
<title>header</title>
<link rel="stylesheet" href="${path}/css/header.css" />
		<script type="text/javascript" src="${path}/js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="${path}/js/jquery.banner.revolution.min.js"></script>
		<script type="text/javascript" src="${path}/js/banner.js"></script>
</head>
<body>
	<header>
		<div id="home" class="header wow bounceInDown navbar-fixed-top"
			data-wow-delay="0s">
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
		<!---- banner ---->
		
		<div id="wrapper">
			<div class="fullwidthbanner-container">
				<div class="banner">
					<ul>
						<li data-transition="3dcurtain-horizontal" data-slotamount="15" data-masterspeed="300">
							<img src="${path}/images/banner1.jpg" alt="" />									
						</li>
						<li data-transition="3dcurtain-vertical" data-slotamount="15" data-masterspeed="300" data-link="#">
							<img src="${path}/images/banner2.jpg" alt="" />
						</li>
						<li data-transition="papercut" data-slotamount="15" data-masterspeed="300" data-link="#">
							<img src="${path}/images/banner3.jpg" alt="" />
						</li>					
					</ul>
				</div>
			</div>
			<!--导航-->
						<nav class="navbar navbar-inverse" id="menu" role="navigation">
							<!-- Brand and toggle get grouped for better mobile display -->
							<div class="navbar-header" id=" ">
								<button type="button" class="navbar-toggle"
									data-toggle="collapse"
									data-target="#bs-example-navbar-collapse-1">
									 <span class="icon-bar"></span> 
									 <span class="icon-bar"></span> 
									 <span class="icon-bar"></span>
								</button>
								
							</div>
							<div class="collapse navbar-collapse  container"
								id="bs-example-navbar-collapse-1">
								<ul id="menuPage" class="nav navbar-nav">
									<li class="nav-active" id="indexPage"><a  href="${path}/index.jsp">首页</a></li>
									<li id="techPage"><a  href="${path}/article/toCatelogy.shtml">技术博客</a></li>
									<li id="lifePage"><a  href="${path}/lifelog.shtml">生活日志</a></li>
									<li id="myPage"><a  href="${path}/aboutme.shtml">关于我</a></li>
								</ul>
							</div>
							 
						</nav>

					</div>

	</header>
	

</body>
</html>