package cn.tjz.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import redis.clients.jedis.ShardedJedis;
import redis.clients.jedis.Tuple;
import cn.tjz.domain.Article;
import cn.tjz.domain.Catelogy;
import cn.tjz.exception.BlogException;
import cn.tjz.mapper.ArticleMapper;
import cn.tjz.service.ArticleService;
import cn.tjz.util.MyShardedJedisPool;
import cn.tjz.util.PageModel;

@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	private ArticleMapper articleMapper;

	/**
	 * 添加文章
	 * 
	 * @param article
	 */
	public void addArticle(Article article) {
		try {
			String article_id = UUID.randomUUID().toString();
			article.setArticleId(article_id);
			article.setDate(new Date());
			//添加默认浏览量和访问量
			ShardedJedis shardedJedis = MyShardedJedisPool.getShardedJedis();
			shardedJedis.zadd("article-readSum",article.getReadSum(),article_id);
			shardedJedis.zadd("article-goodSum",article.getGoodSum(),article_id);
			//插入数据库
			this.articleMapper.insertSelective(article);
		} catch (Exception e) {
			System.out.println(e);
			throw new BlogException("文章管理：添加文章出现异常");
		}
	}

	/**
	 * 修改文章
	 * 
	 * @param article
	 */
	public void modifyArticle(Article article) {
		try {
			article.setDate(new Date());
			
			// 修改浏览量和点赞量
			ShardedJedis shardedJedis = MyShardedJedisPool.getShardedJedis();
			shardedJedis.zadd("article-readSum",article.getReadSum(),article.getArticle_id());
			shardedJedis.zadd("article-goodSum",article.getGoodSum(),article.getArticle_id());
			 
			this.articleMapper.updateByPrimaryKey(article);
		} catch (Exception e) {
			System.out.println(e);
			throw new BlogException("文章管理：修改文章出现异常");
		}
	}

	/**
	 * 根据id删除文章
	 * 
	 * @param articleId
	 */
	public void deleteArticle(String[] ids) {
		try {
			System.out.println(ids[0]);
			ShardedJedis shardedJedis = MyShardedJedisPool.getShardedJedis();
			for (int i = 0; i < ids.length; i++) {
				// 删除redis的访问量
				shardedJedis.zrem("article-readSum", ids[i]+"");
				shardedJedis.zrem("article-goodSum", ids[i]+"");
			}
			this.articleMapper.delArticles(ids);
		} catch (Exception e) {
			System.out.println(e);
			throw new BlogException("文章管理：根据id删除文章出现异常");
		}
	}
	

    /**
     * 获取单个文章
     * @param articleId
     */
	public Article getArticleDetail(String  articleId) {
		try {
			Article ar = new Article();
			ar.setArticleId(articleId);
			Article article = this.articleMapper.selectOne(ar);
		    ShardedJedis shardedJedis = MyShardedJedisPool.getShardedJedis();
			// 浏览文章时访问量+1
			shardedJedis.zincrby("article-readSum", 1, articleId);
			Double readsum = shardedJedis.zscore("article-readSum",articleId);
			Double goodsum = shardedJedis.zscore("article-goodSum",articleId);
		    if(readsum==null) readsum = 0.0;
		    if(goodsum==null) goodsum = 0.0;		  
			article.setReadSum(readsum.intValue());
			article.setGoodSum(goodsum.intValue());
			return article;
		} catch (Exception e) {
			System.out.println(e);
			throw new BlogException("文章管理：根据id查找单个文章出现异常");
		}
	}
	
    

    /**
     * 根据条件查找文章
     */
	public PageInfo<Article> selectByCondition(PageModel pageModel,Article ar,String startTime,String endTime){
    	try {
    		PageHelper.startPage(pageModel.getPageIndex(),pageModel.getPageSize());
    		Example example = new Example(Article.class);
    		example.setOrderByClause("date desc");
    		Criteria cc = example.createCriteria();
    		if(StringUtils.isNotEmpty(ar.getCatelogy())){
    			if(!ar.getCatelogy().equals("0"))  cc.andEqualTo("catelogy",ar.getCatelogy());
    		} 
    		if(StringUtils.isNotEmpty(ar.getTitle())) cc.andLike("title","%"+ar.getTitle()+"%");
    		if(StringUtils.isNotEmpty(startTime) && StringUtils.isNotEmpty(endTime)){
    			cc.andBetween("date",startTime,endTime);
    		}
    		
			List<Article> articles = this.articleMapper.selectByExample(example);
				
			// 添加阅读量
			ShardedJedis shardedJedis = MyShardedJedisPool.getShardedJedis();
			for(Article article:articles){
				Double readsum = shardedJedis.zscore("article-readSum",article.getArticle_id());
				Double goodsum = shardedJedis.zscore("article-goodSum",article.getArticle_id());
				if(readsum==null) readsum = 0.0;
			    if(goodsum==null) goodsum = 0.0;		  
				article.setReadSum(readsum.intValue());
				article.setGoodSum(goodsum.intValue());
			}
			
			PageInfo<Article> pageInfo = new PageInfo<Article>(articles);
			return pageInfo;
		} catch (Exception e) {
			System.out.println(e);
			throw new BlogException("文章管理：根据条件查找文章出现异常");
		}
    }

	/**
     * 获取文章分类
     * @return
     */
    public List<Catelogy> getCatelogy(){
    	try {
			return this.articleMapper.getCatelogy();
		} catch (Exception e) {
			System.out.println(e);
			throw new BlogException("文章管理：获取文章分类时章出现异常");
		}
    }
    
    
    /**
     * 获取热门推荐文章(获取点击量前6的文章)
     * @return
     */
    public List<Article> getRecommendArticle(){
    	try {
			List<Article> articles = new ArrayList<Article>();
			Article ar = new Article();
			Set<Tuple> rang = MyShardedJedisPool.getShardedJedis().zrevrangeWithScores("article-readSum",0,5);
			for (Tuple tuple : rang) {
				 ar.setArticleId(tuple.getElement());
				 articles.add(this.articleMapper.selectOne(ar));
			}
			return articles;
		} catch (Exception e) {
			System.out.println(e);
			throw new BlogException("文章管理：获取热门推荐文章出现异常");
		}
    }
    
    /**
     * 为指定文章点赞
     * 1 点赞    
     * 2 取消赞
     */
    public void zan(String article_id,String flag){
    	try {
			ShardedJedis shardedJedis = MyShardedJedisPool.getShardedJedis();
			if(flag.equals("1")){
				shardedJedis.zincrby("article-goodSum",1,article_id);
			}
			if(flag.equals("2")){
				shardedJedis.zincrby("article-goodSum",-1,article_id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
}
