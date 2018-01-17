package cn.tjz.util;

import org.springframework.util.DigestUtils;

public class test {
	public static void main(String[] args) {
		System.out.println(DigestUtils.md5DigestAsHex(("aa"+"123456").getBytes()));
	}
}
