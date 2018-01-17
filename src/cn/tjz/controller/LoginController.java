package cn.tjz.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tjz.service.UserService;
/**
 * 博主后台登录控制层
 * @author tjz
 *
 */
@Controller
@RequestMapping("/admin")
public class LoginController {

	@Autowired
	private UserService userService;
	
	/**
	 * 跳转到登录界面
	 * @return
	 */
	@RequestMapping(value = "/toLogin")
	public String toLogin() {
        return "admin/login";
	}
	
	/**
	 * 登录(ajax提交)
	 * @return
	 */
	@RequestMapping(value = "login")
	@ResponseBody
	public String login(HttpServletRequest request,HttpServletResponse response,String usercode,String password,String verfiyCode){
		try {
			String data = this.userService.login(request, usercode, password, verfiyCode);
		    return data;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 跳转到登录界面
	 * @return
	 */
	@RequestMapping(value = "/loginout")
	public String loginout(HttpServletRequest request) {
		try {
			request.getSession().invalidate();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "admin/login";
	}

}
