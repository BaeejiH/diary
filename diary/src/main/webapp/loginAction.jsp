<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

  

 <%
   //1.요청값 분석 -> 로그인 성공유무 ->session에 loginMember 생성
   String memberID = request.getParameter("memberID");
   String memberPW = request.getParameter("memberPW");
   
   
   String sql2 = "select member_id memberID from member where member_id=? and member_pw=?";
   PreparedStatement stmt2 = null;
   ResultSet rs2 = null;
   Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
   stmt2 = conn.prepareStatement(sql2);
   stmt2.setString(1, memberID);
   stmt2.setString(2, memberPW);
   rs2 = stmt2.executeQuery();
   
   if(rs2.next()){
      //로그인 성공
      //diary.login.my_session -> "on" 변경
      
      System.out.println("로그인 성공");
		//로그인 성공시 DB값 설정 -> session 변수 성공	
		session.setAttribute("loginMember", rs2.getString("memberID"));
		response.sendRedirect("/diary/diary.jsp"); 
		
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