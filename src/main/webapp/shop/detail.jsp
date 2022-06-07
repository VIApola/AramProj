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
<form action="/cartProc.cart" method="post" id = "cartForm">  
	<div class="row itemInfoBox">
		<div class="col-12 col-md-7">
			<div class="imgBox d-flex justify-content-center m-3">
				<img src="/resources/images/items/${itemImg.sys_name}" style="width:50%;"> 
			</div>
		</div>
		<div class="col-12 col-md-5 d-flex flex-column justify-content-center">
			<div class="item-title text-center">
				<h2>${item.item_name}</h2>
			</div>
			<div class="item-detail d-flex flex-column justify-content-center p-3">
				<table>
					<tr>
						<td colspan="2"><span>판매가격</span></td>
						<td><span class="item-price">${item.price} 원</span></td>
					</tr>
					<tr>
						<td colspan="2"><span>상품수</span></td>
						<td>
							<input type='button' onclick='count("plus")' value='+' />
							<input type="text" id="result" value="1" name="result">
							<input type='button' onclick='count("minus")' value='-' />
						</td>
					</tr>
				</table>      
			</div>
			<div class="totalAmout text-end p-3">
				<span>총 상품금액</span>
				<span id="totalPrice">${item.price}</span>원
			</div>
			<div class="btnBox d-flex justify-content-center">
				<input type="text" name = "item_no" id ="item_no" class="d-none" value="${item.item_no}">       
				<button class="m-2" id="btnCart" type="button">장바구니</button>
				<button class="m-2" type="">구매하기</button>
			</div>
		</div>
		<div class="col-12 imgDesc d-flex justify-content-center p-5 m-3">${item.item_comment}</div>
	</div>
</form>
<!---------------------------------- 상품 리뷰 영역 ------------------------------->
	<div class="itemReviewBox">
		<div class="review-title p-3" style="background-color: lightgray;">
			<h1>Review</h1>
		</div>
	</div>
  <div class="review-inputBox border-bottom">
  	<form id="reviewForm" action="/write.re" method="post">
     <div class="row">
       <div class="col-lg-1 col-2 d-flex justify-content-center align-items-center"><span>닉네임</span></div>
       <div class="col-lg-4 col-2">
         <input type="text" class="form-control" id="nickname" name="nickname" value="${loginSession.nickname}" readOnly>
       </div>
       <div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">평점</div>
       <div class="col-lg-3 col-6 d-flex align-items-center">
    		<fieldset>
	    		<label for="rate1">⭐</label><input type="radio" name="score" value="1" id="rate1">
	    		<label for="rate2">⭐</label><input type="radio" name="score" value="2" id="rate2">
	    		<label for="rate3">⭐</label><input type="radio" name="score" value="3" id="rate3">
				<label for="rate4">⭐</label><input type="radio" name="score" value="4" id="rate4">
				<label for="rate5">⭐</label><input type="radio" name="score" value="5" id="rate5">
    		</fieldset>
       </div>
     </div>
     <div class="row">
       <div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">제목</div>
       <div class="col-lg-4 col-6">
         <input type="text" class="form-control" id="title" name="title">
       </div>
     </div>
     <div class="row">
       <div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">사진</div>
       <div class="col-lg-4 col-6">
         <input type="file">
       </div>
     </div>
     <div class="row">
       <div class="col-lg-1 col-2 d-flex justify-content-center align-items-center">리뷰</div>
       <div class="col-7">
         <textarea class="form-control" id="content" name="content"></textarea>
       </div>
       <div class="d-none">
       	<input name="item_no" value="${item.item_no}">
       </div>
       <div class="col-2">
         <button type="button" id="btnWriteReview">WRITE</button>
       </div>
     </div>
     <div class="row">
       <div class="col"></div>
     </div>
    </form>
  </div>
  <div class="review-board d-flex justify-content-center">
    <table class="m-4">
      <thead class="border-top border-bottom">
        <tr class="text-center">
          <th class="p-2" style="width: 200px">닉네임</th>
          <th class="p-2" style="width: 700px">내용</th>
          <th class="p-2" style="width: 150px">평점</th>
        </tr>
      </thead>
      <tbody>
<c:if test="${empty reviewList}">
	<tr>
       	<td class="text-center" colspan="3">등록된 리뷰가 없습니다.</td>
       </tr>
      </c:if>
      <c:if test="${not empty reviewList}">
      	<c:forEach items="${reviewList}" var="review">
      		<tr class="p-2">
		  <td class="nickname">${review.nickname}</td>
		  <td class="title">
			<span style="padding-right: 2em">${review.title}</span>
			<c:if test="${loginSession.user_id eq review.user_id}">
				<button type="button" id="btnReviewModify" value="${review.review_no}">수정</button>
			</c:if>
			<c:if test="${loginSession.user_id eq review.user_id}">
				<button type="button" id="btnReviewDelete" value="${review.review_no}">삭제</button>
			</c:if>
		  </td>
		  <td class="score">${review.score}</td>
		</tr>
	</c:forEach>
</c:if>
      </tbody>
    </table>
  </div>

<jsp:include page="/frame/footer.jsp"></jsp:include>
</div>

  <script>
  function count(type) {
	  let number = $("#result").val();
	  if(type === 'plus'){
		  if($("#result").val() > 4) {
			  alert("5개 이상 담을 수 없습니다.");
			  return;
		  }
		  number = parseInt(number) + 1;
		  console.log($(this));
	  } else if(type === 'minus'){
		  if($("#result").val() < 2) {
			  return;
		  }
		  number = parseInt(number) - 1;
	  }
	  $("#result").val(number);
	  $("#totalPrice").html(${item.price} * number);
  }
//리뷰 데이터 유효값 검사
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
    		$("#reviewForm").submit();
    	}
    	
    })
    
    $(".review-board").on("click", "#btnReviewDelete", function(){
    	let answer = confirm("리뷰를 삭제하시겠습니까?");
    	if(answer) {
    		console.log($(this).val());
    		let review_no = $(this).val()
    		location.href = "/delete.re?review_no=" + review_no;
    		
    		/*
    		$.ajax({
    			url: "/delete.re"
    			, type: "get"
    			, data: {}
    			, success: function(data) {
    				console.log(data);
    			} error : function(e) {
    				console.log(e);
    			}
    			
    		})
    		*/
    	}
    });
    
    $("#btnCart").on("click", function() {
    	let con = confirm("장바구니에 담으시겠습니까?");
    	if(con){
    		console.log($("#item_no").val());
    		console.log($("#result").val());
    		if(${empty loginSession}) {
    			alert("장바구니를 사용하기 위해 로그인이 필요합니다.");
    			location.href = "/login.user";
    			return;
    		}
    		$("#cartForm").submit();
			alert("장바구니에 추가되었습니다.");
    	}
    });
  </script>
</body>
</html>