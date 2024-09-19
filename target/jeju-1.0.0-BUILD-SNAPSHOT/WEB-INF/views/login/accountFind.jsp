<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계정 찾기</title>
    <link href="<c:url value='/resources/css/style.css'/>" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
  										<!-- 폰트어썸 -->
  	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
  	<!-- bootstrap -->       
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet"/>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	
    <style>
        .find-account-container {
            width: 500px;
            margin: 150px auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            text-align: center;
        }

        .find-account-container h2 {
            margin-bottom: 40px;
            font-weight: bold;
            font-size: 24px;
        }

        .option-buttons a {
            display: block;
            width: 100%;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
            font-weight: bold;
            font-size: 18px;
            text-decoration: none;
            color: white;
        }

        .option-buttons a.btn-primary {
            background-color: #007bff;
        }

        .option-buttons a.btn-secondary {
            background-color: #6c757d;
        }

        .option-buttons a.btn-primary:hover {
            background-color: #0056b3;
        }

        .option-buttons a.btn-secondary:hover {
            background-color: #5a6268;
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
    <div class="find-account-container">
        <h2>계정 찾기</h2>
        <div class="option-buttons">
            <a href="<c:url value='/forgotId.do'/>" class="btn btn-primary">아이디 찾기</a>
            <a href="<c:url value='/forgotPassword.do'/>" class="btn btn-secondary">비밀번호 찾기</a>
        </div>
    </div>
</body>
</html>
