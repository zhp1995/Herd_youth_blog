package cn.tjz.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.tjz.domain.Lifelog;
import cn.tjz.exception.BlogException;
import cn.tjz.mapper.LifelogMapper;
import cn.tjz.service.LifelogService;
import cn.tjz.util.PageModel;
/**
 * 生活日志业务层
 * @author tjz
 *
 */
@Service
public class LifelogServiceImpl implements LifelogService {

	@Autowired
	private LifelogMapper lifelogMapper;

	/**
	 * 获取所有生活日志
	 */
	public PageInfo<Lifelog> getAllLifelogByTime(PageModel pageModel){
		try {
			Example example = new Example(Lifelog.class);
			example.setOrderByClause("date desc");
			PageHelper.startPage(pageModel.getPageIndex(), pageModel.getPageSize());
			List<Lifelog> lifelogs = this.lifelogMapper.selectByExample(example);
			// 加载多图、切分
			for (Lifelog lifelog : lifelogs) {
				List<String> names = new ArrayList<String>();
				String[] split = lifelog.getPics().split(",");
				for (String name : split) {
					names.add(name);
				}
				lifelog.setPicsName(names);
			}
			
			PageInfo<Lifelog> pageInfo = new PageInfo<Lifelog>(lifelogs);
			return pageInfo;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BlogException("获取生活日志出现异常");
		}
	} 
	
	/**
	 * 得到单个生活日志
	 * @param log_id
	 * @return
	 */
	public Lifelog getSingleLifelog(String log_id){
		try {
			List<String> names = new ArrayList<String>();
			Lifelog ll = this.lifelogMapper.selectByPrimaryKey(log_id);
			String[] split = ll.getPics().split(",");
			for (int i = 0; i < split.length; i++) {
				names.add(split[i]);
			}
			ll.setPicsName(names);
			return ll;
		} catch (Exception e) {
			e.printStackTrace();
			throw new BlogException("得到单个生活日志出现异常");
		}
	}
	
	/**
	 * 添加生活日志
	 * @param lifelog
	 */
	public void addLifeLog(Lifelog lifelog){
		try {
			String log_id = UUID.randomUUID().toString();
			lifelog.setLogId(log_id);
			lifelog.setDate(new Date());
			this.lifelogMapper.insert(lifelog);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BlogException("添加生活日志出现异常");
		}
	}
	
	/**
	 * 删除生活日志
	 */
	public void delLifeLog(String[] ids){
		try {
			this.lifelogMapper.delLifelogs(ids);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BlogException("删除生活日志出现异常");
		}
	}
	
	/**
	 * 编辑生活日志
	 * @param ids
	 */
	public void editLifelog(Lifelog lifelog){
		try {
			lifelog.setDate(new Date());
			this.lifelogMapper.updateByPrimaryKey(lifelog);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BlogException("删除生活日志出现异常");
		}
	}
}
