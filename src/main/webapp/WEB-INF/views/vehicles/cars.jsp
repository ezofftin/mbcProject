<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>

<div class="container mt-5 mb-5 p-50">

	<h3>Cars</h3> 
	<br>
	<div class="vehiclesTable">
		<table style="width:100%">
		<tr style="background-color:lightgrey">
			<th>사진</th>
			<th>업체명</th>		
			<th>전화번호</th>
			<th>영업시간</th>
			<th>위치(지도)</th>
		</tr>
		<tr>
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210902_24%2F163054619088884QKz_PNG%2FCQgZweeHR2DgA9oODNHofydq.png" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://jejurentcar.co.kr"/>" target="blank" style="text-decoration:none; color:#b69d7c">제주렌터카</a></td>	
			<td>1588-3301</td>		
			<td>07:30 ~ 22:00(연중무휴)</td>
			<td>제주특별자치도 제주시 용문로 8 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/Fk5dpZed' />'">지도보기</button></td>
		</tr>
		<tr>
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191119_220%2F15741532751138oAax_JPEG%2F%25B7%25CE%25B0%25ED.jpg" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://www.jejurobot.com"/>" target="blank" style="text-decoration:none; color:#b69d7c">로보트렌터카</a></td>		
			<td>0507-1401-0428</td>		
			<td>평일 09:00~18:00</td>
			<td>제주특별자치도 제주시 서해안로 442-53 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/5EQCEUpH' />'">지도보기</button></td>
		</tr>
		<tr>
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fnaverbooking-phinf.pstatic.net%2F20230901_149%2F1693560028384m8vvV_JPEG%2F%25B4%25D9%25BF%25EE%25B7%25CE%25B5%25E5.jpg" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://homepage.skcarrental.com"/>" target="blank" style="text-decoration:none; color:#b69d7c">SK렌터카</a></td>	
			<td>1599-9111</td>		
			<td>평일 09:00~18:00</td>
			<td>제주특별자치도 제주시 용문로 62 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/GFBn7yfZ' />'">지도보기</button></td>
		</tr>
		<tr>
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150820_82%2F1440035068922dFu3Q_JPEG%2FSUBMIT_1440035063241_11704744.jpg" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://www.lotterentacar.net/"/>" target="blank" style="text-decoration:none; color:#b69d7c">롯데렌터카</a></td>
			<td>064-751-8000</td>		
			<td>평일 08:30 ~ 19:00</td>
			<td>제주 제주시 공항로 2 제주국제공항 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/5TiWH09m' />'">지도보기</button></td>
		</tr>
	</table>
	</div>


</div>


<%@ include file="../include/footer.jsp" %>
