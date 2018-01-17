package cn.tjz.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import cn.tjz.domain.User;

/**
 * 用户业务层
 * @author tjz
 *
 */
public interface UserService {
	 /**
	  * 登录
	  * @param usercode
	  * @param passwd
	  * @param vcode
	  * @return
	  */
    public String login(HttpServletRequest request,String usercode,String passwd,String vcode);
    
    /**
     * 添加用户
     * @param user
     */
    public void addUser(User user);
    
    /**
     * 修改用户
     * @param user
     */
    public void modifyUser(User user);
    
    /**
     * 删除用户
     * @param usercode
     */
    public void deleteUser(String usercode);
    
    /**
     * 通过主键获取单个用户
     * @return
     */
    public User getUserByUsercode(String usercode);
    
    /**
     * 获取所有用户
     * @return
     */
    public List<User> findAll();
   	
    	
}
