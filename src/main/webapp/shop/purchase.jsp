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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/purchase.css" rel="stylesheet" type="text/css">
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
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
						<span>${totalPrice}</span>
					</div>
				</div>
			</div>
			<form id="orderForm" action="/complete.order" method="post">
			<div class="orderInfo">
				<div class="titleLabel border-bottom">
					<span>주문자 정보</span>
				</div>
				<div class="content">
					<div class="row border-bottom">
						<div
							class="col-lg-1 col-2 d-flex justify-content-center align-items-center">주문자명</div>
						<div class="col-2">
							<input type="text" class="form-control" id="order_name" name="order_name" value="${userInfo.username}">
						</div>
					</div>
					<div class="row border-bottom">
						<div
							class="col-lg-1 col-2 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-3">
							<input type="text" class="form-control" id="order_phone" name="order_phone" value="${userInfo.phone}">
						</div>
						<div
							class="col-lg-1 col-2 d-flex justify-content-center align-items-center">이메일</div>
						<div class="col-3 d-flex align-items-center">
							<input type="text" class="form-control" id="order_email" name="order_email" value="${userInfo.email}">
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
							<input type="text" class="form-control" id="delivery_name" name="delivery_name">
						</div>
						<div class="col-2 d-flex align-items-center">연락처</div>
						<div class="col-5">
							<input type="text" class="form-control" id="delivery_phone" name="delivery_phone">
						</div>
					</div>
					<div class="row">
						<div class="col-2 d-flex align-items-center">주소</div>
						<div class="col-2">
							<input type="text" class="form-control" id="postcode" name="postcode" readOnly>
						</div>
						<div class="col-8">
							<button type="button" id="btnPostcode" class="btn btn-primary"
								style="width: 100px">우편번호검색</button>
						</div>
					</div>
					<div class="row m-2 border-bottom">
						<div class="col-2"></div>
						<div class="col-3">
							<input type="text" class="form-control" id="delivery_addr" name="delivery_addr" readOnly>
						</div>
						<div class="col-3">
							<input type="text" class="form-control" id="delivery_detail">
						</div>
					</div>
					<div class="row border-bottom">
						<div class="col-2 d-flex align-items-center">주문메시지</div>
						<div class="col-10">
							<input type="text" class="form-control" id="order_msg" name="order_msg">
						</div>
					</div>
					<div class="row m-2">
						<div class="col-2 d-flex align-items-center">배송메시지</div>
						<div class="col-10">
							<input type="text" class="form-control" id="delivery_msg" name="delivery_msg">
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
							<input type="checkbox" id="TermsAccept"> 상기 결제정보를 확인하였으며 구매 진행에 동의합니다.
						</div>
					</div>
				</div>
			</div>
			</form>
			<div class="row finalAmount border-top border-bottom p-4">
			<div class="col-2">
				<span>최종결제 금액</span>
			</div>
			<div class="col-2">
				<span>20.000원</span>
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
		if($("#order_name").val() == ""){
			alert("주문자명을 적어주세요");
			$("#order_name").focus();
			return;
		} else if($("#order_phone").val() == "") {
			alert("주문자 연락처를 적어주세요");
			$("#order_phone").focus();
			return;
		} else if($("#order_email").val() == "") {
			alert("주문자 이메일을 적어주세요");
			$("#order_email").focus();
			return;
		} else if($("#delivery_name").val() == "") {
			alert("배송자명을 적어주세요");
			$("#delivery_name").focus();
			return;
		} else if($("#delivery_phone").val() == "") {
			alert("배송 연락처를 적어주세요");
			$("#phone").focus();
			return;
		} else if($("#postcode").val() == "") {
			alert("검색된 배송지가 없습니다. 배송지를 등록하세요");
			$("#postcode").focus();
			return;
		} else if($("#detailAddr").val() == "") {
			alert("상세 주소가 없습니다. 상세주소를 입력하새요.");
			$("#detailAddr").focus();
			return;
		} else if($("#TermsAccept").is(":checked") == false) {
			alert("구매 약관에 동의해주세요");
			$("#TermsAccept").focus();
			return;
		}
		IMP.init("imp86984194");
		requestPay();
		
		// 아임포트 결제 모듈 실행
		
		function requestPay() {
		// IMP.request_pay(param, callback) 결제창 호출
			IMP.request_pay({ // param
				pg: "html5_inicis",
				pay_method: "card",
				merchant_uid: "ORD20180131-0000011",
				name: "노르웨이 회전 의자",
				amount: 64900,
				buyer_email: "gildong@gmail.com",
				buyer_name: "홍길동",
				buyer_tel: "010-4242-4242",
				buyer_addr: "서울특별시 강남구 신사동",
				buyer_postcode: "01181"
			}, function (rsp) { // callback
					if (rsp.success) {
						console.log("success");
						$("#orderForm").submit();
						// 결제 성공 시 로직,
					} else {
						console.log("fail!");
						// 결제 실패 시 로직,
					}
		      });
		}
	})
	
	// 우편번호 API
	$("#btnPostcode").on("click", function () {
		new daum.Postcode({
	  	theme: {
	          searchBgColor: "#7CC09C", //검색창 배경색
	          queryTextColor: "#FFFFFF" //검색창 글자색
	      }
	      , oncomplete: function(data) {
	
	          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	          // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	          var roadAddr = data.roadAddress; // 도로명 주소 변수
	          var extraRoadAddr = ''; // 참고 항목 변수
	
	          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	              extraRoadAddr += data.bname;
	          }
	          // 건물명이 있고, 공동주택일 경우 추가한다.
	          if(data.buildingName !== '' && data.apartment === 'Y'){
	             extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	          }
	          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	          if(extraRoadAddr !== ''){
	              extraRoadAddr = ' (' + extraRoadAddr + ')';
	          }
	
	          // 우편번호와 주소 정보를 해당 필드에 넣는다.
	          document.getElementById('postcode').value = data.zonecode;
	          document.getElementById('delivery_addr').value = roadAddr;
	      }
	  }).open();
	});
	</script>
</body>
</html>