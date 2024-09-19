<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
   <!-- Ajax -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
   <!-- Data Table -->
   <link rel="stylesheet" href="https://cdn.datatables.net/2.1.5/css/dataTables.dataTables.css" />
   <script src="https://cdn.datatables.net/2.1.5/js/dataTables.js"></script>
   <!-- Chart.js -->
   <script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
   <!-- 폰트어썸 -->
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
   <!-- bootstrap -->       
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
   
   <!-- Chartjs에서 날짜 포맷 바꾸는 라이브러리 -->
   <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns@2.0.0/dist/chartjs-adapter-date-fns.bundle.min.js"></script>

   <!-- css폴더에서 main.css 색상정하기 : css customize를 하려면 가장 밑에 bootstrap 밑에 적기 -->
   <link href="<c:url value="resources/css/main.css"/>" rel="stylesheet"/>
</head>

<style>
   ul{
      list-style:none;   /* - 삭제 */
   }
   
   li>a{
      text-decoration:none;   /* 밑줄 삭제 */
   }
</style>

<body>
<header>   
   <nav class="navbar navbar-expand-sm bg-grey navbar-grey" style="background-color:#F5F7F8">
     <div class="container-fluid">
       <ul class="navbar-nav w-100">
         <li class="nav-item ms-left" style="color:black; line-height:40px">
             <c:if test="${sessionScope.loginDTO.adminName == null}">
                <a class="text-black" href="userMainForm.do"><i class="fas fa-home blackr">&nbsp;&nbsp;</i>집앞제주 홈</a>&nbsp;&nbsp;&nbsp;
             </c:if>
                <a class="text-black" href="adminMain.do"><i class="fas fa-user-shield"></i> 관리자 홈</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         </li>   
   
        <c:if test="${sessionScope.loginDTO.adminId != null}">
            <li class="nav-item">
              <a class="nav-link" href="boardList.do">공지사항</a>
            </li>
<!--             <li class="nav-item">
              <a class="nav-link" href="#">호텔정보</a>
            </li> -->
            <li class="nav-item">
              <a class="nav-link" href="adminMemberList.do">가입자정보</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="adminhotelList.do">호텔관리(Host)</a>
            </li>     
            <li class="nav-item">
              <a class="nav-link" href="reserveList.do">예약관리(Guest)</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="packageList.do">패키지관리(Promotion)</a>
            </li>      
<!--             <li class="nav-item">
              <a class="nav-link" href="packageInput.do">패키지등록</a>
            </li> -->

        </c:if>
      
         <li class="nav-item ms-auto" style="color:black; line-height:40px">
            <c:if test="${sessionScope.loginDTO.adminName != null}">
              <span class="text-black"><i class="fa fa-user-circle">&nbsp;</i>관리자 : ${sessionScope.loginDTO.adminName} 님
              &nbsp;</span>
           </c:if>
           <c:if test="${sessionScope.loginDTO.adminName == null}">
              <a class="text-black" href="adminLogin.do"><i class="fas fa-user">&nbsp;</i>관리자 로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;
           </c:if>
           <c:if test="${sessionScope.loginDTO.adminName != null}">
              <a class="text-black" href="adminLogout.do"><i class="fas fa-user-times">&nbsp;</i>관리자 로그아웃</a>&nbsp;&nbsp;&nbsp;&nbsp;
           </c:if>
         </li>
       </ul>
     </div>
   </nav>


</header>

<div class="container mt-5 p-5 mb-5">