package com.yr.entity;

/**
 * 学生对象
 * 
 * @author zxy-un
 * 
 * 2018年7月23日 下午8:18:10
 */
public class Student {

	private int id;
	private int age;
	private String sex;
	private String name;
	private String addr;

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	@Override
	public String toString() {
		return "Student [id=" + id + ", age=" + age + ", sex=" + sex + ", name=" + name + ", addr=" + addr + "]";
	}

}
