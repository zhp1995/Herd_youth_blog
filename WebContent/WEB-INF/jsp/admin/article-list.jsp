<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html >
<html>
<head>

<title>文章列表</title>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

<script type="text/javascript" src="${path}/js/lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="${path}/js/page/ybpagenation.jquery.1.0.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/js/page/mypagenation.css" /> 

<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/css/style.css" />

</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 文章管理 <span class="c-gray en">&gt;</span> 文章列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<div class="text-c">
	 	<span class="select-box inline">
		<select name="catelogy" class="select">
			<option value="0">全部分类</option>	 
		</select>
		</span> 日期范围：
		<input type="text" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'logmax\')||\'%y-%M-%d\'}' })" id="logmin" class="input-text Wdate" style="width:120px;">
		-
		<input type="text" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'logmin\')}',maxDate:'%y-%M-%d' })" id="logmax" class="input-text Wdate" style="width:120px;">
		<input type="text"  id="title" value="" placeholder="文章题目" style="width:250px" class="input-text">
		<button  id="search" class="btn btn-success" type="submit"><i class="Hui-iconfont">&#xe665;</i> 搜索</button>
	</div>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
	       <span class="l"><a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" data-title="添加文章"  onclick="article_add('添加','${path}/article/admin/toAddArticle.shtml')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加文章</a></span> <span class="r">共有数据：<strong id="num"></strong> 条</span>
	</div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" name="" value=""></th>
					<th width="80">ID</th>
					<th>题目</th>
					<th width="80">分类</th>
					<th width="120">更新时间</th>
					<th width="75">浏览量</th>
					<th width="60">点赞量</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<!-- 文章 -->
			<tbody id = "ar"></tbody>	
		</table>
		<!-- 页码 -->
		<div class="mypagenation" id="mypagenation" style="margin-top: 20px"></div>  	
	</div>
</div>
 
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${path}/js/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${path}/js/static/h-ui/js/H-ui.min.js"></script>  
<script type="text/javascript" src="${path}/js/static/h-ui.admin/js/H-ui.admin.js"></script> 
<!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${path}/js/lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="${path}/js/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${path}/js/lib/laypage/1.2/laypage.js"></script>


</body>
<script type="text/javascript">


/*资讯-添加*/
function article_add(title,url,w,h){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

/*资讯-编辑*/
function article_edit(title,url,id,w,h){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

/*资讯-删除*/
function article_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'get',
			data: "ids="+id,
			url: '${path}/article/admin/delArticle.shtml',
			success: function(data){
				if(data == "success"){
					var number = $("#num").html()-1;
					$("#num").html("").html(number);
					$(obj).parents("tr").remove();
					layer.msg('已删除!',{icon:1,time:1000});	
				}
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}

function datadel(){
	/** 获取选择中的checkbox */
	var boxs = $("input[id^='box_']:checked");
	if (boxs.size() == 0){
		alert("请选择要删除的文章！");
	}else{
		if (confirm("您确定要删除吗？")){
			/** 获取需要审核的用户id */
			var ids = boxs.map(function(){
				return this.value;
			});
			$.ajax({
				type: 'get',
				data: "ids="+ids.get(),
				url: '${path}/article/admin/delArticle.shtml',
				success: function(data){
					if(data == "success"){
						$(boxs).parents("tr").remove();
						layer.msg('已删除!',{icon:1,time:1000});	
					}
				},
				error:function(data) {
					console.log(data.msg);
				},
			});
			var number = $("#num").html()-boxs.size();
			$("#num").html("").html(number);
			layer.msg('已删除!',{icon:1,time:1000});	
			
		}
	}
}


$(function(){
	/** 加载分类 **/
	$.ajax("${path}/article/admin/getCatelogy.shtml",{
		type:"get",
		dateType:"json",
		async:true,
		success:function(data){
            var obj = eval(data);			 
			$(obj).each(function(index){
				var o = obj[index];
				$("<option/>").val(o.catelogy)
	              .text(o.catelogy)
	              .attr("selected", o.catelogy == catelogy)
	              .appendTo(".select");
			});
 
		},
		error:function(){
			alert("加载数据失败");
		}
	});
	
	var total;
	var pageSize;
	var catelogy = "";
	var title = "";
	var startTime = "";
	var endTime = ""; 
	
	
	//加载文章
	function loadArticles(pageIndex,recordCount,catelogy,title,startTime,endTime){
		   var data = "pageIndex="+pageIndex+"&recordCount="+recordCount;  
		   
		   if(catelogy!=null && catelogy != "")  data += "&catelogy="+encodeURIComponent(catelogy);
		  
		   if(title!=null && title != "")  data += "&title="+encodeURIComponent(title);
		  
		   if(startTime != null  || endTime !=null){
			   if(startTime != "" || endTime != ""){
				   if(startTime != null && endTime != null && startTime != "" && endTime != ""){
					   data += "&startTime="+startTime+"&endTime="+endTime;
				   }else{
					   alert("请同时输入开始时间和结束时间"); 
				   }
			   }  
		   }
		  
		   $.ajax("${path}/article/selectArticle.shtml", {
				type : "get",
				data : data,
				dataType : "json",
				async : false,
				success : function(data) {
					
					//加载总页数
					total = $(data).attr("total");	
					$("#num").html("").append(total);
					pageSize = $(data).attr("pageSize");	
					 
					//加载文章
					var articles = $(data).attr("list"); 
					
					$.each(articles, function(i,item) {
						
						 var split = item.date.split("T");
						 var date = split[0];
						 var time = split[1].substring(0,5);
						 var datetime = date + " " + time;
						
						 var content =   "<tr class=\"text-c\">\n" +
										 "	<td><input type=\"checkbox\" value=\""+item.article_id+"\" id=\"box_"+item.article_id+"\"></td>\n" +
										 "	<td width=\"13%\" ><font size=\"1\">"+item.article_id+"</font></td>\n" +
										 "	<td>"+item.title+"</td>\n" +
										 "	<td>"+item.catelogy+"</td>\n" +
										 "	<td width=\"9%\">"+datetime+"</td>\n" +
										 "	<td width=\"6%\">"+item.readSum+"</td>\n" +
										 "	<td width=\"6%\" class=\"td-status\">"+item.goodSum+"</td>\n" +
										 "	<td width=\"8%\" class=\"f-14 td-manage\"><a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"article_edit('编辑','${path}/article/admin/toEditArticle.shtml?article_id="+item.article_id+"','')\" href=\"javascript:;\" title=\"编辑\"><i class=\"Hui-iconfont\">&#xe6df;</i></a>&nbsp<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"article_del(this,'"+item.article_id+"')\" href=\"javascript:;\" title=\"删除\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a></td>\n" +
										 "</tr>";			 
						 $("#ar").append(content);
					});
					 
				},
				error : function() {
					alert("加载数据失败");
				}
			});
	}
	
	
	$("#search").click(function(){
		catelogy = $(".select").val();
		title = $("#title").val();
		startTime = $("#logmin").val();
		endTime = $("#logmax").val();
		$("#ar").html("");
		$("#mypagenation").html("");	
	    
		/*  初始化页码 */
		loadArticles(1,0,catelogy,title,startTime,endTime);	
		if(total == 0) total=1;
		
		$('#mypagenation').initPagenation({  
		    totalCount: total,      //数据总个数  
		    showBtnFirst: true,     //是否显示 首页按钮  
		    showCount: pageSize,    //每页显示多少个,默认10个  
		    showBtnsCount: 8,      //数字按钮数量,最多10个,默认10个  
		    callback: function(pageIndex) { 
		    	$("#ar").html("");
		    	loadArticles(pageIndex,total,catelogy,title,startTime,endTime);
		    }
		   
		});
	});
	
	//首次访问初始化页码
	loadArticles(1,0);
	if(total == 0) total=1;
	//分页
	$('#mypagenation').initPagenation({  
	    totalCount: total,      //数据总个数  
	    showBtnFirst: true,     //是否显示 首页按钮  
	    showCount: pageSize,    //每页显示多少个,默认10个  
	    showBtnsCount: 8,      //数字按钮数量,最多10个,默认10个  
	    callback: function(pageIndex) { 
	    	$("#ar").html("");
	    	loadArticles(pageIndex,total,catelogy,title,startTime,endTime);
	    }    
	});
});
 
</script> 
</html>