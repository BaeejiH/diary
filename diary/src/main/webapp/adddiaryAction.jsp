<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
	//요청값 받아오기
	String diarydate = request.getParameter("diarydate");
	String title = request.getParameter("title");
	String weather = request.getParameter("weather");
	String content = request.getParameter("content");
	//디버깅 코드 
	System.out.println(diarydate + " <-- diarydate");
	System.out.println(title + " <-- title");
	System.out.println(weather + " <-- weather");
	System.out.println(content + " <-- content");
	

	//드라이버 설정
	Class.forName("org.mariadb.jdbc.Driver");
	//DB연결
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	
	//쿼리준비
	String sql= "INSERT INTO diary(diary_date,title,weather,content,update_date,create_date)VALUES(?,?,?,?,NOW(),NOW())";
	//통에 쿼리문 넣어주기
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	//쿼리문 ?값 넣어주기
			
	stmt.setString(1,diarydate);
	stmt.setString(2,title);
	stmt.setString(3,weather);
	stmt.setString(4,content);
	//디버깅
	System.out.println(stmt);
	

	 //쿼리 실행하기
	 int row =stmt.executeUpdate();
	 
	 if(row == 1) {
			System.out.println("입력성공");
			response.sendRedirect("/diary/diaryList.jsp");
		} else {
			System.out.println("입력실패");
			response.sendRedirect("/diary/adddiaryForm.jsp");
		}
	 
	 

%>
