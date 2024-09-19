<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/header.jsp"%>

<link href="<c:url value="resources/css/package.css"/>" rel="stylesheet" />

<!-- 달력 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<div class="w-100 ps-5">

	<ul class="d-flex" style="list-style: none">
		<li class="me-5">
		
			<!-- 썸네일 이미지 출력 @@@@ -->
			<c:set var="imageList" value="${fn:split(dto.packageImage, ',')}" />
			<img src="<c:url value='/external/${imageList[0]}' />" alt="${imageList[0]}" class="package-thumbnail" />
		</li>
		<li>
			<form name="packageForm" method="post">
				<h4>${dto.packageName}</h4>
				<fmt:formatNumber value="${dto.packagePrice}" /> 원
				
				<tr>
					<!-- <td>날짜</td> -->
					<td>
						<div class="date-picker ms-0"> 
						
							<label for="package-date"></label>
							<input type="date" id="packageDate" name="packageDate">
						</div>
					</td>
				</tr>
				


				<div class="mb-3">
					<!-- 예약 인원 선택 -->
					<div class="d-flex justify-content-between align-items-center">
						<!-- 인원 선택 버튼과 입력 필드 -->
						<div class="package-quantity me-3">
							<button class="btn btn-outline-secondary" type="button" id="decrement">-</button>
							<input type="number" id="quantity" name="quantity" class="form-control d-inline" value="1" min="1" style="width: 60px; display: inline;" />
							<button class="btn btn-outline-secondary" type="button" id="increment">+</button>
						</div>
						
						<!-- 총 금액 표시 -->
						<h5 class="m-0">
							총 금액: <span id="totalPriceFormatted"><fmt:formatNumber value="${dto.packagePrice}" /></span> 원
						</h5>
					</div>
				</div>

				<!-- 입력 받은 값 hidden으로 js에 보냄 -->
			    <input type="hidden" id="hiddenDate" name="hiddenDate">
			    <input type="hidden" id="hiddenQuantity" name="hiddenQuantity">
			    <input type="hidden" id="hiddenTotalPrice" name="hiddenTotalPrice">

				<!-- 로그인된 경우 예약하기 버튼 표시 -->
				<c:if test="${sessionScope.loginDTO.memberId != null}">
					<a href="javascript:reservePackage(${dto.packageNum})"
						class="btn btn-sm btn-primary">예약하기</a>
				</c:if>

				<!-- 로그인되지 않은 경우 알림 후 로그인 페이지로 리다이렉트 -->
				<c:if test="${sessionScope.loginDTO.memberId == null}">
					<a href="javascript:reservePackage(${dto.packageNum})" class="btn btn-sm btn-primary">예약하기</a>
				</c:if>

				<!-- 이전 페이지로 돌아가기 버튼 -->
				<a href="javascript:history.back()" class="btn btn-sm btn-outline-primary">돌아가기</a>


			</form>
		</li>
	</ul>

	<hr>

	<!-- 추가 이미지 출력 -->
	<div class="package-content">
		<c:forEach var="image" items="${imageList}" varStatus="status">
			<c:if test="${status.index != 0}">
				<img src="<c:url value='/external/${image}' />" alt="${image}" />
			</c:if>
		</c:forEach>
	</div>
</div>

<!-- 썸네일을 제외한 나머지 이미지 출력  @@@@@@@@@@@@@@@@@@@@-->
<div class="package-content">
	<c:forEach var="image" items="${imageList}" varStatus="status">
		<c:if test="${status.index != 0}">
			<img src="<c:url value='/external/${image}' />" alt="${image}" />
		</c:if>
	</c:forEach>
</div>
</div>



<script>
window.onload = function() {
    // 현재 날짜를 가져와 yyyy-MM-dd 형식으로 변환
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줌
    var day = today.getDate();

    // 월과 일이 한 자릿수일 경우 앞에 0을 추가
    if (month < 10) {
        month = '0' + month;
    }
    if (day < 10) {
        day = '0' + day;
    }

    var formattedDate = year + '-' + month + '-' + day;

    // packageDate input 요소에 최소 날짜 설정
    document.getElementById("packageDate").setAttribute("min", formattedDate);
};


	/* 예약 인원 선택 및 가격 오르락 내리락 @@@@ */
	document.addEventListener('DOMContentLoaded', function() {
		// 패키지 가격을 JavaScript 변수로 설정
		const pricePerPerson = parseInt('${dto.packagePrice}', 10);
		// 인원 수 입력 필드와 총 금액 표시 요소 참조
		const quantityInput = document.getElementById('quantity');
		const totalPriceElement = document
				.getElementById('totalPriceFormatted');

		// 총 금액을 계산하고 업데이트하는 함수
		function updateTotalPrice() {
			// 현재 인원 수를 읽어옴
			const quantity = parseInt(quantityInput.value, 10);
			// 총 금액 계산
			const totalPrice = pricePerPerson * quantity;
			// 총 금액을 천 단위 구분 쉼표를 포함한 형식으로 변환
			const formattedPrice = totalPrice.toLocaleString();
			// 총 금액을 페이지에 표시
			totalPriceElement.textContent = formattedPrice;
		}

		// 인원 수 감소 버튼 클릭 시 처리
		document.getElementById('decrement').addEventListener('click',
				function() {
					let quantity = parseInt(quantityInput.value, 10);
					if (quantity > 1) {
						quantityInput.value = quantity - 1;
						updateTotalPrice(); // 총 금액 업데이트
					}
				});

		// 인원 수 증가 버튼 클릭 시 처리
		document.getElementById('increment').addEventListener('click',
				function() {
					let quantity = parseInt(quantityInput.value, 10);
					quantityInput.value = quantity + 1;
					updateTotalPrice(); // 총 금액 업데이트
				});

		// 페이지 로드 시 총 금액 초기화
		updateTotalPrice();
	});

	// 로그인 없이 예약 버튼 누를 시
	function alertAndRedirect() {
		alert('로그인이 필요합니다.');
		setTimeout(function() {
			window.location.href = '<c:url value="/memberLogin.do"/>';
		}, 500); // 0.5초 후 리다이렉트
	}

	// 예약 @@@@ 
	function reservePackage(packageNum) {
		document.packageForm.action = "reservePackage.do?packageNum="
				+ packageNum;
		document.packageForm.submit();
	}
</script>

<script type="text/javascript" src="resources/js/package.js" charset="utf-8"></script>

<%@ include file="../include/footer.jsp"%>
