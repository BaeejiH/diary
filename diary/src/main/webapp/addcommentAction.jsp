<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%
	
	request.setCharacterEncoding("utf-8");

	//값 요청
	String diaryDate = request.getParameter("diaryDate");
	String memo = request.getParameter("memo");


	// 디버깅
	System.out.println(diaryDate + "<--diaryDate");
	System.out.println(memo + "<--memo");
	
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
	 ResultSet rs1 = null;
	
	//쿼리준비
	String sql=  "INSERT INTO comment(diary_date,memo,update_date,create_date)VALUES(?,?,NOW(),NOW())";
	//통에 쿼리문 넣어주기
	PreparedStatement stmt1 = conn.prepareStatement(sql);
	stmt1.setString(1,diaryDate);
	stmt1.setString(2,memo);
	System.out.println(stmt1);

	//여기까지 디버깅 아래 쿼리 실행문에서 오류남
	
	
	
	 int row =stmt1.executeUpdate();
	 
	
	 
	 if(row == 1) {
			System.out.println("댓글입력성공");
			response.sendRedirect("/diary/diaryList.jsp");
		} else {
			System.out.println("댓글실패");
			response.sendRedirect("/diary/diaryOne.jsp");
		}
	
	
%>





