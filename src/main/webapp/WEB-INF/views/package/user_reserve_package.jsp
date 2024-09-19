<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/header.jsp"%>

<form name="packageReserveForm" method="post">
	<div class="container">
	<h3>구매 확인</h3>
		<table class="table table-border">
			<tbody>
				<tr>
					<td>예약자명</td>
					<td>
						<input type="text" class="form-control form-control" value="${sessionScope.loginDTO.memberName}" disabled />
					</td>
				</tr>
				<tr>
					<td>상품명</td>
					<td>
						<input type="text" class="form-control" value="${dto.packageName}" disabled />
					</td>
				</tr>
				<tr>
					<td>일자</td>
					<td>
						<input type="date" id="packageDate" name="packageDate" value="${param.hiddenDate}" class="form-control">
					</td>
				</tr>
				<tr>
					<td>수량</td>
					<td>
						 <input type="number" class="form-control form-control" name="quantity" id="quantity" value="${param.hiddenQuantity}" min="1" />
                    </td>
					</td>
				</tr>
				<tr>
					<td>금액</td>
					<td>
				         <input type="text" name="totalPrice" id="totalPrice" value="${param.hiddenTotalPrice}" class="form-control" disabled> 원
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<c:if test="${sessionScope.loginDTO.memberId == null}">
							<a href="javascript:alert('로그인이 필요합니다.')" class="btn btn-success me-0" style="width: 200px; float: right">결제하기</a>
						</c:if>
						
						<!-- 돌아가기랑 결제하기 순서를 바꾸고 싶음... -->
						<c:if test="${sessionScope.loginDTO.memberId != null}">
							<a href="javascript:history.back()" class="btn btn-success me-0" style="width: 200px; float: right">돌아가기</a>
							<a href="javascript:reserveConfirm(${sessionScope.loginDTO.memberNum}, ${dto.packageNum})" class="btn btn-success me-0" style="width: 200px; float: right" type="submit">결제하기</a>
						</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<script type="text/javascript" src="resources/js/package.js" charset="utf-8"></script>

<%@ include file="../include/footer.jsp"%>

<script>

</script>
