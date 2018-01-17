package cn.tjz.controller;
import java.io.File;
import java.io.FileInputStream;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

@Controller
@RequestMapping("/")
public class IndexController {

	/**
	 * 跳转到首页
	 * @return
	 */
	@RequestMapping("/index")
	public String index(){
		return "index";
	}
	
	/**
	 * 生活日志
	 * @return
	 */
	@RequestMapping("/lifelog")
	public String lifelog(){
		return "lifelog";
	}
	
	/**
	 * 关于我
	 * @return
	 */
	@RequestMapping("/aboutme")
	public String aboutme(){
		return "aboutme";
	}
	
	/**
	 * 获取图片
	 * @param picName
	 * @param response
	 * @param sc
	 */
	@RequestMapping("/getPic")
	public void getPic(String picName,HttpServletResponse response,HttpServletRequest request){
		 try{
			 /**  getRealPath直接从项目名开始拼接查找，getResourceAsStream只能获取src下的，顶级目录是class文件夹 */
			 ServletContext sc = request.getServletContext();
			 String path = sc.getRealPath("/WEB-INF/pic/"+picName);
			 FileInputStream is=new FileInputStream(new File(path));
			 
			 response.setHeader("contentType","image/jpeg");
             ServletOutputStream os = response.getOutputStream();
             byte[] buff=new byte[1024];
             int i;
             while((i=is.read(buff))!=-1){
                   os.write(buff);            	 
             }
             os.flush();
             is.close();
             os.close();
		 } catch (Exception e) {
             e.printStackTrace();
		}
	}
	
	/**
	 * 获取ueditor编辑器图片
	 * @param picName
	 * @param response
	 * @param sc
	 */
	@RequestMapping("/getUeditorPic")
	public void getUeditorPic(String picName,HttpServletResponse response,HttpServletRequest request){
		 try{
			 /**  getRealPath直接从项目名开始拼接查找，getResourceAsStream只能获取src下的，顶级目录是class文件夹 */
			 ServletContext sc = request.getServletContext();
			 String path = sc.getRealPath("/WEB-INF/pic/article/"+picName);
			 FileInputStream is=new FileInputStream(new File(path));
			 
			 response.setHeader("contentType","image/jpeg");
             ServletOutputStream os = response.getOutputStream();
             byte[] buff=new byte[1024];
             int i;
             while((i=is.read(buff))!=-1){
                   os.write(buff);            	 
             }
             os.flush();
             is.close();
             os.close();
		 } catch (Exception e) {
             e.printStackTrace();
		}
	}
	
	/**
	 * 获取生活日志多个图片
	 * @param picName
	 * @param response
	 * @param sc
	 */
	@RequestMapping("/getLifelogPics")
	public void getLifelogPics(String picName,HttpServletResponse response,HttpServletRequest request){
		 try{
			 /**  getRealPath直接从项目名开始拼接查找，getResourceAsStream只能获取src下的，顶级目录是class文件夹 */
			 ServletContext sc = request.getServletContext();
			 String path = sc.getRealPath("/WEB-INF/pic/lifelog/"+picName);
			 FileInputStream is=new FileInputStream(new File(path));
			 
			 response.setHeader("contentType","image/jpeg");
             ServletOutputStream os = response.getOutputStream();
             byte[] buff=new byte[1024];
             int i;
             while((i=is.read(buff))!=-1){
                   os.write(buff);            	 
             }
             os.flush();
             is.close();
             os.close();
		 } catch (Exception e) {
             e.printStackTrace();
		}
	}
	
	/**
	 * 获取编辑器附件
	 * @return
	 */
	@RequestMapping("/getUEditorAttachment")
	public void getUEditorAttachment(HttpServletRequest request,HttpServletResponse response,String attachmentName,String realAttachmentName){
		try {
			String path = request.getServletContext().getRealPath("/WEB-INF/attachment/"+attachmentName);
			FileInputStream fis=new FileInputStream(new File(path));
			

			/** 根据浏览器设置文件名编码 */
			String userAgent = request.getHeader("user-agent");
			String encoding="utf-8";
			if(userAgent.toLowerCase().indexOf("trident")!=-1){
				encoding="gbk";
			}
			
			realAttachmentName =new String(realAttachmentName.getBytes(encoding),"iso-8859-1");
			response.setHeader("Content-disposition","attachment;filename="+realAttachmentName);
			ServletOutputStream fos = response.getOutputStream();
			/** 往浏览器输出  */
			byte[] buff=new byte[1024];
			int len;
			while((len=fis.read(buff))!=-1){
				fos.write(buff, 0,len);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 图片上传
	 * @param picFile
	 * @return
	 */
	@RequestMapping("/uploadPic")
	@ResponseBody
	public String uploadPic(@RequestParam(value = "picFile", required = true) MultipartFile picFile,HttpServletRequest request){
		JsonObject jb = null;
		try {
			String picName = picFile.getOriginalFilename();
			// 加上随机数的文件名
			String fileName=UUID.randomUUID().toString() + picName.substring(picName.lastIndexOf("."));
			String path=request.getServletContext().getRealPath("/WEB-INF/pic");
			//持久化保存
			File newFile = new File(path+File.separator+fileName);
			picFile.transferTo(newFile);
			
			//转换成Json输出
			jb=new JsonObject();
			jb.addProperty("url",request.getContextPath()+"/getPic.shtml?picName="+fileName);
			jb.addProperty("path",fileName);
			 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jb.toString();
	}
	
	/**
	 * 删除图片
	 * @return
	 */
	@RequestMapping("/delPic")
	@ResponseBody
	public String delPic(String picName,HttpServletRequest request){
		try {
			String path = request.getServletContext().getRealPath("/WEB-INF/pic");
			File f = new File(path+File.separator+picName);
			f.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
}
