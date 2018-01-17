<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html >
<html>
<head>

<title>生活日志列表</title>
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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 生活日志管理 <span class="c-gray en">&gt;</span> 生活日志列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	
	<div class="cl pd-5 bg-1 bk-gray mt-20"> 
	       <span class="l"><a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> <a class="btn btn-primary radius" data-title="添加日志"  onclick="lifelog_add('添加','${path}/lifelog/admin/toAddLifelog.shtml')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 添加日志</a></span> <span class="r">共有数据：<strong id="num"></strong> 条</span>
	</div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="25"><input type="checkbox" name="" value=""></th>
					<th width="80">ID</th>
					<th>内容</th>
					<th width="80">头像</th>
					<th width="120">发布时间</th>
					<th width="120">操作</th>
				</tr>
			</thead>
			<!-- 生活日志 -->
			<tbody id = "lifelog"></tbody>	
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
<script type="text/javascript" src="${path}/js/lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="${path}/js/lib/laypage/1.2/laypage.js"></script>


</body>
<script type="text/javascript">


/*添加*/
function lifelog_add(title,url,w,h){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

/*编辑*/
function lifelog_edit(title,url,id,w,h){
	var index = layer.open({
		type: 2,
		title: title,
		content: url
	});
	layer.full(index);
}

/*删除*/
function lifelog_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'get',
			data: "ids="+id,
			url: '${path}/lifelog/admin/delLifelog.shtml',
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
		alert("请选择要删除的生活日志！");
	}else{
		if (confirm("您确定要删除吗？")){
			/** 获取需要审核的用户id */
			var ids = boxs.map(function(){
				return this.value;
			});
			$.ajax({
				type: 'get',
				data: "ids="+ids.get(),
				url: '${path}/lifelog/admin/delLifelog.shtml',
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
 
	var total;
	var pageSize;
	
	//加载日志
	function loadArticles(pageIndex,recordCount){
		  
		   $.ajax("${path}/lifelog/getLifelog.shtml", {
				type : "get",
				data : "pageIndex="+pageIndex+"&recordCount="+recordCount,
				dataType : "json",
				async : false,
				success : function(data) {
					
					//加载总页数
					total = $(data).attr("total");	
					$("#num").html("").append(total);
					pageSize = $(data).attr("pageSize");
					 
					 
					//加载文章
					var lifelogs = $(data).attr("list"); 
					
					$.each(lifelogs, function(i,item) {
						
						 var split = item.date.split("T");
						 var date = split[0];
						 var time = split[1].substring(0,5);
						 var datetime = date + " " + time;
						
						 var content =   "<tr class=\"text-c\">\n" +
										 "	<td><input type=\"checkbox\" value=\""+item.log_id+"\" id=\"box_"+item.log_id+"\"></td>\n" +
										 "	<td width=\"13%\" ><font size=\"1\">"+item.log_id+"</font></td>\n" +
										 "	<td>"+item.content+"</td>\n" +
										 "	<td><img width=\"90px\" heigth=\"90px\" src=\"${path}/getPic.shtml?picName="+item.pic+"\" </img></td>\n" +
										 "	<td width=\"8%\">"+datetime+"</td>\n" +
										 "	<td width=\"8%\" class=\"f-14 td-manage\"><a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"lifelog_edit('编辑','${path}/lifelog/admin/toEditLifelog.shtml?log_id="+item.log_id+"','')\" href=\"javascript:;\" title=\"编辑\"><i class=\"Hui-iconfont\">&#xe6df;</i></a>&nbsp<a style=\"text-decoration:none\" class=\"ml-5\" onClick=\"lifelog_del(this,'"+item.log_id+"')\" href=\"javascript:;\" title=\"删除\"><i class=\"Hui-iconfont\">&#xe6e2;</i></a></td>\n" +
										 "</tr>";			 
						 $("#lifelog").append(content);
					});
					 
				},
				error : function() {
					alert("加载数据失败");
				}
			});
	}
 	
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
	    	$("#lifelog").html("");
	    	loadArticles(pageIndex,total);
	    }    
	});
});
 
</script> 
</html>