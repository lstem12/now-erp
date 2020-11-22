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
<%
Connection con = null;
PreparedStatement ps = null;
try{
	request.setCharacterEncoding("utf-8");
	String emName = request.getParameter("em_name");
	String diNum = request.getParameter("di_num");
	String emId = request.getParameter("em_id");
	String emNum = request.getParameter("em_num");
	con = DBCon.getCon();
	String sql = "update employee set em_name=?, di_num=?, em_id=? where em_num=?";
	ps = con.prepareStatement(sql);
	ps.setString(1, emName);
	ps.setString(2, diNum);
	ps.setString(3, emId);
	ps.setString(4, emNum);
	if(ps.executeUpdate() == 1){
%>
<script>
	alert('수정 성공');
	location.href = '/em-list.jsp';
</script>
<%
	}else{
%>
<script>
	alert('수정 실패');
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