package cn.tjz.mapper;

import org.apache.ibatis.annotations.Param;

import cn.tjz.domain.Lifelog;

import com.github.abel533.mapper.Mapper;

public interface LifelogMapper  extends Mapper<Lifelog>{

	/**
	 * 批量删除日志
	 * @param ids
	 */
	public void delLifelogs(@Param("ids")String[] ids);
	
}
