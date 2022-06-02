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

  <div class="row itemInfoBox">
    <div class="col-12 col-md-6">
      <div class="imgBox d-flex justify-content-center m-3">
       <img src="/resources/images/items/${itemImg.sys_name}"> 
       </div>
      <div class="imgDesc p-2 m-3">${item.item_comment}</div>
    </div>
    <div class="col-12 col-md-6 d-flex flex-column justify-content-center">
      <div class="item-title text-center">
        <h2>${item.item_name}</h2>
      </div>
      <div class="item-detail d-flex flex-column justify-content-center p-3">
        <table>
          <tr>
            <td colspan="2"><span>판매가격</span></td>
            <td><span class="item-price">
                ${item.price} 원
              </span>
            </td>
          </tr>
          <tr>
            <td colspan="2">
              <span>상품수</span>
            </td>
            <td>
              <input type='button' id="plus" value='+' />
              <input type="text" id="result" value="1">
              <input type='button' value='-' />
             </td>
           </tr>
         </table>
         <div class="totalAmout text-end p-3">
           <span>총 상품금액</span>
           <span>000,000원</span>
         </div>
       </div>
       <div class="btnBox d-flex justify-content-center">
<form action="/cartProc.cart" method="post" id = "cartForm">
	<input type="text" name = "item_no" id = "item_no" class="d-none" value="${item.item_no}">       
       <button class="m-2" id="btnCart" type="button">장바구니</button>
</form>
         <button class="m-2" type="">구매하기</button>
       </div>
     </div>
   </div>
   <div class="itemDetailImageBox">
     상품 세부설명 이미지
   </div>
   <div class="itemReviewBox">
     <div class="review-title p-2" style="background-color: lightgray;">
      <h1>Review</h1>
    </div>
  </div>
  <div class="review-inputBox">
  	<form id="reviewForm" action="/write.re" method="post">
     <div class="row">
       <div class="col-lg-1 col-2">닉네임</div>
       <div class="col-lg-4 col-2">
         <input type="text" class="form-control" id="nickname" name="nickname">
       </div>
       <div class="col-lg-1 col-2">평점</div>
       <div class="col-lg-4 col-2">
         <input type="text" class="form-control" id="score" name="score">
       </div>
     </div>
     <div class="row">
       <div class="col-lg-1 col-2">제목</div>
       <div class="col-lg-4 col-6">
         <input type="text" class="form-control" id="title" name="title">
       </div>
     </div>
     <div class="row">
       <div class="col-lg-1 col-2">사진</div>
       <div class="col-lg-4 col-6">
         <input type="file">
       </div>
     </div>
     <div class="row">
       <div class="col-lg-1 col-2">리뷰</div>
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
  <div class="review-board">
    <table>
      <thead>
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
      		<tr>
		  <td class="nickname">nickname</td>
		  <td class="title">
			<span style="padding-right: 2em">${review.title}</span>
			<c:if test="${empty loginSession}">
				<button type="button" id="btnReviewDelete" value="${review.review_no}">삭제</button>
				${review.review_no}
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
  
  function count(type)  {
	  // 결과를 표시할 element
	  const resultElement = document.getElementById('result');
	  
	  // 현재 화면에 표시된 값
	  let number = resultElement.innerText;
	  
	  // 더하기/빼기
	  if(type === 'plus') {
	    number = parseInt(number) + 1;
	  }else if(type === 'minus')  {
	    number = parseInt(number) - 1;
	  }
	  
	  // 결과 출력
	  resultElement.innerText = number;
	}
  $("#plus").on("click", function(){
	  const resultElement = document.getElementById('result');
	  let number = resultElement.innerText;
	  number = parseInt(number) + 1;
	  resultElement.innerText = number;
  })

    
    $("#btnWriteReview").on("click", function(){
    	// 리뷰 데이터 유효값 검사
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
    	
   <%--//장바구니 데이터에 같은 물품이 있을 때 추가 불가능
   	if($("#item_no").val() ===  ){
    		alert("장바구니에 같은 물품이 존재합니다.");
    		return false;
    	}
    	$("#cartForm").submit();
    	--%>
    	console.log($("#item_no").val());
    });
  </script>
  
</body>
</html>