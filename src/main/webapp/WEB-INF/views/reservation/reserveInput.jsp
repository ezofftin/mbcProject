<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<!-- 달력 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!-- ------------ -->
<form action="reserveCheck.do" method="post" enctype="multipart/form-data">
	<div class="container">
	<table class="table table-border" >
		<tbody>
			<tr>
				<!-- 예약번호:hidden -->
				<td>
				<input type="hidden" class="form-control form-control-sm" name="reserveNum" id="reserveNum" readonly/>
				</td>
			</tr>
			<tr>
				<td>예약자명</td>
				<td>
				<input type="text" class="form-control form-control" name="memberName" value="${sessionScope.loginDTO.memberName}" readonly/>
				</td>
			</tr>
			<tr>
				<td>호텔명</td>
				<td>
				<input type="text" class="form-control" name="hotelName" value="${hotelDto.hotelName}" readonly/>
				</td>
			</tr>
			<tr>
				<td>예약일자</td>
				<td>
					<!-- <input name="checkin" id="checkin" autocomplete="off" readonly/> -->
					<div class="date-picker ms-0">
		            <label for="start-date">체크인 :</label>
		            <input type="date" id="checkin" name="checkin">
		            <label for="end-date">체크아웃 :</label>
            		<input type="date" id="checkout" name="checkout">
	            </div>
				</td>
				<!-- <td>예약종료일자</td>
				<td>
					<input name="checkout" id="checkout" autocomplete="off" readonly/>
				</td> -->
			</tr>
			<tr>
				<td>예약인원</td>
				<td><input type="text" class="form-control form-control" name="people" id="people"/>명</td>
			</tr>
			<tr>
				<td>상세정보</td>
				<td>
				<input type="text" class="form-control form-control" name="hotelInfo" value="${hotelDto.hotelInfo}" readonly/>
				</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
				<input type="text" class="form-control form-control" name="hotelPrice" value="${hotelDto.hotelPrice}" readonly/>원
				</td>
			</tr>
			<tr>
            <td colspan="2" class="text-center">
               <a href="reserveCheck.do" 
			    		class="btn btn-success me-0" style="width:200px ; float:right" type="submit">결재하기</a>
		      </td>
         </tr>
		</tbody>	
	</table>
		
		
	</div>
</form>
<%@ include file="../include/footer.jsp" %>

