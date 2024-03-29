<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
  
  <%  
     request.setCharacterEncoding("utf-8");
   
     //1.요청으로 데이터 받기
     String diaryDate = request.getParameter("diaryDate");
     String title = request.getParameter("title");
     String weather = request.getParameter("weather");
     String content= request.getParameter("content");

     
     //디버깅 코드 
     System.out.println(diaryDate + "<--diaryDate");
     System.out.println(title + "<--title");
     System.out.println(weather + "<--weather");
     System.out.println(content + "<--content");
     

     //2. 데이터를 수정한다 
     //드라이버 설정
     Class.forName("org.mariadb.jdbc.Driver");
     //DB연결
     Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
     
     //쿼리준비
     String sql="update diary SET title=?, weather=?, content=? WHERE diary_date = ?";
     PreparedStatement stmt = conn.prepareStatement(sql);
     
     //디버깅
     stmt.setString(1,title);
     stmt.setString(2,weather);
     stmt.setString(3,content);
     stmt.setString(4,diaryDate);
     System.out.println(stmt);
     
     //쿼리 실행하기
     int row =stmt.executeUpdate();
     
   
     //3. 결과값에 따라 처리
     //성공했을때 boardOne으로 실패했을때 updateboardFrom으로
     if(row==1){
        response.sendRedirect("/diary/diaryList.jsp");
        System.out.println("수정성공");
     }else{
        response.sendRedirect("/diary/updatediaryForm.jsp");
        System.out.println("수정실패");
     }   
  %>