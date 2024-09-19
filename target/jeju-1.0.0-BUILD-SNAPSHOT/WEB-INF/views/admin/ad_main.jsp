<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   
<%@ include file="../admin/ad_header.jsp" %>

<!-- 컨텐츠 -->
<div class="container mt-5 mb-5">   
   <h2>관리자 페이지</h2><br>
   <ul>
      <c:if test="${sessionScope.loginDTO.adminId != null}">    
      <li><a href="boardList.do">공지사항</a></li>
      <br>
      <li><a href="#">호텔정보</a></li>
      <br>
      <li><a href="adminMemberList.do">가입자정보</a></li>
      <br>      
      <li><a href="adminhotelList.do">호텔리스트</a></li>
      <br>
      <li><a href="packageInput.do">패키지등록</a></li>
      <br>
      <li><a href="reserveList.do">예약리스트</a></li>
      <br>     
   </c:if>
   <c:if test="${sessionScope.loginDTO.adminId == null}">
      <li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminLogin.do"><i class="fas fa-user">&nbsp;</i>관리자 로그인</a></li>
   </c:if>  
   </ul>
</div>


<%@ include file="../admin/ad_footer.jsp" %> --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%@ include file="../admin/ad_header.jsp" %>



<!-- 컨텐츠 -->
   <h2>Dashboard</h2><br>
<div class="container mt-5 mb-5">   
<c:if test="${sessionScope.loginDTO.adminId != null}">
   <!-- Chartjs --> 
   <h4>매출통계</h4>
    <div class="container border p-3" style="height:300; text-align:center">
    <canvas id="sales"></canvas>
    </div>    
    <br>
   <h4>호텔매출</h4>
   <div class = "container border p-3">
      <c:set var="sum_commission" value="${0}"/>
      <c:forEach var="total_commission" items="${reserveList}">   
      <c:set var="sum_commission" value="${sum_commission+total_commission.totalPrice*0.1}"/> 
      </c:forEach> 
      <li style="text-align:right;"><b>수수료합계 : <fmt:formatNumber value="${sum_commission}" type="number" groupingUsed="true"/>원</b></li>
      
      
      <c:set var="sum_hotel" value="${0}"/>
      <c:forEach var="total_hotel" items="${reserveList}">   
      <c:set var="sum_hotel" value="${sum_hotel+total_hotel.totalPrice}"/> 
      </c:forEach> 
      <li style="text-align:right;"><b>객실가격합계 : <fmt:formatNumber value="${sum_hotel}" type="number" groupingUsed="true"/>원</b></li>
      <br>   
   <table class="table" id="hotel">
      <thead>
         <tr>
            <th>예약번호</th>               
            <th>호텔번호(이름)</th>
            <th>예약날짜</th>
            <th>객실가격</th>
            <th>수수료(10%)</th>
         </tr>
      </thead>
      <tbody>
         <c:if test="${reserveList.size() != 0}">
            <div class="reservelist d-flex-inline">
               <c:forEach var="dto" items="${reserveList}">
                  <tr>
                  <td>${dto.reserveNum}</td>
                        <td>${dto.hotelNum}</td>
                        <td>${dto.checkin}</td>
                        <td><fmt:formatNumber value="${dto.totalPrice}" type="number" groupingUsed="true"/>원</td>
                        <td><fmt:formatNumber value="${dto.totalPrice*0.1}" type="number" groupingUsed="true"/>원</td>
                  </tr>                  
               </c:forEach>
            </div>
         </c:if>
      </tbody>
   </table>
   </div>
   
   <br>
   <h4>패키지매출</h4>
   <div class = "container border p-3">
      <li style="text-align:right;"><b>수수료합계 : 원</b></li>
      <li style="text-align:right;"><b>패키지가격합계 : 원</b></li><br>
      <table class="table" id="package">
      <thead>
         <tr>
            <th>예약번호</th>               
            <th>패키지번호(이름)</th>
            <th>예약날짜</th>
            <th>패키지가격</th>
            <th>수수료(10%)</th>
         </tr>
      </thead>
      <tbody>

      </tbody>
      </table>
   </div>
</c:if>
</div>

<div>
   <ul>
   <c:if test="${sessionScope.loginDTO.adminId == null}">
      <li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="adminLogin.do"><i class="fas fa-user">&nbsp;</i>관리자 로그인</a></li>
   </c:if>  
   </ul>
</div>

<!-- 수수료 데이터 저장 -->
<div id="data-container" data-reserve-data='${reserveListJson}'></div>
<%-- <div id="data-container" data-reserve-data='<%= reserveListJson %>'></div> --%>

<script>
    // HTML에서 데이터 가져오기
    const dataContainer = document.getElementById('data-container');
    const jsonData = dataContainer.getAttribute('data-reserve-data');

    if (!jsonData || jsonData.trim() === "") {
        console.error("No JSON data found in data-reserve-data attribute.");
    } else {
        try {
            const reserveData = JSON.parse(jsonData);

            // JSON 데이터가 잘 파싱되었는지 로그를 통해 확인
            console.log(reserveData);

            //-------------------------------
            // 한글 날짜를 'YYYY-MM-DD' 형식으로 변환하는 함수
           function convertDate(koreanDate) {
               const months = {
                   '1월': '01', '2월': '02', '3월': '03', '4월': '04',
                   '5월': '05', '6월': '06', '7월': '07', '8월': '08',
                   '9월': '09', '10월': '10', '11월': '11', '12월': '12'
               };
               
               // '9월 6, 2024' -> ['9월', '6,', '2024'] 배열로 분리
               const [month, day, year] = koreanDate.split(' ');
               // console.log("변환날짜 ==>"+ month, day, year); 
   

               // '9월' -> '09'로 변환, '6,'에서 ',' 제거
               const formattedMonth = months[month];
               const formattedDay = day.replace(',', '');
               
               console.log("==========");
               console.log("년월일 ==>" + year, formattedMonth, formattedDay);
   
               // 'YYYY-MM-DD' 형식으로 반환
               const ymd = year +'-'+formattedMonth+'-'+formattedDay;
               console.log("ymd = " + ymd);
               return ymd;
           }
            //-------------------------------
            
            // Chart.js에 사용할 데이터 변환
            const chartData = reserveData.map(item => {
                // x: item.checkinDate, // 체크인 날짜
                // y: item.totalPrice * 0.1 // 수수료 
                const cvtDate = convertDate(item.checkin); 
               console.log("cvtDate =====>" + cvtDate);
                if (cvtDate === null) {
                    console.error("Date conversion failed for checkin:", item.checkin);
                    return null;  // 변환 실패 시 null 반환
                }
               const date = new Date(cvtDate);// Date 객체로 변환
                const price = item.totalPrice * 0.1; // 수수료 
                                
                return {x: date, y: price};
            });

            // Chart.js 차트 생성
            const ctx = document.getElementById('sales').getContext('2d');
            const sales = new Chart(ctx, {
                type: 'bar',
                data: {
                    datasets: [{
                        label: '수수료',
                        data: chartData,
                        backgroundColor: '#b69d7c',
                        borderColor: '#d2b48c',
                        borderWidth: 3
                    }]
                },
                options: {
                    scales: {
                        x: {
                            type: 'time', // x를 시간축
                            time: {
                                unit: 'day',
                                tooltipFormat: 'yyyy-MM-dd',
                                displayFormats: {
                                    day: 'yyyy-MM-dd'
                                }
                            },
                            title: {
                                display: true,
                                text: '체크인 날짜'
                            },
                            ticks:{
                               source: 'data',
                               autoSkip:true, // 필요없는 날짜 생략
                               // maxTicksLimit:2,
                            }
                        },
                        
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: '수수료 (원)'
                            }
                        }
                    }
                }
            });
        } catch (e) {
            console.error("Error parsing JSON data: ", e);
        }
    }
</script>

<script>
$(document).ready( function () {
    $('#hotel').DataTable();
} );

$(document).ready( function () {
    $('#package').DataTable();
} );
</script>


<%@ include file="../admin/ad_footer.jsp" %>
