<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:if test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_header.jsp" %>
	</c:if>
	<c:if test="${sessionScope.mode != 'admin'}">
		<%@ include file="../include/header.jsp" %>
	</c:if>


<div class="container ms-5">
    <h3 class="text-center">공지사항</h3><br>   

    <!-- 검색 폼 -->
    <div>
        <form action="boardList.do" id="searchForm" method="post">
            <input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}"/>
            <div class="d-flex justify-content-center">
                <select class="form-select form-select-sm me-2" name="searchType" style="width:120px">
                    <option value="">선택</option>  
                    <option value="S" ${pDto.searchType == 'S' ? 'selected' : ''}>제목</option>  
                    <option value="C" ${pDto.searchType == 'C' ? 'selected' : ''}>내용</option>  
                    <option value="W" ${pDto.searchType == 'W' ? 'selected' : ''}>작성자</option>
                    <option value="SC" ${pDto.searchType == 'SC' ? 'selected' : ''}>제목 + 내용</option>  
                    <option value="SW" ${pDto.searchType == 'SW' ? 'selected' : ''}>제목 + 작성자</option>  
                    <option value="CW" ${pDto.searchType == 'CW' ? 'selected' : ''}>작성자 + 내용</option>  
                    <option value="SCW" ${pDto.searchType == 'SCW' ? 'selected' : ''}>제목 + 내용 + 작성자</option>  
                </select>
                <input type="text" id="keyword" name="keyword" placeholder="검색어 입력" style="width:150px" class="form-control rounded-0 rounded-start" value="${pDto.keyword}">
                <button class="btn rounded-0 rounded-end" style="background:#b69d7c; color:white; width:50px">
                    <i class="fa fa-search"></i>
                </button>
            </div>
        </form>
    </div>

    <!-- 페이지 및 게시글 수 선택 -->
    <div class="my-3 d-flex justify-content-between">
        <div class="ms-1">&nbsp;<b>${pDto.viewPage}</b> / ${pDto.totalPage} Pages</div>
        <div class="me-3">
            <select class="form-select form-select-sm" id="cntPerPage">
                <option value="5" ${pDto.cntPerPage == 5 ? 'selected' : '' }>게시글 5개</option>
                <option value="10" ${pDto.cntPerPage == 10 ? 'selected' : '' }>게시글 10개</option>
                <option value="20" ${pDto.cntPerPage == 20 ? 'selected' : '' }>게시글 20개</option>
                <option value="30" ${pDto.cntPerPage == 30 ? 'selected' : '' }>게시글 30개</option>
                <option value="50" ${pDto.cntPerPage == 50 ? 'selected' : '' }>게시글 50개</option>
            </select>
        </div>
    </div>
    
    <!-- 실제 게시판 -->
    <table class="table">
        <thead class="table-grey">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>등록일</th>
                <th>조회수</th>
                <c:if test="${sessionScope.mode == 'admin'}">
                	<th>삭제</th>
                </c:if>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="dto" items="${list}"> <!-- model 속성 list를 사용 -->
                <tr>
                    <td>${dto.bid}</td>
                    <td>
                        <a href="<c:url value='viewBoard.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}'/>">
                            <c:out value="${dto.subject}"/>
                            <b>[댓글 : ${dto.replyCnt}]</b>
                        </a>
                    </td>
                    <td><c:out value="${dto.writer}"/></td>
                    <td><c:out value="${dto.reg_date}"/></td>
                    <td>${dto.hit}</td>
                    <c:if test="${sessionScope.mode == 'admin'}">
					        <td>
	                        <button class='btn btn-sm' onclick="delBoard(${dto.bid}, ${pDto.viewPage}, '${pDto.searchType}', '${pDto.keyword}', ${pDto.cntPerPage})">삭제</button>
	                    </td>
                    </c:if>
                </tr>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="6" class="text-center">공지사항이 없습니다.</td>
                </tr>
            </c:if>
            <tr>
                <td colspan="6" class="text-center">
                    <button class="btn my-3" id="btn-write">글쓰기</button>
                </td>
            </tr>
        </tbody>
    </table><br>
    
    <!-- 페이지네이션 -->
    <ul class="pagination d-flex justify-content-center">
        <li class="page-item ${pDto.viewPage > 1 ? '' : 'disabled'}">
            <a class="page-link rounded-start" href="boardList.do?viewPage=${pDto.viewPage-1}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">&lt;</a>
        </li>
        <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
            <li class="page-item ${pDto.viewPage == i ? 'active' : ''}">
                <a class="page-link" href="boardList.do?viewPage=${i}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">${i}</a>
            </li>
        </c:forEach>
        <li class="page-item ${pDto.viewPage < pDto.totalPage ? '' : 'disabled'}">
            <a class="page-link rounded-end" href="boardList.do?viewPage=${pDto.viewPage+1}&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage=${pDto.cntPerPage}">&gt;</a>
        </li>
    </ul>
</div>

<script>
    // 글쓰기 버튼 클릭 이벤트
    $("#btn-write").click(() => {
        location.href="<c:url value='/registerBoard.do'/>";
    });

    // 게시글 수 변경 처리
    $("#cntPerPage").change(() => {
        let cntVal = $("#cntPerPage option:selected").val();
        location.href="<c:url value='boardList.do?viewPage=1&searchType=${pDto.searchType}&keyword=${pDto.keyword}&cntPerPage='/>" + cntVal;
    });

    // 게시글 삭제 처리
    function delBoard(bid, viewPage, searchType, keyword, cntPerPage) {
        if(confirm("정말 삭제하시겠습니까?")) {
            location.href="./removeBoard.do?bid=" + bid + "&viewPage=" + viewPage + "&searchType=" + searchType + "&keyword=" + keyword + "&cntPerPage=" + cntPerPage;
        }
    }
</script>

<c:if test="${sessionScope.mode == 'admin'}">
		<%@ include file="../admin/ad_footer.jsp" %>
	</c:if>
	<c:if test="${sessionScope.mode != 'admin'}">
		<%@ include file="../include/footer.jsp" %>
	</c:if>

