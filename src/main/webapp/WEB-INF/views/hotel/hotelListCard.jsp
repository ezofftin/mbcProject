<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.card-info {
		display: -webkit-box;
		-webkit-line-clamp: 2; /* 줄 수 설정 */
		-webkit-box-orient: vertical;
		overflow: hidden;
		text-overflow: ellipsis;
	}
</style>

<div class="hotelpreview container mt-3">
	<div class="card">
		<div class="row">
		<!-- 이미지 여러 개 저장한 경우 어떻게 하는지? -->
			<div class="col-sm-2">
				<c:set var="imageList" value="${fn:split(hotelDto.hotelImage, ',')}"/>
				<img class="card-img-top" 
						src="<c:url value="/external/${imageList[0]}"/>" 
				  		alt="card-image" style="width:150px">
			</div>
			<div class="col-sm-6">
				<h4 class="card-title">호텔명 : <b>[${hotelDto.hotelName}] </b></h4>
				<p class="card-info">정보 : </br>${hotelDto.hotelInfo}</p>
			</div>
			<div class="col-sm-4">
<!-- 				<p>평점: </p> -->
				<p>객실상태: ${hotelDto.hotelState}</p>
				
				<p>금액(1일): <fmt:formatNumber value="${hotelDto.hotelPrice}" />원</p>
					<a href="hotelInfo.do?hotelNum=${hotelDto.hotelNum}" 
						class="btn me-0" style="width:150px ; float:right"><i class="fas fa-house"></i>상세보기</a>
			</div>
		</div>
	</div>
</div>
