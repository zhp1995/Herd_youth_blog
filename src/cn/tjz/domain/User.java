package cn.tjz.domain;
import java.io.Serializable;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
 
/**
 * 用户实体
 * @author tjz
 */

/**
 * 1.表名默认使用类名,驼峰转下划线,如UserInfo默认对应的表名为user_info.
   2.表名可以使用@Table(name = "tableName")进行指定,对不符合第一条默认规则的可以通过这种方式指定表名.
   3.字段默认和@Column一样,都会作为表字段,表字段默认为Java对象的Field名字驼峰转下划线形式.
   4.可以使用@Column(name = "fieldName")指定不符合第3条规则的字段名
   5.使用@Transient注解可以忽略字段,添加该注解的字段不会作为表字段使用.
   6.建议一定是有一个@Id注解作为主键的字段,可以有多个@Id注解的字段作为联合主键.
   7.默认情况下,实体类中如果不存在包含@Id注解的字段,所有的字段都会作为主键字段进行使用(这种效率极低).
 *  
 *
 *  
 *  使用序列可以添加如下的注解:
		//可以用于数字类型,字符串类型(需数据库支持自动转型)的字段
		@SequenceGenerator(name="Any",sequenceName="seq_userid")
		@Id
		private Integer id;

	使用UUID时:
		//可以用于任意字符串类型长度超过32位的字段
		@GeneratedValue(generator = "UUID")
		private String countryname;
		
	使用主键自增:
		//不限于@Id注解的字段,但是一个实体类中只能存在一个(继承关系中也只能存在一个)
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Integer id;
 */
@Table(name = "user")
public class User implements Serializable {

	private static final long serialVersionUID = -6949324477336170511L;
	
	/** USER_ID VARCHAR2(50) 用户ID PK，大小写英文和数字  （唯一）*/
	@Id
	private String usercode;
	
	/** 姓名 */
	private String username;
	
	/** 密码 MD5加密 */
	private String password;
	
	/** 加盐 */
	private String salt;

	/**  setter and getter method*/
	public String getUsercode() {
		return usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

}