<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>


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
   Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cinzel&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">   
   
   
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
 <a href="/diary/diary.jsp" class="btn btn-danger btn-lg">diary</a>
 <a href="/diary/diaryList.jsp" class="btn btn-danger btn-lg">diary List</a>
 

   <div class="container cinzel">
      <div class="row">
         <div class="col"></div>
         <div class="mt-5 col-7 mb-5 border border-dark border-2">
            <h1>Diary List</h1>
            <table border="1" class="table table-dark table-hover">
               <tr>
                  <th>Title</th>
                  <th>Date</th> 
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
    <div style="text-align: center;">
		   <form method="get" action="/diary/diaryList.jsp"> <!-- get방식으로 보낸 이유는 현재 번호를 보기위해 -->
		      <div>
		         제목검색 :
		         <input type="text" name="searchWord">
		         <button type="submit" class="btn btn-dark">검색</button>
		      </div>
		   </form>
      </div>
         </div>
         <div class="col"></div>
      </div>
   </div>     
   
  

            
</body>
</html>