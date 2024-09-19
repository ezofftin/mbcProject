<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <!-- CSS 및 JavaScript 라이브러리 추가 -->
    <link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet"/>
    <!-- 부트스트랩 또는 다른 CSS 프레임워크 사용 가능 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  										<!-- 폰트어썸 -->
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
  	<!-- bootstrap -->       
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	

    <style>
        .forgot-id-container {
            width: 400px;
            margin: 100px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }
        .forgot-id-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .submit-button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-button:hover {
            background-color: #0056b3;
        }
    </style>


</head>
<body>
   <div class="logo p-3 mt-2" style="background-color:white; width=100%">
	  <ul class="navbar-nav w-100 mt-2">
		<li class="container nav-item mt-3">
			<a href="<c:url value="/"/>" target="_self" style="text-decoration:none; color:black; word-spacing: 10px; font-size:25px; font-weight: bolder">
			<i class="far fa-compass"></i>
			    집 앞 제 주
			</a>  
		</li>
	   </ul>			
	</div> 	  
    <div class="forgot-id-container">
        <h2>아이디 찾기</h2>
        
        <!-- 서버에서 전달된 메시지 표시 -->
        <c:if test="${not empty msg}">
            <div class="alert alert-warning">
                ${msg}
            </div>
        </c:if>
        
        <!-- 아이디 찾기 폼 -->
        <form action="<c:url value='/forgotId.do'/>" method="post">
            <div class="form-group">
                <label for="uName">이름:</label>
                <input type="text" id="uName" name="uName" required>
            </div>
            <div class="form-group">
                <label for="uEmail">이메일:</label>
                <input type="email" id="uEmail" name="uEmail" required>
            </div>
            <button type="submit" class="submit-button">아이디 찾기</button>
        </form>
        
        <!-- 로그인 페이지로 돌아가기 링크 -->
        <div class="form-group">
            <a href="<c:url value='/memberLogin.do'/>">로그인 페이지로 돌아가기</a>
        </div>
    </div>
</body>
</html>
