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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/purchase.css" rel="stylesheet" type="text/css">
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<title> 주문 결제 페이지</title>
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
					<div class="col-2 col-lg-1 d-flex justify-content-center">선택</div>
					<div class="col-6 col-lg-8 d-flex justify-content-center">상품명</div>
					<div class="col-2 col-lg-1 d-flex justify-content-center">수량</div>
					<div class="col-2 col-lg-2 d-flex justify-content-center">가격</div>
				</div>
				<c:forEach items="${cartList}" var="cartItem">
					<div class="row tbl_list ">
						<div
							class="col-2 col-lg-1 d-flex justify-content-center align-items-center">
							<input type="checkbox">
						</div>
						<div class="col-6 col-lg-8 d-flex justify-content-evenly align-items-center">
								<img src="/resources/images/items/${cartItem.item_name}.png" style="width: 100px;">
								<div style="letter-spacing: 3px;">${cartItem.item_name}</div>	
						</div>
						<div class="col-2 col-lg-1 d-flex justify-content-center align-items-center">${cartItem.quantity}</div>
						<div class="col-2 col-lg-2 d-flex justify-content-center align-items-center">${cartItem.price}</div>
					</div>
				</c:forEach>
				<div class="row">
					<div class="col-9 d-flex justify-content-end">
						<span>총 가격 : </span>
					</div>
					<div class="col-2">
						<span>${totalPrice}</span>
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
							<input type="text" class="form-control" id="order_name" name="order_name" value="${loginSession.username}">
						</div>
					</div>
					<!-- 연락처, 이메일 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-lg-3 col-9 d-flex">
							<input type="text" class="form-control" id="order_phone1" name="order_phone1" > &nbsp;
							<input type="text" class="form-control" id="order_phone2" name="order_phone2" > &nbsp;
							<input type="text" class="form-control" id="order_phone3" name="order_phone3" >
						</div>
					</div>
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">이메일</div>
						<div class="col-lg-3 col-9 d-flex align-items-center">
							<input type="text" class="form-control" id="order_email" name="order_email" value="${loginSession.email}">
						</div>
					</div>
				</div>
			</div>
			<!-- 배송지 정보 -->
			<div class="deliveryInfo">
				<div class="row titleLabel">
					<div class="col-lg-2 col-3">배송지 정보</div>
					<div class="col-lg-10 col-9">
						<input type="checkbox" id="ckBox"> 주문하는 사람과 동일한 배송지
					</div>

				</div>
				<div class="content">
					<!-- 받는 사람 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">받는사람</div>
						<div class="col-lg-3 col-9">
							<input type="text" class="form-control" id="delivery_name" name="delivery_name">
						</div>
					</div>
					<!-- 연락처 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">연락처</div>
						<div class="col-lg-3 col-9 d-flex">
							<input type="text" class="form-control" id="phone1"> 
							<input type="text" class="form-control" id="phone2">
							<input type="text" class="form-control" id="phone3">
						</div>
					</div>
					<!-- 주소 -->
					<div class="addressBox">
						<div class="row" style="border: none;">
							<!-- 주소 -->
							<div
								class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주소</div>
							<div class="col-lg-3 col-3">
								<input type="text" class="form-control" id="postcode" name="postcode" readonly>
							</div>
							<!-- 우편번호 검색 -->
							<div class="col-lg-3 col-6">
								<button type="button" id="btnPostcode" class="btn btn-primary"
									style="width: 120px">우편번호검색</button>
							</div>
						</div>
						<div class="row mt-2 mb-2">
							<div class="col-lg-2 col-3"></div>
							<div class="col-lg-4 col-4">
								<input type="text" class="form-control" id="delivery_addr" name="delivery_addr" readonly>
							</div>
							<div class="col-lg-4 col-5">
								<input type="text" class="form-control" id="delivery_detail">
							</div>
						</div>
					</div>
					<!-- 주문 메세지 -->
					<div class="row">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">주문메세지</div>
						<div class="col-lg-8 col-9">
							<textarea class="form-control" placeholder="주문메세지를 입력해주세요" id="order_msg" name="order_msg"></textarea>
						</div>
					</div>
					<!-- 배송 메세지 -->
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">배송메세지</div>
						<div class="col-lg-8 col-9">
							<textarea class="form-control" placeholder="배송메세지를 입력해주세요" id="delivery_msg" name="delivery_msg"></textarea>
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

			<!-- 약관 동의 -->
			<div class="payMoneyInfo">
				<div class="row payMoneyInfo-title titleLabel">
					<span>주문자 약관동의</span>
				</div>
				<div class="payment_wrap content">
					<div class="row mt-2 mb-2">
						<div
							class="col-lg-2 col-3 d-flex justify-content-center align-items-center">약관동의</div>
						<div class="col-lg-10 col-9">
							<%-- 
							<textarea class="form-control" name="" id=""></textarea>
							--%>
							 
							<table style="font-size: 5px; border: 1px solid lightgray;">
								<thead style="text-align: center;">
									<tr>
										<td>목적</td>
										<td>항목</td>
										<td>보유기간</td>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>주문자 정보 확인,<br>주문 내역 안내,<br>주문 내역 조회</td>
										<td>주문자 정보<br>(이름, 연락처, 이메일)</td>
										<td rowspan="2">주문일로부터 90일까지 보유하며, 관계 법령에 따라 5년간 보관</td>
									</tr>
									<tr>
										<td>상품 배송(구매/환불/취소/교환)을 위한 수취인 정보</td>
										<td>수취인 정보<br>(이름, 연락처1, 주소)</td>
									</tr>
								</tbody>
							</table>
							<%-- 
							<div class = "agreeBox">
								<div class = "row">
									<div class ="col-4">목적</div>
									<div class ="col-4">항목</div>
									<div class ="col-4">보유기간</div>
								</div>
								<div class="row">
									<div class="col-4">주문자 정보 확인, 주문 내역 안내, 주문 내역 조회</div>
									<div class="col-4">주문자 정보(이름, 연락처, 이메일)</div>
								</div>
								<div class="row">
									<div class="col-4">상품 배송(구매/환불/취소/교환)을 위한 수취인 정보</div>
									<div class="col-4">수취인 정보(이름, 연락처1, 연락처2, 주소)</div>
									<div class="col-4">주문일로부터 90일까지 보유하며, 관계 법령에 따라 5년간 보관</div>
								</div>
							</div>--%>
						</div>
					</div>
					<div class="row mt-2 mb-2">
						<div class="col-lg-2 col-3 d-flex justify-content-center align-items-center">
							주문동의</div>
						<div class="col-lg-10 col-9">
							<input type="checkbox" id="TermsAccept">상기 결제정보를 확인하였으며, 구매 진행에 동의합니다.
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
                <span>20.000원</span>
            </div>
        </div>
		<!-- 버튼 -->
		<div class="btnBox d-flex justify-content-center">
			<button type="button" class="btn btn-outline-dark">취소하기</button>
			<button type="button" class="btn btn-outline-success" id="btnOrder">주문하기</button>
		</div>
		<%--풋터영역 --%>
		<jsp:include page="/frame/footer.jsp"></jsp:include>
	</div>
		
		

	<script>
	
	// 휴대폰 번호 셋팅
		let phone = "${loginSession.phone}";
		let phone1 = phone.slice(0, 3);
		let phone2 = phone.slice(3, 7);
		let phone3 = phone.slice(7);

		// 셀렉트 박스에 default selected값 주기
		$("#order_phone1").val(phone1);
		$("#order_phone2").val(phone2);
		$("#order_phone3").val(phone3);
		
	// ckBox활성화시 정보 가져오기
		let name = "${loginSession.username}";
		
		$("#ckBox").click(function(){
			
			/* 사용할 수 도 있음
			if($(선택자).is(":checked") == true){
			    console.log('체크된 상태');
			}
			 
			if($(선택자).is(":checked") == false){
			    console.log('체크 안 된 상태');
			}*/
			
			$("#delivery_name").val(name);
			$("#phone1").val(phone1);
			$("#phone2").val(phone2);
			$("#phone3").val(phone3);
			return;
		});
	
		
		
	// 주문서 유효성 검사
	$("#btnOrder").on("click", function() {
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
		} else if($("#delivery_detail").val() == "") {
			alert("상세 주소가 없습니다. 상세주소를 입력하새요.");
			$("#delivery_detail").focus();
			return;
		} else if($("#TermsAccept").is(":checked") == false) {
			alert("구매 약관에 동의해주세요");
			$("#TermsAccept").focus();
			return;
		}
		console.log("eee");
		
		IMP.init("imp86984194");
		requestPay(orderNO(), "관나무 외 6개", 100, $("#order_email").val(), $("#delivery_name").val(), $("#delivery_phone").val(), $("#delivery_addr").val(), $("#postcode").val());
		
		
	})

	
		

	// 아임포트 결제 모듈 실행
	function requestPay(order_no, name, amount, buyer_email, buyer_name, buyer_tel, buyer_addr, buyer_postcode) {
		buyer_addr = $("#delivery_addr").val() + $("#delivery_detail").val();
		buyer_phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
					
		console.log($("#order_email").val());
		console.log($("#delivery_name").val());
		console.log(buyer_phone);
		console.log($("#delivery_addr").val());
		console.log($("#postcode").val())
		
	// IMP.request_pay(param, callback) 결제창 호출
		IMP.request_pay({ // param
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: order_no,
			name: name,
			amount: amount,
			buyer_email: buyer_email,
			buyer_name: buyer_name,
			buyer_tel: buyer_phone,
			buyer_addr: buyer_addr,
			buyer_postcode: buyer_postcode
		}, function (rsp) { // callback
				console.log(rsp);
		
				if (rsp.success) {
					// 결제 성공 시 로직,
					console.log("success");
					requestOrder(order_no);
				} else {
					// 결제 실패 시 로직,
					alert("결제 과정에서 오류가 발생했습니다. 다시 시도해주세요.")
					console.log("fail!");
				}
	      });
	}
	
	// 주문서 정보 ajax로 전달하기
	function requestOrder(order_no) {
		let buyer_addr = "(" $("#postcode").val() + ") " + $("#delivery_addr").val() + ", " + $("#delivery_detail").val();
		let order_phone = $("#order_phone1").val() + $("#order_phone2").val() + $("#order_phone3").val();
		let buyer_phone = $("#phone1").val() + $("#phone2").val() + $("#phone3").val();
		
		$.ajax({
			url:"/complete.order"
			, type:"post"
			, data: {
				order_no: order_no.toString();
				, order_name: $("#order_name").val()
				, order_email: $("#order_email").val()
				, order_phone: order_phone
				, delivery_name: $("#delivery_name").val()
				, delivery_phone: buyer_phone
				, delivery_addr: buyer_addr
				, order_msg: $("#order_msg").val()
				, delivery_msg: $("#delivery_msg").val()
			}
			, success: function(data) {
				location.href = "/success.order";
			}
			, error: function(e) {
				console.log(e);
			}
		})	
		
	}
	
	// 주문번호 생성하는 함수
	function orderNO() {
		let today = new Date();
		let year = (today.getFullYear()).toString();
		let month = today.getMonth() + 1;
		if(month < 10) {
			month = "0" + month;
		}
		let date = today.getDate();
		if(date < 10) {
			date = "0" + (date + 1);
		}
		
		let orderNo = year + month + date + Math.floor(Math.random()*(9000)) + 1;
		
		return orderNo;
	}
	
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