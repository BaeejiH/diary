<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>

<%
   
   //로그인(인증)
   String loginMember = (String)(session.getAttribute("loginMember"));
   
   if(loginMember== null) {
      String errMsg = URLEncoder.encode("!!!!잘못된 접근 입니다. 로그인 먼저 해주세요!!!", "utf-8");
      response.sendRedirect("/diary/loginForm.jsp?errMsg="+errMsg);
      return; // 코드 진행을 끝내는 문법 ex) 메서드 끝낼때 return사용
   }
%>

	
<%
	String lunchDate = request.getParameter("lunchDate");
	
	String sq2 ="SELECT * FROM lunch";
	

%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>
<body>

			<form method="post" action="/diary/lunchAction.jsp">
            
               <div>
               <label for="lunchDate" class="form-label">lunchDate</label>
               <input type="date" name="lunchDate" value="<%=lunchDate%>" id="lunchDate" class="form-label">
              </div> 
                                        
                <label>menu</label>        	
         		<intput type ="radio" name="menu" value="1">한식	
         		<intput type ="radio" name="menu" value="2">일식
         		<intput type ="radio" name="menu" value="3">중식
         		<intput type ="radio" name="menu" value="4">양식
                                 
                  <button type="submit" class="btn btn-dark">투표</button>
               </div>
               
            </form>
            
           
            
            
            
	
	


</body>
</html>