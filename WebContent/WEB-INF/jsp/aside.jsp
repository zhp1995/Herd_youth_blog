<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>侧边栏</title>
<link rel="stylesheet" href="${path}/css/aside.css" />
</head>
<body>
		<!--aside start-->
		<div class="aside">
			<div class="search-article">
				<a>文章搜索</a><br />
				<form action="" class="navbar-form" id="search-form">
					<input  class="form-control" id="bdcsMain"  type="text" placeholder="" >
					<button type="submit" onclick="">
						<span class="glyphicon glyphicon-search"></span>
					</button>
				</form>
			</div>
			<div class="blogger-info">
				<h3>
					关于<span>博主</span>
				</h3>
				<div class="blogger-pic">
					<img src="${path}/images/blogger.jpg"  onclick="window.open('aboutme.jsp')"/>
				</div>
				<ul>
					<li>博主：追风少年</li>
					<li>职业：码农</li>
					<li>简介：一个不断学习和研究，Java web和</li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;大数据技术的90后草根站长.</li>
				</ul>
			</div>
			<div class="lastest">
				<h3>
					<span class="glyphicon glyphicon glyphicon-time"></span>&nbsp;&nbsp;热门推荐
				</h3>
				<hr class="right_hr">
				<ol class="title">
					 
				</ol>
				<ol class="number">
					 
				</ol>
			</div>
			<div class="tags">
				<h3>
					<span class="glyphicon glyphicon glyphicon-tags"></span>&nbsp;&nbsp;标签
				</h3>
				<hr class="right_hr">
				<!-- 加载左侧标签 -->
				<div class="sort"></div>
			</div>
			<div class="friendship">
				<h3>
					<span class="glyphicon glyphicon-heart-empty"></span>&nbsp;&nbsp;友情链接
				</h3>
				<hr class="right_hr">
				<ul>
				    <li ><a  target="_blank" href="http://www.wangsenfeng.com/">神算子</a></li>
					<li ><a  target="_blank" href="http://hill1895.rocks">刘文图熙博客</a></li>
					<li ><a  target="_blank" href="http://www.ruanyifeng.com">阮一峰博客</a></li>
				</ul>
			</div>
		</div>
		<!--aside end-->
		
		<script type="text/javascript">
			$(function(){  
				//标签动画
				var $Span=$(".sort a ");
				$Span.hover(function(){
					var z=$(this).index();
					$Span.eq(z).addClass('over'); 
				},function(){
					var z=$(this).index();
					$Span.eq(z).removeClass('over');
				});
				//搜索框
				$('#search').val('请输入关键字');
				textFill($('#search'));
				function textFill(input){
					var originalvalue=input.val();
					input.focus(function(){
						if( $.trim(input.val())==originalvalue){
							input.val('');
						}
					}).blur(function(){
						if( $.trim(input.val())==''){
							input.val(originalvalue);
						}
					});
				}
				
				
				// 加载标签
				$.ajax("${path}/article/getCatelogyAjax.shtml",{
					type:"get",
					dataType:"json",
				    async:true,
				    success:function(data){
				    	var array = new Array("label label-default label-primary","label label-default",
				    			              "label label-default label-success","label label-default label-danger",
				    			              "label label-default label-warning","label label-default label-success",
				    			              "label label-default label-info","label label-default label-success",
				    			              "label label-default label-info","label label-default label-warning",
				    			              "label label-default","label label-default label-primary",
				    			              "label label-default label-success","label label-default label-danger",
				    			              "label label-default label-warning","label label-default label-success",
				    			              "label label-default label-info","label label-default label-success",
				    			              "label label-default label-info","label label-default label-warning",
				    			              "label label-default","label label-default label-primary",
				    			              "label label-default label-success","label label-default label-danger");
				    	
				    	$.each(data,function(i,item){
				    	   var cl =	encodeURIComponent(item.catelogy);
				    	   var content = "<a href=\"${path}/article/getCatelogyArticle.shtml?catelogy="+cl+" \"> <span class=\""+array[i]+"\">"+item.catelogy+"</span>&nbsp;&nbsp;</a> ";
				    	   $(".sort").append(content);
				    	});
				    },
				    error:function(){
				    	alert("加载数据失败");
				    }
				});
				
			 
				// 加载热门文章
				$.ajax("${path}/article/getHotArticle.shtml",{
					type:"get",
					dateType:"json",
					async:true,
					success:function(data){
						 var obj = eval(data);
						 $(obj).each(function(index){
							var o = obj[index];
							var content = "<a href=\"${path}/article/toDetails.shtml?article_id="+o.article_id+"\"><li>"+o.title+"</li></a>";
							$(".title").append(content);
							var number = index+1;
							var rank = "<li>"+number+"</li>";
							$(".number").append(rank);
						 })
					},
					error:function(){
						alert("加载数据失败");
					}
				});
			});
		 
		</script>
		<script type="text/javascript">(function(){document.write(unescape('%3Cdiv id="bdcs"%3E%3C/div%3E'));var bdcs = document.createElement('script');bdcs.type = 'text/javascript';bdcs.async = true;bdcs.src = 'http://znsv.baidu.com/customer_search/api/js?sid=2941210937061521106' + '&plate_url=' + encodeURIComponent(window.location.href) + '&t=' + Math.ceil(new Date()/3600000);var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(bdcs, s);})();</script>
</body>
</html>





