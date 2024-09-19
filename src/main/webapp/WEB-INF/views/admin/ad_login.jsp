<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%@ include file="../admin/ad_header.jsp" %>

<!-- 컨텐츠 -->
<div class="container w-50 mt-5 border shadow p-5 mb-5">	
	<h2>관리자 로그인</h2><br>
	
	<form action="adminLoginOk.do" method="post">
	  <div class="mb-3 mt-3">
	    <label for="id" class="form-label">관리자 아이디</label>
		<input type="text" class="form-control" id="adminId" placeholder="아이디" name="adminId" 
	    		value="<c:if test="${sessionScope.loginDTO.adminId !=null and loginErr != 'idErr'}">${sessionScope.loginDTO.adminId}</c:if>"/>
	  </div>	  
	  
	  <div class="mb-3">
	    <label for="password" class="form-label">관리자 비밀번호</label>
	    <input type="password" class="form-control" id="adminPw" placeholder="비밀번호" name="adminPw"/>
	  </div>
	  
	  		<c:if test="${requestScope.loginErr == 'idErr' || requestScope.loginErr == 'pwdErr'}">   
		    	<p class="text-danger text-center mt-3 mb-0" style="font-size:15px">관리자 아이디 또는 비밀번호 불일치!!</p><br>
		    </c:if>
		    
	  <div class="text-center">
	  	<button type="submit" class="btn btn-primary" style="width:150px">관리자 로그인</button>
<%-- 	  	<a href="<c:url value="/"/>" class="btn btn btn-outline-primary me-2" style="color:black">집앞제주 홈</a> --%>
	  </div>
	</form>
</div>

<%@ include file="../admin/ad_footer.jsp" %>