package cn.tjz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 后台控制层
 * @author tjz
 *
 */
@RequestMapping("/admin")
@Controller
public class AdminIndexController {
    
	/**
	 * 主界面
	 * @return
	 */
	@RequestMapping("/main")
	public String main(){
		return "admin/main";
	}
	
	
	
	
	 
}
