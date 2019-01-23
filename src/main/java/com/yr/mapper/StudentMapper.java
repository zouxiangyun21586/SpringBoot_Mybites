package com.yr.mapper;

import java.util.List;

import com.yr.entity.Page;
import com.yr.entity.Student;

/**
 * 学生 Mapper 接口
 * @author zxy-un
 * 
 * 2018年7月23日 下午8:19:51
 */
public interface StudentMapper {
	public void ins(Student student); // 插入

	public void del(Integer id); // 删除

	public void upd(Student student); // 修噶

	public List<Student> sel(Integer id); // 条件查询(修改回显)

	public List<Student> query(); // 查询所有
	
	public int getCont();
	
	public int getContName(Student student);
	
	public List<Student> getName(Student student); // 模糊查询
	
	public List<Student> select(Page<Student> page); // 分页查询所有
	
	public List<Student> selName(Page<Student> page); // 分页条件查询
}
