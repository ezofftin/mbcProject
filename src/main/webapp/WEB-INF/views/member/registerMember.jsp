<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="../include/header.jsp" %>


<!-- 약관 동의 페이지 -->
<div class="container mt-5 p-5" id="termsForm">
    <h3 class="text-center mb-4">약관 동의</h3>
    
    <div class="terms-section">
        <div class="terms-box mb-3">
            <p><strong>회원가입 약관</strong></p>
            <p>(주) 집앞제주의 회원가입 약관은 당사 서비스 이용에 있어 회원의 권리와 의무, 그리고 서비스 이용에 따른 제반 사항을 규정합니다. 본 약관은 서비스 이용계약 체결, 회원의 의무와 책임, 이용 제한 및 해지 등의 내용을 포함하고 있으며, 이에 동의함으로써 당사와의 법적 관계가 성립됩니다. 약관에 동의하지 않으실 경우, 서비스 이용에 제한이 있을 수 있습니다.</p>
        </div>
        <div class="terms-box mb-3">
            <p><strong>개인정보 처리방침</strong></p>
            <p>(주) 집앞제주는 회원님의 개인정보 보호를 최우선 과제로 삼고 있으며, 개인정보 처리방침을 통해 수집된 개인정보의 처리 절차와 보호 조치를 상세히 명시하고 있습니다. 본 방침은 개인정보의 수집, 이용, 보관, 제3자 제공, 파기 절차 및 기타 법적 요구사항을 준수하여 운영되며, 이를 통해 회원님의 개인정보를 안전하게 관리하고 있습니다. 본 방침에 대한 동의는 서비스 이용을 위한 필수 조건입니다.</p>
        </div>
        <div class="terms-box mb-3">
            <p><strong>이메일 수신 동의</strong></p>
            <p>(주) 집앞제주는 회원님께 최신 정보와 혜택을 제공하기 위해 이메일을 통한 커뮤니케이션을 시행하고 있습니다. 이메일 수신에 동의하시면, 당사에서 제공하는 이벤트, 프로모션, 뉴스레터 등 다양한 정보가 정기적으로 발송됩니다. 이는 회원님의 권익을 증진하기 위한 목적으로만 사용되며, 원치 않으실 경우 언제든지 수신을 거부할 수 있는 선택권이 제공됩니다.</p>
        </div>
        
        <div class="terms-label mb-3">
            <input type="checkbox" id="allAgree" class="terms-checkbox" onclick="checkAll()">
            <label for="allAgree">전체 동의</label>
        </div>
        
        <div class="terms-label mb-2">
            <input type="checkbox" id="termsAgree" class="terms-checkbox">
            <label for="termsAgree">회원가입 약관 동의</label>
        </div>
        
        <div class="terms-label mb-2">
            <input type="checkbox" id="privacyAgree" class="terms-checkbox">
            <label for="privacyAgree">개인정보 처리방침 동의</label>
        </div>
        
        <div class="terms-label mb-2">
            <input type="checkbox" id="emailAgree" class="terms-checkbox">
            <label for="emailAgree">이메일 수신 동의</label>
        </div>
    </div>
    
    <div class="text-center mt-4">
        <button type="button" class="btn btn-primary" onclick="showSignUpForm()">다음</button>
    </div>
</div>

<!-- 회원가입 폼 -->
<div class="container w-50 mt-5 p-5 shadow" id="signUpForm" style="display:none;">
   <form action="memberInsert.do" method="post" name="joinForm" onSubmit="return submitChk()">
      <h3 class="text-center">회원가입</h3><br>            

      <div class="mt-2 mb-2">
         <label for="id">아이디</label>
         <input class="form-control mb-2" type="text" id="id" name="memberId" placeholder="아이디" onkeyup="idCheck()">
         <p id="chkMsg" class="mb-2"></p>
         <input type="hidden" id="isIdCheck" value="no">
      </div>
      <div class="mb-2">
         <label for="pw">비밀번호</label>
         <input class="form-control mb-2" type="text" id="pw" name="memberPw" placeholder="비밀번호" onkeyup="pwCheck()">
         <p id="chkMsg2" class="mb-2"></p>
      </div>
      <div class="mb-2">
         <label for="pwConfirm">비밀번호 확인</label>
         <input class="form-control mb-2" type="text" id="pwConfirm" name="pwConfirm" placeholder="비밀번호 확인" onkeyup="pwCheck()"/>
         <p id="chkMsg3" class="mb-2"></p>
         <input type="hidden" id="isPwCheck" value="no">
      </div>
      <div class="mb-2">
         <label for="name">이름</label>
         <input class="form-control mb-2" type="text" id="name" name="memberName" placeholder="이름">
      </div>
      <div class="mb-2">
         <label for="tel">전화번호</label>
         <input class="form-control mb-2" type="text"id="tel" name="memberTel" placeholder="전화번호" onkeyup="telCheck()">
         <p id="chkMsg4" class="mb-2"></p>
         <input type="hidden" id="isTelCheck" value="no">
      </div>
      
      <label for="email">이메일</label>
      <div class="row">
         <div class="col-md-8 pe-0">
            <input class="form-control" type="text" id="email" name="memberEmail" placeholder="이메일">
         </div>
         <div class="col-md-4">
            <input id="code-send" class="btn btn-outline-secondary w-100" type="button" onclick="emailCheck()" value="인증번호 발송" style="color:black">
         </div>
         <p class="code-msg0 mt-1 mb-1"></p>
      </div>
      
      <div class="row" id="confirmEmail"> 
         <div class="col-md-8 pe-0">
            <input class="input-code" type="text" id="confirmUUID" placeholder="인증코드 입력"><input class="time" value="" readonly>
         </div>
         <div class="col-md-4">
            <span id="confirm-btn" class="btn btn-outline-secondary w-100" onclick="emailConfirm()" style="color:black">인증코드 확인</span>
         </div>
         <p class="code-msg mt-1 mb-2"></p>
      </div>
      
         <input class="form-select form-select-sm" name="memberType" id="memberType" value="common" readonly type="hidden">
                     
<!--                      <option value="host">사업자</option>  : 최종관리자가 멤버 수정할 때 사용-->
         </input>
      <!-- <div class="row mb-1">
         <label for="addr">주소</label><br>
         <div class="col-md-6">
            <input class="form-control mb-1" type="text" id="sample6_postcode" name="zipcode" placeholder="우편번호" readonly>
         </div>
         <div class="col-md-6">
            <input class="btn btn-secondary mb-1" type="button" id="postcodeButton" value="우편번호 찾기">
         </div>
      </div>
      <input class="form-control mb-2" type="text" id="sample6_address" name="road_addr" placeholder="주소" readonly>
      <input class="form-control mb-2" type="text" id="sample6_detailAddress" name="detail_addr" placeholder="상세주소">
      <input class="form-control mb-2" type="text" id="sample6_extraAddress" name="plus_addr" placeholder="참고항목" readonly> -->
      
      <div class="text-center mt-3"><br>
         <input type="submit" class="btn btn-primary" value="회원가입">
         <input type="reset" class="btn btn-warning" value="취소">
      </div>
   </form>
</div>

<style>
    .terms-box {
        border: 1px solid #ddd;
        padding: 15px;
        height: 150px;
        overflow-y: scroll;
    }

    .terms-label {
        font-weight: bold;
        display: flex;
        align-items: center;
    }

    .terms-checkbox {
        margin-right: 10px;
    }

    .btn-primary {
        background-color: #2d5a4e;
        border-color: #2d5a4e;
        color: white;
    }
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 전체 동의 체크박스
    function checkAll() {
        let allAgree = document.getElementById("allAgree");
        let checkboxes = document.querySelectorAll(".terms-checkbox");
        checkboxes.forEach(function(checkbox) {
            checkbox.checked = allAgree.checked;
        });
    }

    // 약관 페이지에서 다음 버튼 클릭 시 회원가입 폼 표시
    function showSignUpForm() {
        if (document.getElementById("termsAgree").checked && document.getElementById("privacyAgree").checked) {
            document.getElementById("termsForm").style.display = "none";
            document.getElementById("signUpForm").style.display = "block";
        } else {
            alert("모든 필수 약관에 동의해주세요.");
        }
    }

    // 아이디 중복체크
    function idCheck(){
        let uid = $("#id").val(); // 사용자 입력 아이디 가져오기
        
        if(uid.length<4){
            $("#chkMsg").text("아이디 길이는 4자리 이상이어야 합니다!!");
            $("#chkMsg").css({"color":"red", "font-size":"13px"})
            $("#isIdCheck").val("no");        // submitChk()에서 사용
            $("uid").select();
            return;
        }

        $.ajax({
            url : "<c:url value='/memberIdCheck.do'/>", // 접속할 요청주소    // DB에 들어갔다 옴
            type : "get", // 전송방식(get, post)
            data : {"uid":uid}, // 서버에 전송할 데이터
            success : function(responseData){
                if(responseData == "yes"){
                    $("#chkMsg").text("사용 가능한 아이디 입니다!!");
                    $("#chkMsg").css({"color":"blue", "font-size":"13px"})
                    $("#isIdCheck").val("yes");        // submitChk()에서 사용
                } else {
                    $("#chkMsg").text("사용할 수 없는 아이디 입니다!!");
                    $("#chkMsg").css({"color":"red", "font-size":"13px"})
                    $("#isIdCheck").val("no");        // submitChk()에서 사용
                    $("id").select();
                }
            },
            error : function(){alert("Server Error")} // 서버에서 요청처리를 실패했을때 처리되는 함수를 지정
        });
    }
    
    function pwCheck(){
        let upw = $("#pw").val();
        let upw2 = $("#pwConfirm").val();
        
        if(upw.length < 4){
            $("#chkMsg2").text("비밀번호 길이는 4자리 이상이어야 합니다!!");
            $("#chkMsg2").css({"color":"red", "font-size":"13px"})
            $("#isPwCheck").val("no");        // submitChk()에서 사용
            $("upw").select();
            return;
        } else {
            $("#chkMsg2").text("사용 가능한 비밀번호 입니다!!");
            $("#chkMsg2").css({"color":"blue", "font-size":"13px"})
            
            if(upw != upw2){
                $("#chkMsg3").text("비밀번호 재확인을 올바르게 해주세요!!");
                $("#chkMsg3").css({"color":"red", "font-size":"13px"})
                $("#isPwCheck").val("no");        // submitChk()에서 사용
                $("upw2").select();
                return;
            } else {
                $("#chkMsg3").text("비밀번호 재확인 완료입니다!!");
                $("#chkMsg3").css({"color":"blue", "font-size":"13px"})
                $("#isPwCheck").val("yes");        // submitChk()에서 사용
            }
        }
    }
    
    // 전화번호 중복체크
    function telCheck(){
        let utel = $("#tel").val(); // 사용자 입력 아이디 가져오기
        
        if(utel.length<4){
            $("#chkMsg4").text("전화번호 길이는 4자리 이상이어야 합니다!!");
            $("#chkMsg4").css({"color":"red", "font-size":"13px"})
            $("#isTelCheck").val("no");        // submitChk()에서 사용
            $("utel").select();
            return;
        }

        $.ajax({
            url : "<c:url value='/memberTelCheck.do'/>", // 접속할 요청주소    // DB에 들어갔다 옴
            type : "get", // 전송방식(get, post)
            data : {"utel":utel}, // 서버에 전송할 데이터
            success : function(responseData){
                if(responseData == "yes"){
                    $("#chkMsg4").text("사용 가능한 전화번호 입니다!!");
                    $("#chkMsg4").css({"color":"blue", "font-size":"13px"})
                    $("#isTelCheck").val("yes");        // submitChk()에서 사용
                } else {
                    $("#chkMsg4").text("사용할 수 없는 전화번호 입니다!!");
                    $("#chkMsg4").css({"color":"red", "font-size":"13px"})
                    $("#isTelCheck").val("no");        // submitChk()에서 사용
                    $("#tel").select();
                }
            },
            error : function(){alert("Server Error")} // 서버에서 요청처리를 실패했을때 처리되는 함수를 지정
        });
    }
    
    let time_display;
    let timer;
    // timer 동작 함수
    function timer_start(){
        timer_stop();
        
        let count = 180;
        time_display = $('.time');
        time_display.val("03:00");
        
        timer = setInterval(()=>{
            let minutes = parseInt(count / 60);
            let seconds = parseInt(count % 60);
            
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
            
            time_display.val(minutes + ":" + seconds);
            
            if(--count < 0){
                timer_stop();
                time_display.val("시간초과");
                $(".code-msg").css({"display": "block", "color" :"red"});
                $(".code-msg").text("인증코드가 만료되었습니다!!");
                $("#code-send").removeClass("disabled");
                $("#code-send").val("코드 재발송");
                $("#confirm-btn").addClass("disabled");
                $(".input-code").val("");
                $(".input-code").attr("readonly", true);
                $("#email").attr("readonly", false);
            }
        }, 1000)
    }

    // timer 종료
    function timer_stop(){
        isEmailCheck = false;
        clearInterval(timer);
    }
    
    // 이메일 인증코드 보내기
    let responseUUID = "";
    let isEmailCheck = false; // submitChk()에서 사용, 이메일 체크확인, 기본값 false
    
    function emailCheck(){
        let uEmail = $("#email").val();

        if($("#email").val() == ""){
            $(".code-msg0").css({"color":"red", "font-size":"13px"});
            $(".code-msg0").text("이메일을 정확하게 입력하세요.");
        } else {
            $("#code-send").addClass("disabled");
            $("#confirm-btn").removeClass("disabled");
            $("#email").attr("readonly", true);
            $(".code-msg0").css({"color":"red", "font-size":"13px"});
            $(".code-msg0").text("이메일을 전송 중...");
        }
        
        $.ajax({
            url : "<c:url value='/memberEmailCheck.do'/>",
            type : "get",
            data : {"uEmail":uEmail},
            success: function(UUID){
                responseUUID = UUID
                if(responseUUID != "fail"){
                   console.log("이메일 인증코드 : " + responseUUID);
                    $(".code-msg0").css({"color":"blue", "font-size":"13px"});            
                    $(".code-msg0").text("이메일 전송 완료!!");            
                    $(".input-code").attr("readonly", false);
                    $("#confirmEmail").css({"visibility":"visible", "height":"auto"})
                    $(".code-msg").css({"display": "block", "color" :"green"});
                    $(".code-msg").text("인증코드가 발송되었습니다!!");
                    timer_start();
                    
                } else {
                    alert("이메일을 다시 확인하세요!! 처음부터 진행하세요.");
                    $(".code-msg0").css({"color":"red", "font-size":"13px"});
                    $(".code-msg0").text("이메일 전송 에러 1번!! 처음부터 진행하세요.");
                    $("#email").select();
                }
            },
            error : function(){
                alert("메일발송 실패!! 처음부터 진행하세요.");
                $(".code-msg0").css({"color":"red", "font-size":"13px"});
                $(".code-msg0").text("2.이메일 전송 에러 2번!! 처음부터 진행하세요.");
                $("#email").select();
            }
        })
    }

    // 이메일 인증코드 일치하는지 확인
    function emailConfirm(){
        let confirmUUID = $("#confirmUUID").val();
        
        if(confirmUUID == null || confirmUUID.trim() == ""){
            alert("이메일 인증코드를 입력하세요");
            $(".code-msg").css({"display": "block", "color" :"red"});
            $(".code-msg").text("이메일 인증코드를 입력하세요");
            $("#confirmUUID").select();
            isEmailCheck = false;
            return;
        } else if(responseUUID == confirmUUID){
            alert("이메일 인증 성공!!");
            timer_stop();
            $("#confirm-btn").addClass("disabled");
            $("#code-send").addClass("disabled");
            time_display.val("인증완료");
            $(".code-msg").css({"display": "block", "color" :"green"});
            $(".code-msg").text("이메일 인증이 완료되었습니다.");
            $(".input-code").attr("readonly", true);
            isEmailCheck = true;
            return;
        } else {
            alert("이메일 인증코드를 다시 확인하세요!!");
            $(".code-msg").css({"display": "block", "color" :"red"});
            $(".code-msg").text("이메일 인증코드를 다시 확인하세요!!");
            $("#confirmUUID").select();
            isEmailCheck = false;
            return;
        }
    }
    
    // 가입버튼 누를시 onSubmit 진행
    function submitChk(){
        let isIdCheck = $("#isIdCheck").val();
        let isPwCheck = $("#isPwCheck").val();
        let isTelCheck = $("#isTelCheck").val();

        if(isIdCheck == "no" || isPwCheck == "no"){
            alert("아이디 중복체크 또는 비밀번호를 확인해주세요!!")
            $("#id").select();
            return false;
        }
        
        if(isTelCheck == "no"){
            alert("전화번호 중복체크를 확인해주세요!!")
            $("#tel").select();
            return false;
        }
        
        if(!inputChk()){
            alert("inputchk() 실행중");
            return false;
        } 
        
        if(!isEmailCheck){
            alert("이메일 인증을 해주세요!!");
            $("#email").select();
            return false;
        }
        alert("회원가입 완료~ 로그인을 진행해주세요!!");
        return true;
    }

    // 기본적인 inputChk 함수 추가
    function inputChk() {
        if ($("#id").val().trim() === "" || $("#pw").val().trim() === "" || $("#name").val().trim() === "") {
            alert("필수 입력 항목을 모두 입력하세요.");
            return false;
        }
        return true;
    }

    document.getElementById('postcodeButton').onclick = function() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    };
</script>

<%@ include file="../include/footer.jsp" %>
