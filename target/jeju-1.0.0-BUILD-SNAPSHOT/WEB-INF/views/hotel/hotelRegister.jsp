<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:choose>
	<c:when test="${sessionScope.mode == 'user'}">
		<%@ include file="../include/header.jsp" %>
	</c:when>
	<c:when test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_header.jsp" %>
	</c:when>
</c:choose>
<form action="hostHotelRegister.do" method="post" enctype="multipart/form-data">
	<table class="table table-border">
		<tbody>
			<tr>
				<td>숙소명</td>
				<td><input type="text" class="form-control form-control-sm" name="hotelName" id="hotelName"/></td>
			</tr>
			<tr>
				<td>가격(1일)</td>
				<td><input type="text" class="form-control form-control-sm" name="hotelPrice" id="hotelPrice"/></td>
			</tr>
			<tr>
				<td>상세정보</td>
				<td><textarea class="form-control form-control-sm " name="hotelInfo" id="hotelInfo"></textarea></td>
			</tr>
			<tr>
				<td>사진</br>
					<button type="button" class="btn btn-sm btn-secondary" onclick="addMoreImage()">사진추가</button>
				</td>
				<td>
					<div id="imageContainer">
						<div>
							<input type="file" class="form-control form-control-sm" name="hotelImages" id="hotelImages"/></td>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>예약현황</td>
				<td>
					<select class="form-select form-select-sm" name="hotelState" id="hotelState">
						<option value="예약가능">[예약가능]</option>
						<option value="예약불가">[예약불가]</option>
					</select>
				</td>
			</tr>  
			<tr>
				<td>소유주 회원번호</td>
				<td>
					<c:choose>
						<c:when test="${sessionScope.mode == 'user'}">
							<input type="text" class="form-control form-control-sm" name="hostNum" id="hostNum"
					 				readonly value="${sessionScope.loginDTO.memberNum}"/>
						</c:when>
						<c:when test="${sessionScope.mode == 'admin'}">
							<input type="text" class="form-control form-control-sm" name="hostNum" id="hostNum"/>
						</c:when>
					</c:choose>
					
				</td>
			</tr>     
			<tr>
				<td colspan="2" class="text-center">
					<input type="submit" class="btn btn-sm" value="등록"/>   
					<input type="reset" class="btn btn-sm" value="취소"/>   
				</td>
			</tr>
		</tbody>         
	</table>
</form>
<c:choose>
	<c:when test="${sessionScope.mode == 'user'}">
		<%@ include file="../include/footer.jsp" %>
	</c:when>
	<c:when test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_footer.jsp" %>
	</c:when>
</c:choose>

<script>
function addMoreImage() {
	var newInputGroup = document.createElement('div');
	newInputGroup.className = 'input-group mb-2';
	
	var newFileInput = document.createElement('input');
	newFileInput.type= 'file';
	newFileInput.className='form-control form-control-sm';
	newFileInput.name='hotelImages';
	
	var deleteButton = document.createElement('button');
	deleteButton.type='button';
	deleteButton.className='btn btn-sm btn-danger';
	deleteButton.textContent = '삭제';
	deleteButton.onclick = function() {
		removeImage(this);
	};
	
	newInputGroup.appendChild(newFileInput);
	newInputGroup.appendChild(deleteButton);
	
	var container = document.getElementById('imageContainer');
	container.appendChild(newInputGroup);
}

function removeImage(button) {
	var inputGroup = button.parentElement;
	inputGroup.remove();
}
</script>