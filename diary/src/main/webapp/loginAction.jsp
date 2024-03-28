<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
   String sql1 = "select my_session mySession from login";
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = null;
   PreparedStatement stmt1 = null;
   ResultSet rs1 = null;
   conn = DriverManager.getConnection(
         "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
   stmt1 = conn.prepareStatement(sql1);
   rs1 = stmt1.executeQuery();
   String mySession = null;
   if(rs1.next()) {
      mySession = rs1.getString("mySession");
   }
   if(mySession.equals("ON")) {
      response.sendRedirect("/diary/diary.jsp");
      return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
}
   
   //1.요청값 분석
   String memberID = request.getParameter("memberID");
   String memberPW = request.getParameter("memberPW");
   
   
   String sql2 = "select member_id memberID from member where member_id=? and member_pw=?";
   PreparedStatement stmt2 = null;
   ResultSet rs2 = null;
   stmt2 = conn.prepareStatement(sql2);
   stmt2.setString(1, memberID);
   stmt2.setString(2, memberPW);
   rs2 = stmt2.executeQuery();
   
   
   
   if(rs2.next()){
      //로그인 성공
      //diary.login.my_session -> "on" 변경
      System.out.println("로그인 성공");
      String sql3 = "update login set my_session = 'ON', on_date = now()";
      PreparedStatement stmt3 = conn.prepareStatement(sql3);
      int row = stmt3.executeUpdate();
      response.sendRedirect("/diary/diary.jsp"); // Action페이지에서 sendRedirect은 다른 페이지로 넘아가야할 때 씀.HTML의 a태그와 비슷함.
      System.out.println(row+ " <-- row");

   
   }else{
      //로그인 실패
      System.out.println("로그인 실패");
      String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인해주세요", "utf-8");
      response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
   }   

%>


<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title></title>
   </head>
<body>

</body>
</html>