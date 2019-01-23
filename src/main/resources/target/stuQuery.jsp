<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="<%=request.getContextPath()%>/js/jquery-1.8.0.js"></script>
<title>Insert title here</title>
</head>
<body>
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
			<a href='<%=request.getContextPath()%>/stuAdd.jsp'>添&nbsp;加&nbsp;学&nbsp;生</a>
			<br/>
			<c:forEach items="${list }" var="a">
				${a.id }
				${a.name }
				${a.sex }
				${a.age }
				${a.addr }
				<br/>
			</c:forEach>
			<tr id="pageTr"></tr>
			<%-- <tr>
				<td width="199">当前为第${page.currentPage}页,共${page.totalPage}页</td>
				<td width="256" colspan="3" align="center">
				    <c:choose>
				        <c:when test="${page.hasPrePage}">
				            <a href="<%=request.getContextPath %>/user.do?method=list&currentPage=1">首页</a> | 
				   			<a href="<%=request.getContextPath %>/user.do?method=list&currentPage=${page.currentPage -1 }">上一页</a>
				        </c:when>
				        <c:otherwise>
							首页 | 上一页
				        </c:otherwise>
				    </c:choose>
				    <c:choose>
				        <c:when test="${page.hasNextPage}">
				            <a href="<%=request.getContextPath %>/user.do?method=list&currentPage=${page.currentPage + 1 }">下一页</a> | 
				    		<a href="<%=path %>/user.do?method=list&currentPage=${page.totalPage }">尾页</a>
				        </c:when>
				        <c:otherwise>
							下一页 | 尾页
				        </c:otherwise>
				    </c:choose>
				</td>
			</tr> --%>
		</table>
	</div>
</body>
<script type="text/javascript">

	$(document).ready(function(){ // 页面加载完成后出现
		sel();
		/* page(); */
	}); 
	
	function sel() {
		$.ajax({
			type : "get",
			url : '<%=request.getContextPath()%>/sel',
			dataType:"json",
			success : function(list) {
				alert(list);
				var dataObj = list;
				//var dataObj = eval("(" + list + ")"); // eval()函数: 转换为json对象 (注：list为json的数据 -- 如果已经是json格式就不需要转)
				var html = "";
				for(var i in dataObj){
					if(dataObj[i].sex == 1){
						html += "<tr><td align='center'>"+dataObj[i].id+"</td>"+
						"<td  align='center'>"+dataObj[i].name+"</td>"+
						"<td  align='center'>"+'男'+"</td>"+
						"<td  align='center'>"+dataObj[i].age+"</td>"+
						"<td  align='center'>"+dataObj[i].addr+"</td>"+
						"<td  align='center'>"+
						<%-- "<input type='button' value='添加' onclick=\"javascript:location.href='<%=request.getContextPath()%>/stuAdd.jsp'\">"+ --%>
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
						<%-- "<input type='button' value='添加' onclick=\"javascript:location.href='<%=request.getContextPath()%>/stuAdd.jsp'\">"+ --%>
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
						<%-- "<input type='button' value='添加' onclick=\"javascript:location.href='<%=request.getContextPath()%>/stuAdd.jsp'\">"+ --%>
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
	
	<%-- function page() {
		$.ajax({
			type : "get",
			url : '<%=request.getContextPath()%>/cont',
			dataType:"json",
			success : function(list) {
				var dataObj = list;
				var html = "";
				for(var i in dataObj){
					html += "<td width='199'>当前为第${page.currentPage}页,共${page.totalPage}页</td>"+
								"<td width='256' colspan='3' align='center'><c:choose>"+
								"<c:when test='${page.hasPrePage}'>"+
									"<a href='<%=request.getContextPath %>/soy?method=list&currentPage=1'>首页</a> |"+ 
									"<a href='<%=request.getContextPath %>/soy?method=list&currentPage=${page.currentPage -1 }'>上一页</a>"+
								"</c:when><c:otherwise> 首页 | 上一页 </c:otherwise>"+
								"</c:choose><c:choose><c:when test='${page.hasNextPage}'>"+
									"<a href='<%=request.getContextPath %>/soy?method=list&currentPage=${page.currentPage + 1 }'>下一页</a> |"+ 
									"<a href='<%=path %>/soy?method=list&currentPage=${page.totalPage }'>尾页</a>"+
								"</c:when> <c:otherwise> 下一页 | 尾页 </c:otherwise>"+
							"</c:choose></td>"
				}
				$('#pageTr').append(html);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status+","+XMLHttpRequest.readyState+","+textStatus);
            }
		})
	} --%>


	function mssdel(id){
		if(confirm("是否删除id为' "+id+" '的信息?")){
			$.ajax({  
				url:'<%=request.getContextPath()%>/del/'+id,
	            type:'POST',
	            dataType:"json",
	            success:function(data){  
					if (data.aaa == "success") {
						alert("删除成功");
						window.location.replace("<%=request.getContextPath()%>/stuQuery.jsp");
					}else{
						alert("删除失败");
					}
	            }  
	        })
		}	
	}
	
</script>
</html>