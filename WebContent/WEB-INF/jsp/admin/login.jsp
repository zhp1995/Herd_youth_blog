<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html >
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1" charset="utf-8">
<title>登录</title>
<link rel="stylesheet" href="${path}/css/login.css" />
<link rel="stylesheet" href="${path}/css/animate.css" /> 
<script src="${path}/bootstrap3.2.0/front/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="${path}/js/lib/layer/2.4/layer.js"></script>
<script src="${path}/js/wow.min.js"></script>
<script>new WOW().init();</script>
<script> 
	$(function(){
	    /** 为验证码看不清楚绑定点击事件 */
		$("#see").click(function(){
			/** 让验证码变一下 */
			$("#vimg").attr("src", "${path}/verfiyCode/getVerfiyCode.shtml?random=" + Math.random());
		});  
	    
		/** 为验证码图片绑定onmouseover与onclick事件 */
		$("#vimg").mouseover(function(){
			$(this).css("cursor", "pointer");
		}).click(function(){
			/** 事件触发 */
			$("#see").trigger("click");
		});
		
		/** 监听用户按了回车键 */
		$(document).keydown(function(event){
			if (event.keyCode == 13){
				/** 触发登录按钮的点击事件 */
				$(".loginSubmit").trigger("click");
			}
		});
		
		/** 登录 */
		$(".loginSubmit").click(function(){
			var usercode = $("#usercode");
			var password = $("#password");
			var verfiyCode = $("#verfiyCode");
			 
			var msg = "";
			if ($.trim(usercode.val()) == ""){
				msg = "用户名不能为空！"; 
				usercode.focus();
			}else if ($.trim(password.val()) == ""){
				msg = "密码不能为空！";
				password.focus();
			}else if ($.trim(verfiyCode.val()) == ""){
				msg = "验证码不能为空！";
				verfiyCode.focus();
			} 
			 
			if (msg != ""){
				layer.msg(msg);
			}else{
				var dd = $("#user-login").serialize();
			 
				$.ajax("${path}/admin/login.shtml",{
					type:"post",
					data:dd,
					dataType:"json",
					async:false,
					success:function(data){
						if(data.status=="0"){
							 //登录成功
							 location.href = "${path}/admin/main.shtml"
						}else{
							layer.msg(data.tip);
						}
					},
					error:function(){
						alert("登录失败");
					}
				});
			}
		});
	 })  
</script>
</head>
<body>
	<div id="main">
	 	<span class="back-to-index"><a style="text-decoration:none;" href="${path}/index.shtml">返回首页</a></span>
		<div class="login-box wow fadeIn">
			<h2 style="color:black">后台登录</h2>
			<form id="user-login" action="" method="post" >
				<p>
					<label>账号：</label>
					<input type="text" placeholder="请输入你的账号" name="usercode" id="usercode"/>
			   </p>
			   <p>
					<label>密码：</label>
					<input type="password" placeholder="密码" name="password" id="password"/>
			   </p>
			   <p>
			   		<label>验证码：</label> 
			   		<input type="text"  name="verfiyCode" id="verfiyCode" />
			   		<span class="pic"><img src="${path}/verfiyCode/getVerfiyCode.shtml" width="73" height="28" title="看不清，请点我" id="vimg"/></span>
			   		<a  style="text-decoration:none;" href="#" id="see">换张图</a>
			  </p>
			  <!--错误提示  -->
			  <c:if test="${errormsg!=null}">
			    <p class="errormsg">
			  		*&nbsp;&nbsp;账号错误
			    </p>
			  </c:if>
			  <p>
			  		<button type="reset">重置</button>
			 		<button type="button" class="loginSubmit">登录</button>
			  </p>
			</form>
		</div>
	</div>
</body>
</html>

 