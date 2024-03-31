<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>


<%
	//diary.jsp? key=value&key=value, 모든 구조는 key와 value로 이루어져있음.
	//get방식과 post방식을 통해서 페이지에서 보내주는 값을 request.getParameter로 값을 요청함.
	//요청받은 값은 그 페이지 내에서만 쓸 수 있음.
	// a,b,c 페이지가 있다고 가정할때 a에서 c페이지로 갈때 각페이지마다 값을 요청해줘야함.(a->b, b->c) 한번에 가는것은 아직 불가능
	//return: 코드 진행을 끝내는 문법. 메서드 끝낼때 사용.
	//get("key")= value
	//set("key")= value



	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
	         "jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");


//1. 요청 분석
   // 출력하고자는 달력의 년과 월값을 넘겨받음
   String targetYear = request.getParameter("targetYear");
   String targetMonth = request.getParameter("targetMonth");
   
   Calendar target = Calendar.getInstance();
   
   if(targetYear != null && targetMonth != null) {
      target.set(Calendar.YEAR, Integer.parseInt(targetYear));
      target.set(Calendar.MONTH, Integer.parseInt(targetMonth)); 
   }
   // 시작공백의 개수 -> 1일의 요일이 필요 -> 요일에 맵핑된 숫자 -> 타겟 날짜를 1일로변경
   target.set(Calendar.DATE, 1);
   
   // 달력 타이틀로 출력할 변수
   int tYear = target.get(Calendar.YEAR);
   int tMonth = target.get(Calendar.MONTH);
   
   int yoNum = target.get(Calendar.DAY_OF_WEEK); // 일:1, 월:2, .....토:7
   System.out.println(yoNum); 
   // 시작공백의 개수 : 일요일 공백이 없고, 월요일은 1칸, 화요일은 2칸,....yoNum - 1이 공백의 개수
   int startBlank = yoNum - 1;
   int lastDate = target.getActualMaximum(Calendar.DATE); // target달의 마지막 날짜 반환
   System.out.println(lastDate + " <-- lastDate");
   int countDiv = startBlank + lastDate;
   
   //DB에서 tYear와 tMonth에 해당되는 diary목록 추출
   String sql1 = "select diary_date diaryDate, day(diary_date) day, feeling, left(title,5) title from diary where year(diary_date)=? and month(diary_date)=?";
   PreparedStatement stmt1 = null;
   ResultSet rs1 = null;
   stmt1 = conn.prepareStatement(sql1);
   stmt1.setInt(1, tYear);
   stmt1.setInt(2, tMonth+1);
   System.out.println(stmt1);
   
   rs1 = stmt1.executeQuery();
   
   
   
   //현재 4월달의 모든 일기가 들어있음 
   
   //rs2 안에 날짜가 있음. rs2와 날짜를 비교해서 31일까지 비교. rs2.next() 
   // 날자 월별 1~31 . 전부다 비교해야함. 찾은 데이터에서 break.
   
   
   
   
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
   
   .cell {
      float: left;
      width: 70px;
      height: 70px;
      margin: 10px;
      border-radius: 10px;
      color: black;
   }
   
   .sun {
      clear: both;
      color: #FFBB00;
      background-repeat: no-repeat;
      background-size: 100px;
   }
   
   .yo {
      float: left;
      width: 50px;
      height: 20px;
      margin: 19px;
      text-align: center;
      color: black;
   }
   
   .b {
      background-image: url('/diary/img/sp.jpg');
      background-repeat: no-repeat;
      background-size: cover;
   }
   
   .bt {
      top: 50%;
      background-color: #0a0a23;
      color: #fff;
      border: none;
      border-radius: 10px;
      box-shadow: 0px 0px 2px 2px rgb(0, 0, 0);
   }

</style>

   
</head>
<body class="b">   
   <a href="/diary/diary.jsp" class="btn btn-danger btn-lg">diary</a>
   <a href="/diary/diaryList.jsp" class="btn btn-danger btn-lg">diary List</a>
   
   
   
   

<div class="container cinzel ">
  <div class="row">
    <div class="col"> </div>
    <div class="mt-5 col-7 mb-5 border border-dark border-2">
         <h1>Diary Note</h1>


            <div class="container">
               <div class="row">
                  <div class="col">
                     <a
                        href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth - 1%>">
                        <button type="button" class="btn btn-dark">Previous</button>
                     </a>
                  </div>

                  <div class="col-6">
                     <h1><%=tYear%>년
                        <%=tMonth +1%>월
                     </h1>
                  </div>

                  <div class="col">
                     <a
                        href="./diary.jsp?targetYear=<%=tYear%>&targetMonth=<%=tMonth + 1%>">
                        <button type="button" class="btn btn-dark">Next</button>
                     </a>
                  </div>
               </div>
            </div>

   <div class="yo" style=color:#FFBB00>Sun</div>
   <div class="yo">Mon</div>
   <div class="yo">The</div>
   <div class="yo">Wed</div>
   <div class="yo">Thu</div>
   <div class="yo">Fri</div>
   <div class="yo">Sat</div>
   
<!-- DATE값이 들어갈 DIV -->
   <%
      for(int i=1; i<=countDiv; i=i+1) {
         
         if(i%7 == 1) {
   %>
            <div class="cell sun">
   <%         
         } else {
   %>
            <div class="cell">
   <%            
         }
               if(i-startBlank > 0) {
            %>
                  <%=i-startBlank%><br>
            <%
                  // 현재날짜(i-startBlank)의 일기가 rs2목록에 있는지 비교
                  while(rs1.next()) {
                     // 날짜에 일기가 존재한다
                     if(rs1.getInt("day") == (i-startBlank)) {
            %>
                        <div>
                           <%=rs1.getString("feeling")%>
                           <a href='/diary/diaryOne.jsp?diaryDate=<%=rs1.getString("diaryDate")%>'><!--rs1.getString은 쿼리에서 열의 값을 가져오는 것. 여기서는 diaryDate의 열값을 가져옴 -->
                              <%=rs1.getString("title")%>...
                           </a>
                        </div>
            <%            
                        break;
                     }
                  }
                  rs1.beforeFirst(); // ResultSet의 커스 위치를 처음으로...
               } else {
            %>
                  &nbsp;
            <%      
               }
            %>
         </div>
   <%      
      }
   %>
    </div>
    <div class="col"></div>
    </div>
  </div>
</div>


   
   <div class="container cinzel">
      <div class="row">
         <div class="col"></div>
         <div class="col-6">
            <a href="/diary/logout.jsp">Logout</a>
         </div>
         <div class="col"></div>
      </div>
   </div>
   
   <div class="container cinzel">
      <div class="row">
         <div class="col"></div>
         <div class="col-6">
            <button type="button" class="btn btn-dark"><a href="/diary/adddiaryForm.jsp">글쓰기</a></button>
         </div>
         <div class="col"></div>
      </div>
   </div>
   







</body>
</html>