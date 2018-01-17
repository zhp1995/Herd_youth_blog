package cn.tjz.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 * 日期处理类
 * @author LEE.SIU.WAH
 * @email lixiaohua7@163.com
 * @date 2016年1月21日 下午4:18:41
 * @version 1.0
 */
public class DateTag extends SimpleTagSupport {
	
	private Date value;
	
 
	public void doTag() throws JspException, IOException {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String datetime = df.format(value);
		this.getJspContext().getOut().print(datetime);
	}

	
	/** setter and getter method */
	public Date getValue() {
		return value;
	}

	public void setValue(Date value) {
		if(value==null)
			this.value = new Date();
		else 
			this.value = value;
	}
	
}
