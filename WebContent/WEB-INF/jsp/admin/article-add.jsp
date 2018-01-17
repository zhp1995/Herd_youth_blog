<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<title>新增文章</title>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
 <script type="text/javascript" src="${path}/js/lib/jquery/1.9.1/jquery.min.js"></script> 
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="${path}/js/static/h-ui.admin/css/style.css" />
 
</head>
<body>
<article class="page-container">
	<form class="form form-horizontal" id="form-article-add" method="post" enctype="multipart/form-data">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">文章标题：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="" placeholder="" id="title" name="title">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">文章前言：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<textarea name="introduction" id="introduction" cols="" rows="" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-100" dragonfly="true" ></textarea>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">类别：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="" placeholder="" id="catelogy" name="catelogy">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">浏览量：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="" placeholder="" id="readSum" name="readSum">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">点赞量：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="" placeholder="" id="goodSum" name="goodSum">
			</div>
		</div>
		  
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">展示图：</label>
			<div class="formControls col-xs-8 col-sm-9">
			     <img width="100" height="100" src="" id="allImgUrl" style="display:none"/>
			     <!-- 实际传给后台表单的标签 -->
			     <input type="hidden" name="pic" value="" id="path"/>
			     <input type="file" onchange="uploadPic()" name="picFile"/>
			</div>
		</div>
		 
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">文章内容：</label>
			<div class="formControls col-xs-8 col-sm-9"> 
				<textarea id="editor" name="content" style="width:100%;height:600px;" ></textarea>
			</div>
		</div>
		
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button onClick="article_save();" class="btn btn-secondary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 提交</button>
				<button onClick="removeIframe();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${path}/js/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${path}/js/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="${path}/js/static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="${path}/js/static/h-ui.admin/js/H-ui.admin.js"></script>
 <!--/_footer /作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${path}/js/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${path}/js/lib/ueditor/ueditor.config.js"></script> 
<script type="text/javascript" src="${path}/js/lib/ueditor/ueditor.all.js"> </script> 
<script type="text/javascript" src="${path}/js/lib/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">

//加载编辑器
window.UEDITOR_HOME_URL = "${path}/js/lib/ueditor/";
var ue = UE.getEditor('editor');

//上传图片
function uploadPic(){
	
	 if($("#path").val()!=""){
		 var picName = $("#path").val();
		 $.ajax("${path}/delPic.shtml",{
			 type:"get",
			 data:"picName="+picName,
			 async:true,
			 success:function(data){
				 
			 },
			 error:function(){
				 alert("删除图片失败");
			 }
		 });
	 }
	 
	//定义参数
	var options = {
		url : "${path}/uploadPic.shtml",
		dataType : "json",
		type :  "post",
		success : function(data){
			
		 // 回调 二个路径  
		 // url filename
		 $("#allImgUrl").removeAttr("style");
		 $("#allImgUrl").attr("src",data.url);		
		 $("#path").attr("value",data.path);
		 
		}
	};
	
	//jquery.form使用方式
   $("#form-article-add").ajaxSubmit(options);
}

function removeIframe(){
	window.parent.location.reload();
}
 

//提交添加文章
function article_save(){
	
	var title = $("#title");
	var introduction = $("#introduction");
	var catelogy = $("#catelogy");
	var readSum = $("#readSum"); 
	var goodSum = $("#goodSum");
	var pic = $("#path"); 
	var content = ue.getContent();
	
	var msg = "";
	if ($.trim(title.val()) == ""){
		msg = "题目不能为空！"; 
		title.focus();
	}else if ($.trim(introduction.val()) == ""){
		msg = "前言不能为空！";
		introduction.focus();
	}else if ($.trim(catelogy.val()) == ""){
		msg = "分类不能为空！";
		catelogy.focus();
	}else if ($.trim(readSum.val()) == ""){
		msg = "浏览量不能为空！";
		readSum.focus();
	}else if ($.trim(goodSum.val()) == ""){
		msg = "点赞量不能为空！";
		goodSum.focus();
	}else if ($.trim(pic.val()) == ""){
		msg = "展示图不能为空！";
		pic.focus();
	}else if ($.trim(content) == ""){
		msg = "内容不能为空！";
		content.focus();
	}
	 
	if (msg != ""){
		alert(msg);
	}else{
		var dd = $("#form-article-add").serialize();
		
		$.ajax("${path}/article/admin/addArticle.shtml",{
			type:"post",
			data:dd,
			dataType:"json",
			async:false,
			success:function(data){
				if(data.state=="1"){
					layer.msg('添加成功!');
					setTimeout(function(){
						window.close();
						window.parent.location.reload();
					},1000);
				}else{
					layer.msg('添加失败!');
				}
			},
			error:function(){
				alert("添加失败");
			}
		});
	}
}
 

 
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>