<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>

<div class="container mt-5 mb-5 p-50">

	<h3>Shuttle Bus</h3> 
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
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20221213_119%2F16709244619932LmjE_JPEG%2FKakaoTalk_20221213_183625363_03.jpg" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://naver.me/GZAwWLyg"/>" target="blank" style="text-decoration:none; color:#b69d7c">제주라인스쿠터</a></td>	
			<td>0507-1449-0232</td>		
			<td>07:00 ~ 21:00(연중무휴)</td>
			<td>제주 제주시 용마로 28 1층 제주라인스쿠터 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/GZAwWLyg' />'">지도보기</button></td>
		</tr>
		<tr>
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200219_94%2F158207243544421mXQ_JPEG%2FB612_20170724_073830.jpg" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://naver.me/xAtWfaUM"/>" target="blank" style="text-decoration:none; color:#b69d7c">제주힐링스쿠터</a></td>		
			<td>0507-1488-2511</td>		
			<td>07:00 ~ 22:00(연중무휴)</td>
			<td>제주 제주시 남성로 9 1층 제주힐링스쿠터 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/xAtWfaUM' />'">지도보기</button></td>
		</tr>
		<tr>
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20240413_209%2F1713008326350qHMQj_JPEG%2F01.jpg" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://naver.me/xB4hOU5L"/>" target="blank" style="text-decoration:none; color:#b69d7c">준바이크</a></td>	
			<td>064-702-5542</td>		
			<td>08:00 ~ 19:00(연중무휴)</td>
			<td>제주 제주시 오라로 7 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/xB4hOU5L' />'">지도보기</button></td>
		</tr>
		<tr>
			<td><img src="https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20201028_292%2F16038744852248Cwav_JPEG%2F_lHejzc4xyuxV58NXARIzsLy.jpg" style="width:100px; height:100px"></td>
			<td><a href="<c:url value="https://naver.me/5s973ZDP"/>" target="blank" style="text-decoration:none; color:#b69d7c">바이크제주</a></td>
			<td>0507-1364-5541</td>		
			<td>08:30 ~ 22:00(연중무휴)</td>
			<td>제주 제주시 용해로 99 1층 바이크제주 <button type="submit" class="btn btn-primary map-button" onclick="window.location.href='<c:url value='https://naver.me/5s973ZDP' />'">지도보기</button></td>
		</tr>
	</table>
	</div>


</div>


<%@ include file="../include/footer.jsp" %>
