package cn.tjz.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.tjz.domain.Article;
import cn.tjz.domain.Catelogy;

import com.github.abel533.mapper.Mapper;

public interface ArticleMapper extends Mapper<Article> {

	/**
	 * 获取分类
	 * @return
	 */
	public List<Catelogy> getCatelogy();
	
	 
	/**
	 * 批量删除文章
	 * @param ids
	 */
	public void delArticles(@Param("ids")String[] ids);
}
