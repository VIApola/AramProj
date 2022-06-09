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
<title>Insert title here</title>
<style>
@charset "UTF-8";

* {
	border: 0px solid black;
	font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande',
		'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
	font-size: 14px;
}

/* border-line 시작*/
.row {
	border-bottom: 1px solid lightgray;
}

.titleLabel {
	padding: 5px;
	border-bottom: 2px solid lightgray;
}

/* 최종 결제 금액 */
.finalAmount {
	border-top: 2px solid lightgray;
	border-bottom: 2px solid lightgray;
}

/* border-line 끝*/

/* 구매 리스트 */
.tbl_list {
	padding-top: 10px;
	padding-bottom: 10px;
}

.content .row {
	padding: 10px;
}

.page-content {
	padding: 10px;
}

.page-content>div {
	margin-bottom: 50px;
}

.btnBox button {
	width: 140px;
	margin: 15px;
}

.label_wrap {
	float: left;
	width: 120px;
}

.item_wrap {
	float: left;
	width: 200px;
}

.orderInfo-content span {
	margin: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<%-- 헤더 부분 --%>
		<jsp:include page="/frame/header.jsp"></jsp:include>
		<!-- order / payment-->
		<div class="row titleLabel">
			<span>ORDER / PAYMENT</span>
		</div>
		<div class="page-content">
			<!-- 구매 리스트 -->
			<div class="contentList">
				<!-- 구매 리스트 -->
				<div class="contentList">
					<div class="row">
						<div class="col">List 구매리스트</div>
					</div>
					<div class="row list-label">
						<div class="col-9 d-flex justify-content-center">상품명</div>
						<div class="col-1 d-flex justify-content-center">수량</div>
						<div class="col-2 d-flex justify-content-center">가격</div>
					</div>
					<c:forEach items="${itemList}" var="item">
						<div class="row tbl_list">
							<div class="col-3 d-flex justify-content-center">
								<img style="width: 50%;" src="/resources/images/items/${item.item_name}.png">
							</div>
							<div class="col-6">
								<a href="">${item.item_name}</a>
							</div>
							<div class="col-1 d-flex justify-content-center">${item.quantity}</div>
							<div class="col-2 d-flex justify-content-center">${item.price}</div>
						</div>
					</c:forEach>
				</div>

				<!-- 배송지 정보 -->
				<div class="deliveryInfo">
					<div class="row titleLabel">
						<div class="col-lg-2 col-3">주문 결제확인</div>
					</div>
					<div class="content">
						<!-- 받는 사람 -->
						<div class="row">
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">받는사람</div>
							<div class="col-lg-3 col-9">
								<!-- 받는 사람 -->
								<p>${order.delivery_name}</p>
							</div>
						</div>
						<!-- 연락처 -->
						<div class="row">
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">연락처</div>
							<div class="col-lg-3 col-9 d-flex">
								<!-- 연락처 칸 -->
								<p>${order.delivery_phone}</p>
							</div>
						</div>
						<!-- 주소 -->
						<div class="addressBox">
							<div class="row" style="border: none;">
								<!-- 주소 -->
								<div
									class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주소</div>
								<!-- 우편번호 -->
								<div class="col-lg-3 col-3">
									<!-- 우편번호 -->
									<p>${order.delivery_addr}</p>
								</div>
							</div>
							<div class="row mt-2 mb-2">
								<div class="col-lg-2 col-3"></div>
								<!-- 주소 -->
								<div class="col-lg-8 col-9">
									<p></p>
								</div>
							</div>
						</div>
						<!-- 주문 메세지 -->
						<div class="row">
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주문메세지</div>
							<!-- 주문 메세지 입력하기 -->
							<div class="col-lg-8 col-9">
								<p>${order.order_msg}</p>
							</div>
						</div>
						<!-- 배송 메세지 -->
						<div class="row mt-2 mb-2">
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">배송메세지</div>
							<!-- 배송 메세지 입력하기 -->
							<div class="col-lg-8 col-9">
								<p>${order.delivery_msg}</p>
							</div>
						</div>
						<!-- 결제방법 -->
						<div class="row">
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">결제방법</div>
							<div class="col-lg-3 col-3 d-flex align-items-center text-center">
								<!-- 결제방법 -->
								<p class="m-0">신용카드</p>
							</div>
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">결제금액</div>
							<div class="col-lg-3 col-3 d-flex align-items-center text-center">
								<!-- 최종 금액 -->
								<p class="m-0">${order.order_amount} (배송비 미포함 금액)</p>
							</div>
						</div>

					</div>
				</div>
				<!-- 버튼 -->
				<div class="btnBox d-flex justify-content-center">
					<button type="button" class="btn btn-outline-dark">MyPage</button>
					<button type="button" class="btn btn-outline-success" id="btnOrder">Main</button>
				</div>
			</div>
			<%--풋터영역 --%>
			<jsp:include page="/frame/footer.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>