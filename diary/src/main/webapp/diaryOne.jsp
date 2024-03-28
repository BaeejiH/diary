<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>

<%
   // 0. 로그인(인증) 분기
   // diary.login.my_session => 'ON' => redirect("diary.jsp")
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
   if(mySession.equals("OFF")) {
      response.sendRedirect("/diary/loginForm.jsp");  // 특정한 작업을 수행한 후 지정된 페이지로 이동(response.sendRedirect)
      return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
   }

//수정 삭제
   String diaryDate = request.getParameter("diaryDate");
   System.out.println(diaryDate + " <-- diaryDate"); // 디버깅 코드는 확인 후 다음 코드 진행
   
   String sql2 = "select diary_date, title, weather, content from diary where diary_date=?";
   
   PreparedStatement stmt2 = null;
   ResultSet rs2 = null;
   stmt2 = conn.prepareStatement(sql2);
   stmt2.setString(1, diaryDate);
   System.out.println(stmt1);
   // board 상세 내용의 모델값
   rs2 = stmt2.executeQuery(); // 1행 결과이므로 if...

%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>diaryOne</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
      
<style>
   .b {
      background-image: url('/diary/img/sp.jpg');
      background-repeat: no-repeat;
      background-size: cover;
   }
   
   .cinzel {
      font-family: "Cinzel", serif;
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
   }
</style>            
            
   </head>
<body class="b">
<div class="container">
  <div class="row">
    <div class="col">
    </div>
    <div class="cinzel mt-5 col-7 mb-5 border border-dark border-2">
     <h1><%=diaryDate%>Details</h1>
<%
      if(rs2.next()) {
%>
   
            <label><a
               href="/diary/updatediaryForm.jsp?diaryDate=<%=diaryDate%>" 
               class="btn btn-outline-danger">글수정</a></label> <label><a
               href="/diary/deletediaryAction.jsp?diaryDate=<%=diaryDate%>"
               class="btn btn-outline-danger">글삭제</a></label>
            <table class="table table-dark table-hover">
            <!-- input으로 값을 요청하는 것과   <  %=diaryDate% >  같다 -->
               <tr>
                  <th>title:</th>
                  <td><%=rs2.getString("title")%></td> 
                  <!-- 로그인 분기문을 추가하면서 쿼리 실행문이 두개 생겼음. rs1-> rs2로 바뀌어야함. 주의요망  -->
               </tr>

               <tr>
                  <th>weather:</th>
                  <td><%=rs2.getString("weather")%></td>
               </tr>

               <tr>
                  <th>content:</th>
                  <td><%=rs2.getString("content")%></td>
               </tr>


            </table>
     
    </div>
    <div class="col"></div>
  </div>
</div>
   
   
   <%
   }
   %>
   
   
   
   
   


   
</body>
</html>