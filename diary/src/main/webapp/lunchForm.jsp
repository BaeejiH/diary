<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
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
	String lunchDate = request.getParameter("lunchDate");
	
	String sq2 ="SELECT * FROM lunch";
	
	PreparedStatement stmt2 = conn.prepareStatement(sq2);
	

	
	
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