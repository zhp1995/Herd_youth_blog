package cn.tjz.service;
 
import com.github.pagehelper.PageInfo;

import cn.tjz.domain.Lifelog;
import cn.tjz.util.PageModel;

/**
 * 生活日志
 * @author tjz
 *
 */
public interface LifelogService {
	
	/**
	 * 获取所有生活日志（按时间倒叙）
	 * @return
	 */
	public PageInfo<Lifelog> getAllLifelogByTime(PageModel pageModel);
	
	/**
	 * 得到单个生活日志
	 * @param log_id
	 * @return
	 */
	public Lifelog getSingleLifelog(String log_id);
	
    /**
     * 添加生活日志
     * @param lifelog
     */
	public void addLifeLog(Lifelog lifelog);
	
	/**
	 * 删除生活日志
	 * @param ids
	 */
	public void delLifeLog(String[] ids);
	
	/**
	 * 编辑生活日志
	 * @param ids
	 */
	public void editLifelog(Lifelog lifelog);
    	
}
