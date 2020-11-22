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
request.setCharacterEncoding("utf-8");
String emName = request.getParameter("em_name");
String diNum = request.getParameter("di_num");
String emId = request.getParameter("em_id");
String emPwd = request.getParameter("em_pwd");
if(emName!=null && diNum!=null && emId!=null && emPwd!=null){
	Connection con = null;
	PreparedStatement ps = null;
	try{
		con = DBCon.getCon();
		String sql = "insert into employee(em_num, em_name, di_num, em_id, em_pwd)";
		sql += " values(seq_em_num.nextval,?,?,?,?)";
		ps = con.prepareStatement(sql);
		ps.setString(1, emName);
		ps.setString(2, diNum);
		ps.setString(3, emId);
		ps.setString(4, emPwd);
		if(ps.executeUpdate() == 1){
%>
	<script>
		alert('등록완료');
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
	return;
}
%>
<form method="POST">
사원명 : <input type="text" name="em_name"><br>
부서명 : <select name="di_num">
<option selected="selected">부서선택</option>
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
</select><br>
사원아이디 : <input type="text" name="em_id"><br>
사원비밀번호 : <input type="password" name="em_pwd"><br>
</form>
<a href="/em-list.jsp"><button>사원 리스트</button></a>
</body>
</html>