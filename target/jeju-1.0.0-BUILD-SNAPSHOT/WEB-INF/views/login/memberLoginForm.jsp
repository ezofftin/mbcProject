<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .login-container {
            width: 400px;
            margin: 150px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            font-size: 16px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .login-button {
            width: 100%;
            padding: 12px;
            background-color: #333333;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        .login-button:hover {
            background-color: #555555;
        }

        .signup-button {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            display: block;
        }

        .signup-button:hover {
            background-color: #5a6268;
        }

        .forgot-password {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #6c757d;
            font-size: 14px;
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .social-login {
            margin-top: 20px;
            text-align: center;
        }

        .kakao-login img {
            width: 80%; /* 크기 조정 */
            border-radius: 4px;
            cursor: pointer;
            margin: 0 auto; /* 중앙 정렬 */
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

    <div class="login-container">
        <h2>로그인</h2>
        <form action="<c:url value='/memberLogin.do'/>" method="post">
            <div class="form-group">
                <label for="id">아이디:</label>
                <input type="text" id="memberId" name="memberId" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="pw">비밀번호:</label>
                <input type="password" id="memberPw" name="memberPw" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary login-button">로그인</button>
        </form>
        <button class="signup-button" onclick="window.location.href='<c:url value='/memberRegister.do' />'">회원가입</button>
        <a href="<c:url value='/accountFind.do'/>" class="forgot-password">계정 찾기</a>

        <div class="social-login">
            <a class="kakao-login" href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=20b6f1160d8bfff6964dbd006007d8f6&redirect_uri=http://localhost:8088/jeju/kakao/auth">
                <img src="<c:url value='/resources/imgs/kakao_login_medium_narrow.png'/>" alt="카카오 로그인" style="width:183px; height:45px">
            </a>
        </div>
    </div>
</body>
</html>
