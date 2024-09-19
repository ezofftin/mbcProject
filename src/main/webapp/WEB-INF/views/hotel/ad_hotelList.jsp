<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
	<c:when test="${sessionScope.mode == 'user'}">
		<%@ include file="../include/header.jsp" %>
		<a href="hostHotelInput.do" 
			class="btn me-0" style="width:150px ; float:right">새 숙소등록</a><br><br>
	</c:when>
	<c:when test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_header.jsp" %>
			<a href="hostHotelInput.do" 
				class="btn me-0" style="width:150px ; float:right">새 숙소등록</a><br><br>
	</c:when>
</c:choose>


<c:forEach var="hotelDto" items="${hotelList}">		
		<div>${hotelDto.hotelName} 	
			<c:choose>
				<c:when test="${sessionScope.mode == 'user' && sessionScope.loginDTO.memberNum == hotelDto.hostNum}">
					<a href="hotelUpdate.do?hotelNum=${hotelDto.hotelNum}" 
						class="btn me-0" style="width:150px ; float:right">수정하기</a>
					<a href="hotelDelete.do?hotelNum=${hotelDto.hotelNum}" 
						class="btn me-0" style="width:150px ; float:right">삭제하기</a> <br><br>
				</c:when>
				<c:when test="${sessionScope.mode == 'admin'}">
					<a href="hotelUpdate.do?hotelNum=${hotelDto.hotelNum}" 
						class="btn me-0" style="width:150px ; float:right">수정하기</a>
					<a href="hotelDelete.do?hotelNum=${hotelDto.hotelNum}" 
						class="btn me-0" style="width:150px ; float:right">삭제하기</a> <br><br>
				</c:when>
			</c:choose>
		</div>
		<hr>
</c:forEach>

<c:choose>
	<c:when test="${sessionScope.mode == 'user'}">
		<%@ include file="../include/footer.jsp" %>
	</c:when>
	<c:when test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_footer.jsp" %>
	</c:when>
</c:choose>
