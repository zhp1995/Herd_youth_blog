<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
 
<title>个人博客后台管理系统</title>

<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/css/style.css" />
 
</head>
<body>
<header class="navbar-wrapper">
	<div class="navbar navbar-fixed-top"> 
		<div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs" >Herd_youth 后台管理</a> <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="/aboutHui.shtml">H-ui</a> 
			 
			<a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
			<nav class="nav navbar-nav">
				<ul class="cl">
					<li class="dropDown dropDown_hover"><a href="${path}/index.shtml" class="dropDown_A">前台</a>	
				</li>
			</ul>
		    </nav>
		<nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
			<ul class="cl">
				<li>超级管理员</li>
				<li class="dropDown dropDown_hover">
					<a href="#" class="dropDown_A">${user.username }<i class="Hui-iconfont">&#xe6d5;</i></a>
					<ul class="dropDown-menu menu radius box-shadow">
						<li><a href="${path}/admin/loginout.shtml">切换账户</a></li>
						<li><a href="${path}/admin/loginout.shtml">退出</a></li>
				    </ul>
			    </li>
			</ul>
		</nav>
	</div>
</div>
</header>
<aside class="Hui-aside">
	<div class="menu_dropdown bk_2">
		<dl id="menu-article">
			<dt><i class="Hui-iconfont">&#xe616;</i>文章管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${path}/article/admin/toArticleList.shtml" data-title="文章列表" href="javascript:void(0)">文章列表</a></li>
				</ul>
			</dd>
		</dl>
		<dl id="menu-picture">
			<dt><i class="Hui-iconfont">&#xe613;</i>生活日志管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
			<dd>
				<ul>
					<li><a data-href="${path}/lifelog/admin/toLifelog.shtml" data-title="日志列表" href="javascript:void(0)">日志列表</a></li>
				</ul>
			</dd>
		</dl>
	</div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active">
					<span title="首页" data-href="welcome.html">首页</span>
					<em></em>
				</li>
		    </ul>
	    </div>	
    </div>
	<div id="iframe_box" class="Hui-article">
		<div class="show_iframe">
			<div style="display:none" class="loading"></div>
			<!-- <iframe scrolling="yes" frameborder="0" src="welcome.html"></iframe> -->
	    </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
	<ul>
		<li id="closethis">关闭当前 </li>
		<li id="closeall">关闭全部 </li>
    </ul>
</div>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${path}/js/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${path}/js/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${path}/js/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${path}/js/static/h-ui.admin/js/H-ui.admin.js"></script> 
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${path}/js/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>

</body>
</html>