<%@page import="common.DBCon"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Connection con = null;
PreparedStatement ps = null;
try{
	String emNum = request.getParameter("em_num");
	con = DBCon.getCon();
	String sql = "delete from employee where em_num=?";
	ps = con.prepareStatement(sql);
	ps.setString(1, emNum);
	if(ps.executeUpdate() == 1){
%>
<script>
	alert('삭제 성공');
	location.href = '/em-list.jsp';
</script>
<%
	}else{
%>
<script>
	alert('삭제 실패');
	location.href = '/em-list.jsp';
</script>
<%		
	}
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(ps!=null){
		ps.close();		
	}
	if(con!=null){
		con.close();
	}
}
%>
</body>
</html>