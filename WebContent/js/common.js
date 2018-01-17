
$(function(){
//				//导航菜单
//				var $li=$("#menu ul li");
//				$li.click(function(){
//					var i=$(this).index();
//					$li.eq(i).addClass('nav-active')
//							 .siblings().removeClass('nav-active');
//					
//				});
//				
				//翻页
				var $blog = $('#blogPage>div');
				var L = $blog.length;
				$("#first").css('background', '#E1EDF7');
				for (var i = 6; i <= L; i++) {
					$blog.eq(i).hide();
				}
				$('#second,#next').click(function(e) {
					e.preventDefault();
					$blog.fadeToggle();
					$("#second").css('background', '#E1EDF7');
					$("#first").css('background', '#fff');
				});
				$('#first,#prev').click(function(e) {
					e.preventDefault();
					$blog.fadeToggle();
					$("#first").css('background', '#E1EDF7');
					$("#second").css('background', '#fff');
				});
				
	
				//鼠标滚动
				$(window).scroll(function() {
					if($(window).scrollTop()>100){
						$(".sidebar").fadeIn(500);
					}else{
						$(".sidebar").fadeOut(500);
						}
					});
				$(".wx-share").hover(function(){
					$(".QR-code").fadeIn(500);
				},function(){
					$(".QR-code").fadeOut(500);
				});
	 			$(".return-top").click(function(){
	 				$('body,html').animate({scrollTop:0},1000);
	 				return false;
	  			});	
	 			
	 			
	 		
})
			
			
			
			
			
			
			
			