package cn.tjz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.tjz.domain.User;
import cn.tjz.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping("/findAll")
	public String findAll(Model model){
		try {
			List<User> users = this.userService.findAll();
			model.addAttribute("users",users);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@RequestMapping("/add")
	public String add(User user){
		try {
			this.userService.addUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	@RequestMapping("/modify")
	public String modify(User user){
		try {
			this.userService.modifyUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	
	@RequestMapping("/delete")
	public String delete(String usercode){
		try {
			this.userService.deleteUser(usercode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
}
