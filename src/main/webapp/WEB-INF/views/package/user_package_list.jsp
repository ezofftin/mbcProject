<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>

<link href="<c:url value="resources/css/package.css"/>" rel="stylesheet" />
<!-- </div>
</div> -->
<div class="packageList">
    <!-- 패키지 타입 제목 표시 -->
    <c:choose>
        <c:when test="${empty pTypeName}">
            <h3>전체 상품</h3>
        </c:when>
        <c:otherwise>
            <h3>${pTypeName} 상품</h3>
        </c:otherwise>
    </c:choose>
    <br>

    <!-- 상품이 없을 경우 메시지 표시 -->
    <c:if test="${list.size() == 0}">
        <p>${pTypeName} 상품이 존재하지 않습니다.</p>
    </c:if>

    <!-- 카드 목록 컨테이너 -->
    <div class="card-container">
        <c:forEach var="dto" items="${list}">
            <!-- Card -->
            <div class="card">
                <%-- <img src="${dto.packageImage}" class="card-img-top" alt="${dto.packageName}"> --%>
                <%-- <img src="<c:url value="resources/fileRepository/${dto.packageImage}"/>" class="card-img-top" alt="${dto.packageImage}" /> --%>
                <%-- <img src="<c:url value="/external/${dto.packageImage}"/>" class="card-img-top" alt="${dto.packageImage}" /> --%>
                <c:set var="imageList" value="${fn:split(dto.packageImage, ',')}"/>
    			<img src="<c:url value='/external/${imageList[0]}' />" alt="${imageList[0]}" width="60px"/>
                <div class="card-body">
                    <h5 class="card-title">${dto.packageName}</h5>
                    <%-- <p class="card-text">${dto.packagePrice} 원</p> --%>
                    <fmt:formatNumber value="${dto.packagePrice}" /> 원
                    <div class="card-footer">
                    	<a href="UPackView.do?packageNum=${dto.packageNum}" class="btn btn-primary">예약하기</a>
                	</div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


	<%@ include file="../include/footer.jsp"%>