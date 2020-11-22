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
<h1>JSP Test</h1>
<form>
부서명 : <input type="text" name="di_name"><br>
부서설명 : <input type="text" name="di_etc"><br>
<button>검색</button>
</form>
<table border="1">
	<tr>
		<th>부서번호</th>
		<th>부서코드</th>
		<th>부서이름</th>
		<th>부서설명</th>
	</tr>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;
try{
	con = DBCon.getCon();
	String sql = "select di.*,(select count(*) from employee emp where emp.di_num=di.di_num) as di_cnt from depart_info di where 1=1 ";
	String diName = request.getParameter("di_name");
	String diEtc = request.getParameter("di_etc");
	if(diName!=null && !"".equals(diName)){
		sql += "and di_name=?";
	}
	if(diEtc!=null && !"".equals(diEtc)){
		sql += "and di_etc like '%'|| ? || '%'";
	}
	ps = con.prepareStatement(sql);
	if(diName!=null && !"".equals(diName)){
		ps.setString(1, diName);
	}
	if(diEtc!=null && !"".equals(diEtc)){
		if(diName!=null && !"".equals(diName)){
			ps.setString(2, diEtc);
		}else{
			ps.setString(1, diEtc);
		}
	}
	rs = ps.executeQuery();
	boolean hashRow = false;
	while(rs.next()){
		hashRow = true;
%>
	<tr>
		<td><%=rs.getString("di_num")%></td>
		<td><%=rs.getString("di_code")%></td>
		<td><a href="/di-view.jsp?di_num=<%=rs.getString("di_num")%>"><%=rs.getString("di_name")%></a></td>
		<td><%=rs.getString("di_etc")%></td>
	</tr>
<%
}
if(!hashRow){
%>
	<tr>
		<td colspan="4">데이터 없음</td>
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
</table>
<a href="/di-insert.jsp"><button>부서등록</button></a>
</body>
</html>