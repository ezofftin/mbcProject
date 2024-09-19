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

<form action="hotelUpdateOk.do" method="post" enctype="multipart/form-data">
<table class="table table-border">
	<tbody>
		<tr>
			<td></td>
			<td><input type="text" class="form-control form-control-sm" name="hotelNum"
						id="hotelNum" value="${hotelDto.hotelNum}" readonly/></td>
		</tr>
		<tr>
			<td>숙소명</td>
			<td><input type="text" class="form-control form-control-sm" name="hotelName"
						id="hotelName" value="${hotelDto.hotelName}"/></td>
		</tr>
		<tr>
			<td>가격(1일)2</td>
			<td><input type="text" class="form-control form-control-sm" name="hotelPrice"
						id="hotelPrice" value="${hotelDto.hotelPrice}"/></td>
		</tr>
		<tr>
			<td>상세정보</td>
			<td><textarea class="form-control form-control-sm" name="hotelInfo"
						id="hotelInfo">${hotelDto.hotelInfo}</textarea></td>
		</tr>
		<tr>
			<td>사진</td>
			<td>
				<div id="existingImages">
					<c:forEach var="image" items="${fn:split(hotelDto.hotelImage, ',')}">
						<div class="input-group mb-2">
							<img src="<c:url value='/external/${image}' />" width="100px" class="me-2"/>
							<button type="button" class="btn btn-sm"  onclick="removeExistingImage(this, '${image}')">삭제</button>
						</div>
					</c:forEach>
				</div>
            <!-- 새 이미지 추가 기능 -->
				<div id="imageContainer">
					<div class="input-group mb-2">
						<input type="file" class="form-control form-control-sm" name="hotelImages" />
						<button type="button" class="btn btn-sm" onclick="removeImage(this)">삭제</button>
					</div>
				</div>
				<button type="button" class="btn btn-sm mt-2" onclick="addMoreImage()">사진 추가</button>
            
				<!-- 기존 이미지를 서버로 전송하기 위한 hidden input -->
				<input type="hidden" id="hotelImageOld" name="hotelImageOld" value="${hotelDto.hotelImage}" />
			</td>
		</tr>
		<tr>
			<td>예약현황</td>
			<td>
				<select class="form-select form-select-sm" name="hotelState" id="hotelState">
					<option value="예약가능">[예약가능]</option>
					<option value="예약불가">[예약불가]</option>
				</select>
		</tr>       
		<tr>
			<td>소유주 등록번호</td>
			<td><input type="text" class="form-control form-control-sm" name="hostNum" id="hostNum" value="${hotelDto.hostNum}"/></td>
		</tr>
		<tr>
			<td colspan="2" class="text-center">
				<input type="submit" class="btn btn-sm" value="수정완료"/>   
				<input class="btn btn-sm" value="취소" onclick="goBack()"/>   
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
	var container = document.getElementById('imageContainer');
    container.removeChild(button.parentElement);
}
/* 기존 이미지 삭제 */
function removeExistingImage(button, imageName) {
    var container = document.getElementById('existingImages');
    container.removeChild(button.parentElement);

    // 기존 이미지에서 삭제된 이미지를 제거하고 hidden input에 반영
    var oldImagesInput = document.getElementById('packageImageOld');
    var oldImages = oldImagesInput.value.split(',');
    var updatedImages = oldImages.filter(function(image) {
        return image !== imageName;
    });
    oldImagesInput.value = updatedImages.join(',');
}

function goBack() {
    window.history.back();
}
</script>