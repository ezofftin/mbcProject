<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../include/header.jsp" %>

<link href="<c:url value="resources/css/main.css"/>" rel="stylesheet"/>
	<!-- Slick Slider CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
	<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- Slick Slider JS -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link href="<c:url value="resources/css/reservation.css"/>" rel="stylesheet"/>

<!-- 스타일 -->
<style>

</style>

<div class="container w-100 mt-5 border shadow p-5">
	<h4>숙소 이름 : ${hotelDto.hotelName}</h4><br><br>
	<c:set var="imageList" value="${fn:split(hotelDto.hotelImage, ',')}"/>
	<div class="slider-for">
		<c:forEach var="image" items="${imageList}">
			<div>
				<img src="<c:url value='/external/${image}'/>" alt="${image}" />
			</div>
		</c:forEach>
	</div>
	<div class="slider-nav">
		<c:forEach var="image" items="${imageList}">
			<div>
				<img src="<c:url value='/external/${image}'/>" alt="${image}" />
			</div>
		</c:forEach>
	</div><br><br>
	<p>가격 : <fmt:formatNumber value='${hotelDto.hotelPrice}' pattern='#,###' />(1박 기준)</p><br><br>
	<p>상세정보 : ${hotelInfo}</p><br><br>
	<p>예약 현황 : ${hotelDto.hotelState}</p><br><br>
	<c:if test="${hotelDto.hotelState=='예약불가'}">
		<a href="reserveCheck.do?hotelNum=${hotelDto.hotelNum}&memberNum=${sessionScope.loginDTO.memberNum}" 
			class="btn me-0 disabled" style="width:200px ; float:right ; background:yellow;">예약불가</a>
	</c:if>
	<c:if test="${hotelDto.hotelState=='예약가능'}">
		<c:if test="${sessionScope.loginDTO.memberId == null}">
		<a href="javascript:alert('로그인이 필요합니다.')" 
			class="btn me-0" style="width:200px ; float:right">예약하기</a>
		</c:if>	      		
		<c:if test="${sessionScope.loginDTO.memberId != null}"> 
			<a href="reserveCheck.do?hotelNum=${hotelDto.hotelNum}&memberNum=${sessionScope.loginDTO.memberNum}" 
				class="btn me-0" style="width:200px ; float:right">예약하기</a>
		</c:if>	    		
	</c:if>
	<%-- <div> 
		<h4>리뷰 목록</h4></br>
		<c:forEach var="review" items="${reviews}">
        
            평점 : ${review.score != 0 ? review.score : "N/A"}</br>
            ${review.content != null ? review.content : "No review yet"}</br>
    </c:forEach>
	</div>	 --%>
	
</div>

<%@ include file="../include/footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		$('.slider-for').slick({
			slidesToShow: 1,
			slidesToScroll: 1,
			arrows: true,
			fade: true,
			asNavFor: '.slider-nav',
			adaptiveHeight: false // 슬라이더 높이를 자동으로 맞춤
		});
		$('.slider-nav').slick({
			slidesToShow: 3,
			slidesToScroll: 1,
			asNavFor: '.slider-for',
			dots: false,
			centerMode: true,
			focusOnSelect: true,
			variableWidth: false // 슬라이더의 너비를 자동으로 조정하지 않도록 설정
		});
	});
</script>
				
