<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>집앞제주</title>
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<!-- 카카오맵 services와 clusterer, drawing 라이브러리 불러오기 -->
    <script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=41af28c1d758428251c1883e79dce647&libraries=services,clusterer,drawing"></script>
  	<!-- Ajax -->
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
  	<!-- 폰트어썸 -->
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
  	<!-- bootstrap -->       
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<link href="<c:url value="resources/css/main.css"/>" rel="stylesheet"/>
</head>
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <link href="<c:url value="resources/css/mega_menu.css"/>" rel="stylesheet"/>
    
<style>
	ul{
		list-style:none;	
	}
	
	li>a{
		text-decoration:none;	
	}


</style>

<body>


  		<div class="logo p-3 mt-2" style="background-color:white; width=100%">
		  <ul class="navbar-nav w-100 mt-2">
			<li class="container nav-item mt-3">
				<a href="<c:url value="/"/>" target="_self" style="text-decoration:none; color:black; word-spacing: 10px; font-size:25px; font-weight: bolder">
				<img src="resources/imgs/logo.png" style="width:70px; height:auto">
				<!-- <i class="far fa-compass"></i> -->
				    집 앞 제 주
				</a>  
			</li>
		   </ul>			
		</div> 						

		<nav class="navbar navbar-expand-sm menubar"> 
		  <div class="container menu_container">
		    <ul class="navbar-nav w-100 menus">

		      <li class="nav-item menu">
		      	<a class="nav-link" href="hotelList.do">Stays  </a>
          		<ul class="sub-list">
					<c:forEach var="dto" items="${categorylist}">
						 <li>
						 	<a href="UcatList.do?cat_num=${dto.cat_num}&code=${dto.code}&cat_name=${dto.cat_name}">${dto.cat_name}</a>
						 </li>
				   	</c:forEach>
          		</ul>
		      </li>
		      
		      <li class="nav-item menu">
		      	<a class="nav-link" href="#">Vehicles  </a>
          		<ul class="sub-list">
			      	<li><a class="cars" href="cars.do">Cars</a></li>
			      	<li><a class="bikes" href="bikes.do">Bikes</a></li>
			      	<li><a class="shttleBus" href="shuttleBus.do">Shuttle</a></li>
          		</ul>
		      </li>

       	     <li class="nav-item menu"><a class="nav-link" href="#">Hot Deals</a>
                <ul class="sub-list">
                   <li><a class="all" href="UPackList.do">전체 상품</a></li>
                   <li><a class="holiday" href="UPackList.do?packageType=HOLIDAY">연휴 특가</a></li>
                   <li><a class="hotel" href="UPackList.do?packageType=HOTEL">호텔 제휴</a></li>
                   <li><a class="etc" href="UPackList.do?packageType=ETC">기타 상품</a></li>
                </ul>
        	  </li>

		      <li class="nav-item menu">
		      	<a class="nav-link" href="thingstodoList.do">Things to do  </a>
		      </li>
		      
		      <c:if test="${sessionScope.loginDTO.memberId == null}">
			      <li class="nav-item ms-auto d-flex"><!-- 부모 li의 w-100을 줘야지 ms-auto가 먹음 -->
			      	<a class="nav-link2 login" href="<c:url value="/memberLogin.do"/>"><i class="fas fa-user-circle">&nbsp;</i>로그인</a>&nbsp;&nbsp;
	  				<a class="nav-link2 register" href="<c:url value="/memberRegister.do"/>"><i class="fas fa-plus-circle">&nbsp;</i>회원가입</a>&nbsp;&nbsp;

			      </li>
		      </c:if>
		      
		      <c:if test="${sessionScope.loginDTO.memberId != null && sessionScope.mode == 'user'}">
			      <li class="nav-item ms-auto d-flex"><!-- 부모 li의 w-100을 줘야지 ms-auto가 먹음 -->
			      	<a class="me-3 myProfile" type="button" style="color:black" "href="<c:url value="/memberInfo.do?find=info&no=${sessionScope.loginDTO.memberNum}"/>">
			      		<i class="fas fa-check-circle">&nbsp;</i>${sessionScope.loginDTO.memberName} 님</a>&nbsp;&nbsp;
			      	<a class="nav-link2" href="<c:url value="/memberInfo.do?find=pwch&no=${sessionScope.loginDTO.memberNum}"/>"><i class="fas fa-info-circle">&nbsp;</i>내정보</a>&nbsp;&nbsp;
	  				<a class="nav-link2 login" href="<c:url value="javascript:logout()"/>"><i class="fas fa-minus-circle"></i>로그아웃</a>&nbsp;&nbsp;
					<c:choose>
						<c:when test="${sessionScope.loginDTO.memberType == 'host'}">
							<a class="nav-link2" href="<c:url value="myReserveList.do"/>"><i class="fas fa-exclamation-circle">&nbsp;</i>숙소 예약목록</a>&nbsp;&nbsp;
							<a class="nav-link2" href="<c:url value="/adminhotelList.do"/>"><i class="fas fa-home blackr">&nbsp;</i>내 숙소 관리</a>&nbsp;&nbsp;
						</c:when>
						<c:when test="${sessionScope.loginDTO.memberType == 'common'}">
							<a class="nav-link2" href="<c:url value="myReserveList.do"/>"><i class="fas fa-exclamation-circle">&nbsp;</i>나의 예약목록</a>&nbsp;&nbsp;
						</c:when>
					</c:choose>
					</li>
		      </c:if>

	               
<%-- 		      <!-- host 로그인 시 숙소 관리 -->
              <c:if test="${sessionScope.loginDTO.memberType == 'host'}">
			       <a class="nav-link" href="<c:url value="/adminhotelList.do"/>">
	               내 숙소 관리</a>&nbsp;&nbsp;
	          </c:if> --%>
	            
		    </ul>
		  </div>
		</nav>
		
     <!-- Channel Plugin Scripts -->
     <script>
       (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState==="complete"){l();}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}})();     
       ChannelIO('boot', {
         "pluginKey": "75f43e61-1b8a-4494-b166-8dbb9a217f17"
       });
     </script>
     <!-- End Channel Plugin -->
     
     <!-- 로그아웃 스크립트  -->
     <script>
		function logout(){
			location.href="<c:url value="memberLogout.do"/>";
		}
	 </script>
		
		
     <!-- 메가메뉴 -->
	 <script>
	    var menubar = document.querySelector('.menubar');
	    var submenus = document.querySelectorAll('.menu');
 	    var sub_lists = document.querySelectorAll('.sub-list'); 
	    
		
 	    /* submenus안의 각 요소를 submenu 매개변수로 받아서 	    
 	       mouseover와 mouseout이벤트를 등록 시킴 */
	    submenus.forEach(function(submenu) {
	    	/* css hover를 자바스크립트 mouseover, mouseout 이벤트 사용해서 구현 */
	     submenu.addEventListener('mouseover', function() {
	          // 부모 요소의 높이를 키웁니다.
	          
	         //sub_lists안에 각 요소를 sublist매개변수로 받아서 스타일 지정함
	          sub_lists.forEach(function(sublist) {	  	        	
	  	  	      menubar.style.display = 'block';
         		  menubar.style.height = '150px'; 
	  	  	      sublist.style.display = 'block';
	   	  	      sublist.style.maxHeight = '500px';  
  	  	    
  	      }); 
        });

        submenu.addEventListener('mouseout', function() {
	          // 부모 요소의 높이를 원래대로 돌립니다.
		        sub_lists.forEach(function(sublist) {
	        	  menubar.style.height = '';
		 		  sublist.style.display = 'none';
		 		  sublist.style.height= 0; 
		  		}); 
	        });
	    });
	    
 	    
	    /* sticky 옵션 javascript로 구현하기 : 메뉴바는 스크롤시 상단에 고정시키기 */
	    window.addEventListener('scroll', function() { // scroll 이벤트 발생시
	    	
	    	// 여기서 offsetTop은 menubar가 최상단으로부터 얼만큼 떨어져있는지를 픽셀로 표현
	        var stickyPoint = menubar.offsetTop;  
	        console.log(stickyPoint);

	        // pageYOffset은 페이지 스크롤시 그위치값, 맨위에 있으면 0, 아래로 스크롤하면 스크롤된 픽셀수만큼 값 증가
	        if (window.pageYOffset > stickyPoint) {
	          menubar.classList.add('sticky'); // css class sticky를 menubar에 추가(classList 속성사용)
	        } else {
	          menubar.classList.remove('sticky');
	        }
	    });
	 </script>

<!-- 아이콘 참고  https://fontawesome.com/search?o=r&m=free&s=regular -->		
	

<div class="container mt-5 p-3 mb-3"> 



