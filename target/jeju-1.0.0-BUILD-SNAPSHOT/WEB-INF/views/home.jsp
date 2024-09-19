<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="./include/header.jsp" %>
  	<!-- 폰트어썸 -->
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
  	<!-- bootstrap -->       
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- css폴더에서 main.css 색상정하기 : css customize를 하려면 가장 밑에 bootstrap 밑에 적기 -->
	<link href="<c:url value="resources/css/main.css"/>" rel="stylesheet"/>
	<link href="<c:url value="resources/css/hoverEffect.css"/>" rel="stylesheet"/>

</div>

 	<!-- 검색창  -->
	<div class="search-box" style="display:flex; justify-content:center; align-items:center; gap:10px">
       <!-- 검색 상자 -->
        <label for="destination">즐길거리 검색: </label>
         <input type="text" id="keyword" name="keyword"
            value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "제주도 맛집" %>">
        <button type="button" onclick="doSearch()">검색</button>
    </div>
	
    	
	<div class="container-fluid p-0 visual-area">
		<!-- Carousel -->
		<div id="demo" class="carousel slide" data-bs-ride="carousel">
		
		  <!-- Indicators/dots -->
		  <div class="carousel-indicators">
		    <button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
		    <button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
		    <button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
		    <button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>		    
		  </div>
		
		  <!-- The slideshow/carousel -->
		  <div class="carousel-inner">
		  	<div>
		    <a href="UPackList.do" class="carousel-item">
		      <video src="resources/imgs/1.mp4" autoplay muted loop alt="hotDeal1" class="d-block" style="width:100%; height:600%"></video>
		    </a>
		    <a href="UPackList.do" class="carousel-item">
		      <img src="resources/imgs/1.jpg" alt="hotDeal2" class="d-block" style="width:100%; height:100%">
		    </a>
				  <!-- <div class="carousel-caption">
				  <p><p>-->
		    <a href="UPackList.do" class="carousel-item active">
		      <img src="resources/imgs/2.jpg" alt="hotDeal3" class="d-block" style="width:100%; height:100%">
		    </a>
		    </div>
		
		  <!-- Left and right controls/icons -->
		  <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon"></span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
		    <span class="carousel-control-next-icon"></span>
		  </button>
		</div>
	</div>
		<!-- Carousel End -->

	<!-- 본문 내용 삽입 -->	
	<div class="container mt-5 mb-5 p-5">
	
		<h3>Stays</h3><br>
		<!-- Card -->
	    <c:forEach var="hotelDto" items="${hotelList}">      
		    <div class="items">
	            <c:set var="imageList" value="${fn:split(hotelDto.hotelImage, ',')}"/>
	        <div class="item">
	                  <img class="card-img-top me-2 mt-2 " 
	                        src="<c:url value="/external/${imageList[0]}"/>">
	  	              <div class="caption">
		                <a href="<c:url value='/hotelInfo.do?hotelNum=${hotelDto.hotelNum}'/>">예약하기</a>
		              </div>
	        </div>
	        </div>
	 	</c:forEach>
	    <!-- Card End -->    
	    <br><br><br><hr><br><br>

		
		<h3>Weather</h3><br>
			<div id="ww_8811bf0cf166f" v='1.3' loc='id' a='{"t":"responsive","lang":"ko","sl_lpl":1,"ids":["wl7410"],"font":"Arial","sl_ics":"one_a","sl_sot":"celsius","cl_bkg":"#FFFFFF","cl_font":"#000000","cl_cloud":"#bcb5b8","cl_persp":"#81D4FA","cl_sun":"#FFC107","cl_moon":"#FFC107","cl_thund":"#FF5722"}'>More forecasts: <a href="https://oneweather.org/seoul/30_days/" id="ww_8811bf0cf166f_u" target="_blank">Seoul 30 day forecast</a></div><script async src="https://app2.weatherwidget.org/js/?id=ww_8811bf0cf166f"></script>
	    <br><br><hr><br><br>
		
		<h3>Notice</h3><br>
			<div>				
				<%@include file="./board/user_boardList.jsp" %>
			</div>
	    <br><br>	
		
		<br>
		 <div class="image-container">
		   <img src="resources/imgs/promo.jpg" alt="promo" class="background-image">
		   <div class="overlay-text">
		     <h1>가을 집앞제주</h1>
		     <p>매력적인 제주 스테이를 통해 특별한 가을 탈출여행을 계획해봐요. 멤버가 되어 할인받기!</p>
		     <button class="deal-button"><a href="<c:url value="memberRegister.do"/>" target="_self" style="text-decoration:none; color:black; font-weight: bolder">Unlock your deals</a></button>
		   </div>
		 </div>
	    <br><br><br><br>			
	</div>
	
	<script>
	function doSearch() {
	    // 입력된 검색어 가져오기
	   var keyword = document.getElementById("keyword").value;
	   window.location.href = "thingstodoList.do?keyword=" + keyword
	   return;
	
	}
	</script>

		





<%@ include file="./include/footer.jsp" %>
