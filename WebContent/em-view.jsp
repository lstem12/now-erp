<%@page import="common.DBCon"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
%>
</head>
<body>
<form method="POST" action="/em-update.jsp">
<table border="1">
	<tr>
		<th>사원번호</th>
		<th>사원명</th>
		<th>변경부서</th>
		<th>부서명</th>
		<th>사원아이디</th>
		<th>입사일</th>
	</tr>
<%
request.setCharacterEncoding("utf-8");
int emNum = Integer.parseInt(request.getParameter("em_num"));
try{
	con = DBCon.getCon();
	String sql = "select em.em_num, em.em_name, em.di_num, em.em_id, em.credat, di.di_name\r\n" + 
			"from employee em\r\n" + 
			"left join depart_info di\r\n" + 
			"on em.di_num = di.di_code where em_num=?";
	ps = con.prepareStatement(sql);
	ps.setInt(1, emNum);
	rs = ps.executeQuery();
	if(rs.next()){
%>
	<tr>
		<td><%=rs.getString("em_num")%></td>
		<td><input type="text" name="em_name" value="<%=rs.getString("em_name")%>"></td>
		<td>
		<select name="di_num">
			<option value="<%=rs.getString("di_num")%>"><%=rs.getString("di_name")%></option>
		<jsp:include page="/select_di_name.jsp"></jsp:include>
		</select>
		</td>
		<td><%=rs.getString("di_name")%></td>
		<td><input type="text" name="em_id" value="<%=rs.getString("em_id")%>"></td>
		<td><%=rs.getString("credat")%></td>
	</tr>
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
<tr>
	<td colspan="6">
		<button>수정</button>
		<a href="./em-delete.jsp?em_num=<%=emNum%>"><button type="button">삭제</button></a>
		<button type="button" onclick="goBack()">리스트</button>
	</td>
</tr>
</table>
<input type="hidden" name="em_num" value="<%=emNum%>">
</form>
<script>
function goBack(){
	history.back();
}
</script>
</body>
</html>