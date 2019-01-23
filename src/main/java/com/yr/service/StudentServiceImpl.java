package com.yr.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.yr.entity.Page;
import com.yr.entity.Student;
import com.yr.mapper.StudentMapper;

@Service
public class StudentServiceImpl implements StudentService{

	@Autowired
	@Qualifier("studentMapper")
	private StudentMapper stuMapper; // 注入 mybatis 接口
	
	@Override
	public Boolean ins(Student stu) {
		try{
			if (stu.getName().equals("") || stu.getAddr().equals("") || stu.getSex().equals("") || stu.getAddr().equals("")){
				return false;
			} else if (stu.getName() == null || stu.getAddr() == null || stu.getSex() == null || stu.getAddr() == null ) {
				return false;
			} else {
				stuMapper.ins(stu);
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Boolean del(Integer id) {
		try{
			stuMapper.del(id);
			return true;
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Boolean upd(Student stu) {
		try{
			if (stu.getName().equals("") || stu.getAddr().equals("") || stu.getSex().equals("") || stu.getAddr().equals("")){
				return false;
			} else if (stu.getName() == null || stu.getAddr() == null || stu.getSex() == null || stu.getAddr() == null ) {
				return false;
			} else {
				stuMapper.upd(stu);
				return true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<Student> sel(Integer id) {
		return stuMapper.sel(id);
	}

	@Override
	public List<Student> query() {
		return stuMapper.query();
	}

	@Override
	public int getCont() {
		int i = stuMapper.getCont();
		return i;
	}

	@Override
	public List<Student> selName(Page<Student> page) {
		if(page.getT().equals("") || page.getT() == null){
			return null;
		}
		return stuMapper.selName(page);
	}

	@Override
	public List<Student> select(Page<Student> page) {
		List<Student> listStudent = new ArrayList<>();
		listStudent = stuMapper.select(page);
		return listStudent;
	}

	@Override
	public int getContName(Student student) {
		int i = stuMapper.getContName(student);
		return i;
	}

	@Override
	public List<Student> getName(Student student) {
		return stuMapper.getName(student);
	}

}
