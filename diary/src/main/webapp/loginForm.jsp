<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  	//로그인(인증) 분기 session사용으로 변경()
 	//로그인 성공시 세션에 login Member라는 변수를 만들고값으로 로그인 아이디르 ㄹ저장
 	String loginMember =(String)(session.getAttribute("loginMember"));
	// session.getAttribute () 찾는 변수가 없으면 null값을 반환하다.
	//null이면 로그아웃상테이고, null이 아니면 로그인 상태
	System.out.println(loginMember + "<--loginMember");
	
	//logunForm 페이지는 로그아웃상태에서만 출력되는 페이지
	 if(loginMember != null) {
      response.sendRedirect("/diary/diary.jsp"); 
      return;
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