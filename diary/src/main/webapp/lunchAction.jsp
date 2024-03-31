<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	String menu = request.getParameter("menu");
	System.out.println(menu+"<-- 음식");
	

	String sql = "Insert into lunch(lunch_date, menu, update_date, create_date) values(curdate(), ?, now(), now())";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, menu);
	System.out.println(stmt + "<--stmt");
	
	
	//위에 까지 디벙깅 완료  Duplicate entry '2024-03-31' for key 'PRIMARY'(오류문구), 중복된 키값?
	
	/**
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	
	// 재요청(redirect)
	response.sendRedirect("/diary/statsLunch.jsp");
	**/
%>