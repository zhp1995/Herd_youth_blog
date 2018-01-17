package cn.tjz.domain;

import java.io.Serializable;

public class Catelogy implements Serializable {
 
	private static final long serialVersionUID = 3931049870729423344L;

	private String catelogy;
	
	private Integer num;

	/**  setter and getter method **/
	public String getCatelogy() {
		return catelogy;
	}

	public void setCatelogy(String catelogy) {
		this.catelogy = catelogy;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	@Override
	public String toString() {
		return "Catelogy [catelogy=" + catelogy + ", num=" + num + "]";
	}
	
	
	
}
