<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 천단위로 변경 -->

<%@ include file="../include/header.jsp" %>	

<style>/* 세로정렬 */
	td {vertical-align:middle;}
</style> 

<!-- msg 띄우는 것 -->
<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

  <!-- 자바스크립트 불러오기 --> 
  <!-- url "userJoinOk.do" 위치가 root에 있기때문에 "js/valid.js" -->
  <%--	주소  src="js/checkout.js"  == src="<c:url value="/js/checkout.js"/>" 같은내용
  
<script type="text/javascript" src="<c:url value="/js/checkout.js"/>" charset="utf-8"></script> --%>
<script type="text/javascript" src="resources/js/checkout.js" charset="utf-8"></script>


<div class="container w-75 mt-3">
	<h3>주문 / 결제</h3><br>
	<table class="table">
		<thead>
			<tr>								<!-- 체크박스.js 함수 확인해야함 -->
				<th>숙소명</th>
				<th>예약일자</th>
				<th>1일 예약가</th>
				<th>합계</th>
			</tr>
		</thead>
		<tbody> <!-- 장바구니 상품 출력 // 구매하기 진행시 보일부분 -->
				<!-- 총액 합계초기화 -->
				<tr>
					<td>${hDto.hotelName}</td>
					<td>${dto.checkin} ~ ${dto.checkout}</td>
					<td>
						<fmt:formatNumber value="${hDto.hotelPrice}"/>원<br/>
					</td>
					<td>
						<fmt:formatNumber value="${dto.totalPrice}"/>원<br/>
					</td>
					
					<!-- 총액 합계 계산 -->
					<c:set var="totalPrice" value="${dto.totalPrice}"/>
				</tr>
			<tr>							<!-- name="checkForm"은 checkout.js파일에서 사용됌 -->
				<!-- <form action="deleteCheckout.do" name="checkForm" method="post">
					<input type="hidden" name="delPnums"/> name="delPnums"은 checkout.js파일에서 사용하고 받음
					<td colspan="7">	
						<a href="javascript:prodDel()" class="btn btn-sm btn-outline-secondary">선택삭제</a>
					</td>
				</form> -->
			</tr>
		</tbody>
	</table><br/>
	<!-- 장바구니 총액표시 -->
	<%-- <div class="text-end">
		총액 : <fmt:formatNumber value="${totalPrice}"/> 원 <br>
	</div><br/> --%>
	
	<!-------------------------- 구매자 정보 -------------------------->
		<table class="table">
            <thead>
               <tr>
                  <th>구매자 정보</th>
               </tr>
            </thead>
            <tbody>
               <tr>
                  <td>이름</td>
                  <td>${mDto.memberName}</td>
               </tr>
               <tr>
                  <td>이메일</td>
                  <td>${mDto.memberEmail}</td>
               </tr>
               <tr>
                  <td>전화번호</td>
                  <td>${mDto.memberTel}</td>
               </tr>
               
               <tr>
                  <td><b>결제정보</b></td>
               </tr>
               <tr>
                  <td>총 주문금액</td>
                  <td><fmt:formatNumber value="${dto.totalPrice}"/> 원 </td>
               </tr>
               

               <tr>
                  <td>결제금액</td>
                  <td id="totPrice">
                      <fmt:formatNumber value="${dto.totalPrice}"/> 원
                  </td>
               </tr>
               
               <tr>
                  <td>결제방법</td>
                  <td>													<!-- "selPayment()" *.js 함수사용 -->
                     <label><input type="radio" name="payment" value="card" onclick="selPayment()" checked/> 신용카드</label>&nbsp;
                     <label><input type="radio" name="payment" value="rTransfer" onclick="selPayment()"/> 실시간 계좌이체</label>&nbsp;
                     <label><input type="radio" name="payment" value="deposit" onclick="selPayment()"/> 무통장 입금</label>&nbsp;
                     <label><input type="radio" name="payment" value="hp" onclick="selPayment()"/> 휴대폰 결제</label>&nbsp;
                  </td>
               </tr>
            </tbody>
         </table>
	<!--------------------------------------------------------------->
		
		<div id="card">
            카드선택 : <select>
               <option value="" selected>카드사 선택</option>
               <option value="samsung">삼성카드</option>
               <option value="shinhancard">신한카드</option>
               <option value="lotte">롯데카드</option>
               <option value="bc">비씨카드</option>
               <option value="hyundai">현대카드</option>
            </select><br/><br/>			<!-- 포인트 사용으로 50000원 밑으로 내려가는 경우의 수도 생각해봐야 함 -->
            할부기간 : <select <c:if test="${totalPrice < 50000}">disabled</c:if> >
               <option value="1" selected>일시불</option>
               <option value="2">2개월 무이자할부</option>
               <option value="3">3개월 무이자할부</option>
               <option value="4">4개월 무이자할부</option>
               <option value="5">5개월 무이자할부</option>
               <option value="6">6개월 무이자할부</option>
            </select><br/><br/>
         </div>
         <div id="rTransfer" style="display:none">
            은행선택 : <select>
               <option value="" selected>은행선택</option>
               <option value="kakao">카카오뱅크</option>
               <option value="woori">우리은행</option>
               <option value="kookmin">국민은행</option>
               <option value="shinhan">신한은행</option>
            </select>
         </div>
         <div id="deposit" style="display:none" >
            입금은행 : <select>
               <option value="" selected>은행선택</option>
               <option value="kakao">카카오뱅크</option>
               <option value="woori">우리은행</option>
               <option value="kookmin">국민은행</option>
               <option value="shinhan">신한은행</option>
            </select>
            <ul style="font-size:12px"><br>
               무통장 입금시 유의사항
               <li>입금완료 후 상품 품절로 인해 자동취소된 상품은 환불 처리해 드립니다.</li>
               <li>무통장입금 결제 시 부분취소가 불가하며 전체취소 후 다시 주문하시기 바랍니다.</li>
               <li>은행 이체 수수료가 발생될 수 있습니다. 입금시 수수료를 확인해주세요.</li>
            </ul>
         </div>
         <div id="hp" style="display:none" >
            통신사 : <select>
                  <option value="" selected>선택</option>
                  <option value="skt">SK</option>
                  <option value="lg">LG U+</option>
                  <option value="kt">KT</option>
            </select>
         </div>
         
	<!--------------------------------------------------------------->
	
	<div class="text-center"><br>
		<a href="paymentOk.do?reserveNum=${dto.reserveNum}" class="btn me-2">결제하기</a>
		<a href="hotelList.do" class="btn me-2">숙소리스트</a>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>