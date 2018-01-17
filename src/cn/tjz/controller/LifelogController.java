package cn.tjz.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.github.pagehelper.PageInfo;
import com.google.gson.JsonObject;
import com.sdicons.json.mapper.JSONMapper;
import com.sdicons.json.mapper.MapperException;
import com.sdicons.json.model.JSONValue;

import cn.tjz.domain.Article;
import cn.tjz.domain.Lifelog;
import cn.tjz.service.LifelogService;
import cn.tjz.util.PageModel;

@Controller
@RequestMapping("/lifelog")
public class LifelogController {

	@Autowired
	private LifelogService lifelogService;

	/**
	 * 获取生活日志
	 * 
	 * @return
	 */
	@RequestMapping("/getLifelog")
	@ResponseBody
	public String getLifelog(PageModel pageModel) {
		String jsonLifelogs = null;
		try {
			PageInfo<Lifelog> lifelogs = this.lifelogService.getAllLifelogByTime(pageModel);
			JSONValue json = JSONMapper.toJSON(lifelogs);
			jsonLifelogs = json.render(true);
		} catch (MapperException e) {
			e.printStackTrace();
		}
		return jsonLifelogs;
	}

	/** TODO #################### 后台生活日志 ################################ **/

	/**
	 * 跳转到后台生活日志
	 * 
	 * @return
	 */
	@RequestMapping("/admin/toLifelog")
	public String toLifelog() {
		return "admin/lifelog-list";
	}
	
	/**
	 * 跳转到添加后台生活日志
	 * 
	 * @return
	 */
	@RequestMapping("/admin/toAddLifelog")
	public String toAddLifelog() {
		return "admin/lifelog-add";
	}
	
	/**
	 * 添加后台生活日志
	 * 
	 * @return
	 */
	@RequestMapping(value = "/admin/addLifelog",method=RequestMethod.POST)
	@ResponseBody
	public String addLifelog(Lifelog lifelog) {
		JsonObject jb = new JsonObject();
		try {
			this.lifelogService.addLifeLog(lifelog);
			jb.addProperty("state","1");
		} catch (Exception e) {
			e.printStackTrace();
			jb.addProperty("state","2");
		}
		return jb.toString();
	}
	
	/**
	 * 跳转到编辑后台生活日志
	 * 
	 * @return
	 */
	@RequestMapping("/admin/toEditLifelog")
	public String toEditLifelog(String log_id,Model model) {
		try {
			Lifelog lifelog = this.lifelogService.getSingleLifelog(log_id);
			model.addAttribute("lifelog",lifelog);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/lifelog-edit";
	}
	
	/**
	 * 编辑后台文章
	 * @return
	 */
	@RequestMapping("/admin/editLifelog")
	@ResponseBody
	public String editLifelog(Lifelog lifelog){	 
		JsonObject jb = new JsonObject();
		String flag = null;
		try {
			this.lifelogService.editLifelog(lifelog);
			jb.addProperty("state", "1");
		} catch (Exception e) {
			e.printStackTrace();
			jb.addProperty("state", "2");
		}
		flag = jb.toString();
		return flag;
	}
	
	/**
	 * 删除后台生活日志
	 * @return
	 */
	@RequestMapping("/admin/delLifelog")
	@ResponseBody
	public String delLifelog(String[] ids){	
		try {
			this.lifelogService.delLifeLog(ids);
		} catch (Exception e) {
			e.printStackTrace();
			return "failure";
		}
		return "success";
	}

	/**
	 * 多个图片上传
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "uploader")
	@ResponseBody
	public String uploader(HttpServletRequest request, HttpServletResponse response) {

		MultipartHttpServletRequest Murequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = Murequest.getFileMap();// 得到文件map对象
		
		
		 
		StringBuilder sb = new StringBuilder();
		int count = 0;
		String realName = null;
		File tagetFile = null;
		
		String upaloadUrl=request.getServletContext().getRealPath("/WEB-INF/pic/lifelog/");
		
		for (MultipartFile file : files.values()) {
			count++;
			String fileName = file.getOriginalFilename();
			String suffix = fileName.substring(fileName.lastIndexOf("."));
			realName = UUID.randomUUID().toString() + suffix;
            // 注意一定要用分割符，否则读取不了文件
			tagetFile = new File(upaloadUrl+File.separator+realName);// 创建文件对象
			if (!tagetFile.exists()) {// 文件名不存在 则新建文件，并将文件复制到新建文件中
				try {
					tagetFile.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
				try {
					file.transferTo(tagetFile);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			// 拼接返回图片名
			sb.append(count==1?realName:","+realName);
		}
		return "{\"pics\":\""+sb.toString()+"\"}";
	}
}
