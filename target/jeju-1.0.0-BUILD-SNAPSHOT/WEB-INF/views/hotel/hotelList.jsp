<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<!-- 달력 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    
<div class="searchContainer mt-5">
	<form action="hotelList.do" id="dateSearchForm" method="post">
		<!-- 날짜 선택기 -->
		<div class="date-picker">
			<label for="start-date">체크인 :</label>
			<input type="date" id="start-date" name="start-date">
			<label for="end-date">체크아웃 :</label>
			<input type="date" id="end-date" name="end-date">
			<button class="btn">날짜 검색</button>
		</div>
	</form>
</div>
<!-- 호텔리스트 -->
<div>
	<c:if test="${reserveList.size() != 0}">
		<div class="hotellist d-flex-inline">
			<c:forEach var="hotelDto" items="${hotelList}">		
				<!-- Card -->
				<%@include file="hotelListCard.jsp" %>
			</c:forEach>
		</div>
	</c:if>
</div>

<%@ include file="../include/footer.jsp" %>

<script>
//오늘 날짜를 구하는 함수
var today = new Date().toISOString().split('T')[0];

// start-date에 오늘 날짜를 설정
document.getElementById('start-date').setAttribute('min', today);
/* document.getElementById('end-date').setAttribute('min', today); */


// 공통 함수: 날짜 선택 시 비활성화된 날짜인지 확인
function handleDateInput(dateInput) {
	dateInput.addEventListener('input', function() {
	
		var selectedDate = this.value;
		if (disabledDates.includes(selectedDate)) {
			alert('이 날짜는 선택할 수 없습니다.');
			this.value = ''; // 선택된 날짜를 초기화
		}
	});

	// 날짜 필드에 min 속성 및 disabledDates를 설정
	dateInput.addEventListener('focus', function() {
	var date = new Date();
	var today = date.toISOString().split('T')[0];
	dateInput.min = today;
	
	// 특정 날짜를 비활성화하기 위해 유효하지 않은 날짜로 처리
	disabledDates.forEach(function(date) {
		if (dateInput.value === date) {
			alert('이 날짜는 선택할 수 없습니다.');
			dateInput.value = '';
	} else {
			dateInput.setAttribute('value', dateInput.value);
			}
		});
	});
}

// start-date와 end-date에 함수 적용
handleDateInput(document.getElementById('start-date'));
handleDateInput(document.getElementById('end-date'));
document.getElementById('dateSearchForm').addEventListener('submit', function() {});

document.getElementById('dateSearchForm').addEventListener('submit', function(event) {
	var startDate = document.getElementById('start-date').value;
	var endDate = document.getElementById('end-date').value;

	if (!startDate || !endDate) {
		alert('날짜를 선택해 주세요.');
		event.preventDefault(); // 폼 제출을 중단
	}
});

</script>