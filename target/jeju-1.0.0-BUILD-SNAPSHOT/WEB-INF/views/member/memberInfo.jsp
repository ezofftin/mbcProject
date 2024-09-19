<%@page import="com.mbc.jeju.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
      
  <!-- 자바스크립트 불러오기 --> 
  <!-- url "userJoinOk.do" 위치가 root에 있기때문에 "js/valid.js" -->
	<script type="text/javascript" src="resources/js/valid.js" charset="utf-8"></script>
                                                    
<!-- <div class="container w-75 mt-5 p-5 border shadow d-flex">   -->
<div class="container w-50 shadow rounded border shadow p-5 mt-3">
		  <!-- Nav tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <a class="nav-link ${find == 'info' ? 'active':''}" data-bs-toggle="tab" href="#menu1">회원정보 수정</a>
    </li>
    <li class="nav-item">
      <a class="nav-link ${find == 'pwch' ? 'active':''}" data-bs-toggle="tab" href="#menu2">비밀번호 변경</a>
    </li>
  </ul>
	
	<!-- Tab panes -->
  <div class="tab-content">
	  	<!-- 회원정보 수정 - 패널 -->
	    <div id="menu1" class="container tab-pane fade ${find == 'info' ? 'show active':''}"><br>
	      	<h4 class="text-center">회원정보 수정</h4>
		      	<form action="memberUpdate.do" method="post" name="joinForm">       
					 		<input type='hidden' name='memberNum' value='${dto.getMemberNum()}'> 
					     		<div class="mt-3 mb-2 text-end">                                        
									<b>${dto.getMemberName()} 님의 회원정보</b>                                                        
								</div>
	      	  <div class="mt-2 mb-2">
			         <!-- <lable for="id">번호 : 수정불가</lable> -->
			         <input type="hidden" class="form-control" id="no" name="memberNum" value="${dto.memberNum}" readonly/>
			      </div>      			      	      			      		       
			      <div class="mb-2">
			         <lable for="id">아이디</lable>
			         <input type="text" class="form-control" id="id" name="memberId" value="${dto.memberId}" readonly/>
			      </div>
			      <div class="mb-2">
			         <!-- <lable for="pw">비밀번호 : 수정불가(비밀번호 패널에서 수정하세요)</lable> -->
			         <input type="hidden" class="form-control" id="pw" name="memberPw" value="${dto.memberPw}" readonly/>
			      </div>			      
			      <div class="mb-2">
			         <!-- <lable for="pwConfirm">비밀번호 확인 : 수정불가(비밀번호 패널에서 수정하세요)</lable> -->
			        
			         <input type="hidden" class="form-control" id="pwConfirm" name="pwConfirm" value="${dto.memberPw}" readonly/>
			      </div>
		      		
			      <div class="mb-2">
			         <lable for="name">이름</lable>
			         <input type="text" class="form-control" id="name" name="memberName" value="${dto.memberName}"/>
			      </div>		      
<%-- 			      <div class="mb-2">
			         <lable for="name">나이</lable>
			         <input type="text" class="form-control" id="age" name="age" value="${dto.age}"/>
			      </div> --%>
			      <div class="mb-2">
			         <lable for="tel">전화번호</lable>
			         <input type="text" class="form-control" id="tel" name="memberTel" value="${dto.memberTel}"/>
			      </div>
			      <div class="mb-2">
			         <lable for="email">이메일</lable>
			         <input type="text" class="form-control" id="email" name="memberEmail" value="${dto.memberEmail}" readonly/>
			      </div>
			      
			      <!----------------------------------- 주소 ----------------------------------->
			      <%-- 	<div class="row mb-1">
			      		<lable for="addr">주소</lable><br>
			    		<div class="col-md-6">
			    			<input class="form-control mb-1" type="text" id="sample6_postcode" name="zipcode" value="${dto.zipcode}" readonly/>
			    		</div>
					    <div class="col-md-6">
							<input class="btn btn-secondary mb-1" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						</div>
					</div>
							<input class="form-control mb-2" type="text" id="sample6_address" name="road_addr" value="${dto.road_addr}" readonly/>
							<input class="form-control mb-2" type="text" id="sample6_detailAddress" name="detail_addr" value="${dto.detail_addr}"/>
							<input class="form-control mb-2" type="text" id="sample6_extraAddress" name="plus_addr" value="${dto.plus_addr}" readonly/>
			      
			      						<!-- 위에는 뷰 // 아래는 로직 -->
			      	
				    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
					    function sample6_execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
					                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					                var addr = ''; // 주소 변수
					                var extraAddr = ''; // 참고항목 변수
					
					                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					                    addr = data.roadAddress;
					                } else { // 사용자가 지번 주소를 선택했을 경우(J)
					                    addr = data.jibunAddress;
					                }
					
					                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
					                if(data.userSelectedType === 'R'){
					                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
					                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					                        extraAddr += data.bname;
					                    }
					                    // 건물명이 있고, 공동주택일 경우 추가한다.
					                    if(data.buildingName !== '' && data.apartment === 'Y'){
					                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					                    }
					                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					                    if(extraAddr !== ''){
					                        extraAddr = ' (' + extraAddr + ')';
					                    }
					                    // 조합된 참고항목을 해당 필드에 넣는다.  -->> 참고항목을 안넣으면 주석처리
					                    document.getElementById("sample6_extraAddress").value = extraAddr;
					                
					                } else {
					                	// -->> 참고항목을 안넣으면 주석처리
					                    document.getElementById("sample6_extraAddress").value = '';
					                }
					
					                // 우편번호와 주소 정보를 해당 필드에 넣는다.
					                document.getElementById('sample6_postcode').value = data.zonecode;
					                document.getElementById("sample6_address").value = addr;
					                // 커서를 상세주소 필드로 이동한다.
					                document.getElementById("sample6_detailAddress").focus();
					            }
					        }).open();
					    }
					</script> --%>
			      <!----------------------------------------------------------------------------------------------->
			      
			      <div class="text-center mt-3"><br>
			         <input type="button" class="btn btn-sm" value="회원정보 수정" onclick="inputChk()"/>
			         <!-- <input type="reset" class="btn btn-sm btn-warning" value="취소"/> -->
			         <a href="${header.Referer}" class="btn btn-sm">취소</a>			        
			         &nbsp;&nbsp;<a href="memberDelete.do?no=${dto.memberNum}" class="btn btn-sm">회원 탈퇴</a>
			      </div>
		      </form>
			
	    </div>
    
	    <!-- 비밀번호 변경 - 패널 -->	    
	    <div id="menu2" class="container tab-pane fade ${find == 'pwch' ? 'show active':''}"><br>
			<h4 class="text-center">비밀번호 변경</h4><br>
				<input  class="form-control mb-2" type="hidden" id="memberId" value="${sessionScope.loginDTO.memberId}"/>
				<input  class="form-control mb-2" type="hidden" value="${sessionScope.loginDTO.memberPw}"/>
		
				<input class="form-control mb-2" type="password" id="pwck" name="pwck" placeholder="현재 비밀번호"/>
				<input class="form-control mb-2" type="password" id="newPw" name="newPw" placeholder="새 비밀번호"/>
						<p id="pwChkMsg"></p>
				<input class="form-control mb-2" type="password" id="confirmPw" name="confirmPw" placeholder="새 비밀번호 확인"/>
						<p id="pwChkMsg2"></p>
		  
			<div class="text-center"><br>
				<button type="button" id="pwChangeBtn" class="btn btn-sm" style="width:130px">비밀번호 변경</button>
				<a href="${header.Referer}" class="btn btn-sm">취소</a>
				<!-- <input type="reset" id="pwChangeReset" class="btn btn-sm btn-warning" value="취소"/> --> 	<!-- form 태그 안에 없어서 안됌, id="pwChangeReset" 자바스크립트로 진행 -->
			    <!-- <a href="memberList.do" class="btn btn-sm btn-info">회원 리스트</a> -->
			</div>
		</div>
  </div>


	
	<%-- <div class="container w-50">
			<h4 class="text-center">비밀번호 변경</h4><br>
				<input  class="form-control mb-2" type="hidden" id="memberId" value="${sessionScope.loginDTO.id}"/>
				<input  class="form-control mb-2" type="text" value="${sessionScope.loginDTO.pw}"/>
		
				<input class="form-control mb-2" type="text" id="pw" name="pw" placeholder="현재 비밀번호"/>
				<input class="form-control mb-2" type="text" id="newPw" name="newPw" placeholder="새 비밀번호"/>
						<p id="pwChkMsg"></p>
				<input class="form-control mb-2" type="text" id="confirmPw" name="confirmPw" placeholder="새 비밀번호 확인"/>
						<p id="pwChkMsg2"></p>
		  
			<div class="text-center"><br>
				<button id="pwChangeBtn" class="btn btn-sm btn-success">비밀번호 변경</button>
			</div>
	</div> --%>
	
</div> 

<script>
	let pw = "";
	let currentPwChk = "";
	// 현재비밀번호
	function pwCheck(){	// ajax : 비동기 방식
		pw = $("#pwck").val();
		$.ajax({		// Post방식
			url: "<c:url value='pwCheck.do'/>",
			type: "post",
			data: {"pw":pw}, 	// json 형태
			async: false,	// 동기화 처리하겠다. 기본값 true // ajax : 비동기방식으로 진행되면 안되는 상황이라, 순서대로 진행되어야되기때문에 동기방식처럼 넣어줘야함
			success: function(result){
				console.log("result :"+result);
				if(result == "ok"){
					alert("현재 비밀번호 확인 완료");
					currentPwChk = true;
				} else {
					alert("현재 비밀번호를 다시 확인하세요");
					currentPwChk = false;
				}
			},
			error: function(){alert("현재 비밀번호 체크요청 실패!!")}
		});
	}

	// 새로운 비밀번호 유효성 체크
	let newPwChk = "";		// 변경 비밀번호
	let newConfirmPwChk = ""; // 변경 비밀번호 확인
	$("#newPw").on("keyup", function(){
		let npw = $("#newPw").val();
		if(npw == ""){
			$("#pwChkMsg").text("새 비밀번호를 입력하세요");
			newPwChk = false;
		} else if(npw.length < 1){
			$("#pwChkMsg").text("4자리 이상 입력하세요");
			newPwChk = false;
		} else if($("#pwck").val() == $("#newPw").val()){
			$("#pwChkMsg").text("기존 비밀번호와 다르게 입력하세요");
			newPwChk = false;
		} else if($("#confirmPw").val() != ""){
			if($("#confirmPw").val() != $("#newPw").val()){
				$("#pwChkMsg").text("재입력한 비밀번호가 일치하지 않습니다");
				$("#pwChkMsg2").text("재입력한 비밀번호가 일치하지 않습니다");
				newPwChk = false;
			} else if($("#confirmPw").val() == $("#newPw").val()){
				$("#pwChkMsg").text("정상");
				$("#pwChkMsg2").text("정상");
				newPwChk = true;
				newConfirmPwChk = true;
			}
		} else {
			$("#pwChkMsg").text("정상");
            newPwChk = true;
		}
	});
	
	// 새로운 비밀번호 확인 - 체크
	$("#confirmPw").on("keyup", function(){
		let cpw = $("#confirmPw").val();
		if(cpw == ""){
			$("#pwChkMsg2").text("새 비밀번호 재입력을 하세요");
			newConfirmPwChk = false;
		} else if(cpw.length < 4){
			$("#pwChkMsg2").text("4자리 이상 입력하세요");
			newPwChk = false;
		} else if($("#pwck").val() == $("#confirmPw").val()){
			$("#pwChkMsg2").text("기존 비밀번호와 다르게 입력하세요");
			newConfirmPwChk = false;
		} else if($("#confirmPw").val() != $("#newPw").val()){
			$("#pwChkMsg").text("재입력한 비밀번호가 일치하지 않습니다");
			$("#pwChkMsg2").text("재입력한 비밀번호가 일치하지 않습니다");
			newConfirmPwChk = false;
		} else if($("#confirmPw").val() == $("#newPw").val()) {
			$("#pwChkMsg").text("정상");
			$("#pwChkMsg2").text("정상");
			newPwChk = true;
            newConfirmPwChk = true;
		}
	});
	
	// 현재 비밀번호 확인 - 위 버튼에 클릭이벤트가 발생하면 함수수행 // html onclick 이벤트와 동일 - 키업, 온클릭 등 이벤트 발생될때 하단부에 재확인하는 로직을 넣어주어야 함
	$("#pwChangeBtn").on("click", function(){
		// 현재비밀번호 체크 함수호출
		pwCheck()	// ajax : 비동기방식으로 진행되어 순서대로 진행되어야되기때문에 동기방식처럼 넣어줘야함
		
		// 기존비밀번호 오입력 방지
		if($("#pwck").val() == $("#newPw").val() || $("#pwck").val() == $("#confirmPw").val()){					// 새 비밀번호와 새 비밀번호 확인이 일치 하지 않을때 
			alert("중간에 변경된 데이터가 있습니다. 새 비밀번호를 재입력하세요");		// 경고문구
			$("#pwChkMsg").text("기존 비밀번호와 다르게 입력하세요");		// 메세지 변경
			$("#pwChkMsg2").text("기존 비밀번호와 다르게 입력하세요");
			newPwChk = true;
			newConfirmPwChk = false;									// 새 비밀번호 확인 값 false로 아이디 생성방지
		}
		
		// 새비밀번호 재확인 - 새 비밀번호를 다시 수정했을때, 새 비밀번호 확인과 일치하지 않아도 비밀번호 변경요청이 처리되는 문제 발생
		if($("#newPw").val() != $("#confirmPw").val()){					// 새 비밀번호와 새 비밀번호 확인이 일치 하지 않을때 
			alert("중간에 변경된 데이터가 있습니다. 새 비밀번호를 재입력하세요");		// 경고문구
			$("#pwChkMsg2").text("재입력한 비밀번호가 일치하지 않습니다");		// 메세지 변경
			newConfirmPwChk = false;									// 새 비밀번호 확인 값 false로 아이디 생성방지
		}
		
		if(!currentPwChk){
			alert("현재 비밀번호를 확인하세요.");
		} else if(!newPwChk){
			alert("변경할 새 비밀번호를 확인하세요");
		} else if(!newConfirmPwChk){
			alert("새 비밀번호 재확인을 확인하세요");
		} else if(currentPwChk && newPwChk && newConfirmPwChk){
			alert("비밀번호 변경옵션 체크완료");
			console.log("비밀번호 변경 완료");
			let id = $("#memberId").val();
			let pw = $("#newPw").val();
			let member = {"memberId":id, "memberPw":pw} // member는 자바스크립트 객체, 자바스크립트 객체는 http 통신할때 바로 보내지 못함. // jackson lib 이용해서 자바객체로 변환해서 보내고 받아야함
			
			$.ajax({
				url: "<c:url value='pwChange.do'/>",
				type: "post",
				// 자바 스크립트 객체를 전송 할 수 없기 때문에
				// JSON 형태의 문자열로 변환해줌
				data: JSON.stringify(member), // member는 JSON 형태의 자바객체 문자열로 변환
				contentType: "application/json; charset=utf8", // 이게 추가 되어야 함
				success: function(result){
					if(result > 0){
						alert("비밀번호 변경완료!! 새로운 비밀번호로 로그인 하세요!!");
						location.href="<c:url value='memberLogout.do'/>";
					}
				},
				error: function(){alert("비밀번호 변경 요청실패")}
			});
		}
	
	});
	
/* 	$("#pwChangeReset").on("click", function(){
		$("#pwck").val("");
		$("#newPw").val("");
		$("#confirmPw").val("");
		$("#pwChkMsg").text("");
		$("#pwChkMsg2").text("");
	}); 취소누를 경우 리셋에서 이전페이지로 변경*/ 
	

</script> 
                                                    
<%@ include file="../include/footer.jsp" %>