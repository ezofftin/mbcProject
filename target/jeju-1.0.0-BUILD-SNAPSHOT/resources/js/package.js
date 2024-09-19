// 예약 @@@@ 
function reservePackage(packageNum) {
    // 선택한 옵션을 hidden input으로 옮기기
    transferData();

    // 폼을 제출하기 위해 action 설정 후 제출
    document.packageForm.action = "reservePackage.do?packageNum=" + packageNum;
    document.packageForm.submit();
}

function transferData() {
    // 폼에서 값을 가져오기
    var date = document.getElementById('packageDate').value;
    var quantity = document.getElementById('quantity').value;
    var totalPrice = document.getElementById('totalPriceFormatted').textContent;

    // hidden input에 값 설정하기
    document.getElementById('hiddenDate').value = date;
    document.getElementById('hiddenQuantity').value = quantity;
    document.getElementById('hiddenTotalPrice').value = totalPrice.replace(/,/g, ''); // 쉼표 제거
}


function reservePackageOk(packageNum) {
    // 인원 수 및 날짜가 변경되었을 경우 가격 재계산
    recalculateTotalPrice();

    var selectedDate = document.getElementById('packageDate').value;
    var quantity = document.getElementById('quantity').value;
    var totalPrice = document.getElementById('totalPriceFormatted').textContent.replace(/,/g, ''); 

    if (!selectedDate) {
        alert('날짜를 선택해 주세요.');
        return;
    }
    
    var url = 'reservePackage.do?packageNum=' + packageNum 
              + '&selectedDate=' + encodeURIComponent(selectedDate)
              + '&quantity=' + encodeURIComponent(quantity)
              + '&totalPrice=' + encodeURIComponent(totalPrice);
              
    window.location.href = url;
}

function recalculateTotalPrice() {
    // 패키지 가격 가져오기
    const pricePerPerson = parseInt('${dto.packagePrice}', 10);

    // 인원 수 읽기
    const quantity = parseInt(document.getElementById('quantity').value, 10);

    // 총 금액 계산
    const totalPrice = pricePerPerson * quantity;

    // 천 단위 구분 쉼표 추가한 형식으로 변환
    const formattedPrice = totalPrice.toLocaleString();

    // 총 금액 필드 업데이트
    document.getElementById('totalPriceFormatted').textContent = formattedPrice;
}
