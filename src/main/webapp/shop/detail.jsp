<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<title>상세페이지</title>
<link href="${pageContext.request.contextPath}/resources/css/detail.css" rel="stylesheet" type="text/css">




</head>
<body>
	<div class="container">
		<!--  헤더 영역 -->
		<jsp:include page="/frame/header.jsp"></jsp:include>
		<!---------------------------------- 상품 정보 영역 ------------------------------->
		<form action="/cartProc.cart" method="post" id="cartForm">
			<div class="row itemInfoBox">
				<div class="col-12 col-md-7">
					<div class="imgBox d-flex justify-content-center m-3">
						<img src="/resources/images/items/${itemImg.sys_name}"
							style="width: 50%;">
					</div>
				</div>
				<div
					class="col-12 col-md-5 d-flex flex-column justify-content-center">
					<div class="item-title text-center">
						<h2>${item.item_name}</h2>
						<input type="text" class="d-none" name="item_name" value="${item.item_name}">
					</div>
					<div
						class="item-detail d-flex flex-column justify-content-center p-3">
						<table>
							<tr>
								<td colspan="2"><span>판매가격</span></td>
								<td><span class="item-price">${item.price} 원</span></td>
							</tr>
							<tr>
								<td colspan="2"><span>상품수</span></td>
								<td><input type='button' onclick='count("minus")' value='-' />
									<input type="text" id="qty" value="1" name="qty">
									<input type='button' onclick='count("plus")' value='+' /></td>
							</tr>
						</table>
					</div>
					<div class="totalAmout text-end p-3">
						<span>총 상품금액</span> <strong><span id="totalPrice">${item.price}</span></strong> 원
						<input type="text" class="d-none" name="price" value="${item.price}">
					</div>
					<div class="btnBox d-flex justify-content-center">
						<input type="text" name="item_no" id="item_no" class="d-none"
							value="${item.item_no}">
						<button class="m-2 btn btn-success" id="btnCart" type="button">장바구니</button>
						<button class="m-2 btn btn-warning" id="btnBuy" type="button">구매하기</button>
					</div>
				</div>
				<div class="col-12 imgDesc d-flex justify-content-center p-5 m-3">${item.item_comment}</div>
			</div>
		</form>
		<!---------------------------------- 상품 리뷰 영역 ------------------------------->
		<div class="itemReviewBox">
			<img src="/resources/images/Board_Review.png" class="d-block w-100">
		</div>
		<div class="review-inputBox border-bottom">
			<form id="reviewForm" action="/write.re" method="post">
				<div class="row">
					<div class="col-lg-1 col-2 d-flex justify-content-center align-items-center"><span>닉네임</span></div>
					<div class="col-lg-4 col-2">
						<input type="text" class="form-control" id="nickname" name="nickname" value="${loginSession.nickname}" readOnly>
					</div>
					<div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">평점</div>
					<div class="col-lg-3 col-6 d-flex align-items-center" name="myform" id="myform">
						<fieldset>
								<input type="radio" name="score" value="1" id="rate1"> <label for="rate1">⭐</label>
								<input type="radio" name="score" value="2" id="rate2"> <label for="rate2">⭐</label>
								<input type="radio" name="score" value="3" id="rate3"> <label for="rate3">⭐</label>
								<input type="radio" name="score" value="4" id="rate4"> <label for="rate4">⭐</label>
								<input type="radio" name="score" value="5" id="rate5"><label for="rate5">⭐</label>
						</fieldset>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">제목</div>
					<div class="col-lg-4 col-6">
						<input type="text" class="form-control" id="title" name="title">
					</div>
				</div>
				<!-- <div class="row">
					<div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">사진</div>
					<div class="col-lg-4 col-6">
						<input type="file">
					</div>
				</div>  -->
				<div class="row">
					<div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">리뷰</div>
					<div class="col-7">
						<textarea class="form-control" id="content" name="content" style=resize:none></textarea>
					</div>
					<div class="d-none">
						<input name="item_no" value="${item.item_no}">
					</div>
					<div class="col-2 btnCol">
						<button type="button" id="btnWriteReview" class="btn btn-secondary btn-lg">글쓰기</button>
						<button type="button" id="btnModifyReview" style="display:none">수정완료</button>
						<input type="hidden" id="review_no" name="review_no" value="">
					</div>
				</div>
				<div class="row">
					<div class="col"></div>
				</div>
			</form>
		</div>
		<!-------------------------------- 리뷰 게시판 -------------------------------------->
		<div class="review-board d-flex justify-content-center">
			<table class="m-4" id="reviewTable">
				<thead class="border-top border-bottom">
					<tr class="text-center">
						<th class="p-2" style="width: 200px">닉네임</th>
						<th class="p-2" style="width: 700px">제목 ( 클릭 시 내용 열람이 가능합니다 ) </th>
						<th class="p-2" style="width: 150px">평점</th>
					</tr>
				</thead>
				<tbody class="reviewList">
					<c:if test="${empty reviewList}">
						<tr>
							<td class="text-center" colspan="3">등록된 리뷰가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty reviewList}">
						<c:forEach items="${reviewList}" var="review">
							<tr class="p-2 tr1">
								<td class="nickname">${review.nickname}</td>
								<td class="title"><span class="titleSpan" style="padding-right: 2em">${review.title}</span>
									<c:if test="${loginSession.user_id eq review.user_id}">
										<button type="button" id="btnReviewModify" class="btn btn-warning"
											value="${review.review_no}">수정</button>
									</c:if> <c:if test="${loginSession.user_id eq review.user_id}">
										<button type="button" id="btnReviewDelete" class="btn btn-danger"
											value="${review.review_no}">삭제</button>
									</c:if></td>
								<td class="score">${review.score}</td>
							</tr>
						 <tr class="p-2 contentTr" id="contentTr" style="display:none"><td class="contentTd" id="contentTd" colspan="3">
						 <span id="contentSpan" class="contentSpan">${review.content}</span>
						 </td></tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>

		<jsp:include page="/frame/footer.jsp"></jsp:include>
	</div>

	<script>
	
  getTitle();
	
  function count(type) {
	  let number = $("#qty").val();
	  if(type === 'plus'){
		  if($("#qty").val() > 4) {
			  alert("5개 이상 담을 수 없습니다.");
			  return;
		  }
		  number = parseInt(number) + 1;
		  console.log($(this));
	  } else if(type === 'minus'){
		  if($("#qty").val() < 2) {
			  return;
		  }
		  number = parseInt(number) - 1;
	  }
	  $("#qty").val(number);
	  $("#totalPrice").html(${item.price} * number);
  }
	// 리뷰 데이터 유효값 검사
    $("#btnWriteReview").on("click", function() {
    	if("${loginSession}" == "") {
    		alert("로그인 된 유저만 리뷰를 등록할 수 있습니다.");
    		return;
    	}
    	if($("#nickname").val() == "") {
    		alert("닉네임을 입력해주세요");
    		return;
    	} else if($("#score").val() == "") {
    		alert("평점을 등록해주세요");
    		return;
    	} else if($("#title").val() == "") {
    		alert("제목이 비어있습니다. 제목을 입력해주세요.")
    		return;
    	} else if($("#content").val() == "") {
    		alert("리뷰 내용이 비어있습니다. 내용을 입력해주세요.");
    		return;
    	}
    	let answer = confirm("리뷰를 등록하시겠습니까?");
    	if(answer) {
    		/* $("#reviewForm").submit(); */
    		$.ajax({
    			url: "/write.re"
    			, type: "post"
    			, data: {
    				title: $("#title").val()
    				, score: 5
    				, content: $("#content").val()	
    				, item_no:	"${item.item_no}"
    			}
    			, success: function(data) {
    				printReviewList(data);		

    				getTitle();
    				
    			}, error: function(e) {
    				console.log(e);
    			}
			})
			// 비우기
			$("#title").val("")
			$("#content").val("")
		}
    })
    
    // 리뷰 수정
     $(".review-board").on("click", "#btnReviewModify", function(){
    	console.log($(this).val());
    	
    		modify_review($(this));
    	
    		// 수정완료 버튼 클릭이벤트
    		$("#btnModifyReview").on("click", function(){
    					
    			$(this).prev().html( $("#content").val() ); // 제목 최신화
    			$(this).parent().parent().next().children().children().html( $("#title").val() ); // 내용 최신화
    			//console.log("수정title:   "+$(this).prev().html()); // 버튼 반응 확인
    			//console.log("수정content:  "+$(this).parent().parent().next().children().children().html());

    			modifyForm();
    			
    			// 비우기
    			$("#title").val("");
    			$("#content").val("");
    		})
    	
    });
	
    // 리뷰 삭제
    $(".review-board").on("click", "#btnReviewDelete", function(){
    	let answer = confirm("리뷰를 삭제하시겠습니까?");
    	if(answer) {
    		$.ajax({
    			url: "/delete.re"
    			, type: "post"
    			, data: {
    				review_no: $(this).val()
    				, item_no:	"${item.item_no}"
    			}
    			, success: function(data) {
    				printReviewList(data);
		
    					getTitle();
    				
        			$("#title").val("");
        			$("#content").val("");
    			}, error: function(e) {
    				console.log(e);
    			}
			})
    	}
    });
	
	// 바로 구매할 때
	$("#btnBuy").on("click", function() {
		if(${empty loginSession}) {
			alert("로그인이 필요합니다.");
			location.href = "/login.user";
			return;
		}
		let con = confirm("이 상품을 구매하시겠습니까?");
		if(con){
			$("#cartForm").attr("action", "/toOrderPage.order");
			$("#cartForm").submit();
		}
	})
    
	// 장바구니에 담을 때
    $("#btnCart").on("click", function() {
    	let con = confirm("장바구니에 담으시겠습니까?");
    	if(con){
    		if(${empty loginSession}) {
    			alert("장바구니를 사용하기 위해 로그인이 필요합니다.");
    			location.href = "/login.user";
    			return;
    		}
    		$("#cartForm").submit();
			alert("장바구니에 추가되었습니다.");
    	}
    });
	
	// 리뷰 수정 함수
	function modify_review(a){
    	
    	$("#btnWriteReview").css({"display":"none"});
    	$("#btnModifyReview").css({"display":""});
    	
    	console.log(a.prev().html());
    	$("#title").val(a.prev().html()); // 제목
    	
    	console.log( a.parent().parent().next().children().children().html()); // 내용
    	$("#content").val( a.parent().parent().next().children().children().html());
    	
    	console.log( a.parent().next().html() ); //별점
    	$("#myform").val( a.parent().next().html());
    	 
    	$("#review_no").val(a.val()); // 리뷰번호 따오기
    	
    }
	
	
	// form 2번째 경로로 이동 (수정처리) 함수
    function modifyForm(){ 
    	$("#reviewForm").attr("action","/modify.re");
    	//$("#reviewForm").attr("target","iframe"); // iframe으로 페이지 로드되지 않게(실패)
    	$("#reviewForm").submit();
    }
	
    // 제목 클릭 시 내용 보이기 함수
    function getTitle(){
   	$(".titleSpan").each(function(){
       	$(this).on("click", function(){
       		console.log($(this).html());		
       	
       		 $(this).parent().parent().next().toggle();		
       	})
       })
	}
	
	// 리뷰 목록 뿌려주는 함수
	function printReviewList(data) {
		console.log(data)
		let list = JSON.parse(data);
		console.log(list);
		
		$(".reviewList").empty();
		
		if(list.length == 0){
			let tr = $("<tr>")
			let	td = $("<td>").addClass("text-center").attr("colspan","3")
			td.html("등록된 리뷰가 없습니다.");
			
			tr.append(td);
			$(".reviewList").append(tr);
		} else {
			for(let dto of list) {
				let tr = $("<tr>").addClass("p-2 tr1")
				
				let nickname = $("<td>").addClass("nickname").html(dto.nickname);
				let title = $("<td>").addClass("title");
				let titleSpan = $("<span>").addClass("titleSpan").css({"padding-right":"2em"}).html(dto.title);
				title.append(titleSpan)
				
				let modifyBtn;
				let deleteBtn;
				if(dto.user_id == '${loginSession.user_id}') {
					modifyBtn = $("<button>").addClass("btn btn-warning").attr("id","btnReviewModify").attr("value",dto.review_no)
					modifyBtn.html("수정")
					deleteBtn = $("<button>").addClass("btn btn-danger").attr("id","btnReviewDelete").attr("value",dto.review_no)
					deleteBtn.html("삭제")
				}
				title.append(modifyBtn);
				title.append(deleteBtn);
				
				let score = $("<td>").addClass("score").html(dto.score)
				
				tr.append(nickname)
				tr.append(title)
				tr.append(score)
				
				
				let tr2 = $("<tr>").addClass("p-2 contentTr").attr("id","contentTr").css({"display":"none"});
				let contentTd = $("<td>").addClass("contentTd").attr("id","contentTd").attr("colspan","3");
				let contentSpan = $("<span>").addClass("contentSpan").attr("id","contentSpan").html(dto.content);
				console.log("contentSpan : " + contentSpan);
				
				contentTd.append(contentSpan);
				tr2.append(contentTd);
	
			
				$(".reviewList").append(tr);
				$(".reviewList").append(tr2);
			}
		}
	}
  </script>
</body>
</html>