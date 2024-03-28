<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%
// 0. 로그인(인증) 분기
// diary.login.my_session => 'OFF' => redirect("loginForm.jsp")

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
   // diary.login.my_session => 'OFF' => redirect("loginForm.jsp")
   if(mySession.equals("OFF")) {
      String errMsg = URLEncoder.encode("잘못된 접근 입니다. 로그인 먼저 해주세요", "utf-8");
      response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
      return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
   }
%>

<%
   String checkDate = request.getParameter("checkDate");
   if(checkDate == null) {
      checkDate = "";
   }
   String ck = request.getParameter("ck");
   if(ck == null) {
      ck = "";
   }
   
   String msg = "";
   if(ck.equals("T")) {
      msg = "입력이 가능한 날짜입니다";
   } else if(ck.equals("F")){
      msg = "일기가 이미 존재하는 날짜입니다";
   }
%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>addDiaryForm</title>
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
     
    .di{
       background-color:#B5B2FF;  
    }
   

</style>



</head>
<body style="background-image: url('/diary/img/sp.jpg');
      background-repeat: no-repeat;
      background-size : cover;">

   <div class="container opacity-45 cinzel ">
      <div class="row">
         <div class="col"></div>
         <div class=" mt-5 col p-3 mb-5 border border-dark border-2">

            checkDate :
            <%=checkDate%><br> ck :
            <%=ck%>

         
            <h1>Diary write</h1>

            <form method="post" action="/diary/checkdateAction.jsp">
            
               <div>
               <label for="checkdate" class="form-label">★datecheck</label>
               <input type="date" name="checkDate" value="<%=checkDate%>" id="checkdate" class="form-label">
                  <span><%=msg%></span>
                  <button type="submit" class="btn btn-dark">Check date availability</button>
               </div>
               
            </form>
                        

            <br>

            <form method="post" action="/diary/adddiaryAction.jsp">
               <div class="form-floating mb-3">
                  ★date
                  <%
               if (ck.equals("T")) {
               %>
                  <input value="<%=checkDate%>" type="text" name="diarydate"
                     readonly="readonly" class="form-control">
                  <%
                  } else {
                  %>
                  <input value="" type="text" name="diaryDate" readonly="readonly" class="form-control">
                  <%
                  }
                  %>


               </div>
               <br>
               
               <div>
                  기분:
                  <input type="radio" name="feeling" value="&#128512">&#128512;
                  <input type="radio" name="feeling" value="&#128513">&#128513;
                  <input type="radio" name="feeling" value="&#128514">&#128514;
                  <input type="radio" name="feeling" value="&#128515">&#128515;
                  <input type="radio" name="feeling" value="&#128516">&#128516;
               </div>
                           
               <div>
                <label for="title" class="form-label">★title</label>
               <input type="text" name="title" id="title" class="form-control">   
               </div>
               <br>         
               <div>
                  ★weather:<select name="weather">
                     <option value="맑음">맑음</option>
                     <option value="흐림">흐림</option>
                     <option value="비">비</option>
                     <option value="눈">눈</option>
                  </select>
               </div>
               <br>
               <div>
                <label for="exampleFormControlTextarea1" class="form-label" >★content</label>
                 <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="content"></textarea>
               </div>
               <div>
                  <button type="submit" class="btn btn-dark">Input</button>
               </div>
            </form>



            <!-- input name값 일치하는지 확인. name의 이름이 안맞아서 값이 안넘어감.-->



         </div>
         <div class="col"></div>
      </div>
   </div>

</body>
</html>   