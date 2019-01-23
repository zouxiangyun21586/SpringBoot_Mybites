<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<%=request.getContextPath()%>/js/jquery-1.8.0.js"></script>
<style type="text/css">

	#ashow {  
		display:none;  
		border:1em solid pink;
		height:50%;  
		width:24%;  
		position:absolute;/*让节点脱离文档流,我的理解就是,从页面上浮出来,不再按照文档其它内容布局*/  
		top:20%;/*节点脱离了文档流,如果设置位置需要用top和left,right,bottom定位*/  
		left:35%;  
		z-index:2;/*个人理解为层级关系,由于这个节点要在顶部显示,所以这个值比其余节点的都大*/  
		background: white;  
	}
	
	#aover,#hid {  
		width: 100%;  
		height: 100%;  
		opacity:0.3;/*设置背景色透明度,1为完全不透明,IE需要使用filter:alpha(opacity=80);*/  
		filter:alpha(opacity=80);  
		display: none;  
		position:absolute;  
		top:0;  
		left:0;  
		z-index:1;  
		background: silver;  
	}

	a{ text-decoration:none;}
	/* css注释： 鼠标经过热点文字被加下划线 */ 
	a:hover{ text-decoration:underline;}
	/* a 标签字体颜色为 黑色 */
	a{color:#000}
</style>
<title>查询信息</title>
</head>
<body>
	<div align="center">
		<form id="queryName">
			<input type="text" placeholder="请输入要搜索的学生姓名" name="name" id="selName">
			<input type="button" value="搜索" id="sousuo">
		</form>
	</div>

	<div align="center">
		<table border="1" cellpadding="0" cellspacing="0">
			<tr>
				<th>编号</th>
				<th>名字</th>
				<th>性别</th>
				<th>年龄</th>
				<th>地址</th>
				<th>操作</th>
			</tr>
			<tbody id="lo"></tbody>
		</table>
		<br/>
		<a href="javascript:void(0)" onclick="sel(1)" id="shouye" >首页</a>
		<a href="javascript:void(0)" onclick="sel(2)" id="shang">上页</a>
		<a href="javascript:void(0)" onclick="sel(3)" id="xia">下页</a>
		<a href="javascript:void(0)" onclick="sel(4)" id="weiye">尾页</a>
		<select id="pageSizeId" onchange="sel(5)">
			<option value="2">2</option>
			<option value="4">4</option>
			<option value="10">10</option>
			<option value="20">20</option>
		</select>
		<br>
		总记录数：<span id="pageSizeCountId"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		总页数：<span id="pageCountId"></span>       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		当前页：<span id="pageId"></span>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<br/>
		<a href="javascript:add_show()">添&nbsp;加&nbsp;学&nbsp;生</a>
		<form id="fo">
			<div id="ashow">
				<div align="right">
					<button>
						<a href="javascript:add_hide()">&nbsp;X&nbsp;</a>
					</button>
				</div> 
				<div align="center">
					<p align="left">添加</p>
					姓名: <input type="text" name="name" id="name" placeholder="请在这里输入学生名" /><br/>
					性别: <input type="radio" name="sex" id="sex" value="1"/>男&nbsp;&nbsp;&nbsp;<input type="radio" name="sex" id="sex" value="0"/>女<br/>
					年龄: <input type="text" name="age" id="age" placeholder="请输入年龄" /><br/>
					地址: <input type="text" name="addr" id="addr" placeholder="请输入家庭地址" /><br/>
					<input name="sub" type="submit" id="sub"/>
					<input name="res" type="reset" id="res"/>
					<input type="button" value="返回" onclick="back()" />
				</div>
			</div>
			<div id="aover"></div>
		</form>
	</div>
	
</body>
<script type="text/javascript">

	$(document).ready(function(){ // 页面加载完成后出现
		sel();
	});
	
	var ars = document.getElementById('ashow');
	var aro = document.getElementById('aover');
	function add_show()
	{  
		ars.style.display = "block";
	    aro.style.display = "block";
	}  
	function add_hide()
	{  
	    ars.style.display = "none";
	    aro.style.display = "none";
	}

	function sel(mark) {
		
		var pageSize = "";
		var page = "";
		if (mark == 1) {
			pageSize = $("#pageSizeId").val();
			page = 1;
		} else if (mark == 2){
			pageSize = $("#pageSizeId").val();
			var pageCount = $("#pageId").text();
			page = (parseInt(pageCount)-1);
			
		} else if (mark == 3){
			pageSize = $("#pageSizeId").val();
			var pageCount = $("#pageId").text();
			page = (parseInt(pageCount)+1);
		} else if (mark == 4){
			pageSize = $("#pageSizeId").val();
			page = $("#pageCountId").text();
		} else if (mark == 5){
			pageSize = $("#pageSizeId").val();
			page = 1;
		}
		
		var selName = $("#selName").val();
		if(selName != ""){ // 如果搜索框中有值,代表正在使用,分页时只会显示模糊查询出来的值
			$.ajax({
				type: "get",
				url : '<%=request.getContextPath()%>/selNameQuery',
				data : $("#queryName").serialize(), // 序列化
				dataType:"json",
				data:{pageSize:pageSize,page:page,name:selName},
				success : function(parameter) {
					$("#lo").empty(); // 如果不清空会一直追加
					var dataObj = parameter.t;
					var emptying = "";
					
					$("#pageSizeCountId").text(parameter.pageSizeCount);
					$("#pageCountId").text(parameter.pageCount);
					$("#pageId").text(parameter.page);
					$("#pageSizeId").val(parameter.pageSize);
					
					if(parameter.page == 1){
						$("#shang").hide();
						$("#shouye").hide();
					}else{
						$("#shang").show();
						$("#shouye").show();
					}
					
					if(parameter.page == parameter.pageCount){
						$("#xia").hide();
						$("#weiye").hide();
					}else{
						$("#xia").show();
						$("#weiye").show();
					}
					
					for(var i in dataObj){
						if(dataObj[i].sex == 1){
							emptying += "<tr><td align='center'>"+dataObj[i].id+"</td>"+
							"<td  align='center'>"+dataObj[i].name+"</td>"+
							"<td  align='center'>"+'男'+"</td>"+
							"<td  align='center'>"+dataObj[i].age+"</td>"+
							"<td  align='center'>"+dataObj[i].addr+"</td>"+
							"<td  align='center'>"+
							"<input type='button' value='修改' onclick=\"javascript:location.href='<%=request.getContextPath()%>/"+dataObj[i].id+"/get'\">"+
							"<input type='button' value=\"删除\"onclick=mssdel('"+dataObj[i].id+"')>"+
							"</td></tr>";
						}else if(dataObj[i].sex == 0){
							emptying += "<tr><td align='center'>"+dataObj[i].id+"</td>"+
							"<td  align='center'>"+dataObj[i].name+"</td>"+
							"<td  align='center'>"+'女'+"</td>"+
							"<td  align='center'>"+dataObj[i].age+"</td>"+
							"<td  align='center'>"+dataObj[i].addr+"</td>"+
							"<td  align='center'>"+
							"<input type='button' value='修改' onclick=\"javascript:location.href='<%=request.getContextPath()%>/"+dataObj[i].id+"/get'\">"+
							"<input type='button' value=\"删除\"onclick=mssdel('"+dataObj[i].id+"')>"+
							"</td></tr>";
						}else{
							emptying += "<tr><td align='center'>"+dataObj[i].id+"</td>"+
							"<td  align='center'>"+dataObj[i].name+"</td>"+
							"<td  align='center'>"+dataObj[i].sex+"</td>"+
							"<td  align='center'>"+dataObj[i].age+"</td>"+
							"<td  align='center'>"+dataObj[i].addr+"</td>"+
							"<td  align='center'>"+
							"<input type='button' value='修改' onclick=\"javascript:location.href='<%=request.getContextPath()%>/"+dataObj[i].id+"/get'\">"+
							"<input type='button' value=\"删除\"onclick=mssdel('"+dataObj[i].id+"')>"+
							"</td></tr>"
						} 
					}
					$('#lo').html(emptying);
				},error: function(XMLHttpRequest, textStatus, errorThrown) {
	                alert(XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
	            }
			})
		} else {
			$.ajax({
				type : "get",
				url : '<%=request.getContextPath()%>/pageSel',
				dataType:"json",
				data:{pageSize:pageSize,page:page},
				success : function(parameter) {
					$("#lo").empty(); // 如果不清空会一直追加
					
					var dataObj = parameter.t;
					var html = "";
					
					$("#pageSizeCountId").text(parameter.pageSizeCount);
					$("#pageCountId").text(parameter.pageCount);
					$("#pageId").text(parameter.page);
					$("#pageSizeId").val(parameter.pageSize);
					
					if(parameter.page == 1){
						$("#shang").hide();
						$("#shouye").hide();
					}else{
						$("#shang").show();
						$("#shouye").show();
					}
					
					
					if(parameter.page == parameter.pageCount){
						$("#xia").hide();
						$("#weiye").hide();
					}else{
						$("#xia").show();
						$("#weiye").show();
					}
					
					for(var i in dataObj){
						if(dataObj[i].sex == 1){
							html += "<tr><td align='center'>"+dataObj[i].id+"</td>"+
							"<td  align='center'>"+dataObj[i].name+"</td>"+
							"<td  align='center'>"+'男'+"</td>"+
							"<td  align='center'>"+dataObj[i].age+"</td>"+
							"<td  align='center'>"+dataObj[i].addr+"</td>"+
							"<td  align='center'>"+
							"<input type='button' value='修改' onclick=\"javascript:location.href='<%=request.getContextPath()%>/"+dataObj[i].id+"/get'\">"+
							"<input type='button' value=\"删除\"onclick=mssdel('"+dataObj[i].id+"')>"+
							"</td></tr>";
						}else if(dataObj[i].sex == 0){
							html += "<tr><td align='center'>"+dataObj[i].id+"</td>"+
							"<td  align='center'>"+dataObj[i].name+"</td>"+
							"<td  align='center'>"+'女'+"</td>"+
							"<td  align='center'>"+dataObj[i].age+"</td>"+
							"<td  align='center'>"+dataObj[i].addr+"</td>"+
							"<td  align='center'>"+
							"<input type='button' value='修改' onclick=\"javascript:location.href='<%=request.getContextPath()%>/"+dataObj[i].id+"/get'\">"+
							"<input type='button' value=\"删除\"onclick=mssdel('"+dataObj[i].id+"')>"+
							"</td></tr>";
						}else{
							html += "<tr><td align='center'>"+dataObj[i].id+"</td>"+
							"<td  align='center'>"+dataObj[i].name+"</td>"+
							"<td  align='center'>"+dataObj[i].sex+"</td>"+
							"<td  align='center'>"+dataObj[i].age+"</td>"+
							"<td  align='center'>"+dataObj[i].addr+"</td>"+
							"<td  align='center'>"+
							"<input type='button' value='修改' onclick=\"javascript:location.href='<%=request.getContextPath()%>/"+dataObj[i].id+"/get'\">"+
							"<input type='button' value=\"删除\"onclick=mssdel('"+dataObj[i].id+"')>"+
							"</td></tr>"
						} 
					}
					$('#lo').append(html);
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
	                alert(XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
	            }
			})
		}
	}
	
	function mssdel(id){
		if(confirm("是否删除id为' "+id+" '的信息?")){
			$.ajax({  
				url:'<%=request.getContextPath()%>/del/'+id,
	            type:'POST',
	            dataType:"json",
	            success:function(data){  
					if (data.aaa == "success") {
						alert("删除成功");
						window.location.replace("<%=request.getContextPath()%>/testJsp");
					}else{
						alert("删除失败");
					}
	            }  
	        })
		}	
	}
	
	$(function(){
		$("#sub").click(function(){
			pageLoad();
		})
	})
	
	function pageLoad(){
		var name = $("#name").val();
		var sex = $("input[type=radio][name=sex]:checked");
		var age = $("#age").val();
		var addr = $("#addr").val();
		if(name == "" || age == "" || addr == ""){
			alert("请输入值!");
			window.close();
		} else if(sex.length <= 0){ // 如果没有选择,那么长度等于 0 
			alert("请选择性别!");
			window.close();
		} else if(isNaN(age)) { // 如果其中带有字母等特殊符号会进入
			alert("请输入正确的年龄");
		} else {
			$.ajax({
				type: "post",
				url : '<%=request.getContextPath()%>/add',
				data : $("#fo").serialize(), // 序列化 serializeArray
				dataType:"json",
				success : function(mark) {
					if (mark == "success") {
						alert("添加成功");
						window.location.replace("<%=request.getContextPath()%>/testJsp");
					} else{
						alert("添加失败");
					}
				},error: function(XMLHttpRequest, textStatus, errorThrown) {
	                alert(XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
	            }
			})
		}
	}
	
	function back() {
		window.history.back();
	}
	
	$(function(){
		$("#sousuo").click(function(){
			sel();
		})
	})
	
</script>
</html>