<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%
   
   //로그인(인증)
   String loginMember = (String)(session.getAttribute("loginMember"));
   
   if(loginMember== null) {
      String errMsg = URLEncoder.encode("!!!!잘못된 접근 입니다. 로그인 먼저 해주세요!!!", "utf-8");
      response.sendRedirect("/diary/diary.jsp?errMsg="+errMsg);
      return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
   }
%> 


<%
//수정 삭제
   String diaryDate = request.getParameter("diaryDate"); // 이해확인 필요, 요청값 url에 보여지는 주소명과 요청하는 이름이 동일 해야함.
   System.out.println(diaryDate + " <-- diaryDate"); // 디버깅 코드는 확인 후 다음 코드 진행
   
   String sql1 = "select title, weather, content from diary where diary_date=?";
   Class.forName("org.mariadb.jdbc.Driver");
   
   Connection conn = null;
   PreparedStatement stmt1 = null;
   ResultSet rs1 = null;
   conn = DriverManager.getConnection(
         "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
   stmt1 = conn.prepareStatement(sql1);
   stmt1.setString(1, diaryDate);
   System.out.println(stmt1);
   // board 상세 내용의 모델값
   rs1 = stmt1.executeQuery(); // 1행 결과이므로 if...

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
   .bo {
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
   
   
<body class="bo">
<%
      if(rs1.next()) {
%>
         
 <div class="container">
  <div class="row">
    <div class="col"></div>
    <div class="cinzel mt-5 col-7 mb-5 border border-dark border-2">
   		<h1>게시글 수정</h1>
      <form method="post" action="./updatediaryAction.jsp">
            <table>
               <tr>
                  <th>diaryDate:</th>
                  <td><input type="date" name="diaryDate" value="<%=diaryDate%>" readonly="readonly"></td> 
               </tr>

               <tr>
                  <th>title:</th>
                  <td><input type="text" name="title" value="<%=rs1.getString("title")%>"></td>
               </tr>

               <tr>
                  <th>weather:</th>
                  <td><input type="text" name="weather" value="<%=rs1.getString("weather")%>"></td>         
               </tr>

               <tr>
                  <th>content:</th>
                  <td><input type="text" name="content" value="<%=rs1.getString("content")%>"></td>
               </tr>


            </table>
            <button type="submit" class="badge text-bg-danger">글 수정</button>
            </form>
    </div>
    <div class="col"></div>
  </div>
</div>
      
      
      
      
      
      
      
      
      
      
      
<%
}
%>
</body>
</html>