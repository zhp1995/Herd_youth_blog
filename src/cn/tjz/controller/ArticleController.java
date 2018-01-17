package cn.tjz.controller;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.google.gson.JsonObject;
import com.sdicons.json.mapper.JSONMapper;
import com.sdicons.json.mapper.MapperException;
import com.sdicons.json.model.JSONValue;

import cn.tjz.domain.Article;
import cn.tjz.domain.Catelogy;
import cn.tjz.service.ArticleService;
import cn.tjz.util.PageModel;

@Controller
@RequestMapping("/article")
public class ArticleController {
   
	@Autowired
	private ArticleService articleService;
	
	/**
	 * 首页获取所有文章
	 * @param pageModel
	 * @return
	 */
	@RequestMapping("/selectArticle")
	@ResponseBody
	public String selectAll(PageModel pageModel,Model model,Article article,String startTime,String endTime){
		String data = null;
		try {
		   PageInfo<Article> articles = this.articleService.selectByCondition(pageModel, article,startTime,endTime);
		   
		   JSONValue json = JSONMapper.toJSON(articles);
		   data = json.render(true);
		   
		} catch (Exception e) {
           e.printStackTrace();
		}
		return data;
	}
	

	
	/**
	 * 跳转到文章详情页
	 * @return
	 */
	@RequestMapping("/toDetails")
	public String toDetail(String article_id,Model model){
		Article article = this.articleService.getArticleDetail(article_id);
		model.addAttribute("article",article);
		return "details";
	}
	
	/**
	 * 跳转到分类
	 * @return
	 */
	@RequestMapping("/toCatelogy")
	public String toCatelogy(Model model){
		List<Catelogy> catelogys = this.articleService.getCatelogy();
		model.addAttribute("catelogys",catelogys);
		return "techblog";
	}
	
	/**
	 * 跳转到分类文章
	 * @param catelogy
	 * @return
	 */
	@RequestMapping("/getCatelogyArticle")
	public String catelogyArticle(String catelogy,Model model){
	    model.addAttribute("catelogy",catelogy);
		return "blogs";
	}
	
	
	/**
	 * 加载左侧标签分类
	 * @return
	 */
	@RequestMapping("/getCatelogyAjax")
	@ResponseBody
	public String getCatelogyAjax(){
		String catelogysJson = null;
		try {
			List<Catelogy> catelogys = this.articleService.getCatelogy();
			JSONValue json = JSONMapper.toJSON(catelogys);
			catelogysJson = json.render(true);
		} catch (MapperException e) {
			e.printStackTrace();
		}
		return catelogysJson;
	}
	
	
	/**
	 * 热门推荐
	 * @param catelogy
	 * @return
	 */
	@RequestMapping("/getHotArticle")
	@ResponseBody
	public String hotArticle(){
		String jsonArticle = null;
	    try {
			List<Article> recommendArticle = this.articleService.getRecommendArticle();
			JSONValue json = JSONMapper.toJSON(recommendArticle);
			jsonArticle = json.render(true);
		} catch (Exception e) {
            e.printStackTrace();
		}
		return jsonArticle;
	}
	
	/**
	 * 点赞
	 * @return
	 */
	@RequestMapping("/zan")
	@ResponseBody
	public String zan(String article_id,String flag){	 
		try {
			this.articleService.zan(article_id, flag);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";  
	}
	
	
	
	/**TODO ##################################### 系统后台  ###################################################### TODO*/
	
	/**
	 * 跳转到后台文章列表
	 * @return
	 */
	@RequestMapping("/admin/toArticleList")
	public String toArticleList(){	 
		return "admin/article-list";
	}
	
	/**
	 * 跳转到添加后台文章
	 * @return
	 */
	@RequestMapping("/admin/toAddArticle")
	public String toAddArticle(){	 
		return "admin/article-add";
	}
	
	/**
	 * 添加后台文章
	 * @return
	 */
	@RequestMapping(value = "/admin/addArticle",method=RequestMethod.POST)
	@ResponseBody
	public String addArticle(Article article){
		JsonObject jb = new JsonObject();
		String flag = null;
		try {
			this.articleService.addArticle(article);
			jb.addProperty("state", "1");
		} catch (Exception e) {
			e.printStackTrace();
			jb.addProperty("state", "2");
		}
		flag = jb.toString();
		return flag;
	}
	
	/**
	 * 跳转到编辑后台文章
	 * @return
	 */
	@RequestMapping("/admin/toEditArticle")
	public String toEditArticle(String article_id,Model model){	 
		try {
			Article ar = this.articleService.getArticleDetail(article_id);
			model.addAttribute("article",ar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin/article-edit";
	}
	
	/**
	 * 编辑后台文章
	 * @return
	 */
	@RequestMapping("/admin/editArticle")
	@ResponseBody
	public String editArticle(Article article){	 
		JsonObject jb = new JsonObject();
		String flag = null;
		try {
			this.articleService.modifyArticle(article);
			jb.addProperty("state", "1");
		} catch (Exception e) {
			e.printStackTrace();
			jb.addProperty("state", "2");
		}
		flag = jb.toString();
		return flag;
	}
	
	
	/**
	 * 删除后台文章
	 * @return
	 */
	@RequestMapping("/admin/delArticle")
	@ResponseBody
	public String delArticle(String[] ids){	
		try {
			this.articleService.deleteArticle(ids);
		} catch (Exception e) {
			e.printStackTrace();
			return "failure";
		}
		return "success";
	}
	
	/**
	 * 后台ajax请求分类列表
	 * @return
	 */
	@RequestMapping("/admin/getCatelogy")
	@ResponseBody
	public String getCatelogy(){	 
		String jsonCatelogys = null;
		try {
			List<Catelogy> catelogys = this.articleService.getCatelogy();
			JSONValue json = JSONMapper.toJSON(catelogys);
			jsonCatelogys = json.render(true);
		} catch (MapperException e) {
			e.printStackTrace();
		}
		return jsonCatelogys;  
	}
	
	
	
	
	
}
