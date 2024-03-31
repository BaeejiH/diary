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
<style>
      .cinzel {
      font-family: "Cinzel", serif;
      font-optical-sizing: auto;
      font-weight: 400;
      font-style: normal;
   }
       
   .b {
      background-image: url('/diary/img/sp.jpg');
      background-repeat: no-repeat;
      background-size: cover;
   }

</style>  
		
		
		
		
	</head>
<body class="b cinzel">





		<form method="post" action="/diary/lunchAction.jsp">
		<table style="margin-left: auto; margin-right: auto;">
			
			
			<tr>
				<td><label>menu</label></td>
				<td>
				<input type ="radio" name="menu" value="한식">한식	
         		<input type ="radio" name="menu" value="일식">일식
         		<input type ="radio" name="menu" value="중식">중식
         		<input type ="radio" name="menu" value="양식">양식
				
				</td>
			</tr>
			<tr>
				<td><button type="submit" class="btn btn-dark">투표</button></td>
				
			
			</tr>         
                     
            </table>
            
          
              
           
                                   
                  	
         		
           
               
            </form>
            

            
            
            
            
            
            
           
            
            
            
	
	


</body>
</html>