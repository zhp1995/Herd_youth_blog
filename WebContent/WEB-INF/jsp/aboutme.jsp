<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html >
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="utf-8">
<title>关于我</title>
<link href="${path}/bootstrap3.2.0/front/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/animate.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/index.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/aboutme.css" rel="stylesheet" type='text/css'/>

<script src="${path}/bootstrap3.2.0/front/js/jquery-1.11.0.min.js"></script>
<script src="${path}/bootstrap3.2.0/front/js/bootstrap.js"></script>
<script type="text/javascript" src="${path}/js/common.js"></script>
<script src="${path}/js/wow.min.js"></script>
<script type="text/javascript">
	$(function(){
		new WOW().init();
		$('#myPage ').addClass('nav-active').siblings().removeClass('nav-active');
		$('#myPage a').css('color','#fff');
	})
</script>
</head>

<body>
<div class="bg">
		<!--header  -->
		<%@include file="header.jsp"%>
		<!--- article --->
		<div id="article">
			<div id="pagination" class="container">
		<!--start-->
			<div id="mypage" >
				<div id='aboutme' class="row wow fadeIn" data-wow-delay="0.5s">
					<div class="col-lg-4 col-md-4 col-sm-4">
						<div class="personal-profile">
							<img alt="" src="images/blogger.jpg">
							<div >
								<p style="margin:15px 10px 5px 10px">博主：追风少年</p>
								<p style="margin:10px 10px 5px 30px">QQ：215936016</p>
								<p style="margin:10px 35px 5px 5px">职业：码农</p>
								<p style="margin:10px 10px 5px 20px">爱好：运动、旅游</p>
								<p style="margin:10px 20px 5px 15px">喜欢的音乐：《小手拉大手》</p>
								<p style="margin:5px 5px 5px 80px">《我曾是少年》</p>
								<p style="margin:10px 5px 5px 2px">人生格言:作为青年,要经得起谎言,受得</p>
								<p style="margin:5px 0px 5px 70px">起敷衍,忍得住眼泪,放得下诺言.</p>
							</div>
						</div>
					</div>
					<div class="col-lg-8 col-md-8 col-sm-8">
						<div class="personal-text">
							<h2>About me</h2>
							<p>一个不断学习和研究，Java Web和大数据技术的90后草根站长。</p>
							<p>我属于巨蟹座:很多时候觉得自己对待任何事情都很执着，一旦有了目标和方向，就会很努力的去完成，永不退缩！ 面对爱情也是一样，当真正遇到自己喜欢的一个人，会不顾一切去追。</p>
							<p>在学习这条路上，最大的收获就是：不管你学什么，最重要的是毅力。即使你学着再好再牛逼的技术，没有毅力，三天打鱼，两天晒网，最后也只不过是白纸一张。其次才是方法， 一句很经典的话："授人以鱼不如授人以渔"，讲的是：传授给人知识，不如传授给人学习知识的方法，有了好的方法自然很快上手 。</p>
							<p>人的一生很长，还需要自己一步一步脚踏实地的完成！我曾经有个梦想，如果可以的话，我想带着一家人定期一年一次国外旅行，让生活变得更美好，更幸福！</p>
							<p>感谢那些曾经帮助过我的人，因为有你们我才会变得如此的优秀。</p>
							<p>----By:<span class="name">追风少年</span></p>
						</div>	
					</div>
				</div>				
			</div>		
			</div>
		</div>
		<!-- 返回顶部 -->
		<div class="sidebar">
			<a class=" wx-share"><span class="glyphicon glyphicon-qrcode"></span></a>
			<a class=" return-top"><span
				class="glyphicon glyphicon-chevron-up"></span></a>
		</div>
		<div class="QR-code"><img src="${path}/images/weixin.jpg" alt="" /></div>	
		
		<!--footer  -->
		<footer class="footer-wrap  wow fadeIn">
			<p>Copyright © 2017 Herd_youth  粤ICP备17048822号</p>
		</footer>
	</div>
			
</body>
</html>