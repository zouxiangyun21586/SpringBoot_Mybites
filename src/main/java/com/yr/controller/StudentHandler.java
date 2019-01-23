package com.yr.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yr.entity.Page;
import com.yr.entity.Student;
import com.yr.service.StudentService;

@Controller
public class StudentHandler {
	
	@Autowired
	private StudentService stuService;
	private List<Student> listStudent;
	
	@RequestMapping("/testJsp")
	public String aa(Map<String, Object> map){
		return "stuQuery";
	}
	
	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String add(Student stu, ModelMap mm, HttpServletResponse response, HttpServletRequest request) { // 添加
		Page<Student> page = new Page<Student>();
		Boolean boo = stuService.ins(stu);
		String mark = null;
		if (boo) {
			page = sel(response,request);
			mm.addAttribute("list", page);
			mark = "success";
		} else {
			mark = "error";
		}
		return mark;
	}
	
	@ResponseBody
	@RequestMapping(value="del/{id}",method=RequestMethod.POST)
	public String del(@PathVariable Integer id, ModelMap mm, HttpServletResponse response, HttpServletRequest request) { // 删除
		Page<Student> page = new Page<Student>();
		Boolean bool = stuService.del(id);
		String mark  = null;
		if (bool) {
			page = sel(response,request);
			mm.addAttribute("list", page);
			mark = "{\"aaa\":\"success\"}";
		}else{
			mark = "{\"aaa\":\"error\"}";
		}
		return mark;
	}
	
	@RequestMapping("{id}/get")
	public String get(@PathVariable Integer id, ModelMap mm) { // 修改回显
		listStudent = stuService.sel(id);
		mm.addAttribute("list", listStudent);
		return "stuUpd";
	}
	
	@RequestMapping(value="/upd",method=RequestMethod.POST)
	public @ResponseBody Map<String,Object> upd(Student stu, ModelMap mm, HttpServletResponse response, HttpServletRequest request) { // 修改
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			Page<Student> page = new Page<Student>();
			Boolean bool = stuService.upd(stu);
			if (bool) {
				page = sel(response,request);
				mm.addAttribute("list", page);
				map.put("aaa","success");
			}else{
				mm.addAttribute("err",1);
				map.put("aaa","error");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("aaa","aaa");
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selNameQuery", method = RequestMethod.GET)
	public Page<Student> selName(HttpServletResponse response,HttpServletRequest request) { // 搜索查询
		String name = request.getParameter("name");
		Page<Student> page = new Page<Student>();
		String pageNow = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");
		int startIndex = page.getPageSize() * (page.getPage()-1);
		page.setStartIndex(startIndex);
		if (pageNow != null && !"".equals(pageNow)) {
			page.setPage(Integer.valueOf(pageNow));
			page.setPageSize(Integer.valueOf(pageSize));
			startIndex = page.getPageSize() * (Integer.valueOf(pageNow)-1);
			page.setStartIndex(startIndex);
		}
		Student stu = new Student();
		stu.setName(name);
		int count = stuService.getContName(stu); // 学生总数
		page.setPageSizeCount(count);
		page.setT1(stu);
		listStudent = stuService.selName(page);
		page.setT(listStudent);
		return page;
	}
	
	@RequestMapping(value="/pageSel",method=RequestMethod.GET)
	public @ResponseBody Page<Student> sel(HttpServletResponse response,HttpServletRequest request) {
		Page<Student> page = new Page<Student>();
		String pageNow = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");
		int startIndex = page.getPageSize() * (page.getPage()-1);
		page.setStartIndex(startIndex);
		if (pageNow != null && !"".equals(pageNow)) {
			page.setPage(Integer.valueOf(pageNow));
			page.setPageSize(Integer.valueOf(pageSize));
			startIndex = page.getPageSize() * (Integer.valueOf(pageNow)-1);
			page.setStartIndex(startIndex);
		}
		int count = stuService.getCont(); // 学生总数
		page.setPageSizeCount(count);
		listStudent = stuService.select(page);
		page.setT(listStudent);
		return page;
	}
	
}
