<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link href="${pageContext.request.contextPath}/resources/css/mycart.css" rel="stylesheet" type="text/css">
    <title>장바구니</title>

</head>
<body>
    <div class="container">
		<jsp:include page="/frame/header.jsp"></jsp:include>
        <div class="row" style="margin-bottom: 20px;">
            <div class="col-10">
                <h3>SHOPPING CART</h3>
            </div>
            <div class="col-2">
                <button type="button" class="btn btn-secondary" id="btnDelete">삭제</button>
            </div>

        </div>
        <div class="row title-row">
            <div class="col-8">
                <p>product</p>
            </div>
            <div class="col-2">
                <p>Quantity</p>
            </div>
            <div class="col-2">
                <p>Price</p>
            </div>
        </div>

        
        <c:forEach items="${list}" var="dto">
        
        
        
         <div class="row list-row">
            <div class="col-3">
                <input class="form-check-input" type="checkbox" checked="checked" id="selectBox" value="">
                <img src="/resources/images/category/air/개운죽.png">
            </div>
              

            <div class="col-5" style="margin-top: 25px; text-align: left;">
                ${dto.item_name}
            </div>

            <div class="col-2" style="text-align: center; margin-top: 25px;">
                    <input type="text" size="1" maxlength="4" class="p_num" value="${dto.quantity}">
            </div>

           
            <div class="col-2" style="margin-top:25px; text-align: center;">${dto.price}
            </div>
        </div>
        
        
        
        </c:forEach>
        
       


        <div class="row price-row">
            <div class="col">총 가격 : XXXX 원</div>
        </div>

            
      
        <div class="row button-row">
           
            <div class="col">
                <button type="button" class="btn btn-secondary btn-lg" id="btnShopping">쇼핑 계속하기</button>
                <button type="button" class="btn btn-secondary btn-lg" id="btnOrder"> &nbsp&nbsp&nbsp주문하기&nbsp&nbsp&nbsp </button>
            </div>
        </div>
	<jsp:include page="/frame/footer.jsp"></jsp:include>
    </div>
  
</body>
</html>