<%@page import="common.DBCon"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
window.onload = function(){
	var search_type = '<%=request.getParameter("search_type")%>';
	var di_num = '<%=request.getParameter("di_num")%>';
	var di_name = '<%=request.getParameter("di_name")%>';
	var em_name = '<%=request.getParameter("em_name")%>';
	if(em_name!='null'){
		document.querySelector('#em_name').value = em_name;
	}
	document.querySelector('[name=search_type][value='+search_type+']').checked = true;
	document.querySelector('#di_num').value = di_num;
	document.querySelector('#di_name').value = di_name;
	checkSearchType(document.querySelector('[name=search_type]:checked'));
}
function checkSearchType(obj){
	document.querySelector('#di_num').style.display='none';
	document.querySelector('#di_name').style.display='none';
	document.querySelector('#' + obj.value).style.display='';
}
</script>
<form>
<input type="radio" name="search_type" id="type1" value="di_num" checked onchange="checkSearchType(this)">
<label for="type1">선택</label>
<input type="radio" name="search_type" id="type2" value="di_name" onchange="checkSearchType(this)">
<label for="type2">검색</label>
부서명 : <select name="di_num" id="di_num">
<option value="">부서선택</option>
<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try{
	con = DBCon.getCon();
	String sql = "select * from depart_info order by di_code";
	ps = con.prepareStatement(sql);
	rs = ps.executeQuery();
	while(rs.next()){
%>
	<option value="<%=rs.getString("di_code")%>">
		<%=rs.getString("di_name")%>
	</option>
<%	
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(rs!=null){
		rs.close();
	}
	if(ps!=null){
		ps.close();
	}
	if(con!=null){
		con.close();
	}
}
%>
</select>
<input type="text" name="di_name" id="di_name" style="display:none;"><br>
사원명 : <input type="text" name="em_name" id="em_name"><br>
<button>검색</button>
</form>
<table border="1">
	<tr>
		<th>사원번호</th>
		<th>사원명</th>
		<th>부서코드</th>
		<th>사원아이디</th>
		<th>입사일</th>
		<th>부서명</th>
	</tr>

<%
try{
	con = DBCon.getCon();
	String sql = "select em.em_num, em.em_name, em.di_num, em.em_id, em.credat, di.di_name\r\n" + 
			"from employee em\r\n" + 
			"left join depart_info di\r\n" + 
			"on em.di_num = di.di_code where 1=1";
	String emName = request.getParameter("em_name");
	String diNum = request.getParameter("di_num");
	String diName = request.getParameter("di_name");
	if(emName!=null && !"".equals(emName)){
		sql += " and em_name=?";
	}
	if(diNum!=null && !"".equals(diNum)){
		sql += " and di_code=?";
	}
	if(diName!=null && !"".equals(diName)){
		sql += " and di_name like '%' || ? || '%'";
	}
	ps = con.prepareStatement(sql);
	if(emName!=null && !"".equals(emName)){
		ps.setString(1, emName);
	}
	if(diNum!=null && !"".equals(diNum)){
		if(emName!=null && !"".equals(emName)){
			ps.setString(2, diNum);
		}else{
			ps.setString(1, diNum);
		}
	}else if(diName!=null && !"".equals(diName)){
		if(emName!=null && !"".equals(emName)){
			ps.setString(2, diName);
		}else{
			ps.setString(1, diName);
		}
	}
	rs = ps.executeQuery();
	boolean hashRow = false;
	while(rs.next()){
		hashRow = true;
%>
	<tr>
		<td><%=rs.getString("em_num")%></td>
		<td><%=rs.getString("em_name")%></td>
		<td><%=rs.getString("di_num")%></td>
		<td><a href="/em-view.jsp?em_num=<%=rs.getString("em_num")%>"><%=rs.getString("em_id")%></a></td>
		<td><%=rs.getString("credat")%></td>
		<td><%=rs.getString("di_name")%></td>
	</tr>
<%
}
if(!hashRow){
%>
	<tr>
		<td colspan="5">데이터 없음</td>
	</tr>
<%		
}
}catch(Exception e){
	out.print(e);
}finally{
	if(rs!=null){
		rs.close();
	}
	if(ps!=null){
		ps.close();
	}
	if(con!=null){
		con.close();
	}
}
%>
</table>
<a href="/em-insert.jsp"><button>사원등록</button></a>
</body>
</html>