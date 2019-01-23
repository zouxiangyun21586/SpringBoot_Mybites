package com.yr.service;

import java.util.List;

import com.yr.entity.Page;
import com.yr.entity.Student;

/**
 * 学生 Service 接口
 * @author zxy-un
 * 
 * 2018年7月23日 下午8:26:25
 */
public interface StudentService {
	public Boolean ins(Student stu);

	public Boolean del(Integer id);

	public Boolean upd(Student stu);

	public List<Student> sel(Integer id); // 条件查询(修改回显)

	public List<Student> query(); // 查询所有
	
	public int getCont();
	
	public int getContName(Student student);
	
	public List<Student> getName(Student student);
	
	public List<Student> select(Page<Student> page);
	
	public List<Student> selName(Page<Student> page);
}
