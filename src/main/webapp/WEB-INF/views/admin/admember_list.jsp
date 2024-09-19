<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ include file="../admin/ad_header.jsp" %>

<!-- msg 띄우는 것 -->
<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>

<!-- 컨텐츠 -->
<div class="container mt-5 border shadow p-5 mb-5">   
   <h2>멤버 리스트</h2><br>
   <table class="table">
   		<thead class='table-dark'>
   			<tr>
   				<th>번호</th>
   				<th>아이디</th>
   				<th>비밀번호</th>
   				<th>이름</th>
   				<th>전화번호</th>
   				<th>이메일</th>
   				<th>멤버타입</th>
   				<!-- <th>참고항목</th> -->
   				<th>수정</th>
   				<th>삭제</th>
   			</tr>
   		</thead>
   		<tbody>
   			<c:forEach var="dto" items="${requestScope.list}">
      		<tr>
      			<th>${dto.memberNum}</th>
   				<th>${dto.memberId}</th>
   				<th>${dto.memberPw.substring(0,4)}</th>
   				<th>${dto.memberName}</th>
   				<th>${dto.memberTel}</th>
   				<th>${dto.memberEmail}</th>
   				<th>${dto.memberType}</th>
   				<%-- <th>${dto.plus_addr}</th> --%>
   				<th><a href="adminMemberUpdate.do?no=${dto.memberNum}" class="btn btn-sm btn-info">수정</a></th>
   				<th><a href="adminMemberDelete.do?no=${dto.memberNum}" class="btn btn-sm btn-danger">삭제</a></th>
   			</tr>
   			</c:forEach>
   		</tbody>
   </table>
</div>


<%@ include file="../admin/ad_footer.jsp" %>