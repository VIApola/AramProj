<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
	<link href="${pageContext.request.contextPath}/resources/css/purchase.css" rel="stylesheet" type="text/css">
<title> 주문 결제 페이지</title>
</head>
<body>
	<div class="container">
		<jsp:include page="/frame/header.jsp"></jsp:include>
		<div class="title-label">
			<span>ORDER / PAYMENT</span>
		</div>
		<hr class="one">
		<div class="page-content">
			<div class="contentList">
				<div class="row">
					<div class="col">List 구매리스트</div>
				</div>
				<div class="row list-label border-top border-bottom">
					<div class="col-1 d-flex justify-content-center">선택</div>
					<div class="col-8 d-flex justify-content-center">상품명</div>
					<div class="col-1 d-flex justify-content-center">수량</div>
					<div class="col-2 d-flex justify-content-center">가격</div>
				</div>
				<c:forEach items="${cartList}" var="cartItem">
				<div class="row tbl_list">
					<div class="col-1 d-flex justify-content-center align-items-center">
						<input type="checkbox">
					</div>
					<div class="col-2">
						<img src="/resources/images/items/${cartItem.item_name}.png">
					</div>
					
					<div class="col-6">${cartItem.item_name}</div>
					<div class="col-1 d-flex justify-content-center">${cartItem.quantity}</div>
					<div class="col-2 d-flex justify-content-center">${cartItem.price}</div>
				</div>
				</c:forEach>
				<div class="row border-top">
					<div class="col-9 d-flex justify-content-end">
						<span>총 가격 : </span>
					</div>
					<div class="col-2">
						<span>dd</span>
					</div>
				</div>
			</div>
			<div class="orderInfo">
				<div class="titleLabel border-bottom">
					<span>주문자 정보</span>
				</div>
				<div class="content">
					<div class="row border-bottom">
						<div
							class="col-lg-1 col-2 d-flex justify-content-center align-items-center">주문자명</div>
						<div class="col-2">
							<input type="text" class="form-control" value="${userInfo.username}">
						</div>
					</div>
					<div class="row border-bottom">
						<div
							class="col-lg-1 col-2 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-3">
							<input type="text" class="form-control" value="${userInfo.phone}">
						</div>
						<div
							class="col-lg-1 col-2 d-flex justify-content-center align-items-center">이메일</div>
						<div class="col-3 d-flex align-items-center">
							<input type="text" class="form-control" value="${userInfo.email}">
						</div>
					</div>
				</div>
			</div>
			<div class="deliveryInfo">
				<div class="titleLabel border-bottom">
					<span>배송지 정보</span>
					<input type="checkbox"> 주문하는 사람과 동일한 배송지
				</div>
				<div class="content">
					<div class="row border-bottom">
						<div class="col-2 d-flex align-items-center">받는사람</div>
						<div class="col-2">
							<input type="text" class="form-control" id="delivery_name">
						</div>
						<div class="col-2 d-flex align-items-center">연락처</div>
						<div class="col-5">
							<input type="text" class="form-control" id="phone">
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">주소</div>
						<div class="col-2">
							<input type="text" class="form-control" id="postcode" disabled>
						</div>
						<div class="col-8">
							<button type="button" class="btn btn-primary"
								style="width: 100px">우편번호검색</button>
						</div>
					</div>
					<div class="row m-2 border-bottom">
						<div class="col-2"></div>
						<div class="col-3">
							<input type="text" class="form-control" disabled>
						</div>
						<div class="col-3">
							<input type="text" class="form-control">
						</div>
					</div>
					<div class="row border-bottom">
						<div class="col-2 d-flex align-items-center">주문메시지</div>
						<div class="col-10">
							<input type="text" class="form-control">
						</div>
					</div>
					<div class="row m-2">
						<div class="col-2 d-flex align-items-center">배송메시지</div>
						<div class="col-10">
							<input type="text" class="form-control">
						</div>
					</div>
				</div>
			</div>
			<div class="payMoneyInfo">
				<div class="payMoneyInfo-title border-bottom">
					<span>배송비 및 할인정보</span>
				</div>
				<div class="row payMoneyInfo-content">
					<div class="col-3 d-flex justify-content-center">1</div>
					<div class="col-3 d-flex justify-content-center">1</div>
					<div class="col-3 d-flex justify-content-center">1</div>
				</div>
			</div>

			<div class="payMoneyInfo">
				<div class="payMoneyInfo-title border-bottom">
					<span>결제정보</span>
				</div>
				<div class="payMoneyInfo-title border-bottom">
					<span>결제 이니시스 소개</span>
				</div>
				<div class="payment_wrap content">
					<div class="row">
						<div
							class="col-2 d-flex justify-content-center align-items-center">결제방법</div>
						<div class="col">
							<ul>
								<li><input type="radio" name="payment"> 무통장입금</li>
								<li><input type="radio" name="payment"> 신용카드</li>
								<li><input type="radio" name="payment"> 실시간 계좌이체</li>
								<li><input type="radio" name="payment"> 핸드폰 결제</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="payMoneyInfo">
				<div class="payMoneyInfo-title">
					<span>주문자 약관동의</span>
				</div>
				<hr>
				<div class="payment_wrap content">
					<div class="row m-2">
						<div
							class="col-2 d-flex justify-content-center align-items-center">약관동의</div>
						<div class="col">
							<textarea name="" id="" cols="50" rows="5"></textarea>
						</div>
					</div>
					<div class="row m-2">
						<div
							class="col-2 d-flex justify-content-center align-items-center">
							주문동의</div>
						<div class="col">
							<input type="checkbox"> 상기 결제정보를 확인하였으며 구매 진행에 동의합니다.
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row finalAmount border-top border-bottom p-4">
			<div class="col-2">
				<span>최종결제 금액</span>
			</div>
			<div class="col-2">
				<span>20.000원<span>
			</div>
		</div>
		<div class="btnBox d-flex justify-content-center">
			<button type="button" class="btn btn-dark">취소하기</button>
			<button type="button" class="btn btn-success" id="btnOrder">주문하기</button>
		</div>
	</div>

	<jsp:include page="/frame/footer.jsp"></jsp:include>
	</div>
	
	<script>
	// 주문서 유효성 검사
	$("#btnOrder").on("click", function(){
		if($("#delivery_name").val() == "") {
			alert("배송자명을 적어주세요");
			return;
		} else if($("#phone").val() == "") {
			alert("배송 연락처를 적어주세요");
			return;
		} else if($("postcode").val() == "") {
			alert("검색된 배송지가 없습니다. 배송지를 등록하세요");
			return;
		} else if($("detailAddr").val() == "") {
			alert("상세 주소가 없습니다. 상세주소를 입력하새요.");
			return;
		} else if() {
			
		}
		
	})
	
	</script>
</body>
</html>