<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<%@ include file="../admin/ad_header.jsp" %>

<div class="container w-50 mt-5 p-5 shadow">
	<form action="<c:url value='modifyBoard.do'/>" method="post">
		<!-- Post 방식으로 전달할 히든 필드들 -->
		<input type="hidden" name="viewPage" value="${pDto.viewPage}"/>
		<input type="hidden" name="searchType" value="${pDto.searchType}"/>
		<input type="hidden" name="keyword" value="${pDto.keyword}"/>
		<input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}"/>
      
		<h4 class="text-center">글 수정하기</h4><br>
      
		<div class="form-group">
      		<label for="bid">번호</label>
		 	<input class="form-control" type="text" id="bid" name="bid" value="${dto.bid}" readonly>
		</div><br> 
		
		<div class="form-group">
      		<label for="subject">제목</label>
		  	<input class="form-control" type="text" id="subject" name="subject" value="${dto.subject}" required>      
	    </div><br> 
	      	
	    <div class="form-group">
      		<label for="contents">내용</label> 
	     	<textarea class="form-control mt-2" name="contents" id="contents" required><c:out value="${dto.contents}"/></textarea>
	    </div><br> 
	      	
	    <div class="form-group">
      		<label for="writer">작성자</label>
	      	<input class="form-control mt-2" type="text" id="writer" name="writer" value="${dto.writer}" disabled>
	    </div><br> 
	     	
	    <div class="text-center mt-3"> 
	        <button id="btn-modify" type="submit" class="btn btn-primary me-2">수정</button>
	        <button id="btn-remove" type="button" class="btn btn-danger me-2">삭제</button>   
	        <button id="btn-list" type="button" class="btn btn-primary">리스트</button>    
	    </div> 
	</form>
</div>

<script>
	// 리스트 버튼 클릭 시 리스트 페이지로 이동
	$("#btn-list").click(() => {
		location.href="<c:url value='/boardList.do?viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
	});
	
 	// 삭제 버튼 클릭 시 삭제 처리
 	$("#btn-remove").click(() => {
		if(confirm("정말 삭제하시겠습니까?")) {
			location.href="<c:url value='/removeBoard.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>";
		}
	});
</script>

<%@ include file="../admin/ad_footer.jsp" %>
