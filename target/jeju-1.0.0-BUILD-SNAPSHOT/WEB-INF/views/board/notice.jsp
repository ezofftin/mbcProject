<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<c:if test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_header.jsp" %>
	</c:if>
	<c:if test="${sessionScope.mode != 'admin'}">
		<%@ include file="../include/header.jsp" %>
	</c:if>


<div class="container w-50 mt-5 p-5 shadow">
    <h4 class="text-center">글 상세보기</h4><br>
    <form action="modifyBoard.do" method="post" id="boardForm">
        <input type="hidden" name="viewPage" value="${pDto.viewPage != null ? pDto.viewPage : 1}">
        <input type="hidden" name="cntPerPage" value="${pDto.cntPerPage != null ? pDto.cntPerPage : 10}">
        <input type="hidden" name="searchType" value="${pDto.searchType != null ? pDto.searchType : ''}">
        <input type="hidden" name="keyword" value="${pDto.keyword != null ? pDto.keyword : ''}">

        <div class="form-group">       
            <label for="bid">번호</label>    
            <input class="form-control" type="text" id="bid" name="bid" value="${dto.bid}" readonly>
        </div><br> 

        <div class="form-group">       
            <label for="subject">제목</label>       
            <input class="form-control" type="text" id="subject" name="subject" value="${dto.subject}" disabled>      
        </div><br> 

        <div class="form-group">       
            <label for="contents">내용</label> 
            <textarea class="form-control mt-2" name="contents" id="contents" disabled>${dto.contents}</textarea>
        </div><br> 

        <div class="form-group">       
            <label for="writer">작성자</label>
            <input class="form-control mt-2" type="text" id="writer" name="writer" value="${dto.writer}" disabled><br>
        </div><br> 

        <div class="text-center mt-3">
        	<c:if test="${sessionScope.mode=='admin'}">
	            <button type="button" id="btn-modify" class="btn me-2">수정하기</button>   
	            <button type="submit" id="btn-save" class="btn" style="display:none;">저장하기</button>   
            </c:if>
            <a href="boardList.do?viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}" 
               id="btn-list" class="btn">리스트</a>
        </div>
    </form>
</div>

<script>
    document.getElementById('btn-modify').onclick = function() {
        // 수정 가능하도록 필드 활성화
        document.getElementById('subject').disabled = false;
        document.getElementById('contents').disabled = false;
        
        // 수정 버튼 숨기고 저장 버튼 보이게
        document.getElementById('btn-modify').style.display = 'none';
        document.getElementById('btn-save').style.display = 'inline-block';
    }
</script>

<c:if test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_footer.jsp" %>
	</c:if>
	<c:if test="${sessionScope.mode != 'admin'}">
		<%@ include file="../include/footer.jsp" %>
	</c:if>
