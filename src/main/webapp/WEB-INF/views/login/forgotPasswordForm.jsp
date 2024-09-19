<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>
    <link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet"/>

    <!-- 폰트어썸 -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
    <!-- bootstrap -->       
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .reset-container {
            width: 500px;
            margin: 150px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }

        .reset-container h2 {
            text-align: center;
            margin-bottom: 40px;
            font-weight: bold;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            font-size: 18px;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .reset-button {
            width: 100%;
            padding: 15px;
            background-color: #333333;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 18px;
            cursor: pointer;
        }

        .reset-button:hover {
            background-color: #555555;
        }

        .back-to-login {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #6c757d;
            font-size: 16px;
            text-decoration: none;
        }

        .back-to-login:hover {
            text-decoration: underline;
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
	
    <div class="reset-container">
        <h2>비밀번호 재설정</h2>

        <!-- 에러 메시지 또는 성공 메시지 표시 -->
        <c:if test="${not empty msg}">
            <div class="alert alert-warning">
                ${msg}
            </div>
        </c:if>

        <!-- 비밀번호 재설정 요청 폼 -->
        <form action="<c:url value='/forgotPassword.do'/>" method="post">
            <div class="form-group">
                <label for="uid">아이디:</label>
                <input type="text" id="uid" name="uid" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="uEmail">이메일:</label>
                <input type="email" id="uEmail" name="uEmail" class="form-control" required>
            </div>
            <button type="submit" class="reset-button">비밀번호 재설정</button>
        </form>

        <a href="<c:url value='/memberLogin.do'/>" class="back-to-login">로그인 페이지로 돌아가기</a>
    </div>
</body>
</html>
