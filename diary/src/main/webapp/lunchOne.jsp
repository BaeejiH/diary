<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	String food= request.getParameter("menu");

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");

	String sql1 = "select lunch_date,menu from lunch where lunch_date = curdate()";
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>점심투표</h1>
<%
	if(rs1.next()){		
%>
	<div>참여완료</div>
	<div><a href="/diary/statsLunch.jsp">통계확인</a></div>
	
<%
	}else{
%>
	<div>참여가 완료되지 않았습니다.</div>
	<div><a href="/diary/statsLunch.jsp">투표하기</a></div>
	
<% 		
	}
%>








</body>
</html>