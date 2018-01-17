<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="utf-8">
<title>生活日志</title>
<link href="${path}/bootstrap3.2.0/front/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/animate.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/index.css" rel='stylesheet' type='text/css' />
<link href="${path}/css/lifelog.css" rel="stylesheet" type='text/css'/>
<link rel="stylesheet" href="${path}/css/lightbox.css">
<link rel="stylesheet" type="text/css" href="${path}/js/page/mypagenation.css" />

<script src="${path}/bootstrap3.2.0/front/js/jquery-1.11.0.min.js"></script>
<script src="${path}/bootstrap3.2.0/front/js/bootstrap.js"></script>
<script src="${path}/js/common.js" ></script>
<script src="${path}/js/wow.min.js"></script>
<script src="${path}/js/page/ybpagenation.jquery.1.0.js" ></script>
<script src="${path}/js/lightbox-plus-jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		new WOW().init();
		$('#lifePage ').addClass('nav-active').siblings().removeClass('nav-active');
		$('#lifePage a').css('color','#fff');
	})
</script>
</head>

<body>
	<div class="bg">
		<!--header-->
		<%@include file="header.jsp"%>
		<!--- article --->
		<div id="article">
			<div id="pagination" class="container wow fadeIn" data-wow-delay="0.5s" >
			    <!-- 生活日志 -->
				<div id="log"></div>
		 		<!-- 页码 -->
		        <div class="mypagenation" id="mypagenation" style="margin-top: 20px"></div>  
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
		<footer class="footer-wrap wow fadeIn">
			<p>Copyright © 2017 Herd_youth  粤ICP备17048822号</p>
		</footer>

	</div>
<!--控制日志内容盒子的高度  -->
<script type="text/javascript">
	$(function(){
		var l=$('.info').height();
		$('.info').each(function(){
			if($(this).height()<70 & $(this).nextAll().length<2 ){
				$(this).css('height','70px');
			}
		});
	});
	
	
	var total;
	var pageSize;
	
	//加载文章
	function loadLifelogs(pageIndex,recordCount){
		   $.ajax("${path}/lifelog/getLifelog.shtml", {
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
						 
						 var picsShow = "";
						 var picsName = $(item).attr("picsName");
						 
						 if(picsName!=""){
							 $.each(picsName,function(i,item){
								 picsShow += "<a class=\"example-image-link\" href=\"${path}/getLifelogPics.shtml?picName="+item+"\" data-lightbox=\"gallery\" data-title=\"图"+(i+1)+"\">\n" +
											 "	 <img class=\"example-image\" width=\"60px\" height=\"60px\" src=\"${path}/getLifelogPics.shtml?picName="+item+"\" alt=\"\"/>\n" +
											 "</a>";
							 });
						 
						 }
						
						 
						 var content =   "<div id='lifeLog' class=\"row \" >\n" +
										 "	<div class=\"wow bounceIn\" data-wow-delay=\"0.4s\"\n" +
										 "		data-wow-duration=\"0.8s\">\n" +
										 "		<div class=\"col-lg-2 col-md-2 col-sm-2\">\n" +
										 "			<div class=\"log-pic \">\n" +
										 "				<img src=\"${path}/getPic.shtml?picName="+item.pic+"\" alt=\"\" />\n" +
										 "			</div>\n" +
										 "		</div>\n" +
										 "		<div class=\"col-lg-10 col-md-10 col-sm-10\">\n" +
										 "			<div class=\"log-text \">\n" +
										 "				<img src=\"${path}/images/left.png\" alt=\"左箭头\" />\n" +
										 "				<p class=\"info\">"+item.content+"</p>\n" +
										 "				<div class='logpic'>"+picsShow+"</div>\n" +
										 "				<p   class=\"date-time\"><span>"+datetime+"</span></p>\n" +
										 "			</div>\n" +
										 "		</div>\n" +
										 "	</div>\n" +
										 "</div>";
						 $("#log").append(content);
					});
					 
				},
				error : function() {
					alert("加载数据失败");
				}
			});
	}

	// 首次访问初始化页码
	loadLifelogs(1,0);
	//分页
	$('#mypagenation').initPagenation({  
	    totalCount: total,      //数据总个数  
	    showBtnFirst: true,     //是否显示 首页按钮  
	    showCount: pageSize,    //每页显示多少个,默认10个  
	    showBtnsCount: 8,      //数字按钮数量,最多10个,默认10个  
	    callback: function(pageIndex) { 
	    	$("#log").html("");
	    	loadLifelogs(pageIndex,total);
	    }
	   
	});  
</script>

</body>
</html>