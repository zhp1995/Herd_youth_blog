package cn.tjz.util;

/**
 * 分页实体
 * @author tjz
 */
public class PageModel {
	
	/** 定义每页的记录数大小  */
	public static final int PAGE_SIZE=4;
	
	/** 当前页码 */
	private int pageIndex;
	/** 每页显示的数量 */
	private int pageSize;
	/** 总记录条数 */
	private int recordCount;
	
	/** setter and getter method */
	public int getPageIndex() {
		this.pageIndex = pageIndex <=1 ? 1 : pageIndex;
	    int totalPage=(getRecordCount()-1)/getPageSize()+1;
	    return pageIndex >= totalPage ? totalPage : this.pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageSize() {
		return pageSize <=0 ? PAGE_SIZE : pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getRecordCount() {
		return recordCount;
	}
	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}
	/** limit的第一个问号 */
	public int getStartRow(){
		return (getPageIndex()-1)*getPageSize();
	}
}