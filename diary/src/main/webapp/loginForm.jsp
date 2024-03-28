<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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

   
   // 1. 요청값 분석
   String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
   
<style>
.cinzel{
     font-family: "Cinzel", serif;
     font-optical-sizing: auto;
     font-weight: 400;
     font-style: normal;
     }
     
   
</style>   

</head>
<body style="background-image: url('/diary/img/sp.jpg');
         background-repeat: no-repeat;
         background-size : cover;">



   <div class="container cinzel">
      <div class="row">
         <div class="col">
            <%
            if (errMsg != null) {
            %>
            <%=errMsg%>
            <%
            }
            %>
         </div>

         <div class=" mt-5 col mb-5">
            <h1 class="display-1">Login</h1>
            <form method=post action="/diary/loginAction.jsp">
               <table>
                  <tr>
                     <th>Id:</th>
                     <td><input type="text" name="memberID" class=form-control
                        value="" placeholder="아이디"></td>   <br>
                  </tr> <br>
      
                  <tr>
                  <br>
                     <th>Pw:</th>
                     <td><input type="password" name="memberPW"
                        class=form-control value="" placeholder="비밀번호"></td>
                  </tr>
               </table>
               <br>
               <button type="submit" class="btn btn-dark">로그인</button>
               <button class="btn btn-primary" type="button" disabled>
              <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
              Loading...
            </button>
            </form>
         </div>

         <div class="col"></div>
      </div>
   </div>

</body>
</html>