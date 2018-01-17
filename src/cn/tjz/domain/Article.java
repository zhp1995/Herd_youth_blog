package cn.tjz.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
@Table(name="article")
public class Article implements Serializable{

	private static final long serialVersionUID = 9119119696350546495L;
    //文章编号
	@Id
	private String article_id;
	//分类
	private String catelogy;
	//标题
	private String title;
	//前言
	private String introduction;
	//内容
	private String content;
	//发布时间
	private Date date;
	//标题图片路径
	private String pic;
	//阅读量
	@Transient
	private int readSum;
	//点赞数
	@Transient
	private int goodSum;
	
	
	/**  setter and getter method  */
	public String getArticle_id() {
		return article_id;
	}
	public void setArticleId(String article_id) {
		this.article_id = article_id;
	}
	public String getCatelogy() {
		return catelogy;
	}
	public void setCatelogy(String catelogy) {
		this.catelogy = catelogy;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public int getReadSum() {
		return readSum;
	}
	public void setReadSum(int readSum) {
		this.readSum = readSum;
	}
	public int getGoodSum() {
		return goodSum;
	}
	public void setGoodSum(int goodSum) {
		this.goodSum = goodSum;
	}
	@Override
	public String toString() {
		return "Article [article_id=" + article_id + ", catelogy=" + catelogy
				+ ", title=" + title + ", introduction=" + introduction
				+ ", content=" + content + ", date=" + date + ", pic=" + pic
				+ ", readSum=" + readSum + ", goodSum=" + goodSum + "]";
	}
	
}
