<%@page import="com.mbc.jeju.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp" %>	

<!-- msg 띄우는 것 -->
<c:if test="${requestScope.msg != null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>


<div class="container w-50 mt-5 border shadow p-5">
   <form action="MemberUpdateOk.do" method="post" name="joinForm" onsubmit="return inputChk();"> 
      <h3 class="text-center">멤버정보 수정</h3>      
          <input type='hidden' name='no' value='${dto.getMemberNum()}'> 
              <div class="mt-3 mb-2 text-end">                                        
               <b>${dto.getMemberName()} 님의 멤버정보</b>                                                        
         	  </div>
		      	  <div class="mt-2 mb-2">
			         <!-- <lable for="id">번호 : 수정불가</lable> -->
			         <input type="hidden" class="form-control" id="no" name="no" value="${dto.memberNum}" readonly/>
			      </div>		      			      	      			      		       
			      <div class="mb-2">
			         <lable for="id">아이디</lable>
			         <input type="text" class="form-control" id="id" name="id" value="${dto.memberId}" readonly/>
			      </div>
			      <div class="mb-2">
			         <!-- <lable for="pw">비밀번호 : 수정불가(비밀번호 패널에서 수정하세요)</lable> -->
			         <input type="hidden" class="form-control" id="pw" name="pw" value="${dto.memberPw}" readonly/>
			      </div>			      
			      <div class="mb-2">
			         <!-- <lable for="pwConfirm">비밀번호 확인 : 수정불가(비밀번호 패널에서 수정하세요)</lable> -->
			        
			         <input type="hidden" class="form-control" id="pwConfirm" name="pwConfirm" value="${dto.memberPw}" readonly/>
			      </div>
		      		
			      <div class="mb-2">
			         <lable for="name">이름</lable>
			         <input type="text" class="form-control" id="name" name="name" value="${dto.memberName}"/>
			      </div>		      
<%-- 			      <div class="mb-2">
			         <lable for="name">나이</lable>
			         <input type="text" class="form-control" id="age" name="age" value="${dto.age}"/>
			      </div> --%>
			      <div class="mb-2">
			         <lable for="tel">전화번호</lable>
			         <input type="text" class="form-control" id="tel" name="tel" value="${dto.memberTel}"/>
			      </div>
			      <div class="mb-2">
			         <lable for="email">이메일</lable>
			         <input type="text" class="form-control" id="email" name="email" value="${dto.memberEmail}" readonly/>
			      </div>

         
          <div class="text-center mt-3"><br>
            
            <a href="..home" class="btn btn-sm btn-info">홈으로</a>            
          </div>
   </form>
</div> 
  
  <!-- ?v=${now.time}: 캐시 때문에 js 적용 안 될 때 사용 -->
  <%-- <script type="text/javascript" src="resources/js/valid.js?v=${now.time}" charset="utf-8"></script> --%>
  <script type="text/javascript" src="resources/js/valid.js" charset="utf-8"></script>
  
   
<%@ include file="../include/footer.jsp" %>





















