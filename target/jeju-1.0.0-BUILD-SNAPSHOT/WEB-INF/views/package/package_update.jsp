<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="../admin/ad_header.jsp" />

<div class="container w-50 mt-5">
    <h3>프로모션 상품 수정</h3>
    <br>
    <form action="updatePackageOk.do" method="post" enctype="multipart/form-data">
        <table class="table table-borderless">
            <tbody>
                <tr>
                    <td>번호</td>
                    <td><input type="text" class="form-control form-control-sm" name="packageNum" value="${dto.packageNum}" readonly /></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td><input type="text" class="form-control form-control-sm" name="packageName" value="${dto.packageName}" /></td>
                </tr>
                <tr>
                    <td>이미지</td>
                    <td>
                        <!-- 현재 등록된 이미지를 표시하고, 삭제할 수 있도록 구현 -->
                        <div id="existingImages">
                            <c:forEach var="image" items="${fn:split(dto.packageImage, ',')}">
                                <div class="input-group mb-2">
                                    <img src="<c:url value='/external/${image}' />" width="100px" class="me-2"/>
                                    <button type="button" class="btn btn-sm btn-danger" onclick="removeExistingImage(this, '${image}')">삭제</button>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- 새 이미지 추가 기능 -->
                        <div id="imageContainer">
                            <div class="input-group mb-2">
                                <input type="file" class="form-control form-control-sm" name="packageImages" />
                                <button type="button" class="btn btn-sm btn-danger" onclick="removeImage(this)">삭제</button>
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-secondary mt-2" onclick="addMoreImage()">사진 추가</button>
                        
                        <!-- 기존 이미지를 서버로 전송하기 위한 hidden input -->
                        <input type="hidden" id="packageImageOld" name="packageImageOld" value="${dto.packageImage}" />
                    </td>
                </tr>
                <tr>
                    <td>가격</td>
                    <td><input type="text" class="form-control form-control-sm" name="packagePrice" value="${dto.packagePrice}" /></td>
                </tr>
                <tr>
                    <td>사양</td>
                    <td>
                        <select class="form-select form-select-sm" name="packageType">
                            <c:forEach var="type" items="${packTypes}">
                                <option value="${type.name()}" ${type.name() == dto.packageType ? 'selected' : ''}>${type.getValue()}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>소개</td>
                    <td><textarea class="form-control" name="packageInfo" rows="3">${dto.packageInfo}</textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="text-center"><br> 
                        <input type="submit" class="btn btn-sm btn-primary" value="수정" /> 
                        <input type="reset" class="btn btn-sm btn-secondary" value="취소" /> 
                        <a href="packageList.do" class="btn btn-sm btn-outline-primary">Hot Deals 리스트</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</div>

<jsp:include page="../admin/ad_footer.jsp" />

<script>
/* 이미지 추가 */
function addMoreImage() {
    var newInputGroup = document.createElement('div');
    newInputGroup.className = 'input-group mb-2';

    var newFileInput = document.createElement('input');
    newFileInput.type = 'file';
    newFileInput.className = 'form-control form-control-sm';
    newFileInput.name = 'packageImages';

    var deleteButton = document.createElement('button');
    deleteButton.type = 'button';
    deleteButton.className = 'btn btn-sm btn-danger';
    deleteButton.textContent = '삭제';
    deleteButton.onclick = function() {
        removeImage(this);
    };

    newInputGroup.appendChild(newFileInput);
    newInputGroup.appendChild(deleteButton);

    document.getElementById('imageContainer').appendChild(newInputGroup);
}

/* 새로 추가한 이미지 삭제 */
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
</script>
