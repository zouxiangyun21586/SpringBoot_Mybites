<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<%=request.getContextPath()%>/js/jquery-1.8.0.js"></script>
<title>修改数据</title>
</head>
<body>
	<div align="center">
		<form id="fo">
			<c:forEach var="ms" items="${list}">
				<input type="hidden" name="id" value="${ms.getId()}" id="id" />
				<table>
					<tr>
						<th>
							名字:<input type="text" name="name" id="name" value="${ms.getName()}" />
						</th>
					</tr>
					<tr>
						<th id="sex"><input id="sexID" value="${ms.getSex()}" type="hidden"/></th>
					</tr>
					<tr>
						<th id="age"><input id="age" name="age" value="${ms.getAge()}" type="text"/></th>
					</tr>
					<tr>
						<th id="addr"><input id="addr" name="addr" value="${ms.getAddr()}" type="text"/></th>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="reset" value="重置">
							<input type="submit" value="提交" id="sub" />
							<input type="button" value="返回" onclick="back()" />
						</td>
					</tr>
				</table>
			</c:forEach>
		</form>
		<input type="hidden" value="${err}" id="err"/>
	</div>
</body>
<script type="text/javascript">
	var errVar = document.getElementById("err").value;
	
	$(document).ready(function(){ // 页面加载完成后出现
		var sex = $("#sexID").val();
		var html = "";
		if (sex==1) {
			html += "性别:   <input type='radio' name='sex' id='id' value='1' checked='checked'>男"+
					"&nbsp;&nbsp;&nbsp;<input type='radio' name='sex' id='id' value='0' >女</input>"
		} else if(sex==0) {
			html += "性别:   <input type='radio' name='sex' id='id' value='0' checked='checked'>女"+
					"&nbsp;&nbsp;&nbsp;<input type='radio' name='sex' id='id' value='1' >男</input>"
		} else if(sex == '男') {
			html += "性别:   <input type='radio' name='sex' id='id' value='1' checked='checked'>男"+
			"&nbsp;&nbsp;&nbsp;<input type='radio' name='sex' id='id' value='0' >女</input>"
		} else if(sex == '女') {
			html += "性别:   <input type='radio' name='sex' id='id' value='0' checked='checked'>女"+
			"&nbsp;&nbsp;&nbsp;<input type='radio' name='sex' id='id' value='1' >男</input>"
		}
		$('#sex').html(html);
	}); 
	
	if(1 == errVar) {
		alert("输入错误,请重新输入");
		window.history.back();
	}
	
	$(function(){
		$("#sub").click(function(){
			pageLoad();
		})
	})
	
	function pageLoad(){
		var id = $("#id").val();
		var name = $("#name").val();
		var sex = $("input[type=radio][name=sex]:checked");
		var age = $("#age").val();
		var addr = $("#addr").val();
		if(isNaN(age)) { // 如果其中带有字母等特殊符号会进入
			alert("请输入正确的年龄");
			window.location.replace("<%=request.getContextPath()%>/id/get");
		} else {
			$.ajax({
				type: "post",
				url : '<%=request.getContextPath()%>/upd',
				data : $("#fo").serialize(), // 序列化
				dataType:"json",
				timeout : 50000, //超时时间：50秒
				success : function(mark) {
					if (mark.aaa == "success") {
						alert("修改成功");
						window.location.replace("<%=request.getContextPath()%>/testJsp");
					} else{
						alert("修改失败");
						window.location.replace("<%=request.getContextPath()%>/testJsp");
					}
				},error: function(XMLHttpRequest, textStatus, errorThrown) {
	                alert(XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
	            }
			})
		}
	}
	
	function back(){
		window.history.back();
	}
</script>
</html>