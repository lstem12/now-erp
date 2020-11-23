<%@page import="vo.DepartinfoVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1">
<tr>
	<th>번호</th>
	<th>팀코드</th>
	<th>팀이름</th>
	<th>팀 설명</th>
	<th>팀카운드</th>
</tr>
<%
List<DepartinfoVO> diList = (List<DepartinfoVO>)request.getAttribute("diList");
for(DepartinfoVO diVO:diList){
%>
<tr>
	<td><%=diVO.getDiNum()%></td>
	<td><%=diVO.getDiCode()%></td>
	<td><%=diVO.getDiName()%></td>
	<td><%=diVO.getDiEtc()%></td>
	<td><%=diVO.getDiCnt()%></td>
</tr>
<%
}
%>
</table>
</body>
</html>