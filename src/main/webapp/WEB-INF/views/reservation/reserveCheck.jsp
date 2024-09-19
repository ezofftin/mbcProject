<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="../include/header.jsp" %>
<!-- 달력 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link href="<c:url value="resources/css/reservation.css"/>" rel="stylesheet"/>
<!-- ------------ -->
<form name="reserveForm" method="post" enctype="multipart/form-data">
	<div class="container">
		<table class="table table-border" >
			<tbody>
				<%-- <tr>
					<td>예약자 번호</td>
					<td>
						<input type="number" class="form-control form-control-sm" name="memberNum" id="memberNum" 
								value="${sessionScope.loginDTO.memberNum}" readonly/>
					</td>
				</tr>
				<tr>
					<td>호텔번호</td>
					<td>
						<input type="number" class="form-control form-control-sm" name="hotelNum" id="hotelNum" 
								value="${hotelDto.hotelNum}" readonly/>
					</td>
				</tr> --%>
				<tr>
					<td>예약자명</td>
					<td>
						<input type="text" class="form-control"
								value="${sessionScope.loginDTO.memberName}" readonly/>
					</td>
				</tr>
				<tr>
					<td>호텔명</td>
					<td>
						<input type="text" class="form-control" value="${hotelDto.hotelName}" readonly/>
					</td> 
				</tr>
				<tr>
					<td>예약일자</td>
					<td>
						<div class="date-picker ms-0">
							<label for="start-date">체크인 :</label>
							<input type="date" id="checkin" name="checkin">
							<label for="end-date">체크아웃 :</label>
							<input type="date" id="checkout" name="checkout">
						</div>
					</td>
				</tr>
				<tr>
					<td>예약인원</td>
					<td><input type="text" name="people" id="people"/>명</td>
				</tr>
				<tr>
					<td>상세정보</td>
					<td>
						<textarea class="form-control form-control" readonly>${hotelDto.hotelInfo}</textarea>
					</td>
				</tr>
				<tr>
					<td>1일 숙박가</td>
					<td>
						<input type="text" id="hotelPrice"
							 name="hotelPrice" value="<fmt:formatNumber value='${hotelDto.hotelPrice}' pattern='#,###' />" readonly /> 원
					</td>
				</tr>
				<tr>
					<td>총액
					<input type="button" id="btn" value="계산하기" onclick="totPay()"></td>
					<td>
				        <input name="totalPriceDisplay" id="totalPrice" readonly /> 원
				        <input type="hidden" name="totalPrice" id="totalPriceHidden" />  <!-- 숨겨진 필드에 int 타입으로 변환된 값을 저장 -->
				        
				    </td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<c:if test="${sessionScope.loginDTO.memberId == null}">
							<a href="javascript:alert('로그인이 필요합니다.')" 
								class="btn me-0" style="width:200px ; float:right" >예약하기</a>
						</c:if>
						<c:if test="${sessionScope.loginDTO.memberId != null}">
							<a href="javascript:reserveConfirm(${sessionScope.loginDTO.memberNum}, ${hotelDto.hotelNum})" 
								class="btn me-0" style="width:200px ; float:right" type="submit">예약하기</a>
						</c:if>
					</td>
				</tr>
			</tbody>	
		</table>
	</div>
</form>
<%@ include file="../include/footer.jsp" %>
<script>

var today = new Date().toISOString().split('T')[0];
document.getElementById('checkin').setAttribute('min', today);

// 서버에서 예약된 날짜들을 JSP로 전달
// 	var disabledDates = ${reservedDates};

//공통 함수: 날짜 선택 시 비활성화된 날짜인지 확인
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

//start-date와 end-date에 함수 적용
handleDateInput(document.getElementById('checkin'));
handleDateInput(document.getElementById('checkout'));

document.getElementById('dateSearchForm').addEventListener('submit', function() {});

function reserveConfirm(memberNum, hotelNum) {
	var totalPrice = document.getElementById('totalPrice').value;
    var checkin = document.getElementById('checkin').value; 
    var checkout = document.getElementById('checkout').value;
    var people = document.getElementById('people').value;
    
    if (!checkin || checkin === "" || !checkout || checkout === "") {
        alert('예약일자를 선택해 주세요. 하루 예약을 원하실 경우 체크인과 체크아웃 날짜를 동일하게 선택해 주세요');
        return;
    }
    if (!people || people === "") {
        alert('인원을 입력해 주세요.');
        return;
    }
    if (!totalPrice || totalPrice === "" || totalPrice === "NaN") {
        alert('총액을 계산해 주세요.');
        return;
    }
    
    // 천단위 콤마 제거 후 int 타입으로 변환
    totalPrice = parseInt(totalPrice.replace(/,/g, ''), 10);
    
    // totalPrice를 hidden input에 설정하여 전달
    document.getElementById("totalPriceHidden").value = totalPrice;
	document.reserveForm.action="reserveCheckOk.do?memberNum="+memberNum+"&hotelNum="+hotelNum;
	document.reserveForm.submit();
}

function totPay() {
	 // 입력된 날짜 가져오기
	var checkinDate = document.getElementById('checkin').value;
    var checkoutDate = document.getElementById('checkout').value;
    
 // 날짜를 Date 객체로 변환
    var date1 = new Date(checkinDate);
    var date2 = new Date(checkoutDate);
    
	// 날짜가 유효한지 확인 (체크인과 체크아웃이 선택되지 않으면 계산하지 않음)
	if (!date1 || !date2 || date1 > date2) {
		/* document.getElementById("totalPrice").value = "날짜를 올바르게 선택해주세요."; */
		javascript:alert('날짜를 올바르게 선택해주세요.');
		return;
	}

	// 기간 계산하기
	var period = (date2-date1) / (1000* 3600 * 24);
	if(date2 === date1){
		period = 1;
	}

	// 총액 계산하기
	
	var price = parseInt(document.getElementById('hotelPrice').value.replace(/,/g, ''), 10); // 천단위 콤마 제거 후 숫자로 변환
	var totalPrice = period * price;
	
	document.getElementById("totalPrice").value = totalPrice.toLocaleString();
	document.getElementById("totalPriceHidden").value = totalPrice;
}





</script>
