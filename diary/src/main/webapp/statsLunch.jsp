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
	/*
	SELECT menu,COUNT(*) 
	FROM lunch
	GROUP BY menu
	ORDER BY COUNT(*) DESC;
	*/
	String sql2 = "select menu, count(*) cnt from lunch group by menu";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">   

<style> 
   .b {
      background-image: url('/diary/img/sp.jpg');
      background-repeat: no-repeat;
      background-size: cover;
   }
</style>   	
</head>
<body class="b">


	<h1>statsLunch</h1>
	<%
				double maxHeight = 500;
				double totalCnt = 0; //
				while(rs2.next()) {
					totalCnt = totalCnt + rs2.getInt("cnt");
				}
				
				rs2.beforeFirst();
	%>
	
	<div>
		전체 투표수 : <%=(int)totalCnt%>
	</div>
	
	
	<table border="1" style="width: 400px;">
		<tr>
			<%	
				String[] c = {"#FF0000", "#FF5E00", "#FFE400", "#1DDB16", "#0054FF"};
				int i = 0;
				while(rs2.next()) {
					int h = (int)(maxHeight * (rs2.getInt("cnt")/totalCnt));
			%>
					<td style="vertical-align: bottom;">
						<div style="height: <%=h%>px; 
									background-color:<%=c[i]%>;
									text-align: center">
							<%=rs2.getInt("cnt")%>
						</div>
					</td>
			<%		
					i = i+1;
				}
			%>
		</tr>
			
		<tr>
			<%
				// 커스의 위치를 다시 처음으로
				rs2.beforeFirst();
							
				while(rs2.next()) {
			%>
					<td><%=rs2.getString("menu")%></td>
			<%		
				}
			%>
		</tr>
	</table>
	
	

</body>
</html>