<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>

<div class="container mt-5 mb-5 p-50">

	<h3>Things to do</h3> 

	<!-- 리스트 창(hotelListCard를 한 블럭에 지정, foreach 이용) -->
	<div>
					<!-- kakaoMap -->
						<%@include file="kakaoMap.jsp" %>
					<!-- Card End -->
	</div>

</div>


<%@ include file="../include/footer.jsp" %>
