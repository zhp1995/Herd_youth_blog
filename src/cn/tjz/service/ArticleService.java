package cn.tjz.service;

import java.util.List;

import cn.tjz.domain.Article;
import cn.tjz.domain.Catelogy;
import cn.tjz.util.PageModel;

import com.github.pagehelper.PageInfo;


public interface ArticleService {

	/**
	 * 添加文章
	 * @param article
	 */
	public void addArticle(Article article);

	/**
	 * 修改文章
	 * @param article
	 */
    public void modifyArticle(Article article);
    
    /**
     * 根据id删除文章
     * @param articleId
     */
    public void deleteArticle(String[] ids);
    
    /**
     * 获取单个文章
     * @param articleId
     */
    public Article getArticleDetail(String  articleId);
    
    /**
     * 根据条件查找文章
     */
    public PageInfo<Article> selectByCondition(PageModel pageModel,Article article,String startTime,String endTime);
    
    /**
     * 获取分类
     * @return
     */
    public List<Catelogy> getCatelogy();
    
    /**
     * 获取热门推荐文章
     * @return
     */
    public List<Article> getRecommendArticle();
    
    /**
     * 点赞功能
     * @param flag
     */
    public void zan(String article_id,String flag);
    
    

}
