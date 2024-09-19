<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../admin/ad_header.jsp"%>

<div class="container w-50 mt-5 border shadow p-5">
    <h3>프로모션 상품 등록</h3><br>
    
    <form action="packageRegisterOk.do" method="post" enctype="multipart/form-data">
        <table class="table table-borderless">
            <tbody>
                <tr>
                    <td>이름</td>
                    <td><input type="text" class="form-control form-control-sm" name="packageName" /></td>
                </tr>
                <tr>
                    <td>이미지</td>
                    <td>
                        <div id="imageContainer">
                            <div class="input-group mb-2">
                                <input type="file" class="form-control form-control-sm" name="packageImages" />
                                <button type="button" class="btn btn-sm btn-danger" onclick="removeImage(this)">삭제</button>
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-secondary mt-2" onclick="addMoreImage()">사진 추가</button>
                    </td>
                </tr>
                <tr>
                    <td>가격</td>
                    <td><input type="text" class="form-control form-control-sm" name="packagePrice" /></td>
                </tr>
                <tr>
                    <td>타입</td>
                    <td>
                        <select class="form-select form-select-sm" name="packageType">
                            <c:forEach var="type" items="${packTypes}">
                                <option value="${type.name()}">${type.getValue()}</option>
                            </c:forEach>    
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>정보</td>
                    <td>
                        <textarea class="form-control" name="packageInfo" rows="3"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="text-center"><br>
                        <input type="submit" class="btn btn-sm btn-primary" value="등록" />
                        <a href="packageList.do" class="btn btn-sm btn-outline-primary">취소</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</div>

<script>
/* 이미지 추가 */
function addMoreImage() {
    // Create a new input group for file input and delete button
    var newInputGroup = document.createElement('div');
    newInputGroup.className = 'input-group mb-2';

    // Create a new file input element
    var newFileInput = document.createElement('input');
    newFileInput.type = 'file';
    newFileInput.className = 'form-control form-control-sm';
    newFileInput.name = 'packageImages';

    // Create a new delete button
    var deleteButton = document.createElement('button');
    deleteButton.type = 'button';
    deleteButton.className = 'btn btn-sm btn-danger';
    deleteButton.textContent = '삭제';
    deleteButton.onclick = function() {
        removeImage(this);
    };

    // Append the file input and delete button to the input group
    newInputGroup.appendChild(newFileInput);
    newInputGroup.appendChild(deleteButton);

    // Append the input group to the container
    var container = document.getElementById('imageContainer');
    container.appendChild(newInputGroup);
}

/* 이미지 삭제 */
function removeImage(button) {
    // Get the input-group div containing the file input and delete button
    var inputGroup = button.parentElement;
    
    // Remove the input-group div from the container
    inputGroup.remove();
}
</script>

<%@ include file="../admin/ad_footer.jsp"%>
