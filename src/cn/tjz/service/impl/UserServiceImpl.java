package cn.tjz.service.impl;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import cn.tjz.domain.User;
import cn.tjz.exception.BlogException;
import cn.tjz.mapper.UserMapper;
import cn.tjz.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	/**
	 * 登录
	 */
	@Override
	public String login(HttpServletRequest request, String usercode,
			String passwd, String vcode) {
		try {
			/** 定义提示信息 */
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("tip", "验证码不正确！");
			jsonObject.put("status", "1");

			/** 判断验证码 */
			String oldCode = (String) request.getSession().getAttribute("verify_code");
			
			if(StringUtils.isNotEmpty(vcode)){
				/** 验证码正确 */
				if (oldCode != null && oldCode.equalsIgnoreCase(vcode)) {
					/** 判断用户名与密码是否为空 */
					if (!StringUtils.isEmpty(usercode) && !StringUtils.isEmpty(passwd)) {
						/** 查询用户 */
						User user = this.userMapper.selectByPrimaryKey(usercode);
						if (user != null) {
							if (user.getPassword()
									.equals(DigestUtils.md5DigestAsHex((passwd+user.getSalt()).getBytes()))) {
								/** 登录成功 */
								jsonObject.put("tip", "登录成功！");
								jsonObject.put("status", "0");
								/** 放入session  */
								request.getSession().setAttribute("user",user);
								
							} else {
								jsonObject.put("tip", "用户名或密码不正确！");
								jsonObject.put("status", "4");
							}
						} else {
							jsonObject.put("tip", "用户名或密码不正确！");
							jsonObject.put("status", "4");
						}
					} else {
						jsonObject.put("tip", "用户名或密码为空！");
						jsonObject.put("status", "3");
					}
				}
			}else{
				jsonObject.put("tip", "验证码为空！");
				jsonObject.put("status", "2");
			}
			
			/** 返回提示信息 */
			return jsonObject.toString();
		} catch (Exception ex) {
			throw new BlogException("后台用户：登录异常");
		}
	}

	/**
	 * 添加用户
	 */
	@Override
	public void addUser(User user) {
		try {
			String uuid = UUID.randomUUID().toString();
			user.setSalt(uuid);
			user.setPassword(DigestUtils.md5DigestAsHex((user.getPassword() + uuid)
					.getBytes()));
			this.userMapper.insertSelective(user);
		} catch (Exception e) {
			throw new BlogException("后台用户：添加用户出现异常");
		}
	}

	/**
	 * 修改用户
	 */
	@Override
	public void modifyUser(User user) {
		try {
			String uuid = UUID.randomUUID().toString();
			user.setSalt(uuid);
			user.setPassword(DigestUtils.md5DigestAsHex((user.getPassword() + uuid)
					.getBytes()));
			this.userMapper.updateByPrimaryKeySelective(user);
		} catch (Exception e) {
			throw new BlogException("后台用户：修改用户出现异常");
		}
	}

	/**
	 * 根据主键获取单个用户
	 */
	public User getUserByUsercode(String usercode) {
		try {
			return this.userMapper.selectByPrimaryKey(usercode);
		} catch (Exception e) {
			throw new BlogException("后台用户：获取单个用户出现异常");
		}
	}

	@Override
	public void deleteUser(String usercode) {
		try {
			this.userMapper.deleteByPrimaryKey(usercode); 
		} catch (Exception e) {
			throw new BlogException("后台用户：删除用户出现异常");
		}
	}

	@Override
	public List<User> findAll() {
		try {
			return this.userMapper.selectByExample(new User());
		} catch (Exception e) {
		    throw new BlogException("后台用户：获取所有的用户");
		}
	}

}
