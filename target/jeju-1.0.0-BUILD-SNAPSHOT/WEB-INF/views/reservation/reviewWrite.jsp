<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>

    <title>리뷰 작성</title>
    <style>
        /* 전체 레이아웃을 위한 스타일 */
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin: 0;
            font-family: Arial, sans-serif;
        }
        header {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 50px;
            box-sizing: border-box;
        }
        nav {
            display: flex;
            gap: 20px;
        }
        .form-container {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            height: 60vh; /* 폼을 화면 중간에 위치시키기 위한 높이 설정 */
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: 300px;
        }
        label, input, textarea, button {
            margin-bottom: 10px;
            width: 100%;
        }
        button {
            width: auto;
            align-self: center;
        }
        .star-rating {
			    direction: rtl;
			    font-size: 30px;
			    cursor: pointer;
			}
			
			.star {
			    color: #ddd;
			    transition: color 0.2s;
			}
			
			.star:hover,
			.star:hover ~ .star {
			    color: #ffc107;
			}
			
			.star.selected,
			.star.selected ~ .star {
			    color: #ffc107;
			}
    </style>


    <!-- 중앙에 위치한 폼 -->
    <div class="form-container">
        <form action="reviewInput.do?reserveNum=${rDto.reserveNum}&hotelNum=${rDto.hotelNum}&memberNum=${rDto.memberNum}" method="post">
            <%-- <label for="title">이용호텔:</label>
            <input type="text" id="title" name="title" value="${hDto.hotelName}" readonly>
            <label for="writer">글쓴이:</label>
            <input type="text" id="writer" name="writer" value="${sessionScope.loginDTO.memberName}" readonly> 
            <label for="writer">이용날짜:</label>
            <input type="text" id="date" name="date" value="${rDto.checkin}~${rDto.checkout}" readonly> --%> 
            <label for="content">리뷰내용:</label>
            <textarea id="content" name="content" required></textarea>
            <label for="score">별점</label>
            <div class="star-rating">
	            <input type="hidden" name="score" id="score" value="0">
	            <span class="star" data-value="1">&#9733;</span>
	            <span class="star" data-value="2">&#9733;</span>
	            <span class="star" data-value="3">&#9733;</span>
	            <span class="star" data-value="4">&#9733;</span>
	            <span class="star" data-value="5">&#9733;</span>
	        </div>
            <br>
            <a class="btn">리뷰 등록</a>
        </form>
    </div>

    <footer>
        <%@ include file="../include/footer.jsp" %>
    </footer>
<script>
document.querySelectorAll('.star-rating .star').forEach(function(star) {
    star.addEventListener('click', function() {
        const rating = this.getAttribute('data-value');
        document.getElementById('score').value = rating;

        // 모든 별에서 'selected' 클래스 제거
        document.querySelectorAll('.star-rating .star').forEach(function(star) {
            star.classList.remove('selected');
        });

        // 클릭된 별과 그 이전 별들에 'selected' 클래스 추가
        this.classList.add('selected');
        let previousSibling = this.previousElementSibling;
        while (previousSibling) {
            previousSibling.classList.add('selected');
            previousSibling = previousSibling.previousElementSibling;
        }
    });
});
</script>