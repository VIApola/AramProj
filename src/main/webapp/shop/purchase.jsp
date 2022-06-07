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

<!--폰트-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
	
<!-- css -->
<link
	href="${pageContext.request.contextPath}/resources/css/purchase.css"
	rel="stylesheet" type="text/css">
<title>주문 결제 페이지</title>
</head>
<body>
	<div class="container">
		<!--헤더영역-->
		<jsp:include page="/frame/header.jsp"></jsp:include>
		<!-- order / payment-->
		<div class="row titleLabel">
			<span>ORDER / PAYMENT</span>
		</div>
		<div class="page-content">
			<!-- 구매 리스트 -->
			<div class="contentList">
				<div class="row">
					<div class="col">List 구매리스트</div>
				</div>
				<div class="row list-label">
					<div class="col-1 d-flex justify-content-center">선택</div>
					<div class="col-8 d-flex justify-content-center">상품명</div>
					<div class="col-1 d-flex justify-content-center">수량</div>
					<div class="col-2 d-flex justify-content-center">가격</div>
				</div>
				<c:forEach items="${cartList}" var="cartItem">
					<div class="row tbl_list">
						<div
							class="col-1 d-flex justify-content-center align-items-center">
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
				<div class="row">
					<div class="col-9 d-flex justify-content-end">
						<span>총 가격 : </span>
					</div>
					<div class="col-2">
						<span>dd</span>
					</div>
				</div>
			</div>
			<!-- 주문자 정보 -->
			<div class="orderInfo">
				<div class=" row titleLabel">
					<span>주문자 정보</span>
				</div>
				<div class="content">
					<!-- 주문자명 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주문자명</div>
						<div class="col-lg-3 col-9">
							<input type="text" class="form-control"
								value="${userInfo.username}">
						</div>
					</div>
					<!-- 연락처, 이메일 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-lg-3 col-9 d-flex">
							<input type="text" class="form-control" value="${userInfo.phone}">
							- <input type="text" class="form-control"
								value="${userInfo.phone}"> - <input type="text"
								class="form-control" value="${userInfo.phone}">
						</div>
					</div>
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">이메일</div>
						<div class="col-lg-3 col-9 d-flex align-items-center">
							<input type="text" class="form-control" value="${userInfo.email}">
						</div>
					</div>
				</div>
			</div>
			<!-- 배송지 정보 -->
			<div class="deliveryInfo">
				<div class="row titleLabel">
					<div class="col-lg-2 col-3">배송지 정보</div>
					<div class="col-lg-10 col-9">
						<input type="checkbox"> 주문하는 사람과 동일한 배송지
					</div>

				</div>
				<div class="content">
					<!-- 받는 사람 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">받는사람</div>
						<div class="col-lg-3 col-9">
							<input type="text" class="form-control" id="delivery_name">
						</div>
					</div>
					<!-- 연락처 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-lg-3 col-9 d-flex">
							<input type="text" class="form-control" id="phone1"> - <input
								type="text" class="form-control" id="phone2"> - <input
								type="text" class="form-control" id="phone3">
						</div>
					</div>
					<!-- 주소 -->
					<div class="addressBox">
						<div class="row" style="border: none;">
							<!-- 주소 -->
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주소</div>
							<div class="col-lg-3 col-3">
								<input type="text" class="form-control" id="postcode" disabled>
							</div>
							<!-- 우편번호 검색 -->
							<div class="col-lg-3 col-6">
								<button type="button" class="btn btn-primary"
									style="width: 120px">우편번호검색</button>
							</div>
						</div>
						<div class="row mt-2 mb-2">
							<div class="col-lg-2 col-3"></div>
							<div class="col-lg-4 col-4">
								<input type="text" class="form-control" disabled>
							</div>
							<div class="col-lg-4 col-5">
								<input type="text" class="form-control">
							</div>
						</div>
					</div>
					<!-- 주문 메세지 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주문메세지</div>
						<div class="col-lg-8 col-9">
							<textarea class="form-control" placeholder="주문메세지를 입력해주세요"></textarea>
						</div>
					</div>
					<!-- 배송 메세지 -->
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">배송메세지</div>
						<div class="col-lg-8 col-9">
							<textarea class="form-control" placeholder="배송메세지를 입력해주세요"></textarea>
						</div>
					</div>
				</div>
			</div>
			<!-- 배송비 및 할인 정보 -->
			<div class="payMoneyInfo">
				<div class="row payMoneyInfo-title titleLabel">
					<span>배송비 및 할인정보</span>
				</div>
				<div class="row">
					<div
						class=" payMoneyInfo-content d-flex justify-content-between align-items-center ">
						<div class="col-3 d-flex justify-content-center">상품금액</div>
						<div class="col-3 d-flex justify-content-center">배송비</div>
						<div class="col-3 d-flex justify-content-center">결제 예정금액</div>
					</div>
				</div>

			</div>
			<!-- 결제 정보 -->
			<div class="payMoneyInfo">
				<div class="row payMoneyInfo-title titleLabel">
					<span>결제정보</span>
				</div>
				<!-- <div class="payMoneyInfo-title border-bottom">
                    <span>결제 이니시스 소개</span>
                </div> -->
				<div class="payment_wrap content">
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">결제방법</div>
						<div class="col flex-column align-items-center">
							<ul class="mb-0">
								<li class="p-1"><input type="radio" name="payment">
									무통장입금</li>
								<li class="p-1"><input type="radio" name="payment">
									신용카드</li>
								<li class="p-1"><input type="radio" name="payment">
									실시간 계좌이체</li>
								<li class="p-1"><input type="radio" name="payment">
									핸드폰 결제</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- 약관 동의 -->
			<div class="payMoneyInfo">
				<div class="row payMoneyInfo-title titleLabel">
					<span>주문자 약관동의</span>
				</div>
				<div class="payment_wrap content">
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">약관동의</div>
						<div class="col-lg-8 col-9">
							<textarea class="form-control" name="" id=""></textarea>
						</div>
					</div>
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">
							주문동의</div>
						<div class="col-lg-10 col-9">
							<input type="checkbox">상기 결제정보를 확인하였으며, 구매 진행에 동의합니다.
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 최종 결제 금액 -->

        <div class="finalAmount p-4 d-flex">
            <div class="col-lg-2 col-3 d-flex justify-content-center align-items-center">
                <span>최종결제 금액</span>
            </div>
            <div class="col-lg-10 col-3 d-flex justify-content-start align-items-center">
                <span>20.000원<span>
            </div>
        </div>
		<!-- 버튼 -->
		<div class="btnBox d-flex justify-content-center">
			<button type="button" class="btn btn-outline-dark">취소하기</button>
			<button type="button" class="btn btn-outline-success" id="btnOrder">주문하기</button>
		</div>
	</div>


	<%--풋터영역 --%>
	<jsp:include page="/frame/footer.jsp"></jsp:include>
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
		}
	})
	
	</script>
</body>
</html>