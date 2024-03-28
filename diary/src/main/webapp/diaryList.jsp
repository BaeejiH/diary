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
   //현재페이지
   //페이징(페이지가 다음 페이지로 넘어가는 것)
   //리스트 
   //처음 페이지랑 마지막 페이지
   //클라이언트가 현재 페이지를 요청
   //한 페이지당 보여지는 페이지 개수 = rowPerpage
   
   // 출력 리스트 모듈
   int currentPage = 1;
   if(request.getParameter("currentPage") != null) {
      currentPage = Integer.parseInt(request.getParameter("currentPage"));
   }
   
   int rowPerPage = 10;
   /*
   if(request.getParameter("rowPerPage") != null) {
      rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
   }
   */
   
   int startRow = (currentPage-1)*rowPerPage; // 1-0, 2-10, 3-20, 4-30,....
   
   String searchWord = ""; //null은 절대 들어갈 수 없음
   if(request.getParameter("searchWord") != null) {
      searchWord = request.getParameter("searchWord");
   }
   /*
      select diary_date diaryDate, title
      from diary
      where title like ?
      order by diary_date desc
      limit ?, ?
   */
   String sql2 = "select diary_date diaryDate, title from diary where title like ? order by diary_date desc limit ?, ?";
   PreparedStatement stmt2 = null;
   ResultSet rs2 = null;
   stmt2 = conn.prepareStatement(sql2);
   stmt2.setString(1, "%"+searchWord+"%");
   stmt2.setInt(2, startRow);
   stmt2.setInt(3, rowPerPage);
   rs2 = stmt2.executeQuery();
%>

<%
   // lastPage 모듈
   String sql3 = "select count(*) cnt from diary where title like ?";
   PreparedStatement stmt3 = null;
   ResultSet rs3 = null;
   stmt3 = conn.prepareStatement(sql3);
   stmt3.setString(1, "%"+searchWord+"%");//null이면 where문이 없는 것과 동일시 됨
   rs3 = stmt3.executeQuery();
   int totalRow = 0;
   if(rs3.next()) {
      totalRow = rs3.getInt("cnt");
   }
   int lastPage = totalRow / rowPerPage;
   if(totalRow % rowPerPage != 0) {
      lastPage = lastPage + 1;
   }
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
<body class="b">

   <div class="container">
      <div class="row">
         <div class="col"></div>
         <div class="col">
            <h1>일기 목록</h1>
            <table border="1">
               <tr>
                  <th>제목</th>
                  <th>날짜</th>
               </tr>
               <%
               while (rs2.next()) {
               %>
               <tr>
                  
                  <td><%=rs2.getString("title")%></td>
                  <td><a href="/diary/diaryOne.jsp?diaryDate=<%=rs2.getString("diaryDate")%>">
                  <%=rs2.getString("diaryDate")%></a></td>
               </tr>
               <%
               }
               %>
            </table>

            <nav aria-label="Page navigation example">
               <ul class="pagination justify-content-center">

                  <%
                  if (currentPage > 1) {
                  %>
                  <li class="page-item"><a class="page-link"
                     href="./diaryList.jsp?currentPage=1">처음페이지</a></li>
                  <li class="page-item"><a class="page-link"
                     href="./diaryList.jsp?currentPage=<%=currentPage - 1%>">이전페이지</a></li>
                  <%
                  } else {
                  %>
                  <li class="page-item disabled"><a class="page-link"
                     href="./diaryList.jsp?currentPage=1">처음페이지</a></li>
                  <li class="page-item disabled"><a class="page-link"
                     href="./diaryList.jsp?currentPage=<%=currentPage - 1%>">이전페이지</a></li>
                  <%
                  }

                  if (currentPage < lastPage) {
                  %>
                  <li class="page-item"><a class="page-link"
                     href="./diaryList.jsp?currentPage=<%=currentPage + 1%>">다음페이지</a></li>
                  <li class="page-item"><a class="page-link"
                     href="./diaryList.jsp?currentPage=<%=lastPage%>">마지막페이지</a></li>
                  <%
                  }
                  %>
               </ul>
            </nav>
         </div>
         <div class="col"></div>
      </div>
   </div>

   <form method="get" action="/diary/diaryList.jsp"> <!-- get방식으로 보낸 이유는 현재 번호를 보기위해 -->
      <div>
         제목검색 :
         <input type="text" name="searchWord">
         <button type="submit">검색</button>
      </div>
   </form>
            
</body>
</html>