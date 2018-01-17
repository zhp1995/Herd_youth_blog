package cn.tjz.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
@Table(name="lifelog")
public class Lifelog implements Serializable{
 
	private static final long serialVersionUID = 5476352091780067733L;

	@Id
	private String log_id;
	private String content;
	private String pic;
	private String pics;
	private Date date;
	@Transient
	private List<String> picsName;
	
	/** setter and getter method **/
	public String getLog_id() {
		return log_id;
	}
	public void setLogId(String log_id) {
		this.log_id = log_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getPics() {
		return pics;
	}
	public void setPics(String pics) {
		this.pics = pics;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
	public List<String> getPicsName() {
		return picsName;
	}
	public void setPicsName(List<String> picsName) {
		this.picsName = picsName;
	}
	
	@Override
	public String toString() {
		return "Lifelog [log_id=" + log_id + ", content=" + content + ", pic="
				+ pic + ", pics=" + pics + ", date=" + date + ", picsName="
				+ picsName + "]";
	}
	 
}
