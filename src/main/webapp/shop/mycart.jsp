<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<link href="${pageContext.request.contextPath}/resources/css/mycart.css"
	rel="stylesheet" type="text/css">
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
		<div class="col-8 d-flex align-items-center justify-content-center">
			<span>product</span>
		</div>
		<div class="col-2 d-flex align-items-center justify-content-center">
			<span>Quantity</span>
		</div>
		<div class="col-2 d-flex align-items-center justify-content-center">
			<span>Price</span>
		</div>
	</div>
	<div class="body-list">
		<c:forEach items="${list}" var="dto">
			<c:if test="${loginSession eq dto.user_id}">
			<div class="row list-row">
				<div class="col-1 d-flex align-items-center justify-content-center">
					<input class="form-check-input" type="checkbox" checked="checked"
							id="${dto.price}" name="checkBox" value="${dto.item_no}">
				</div>
				<div class="col-2">
					<img src="/resources/images/items/${dto.item_name}.png">
				</div>
				<div class="col-5 itemName d-flex align-items-center">
					<span>${dto.item_name}</span>
				</div>
				<div class="col-2 quantityBox d-flex align-items-center justify-content-center">
					<input type='button' class="btnPlus" value='+' />
					<input type="text" class="p_num" value="${dto.quantity}" style="width: 20px;text-align:center;">
					<input type='button' class="btnMinus" value='-' />
				</div>
				<div class="col-2 priceName d-flex align-items-center justify-content-center">
					<span>${dto.price}</span>
				</div>
			</div>
			</c:if>
		</c:forEach>
	</div>
	<div class="row price-row">
		<div class="col">총 가격 : ${total} 원</div>
	</div>
	<div class="row button-row">
		<div class="col">
			<button type="button" class="btn btn-secondary btn-lg"
				id="btnShopping">쇼핑 계속하기</button>
			<button type="button" class="btn btn-secondary btn-lg" id="btnOrder">
				&nbsp&nbsp&nbsp주문하기&nbsp&nbsp&nbsp</button>
		</div>
	</div>
	<jsp:include page="/frame/footer.jsp"></jsp:include>
</div>

	<script>
	$("#btnOrder").on("click", function(){
		let ans = confirm("장바구니에 담긴 상품을 주문하시겠습니까?");
		if(ans) {
			location.href = "/purchase.order";
		}
	})
    
    <%--
    $("input:checkbox:checked").each(function(){
		
		checkVals.push( $(this).val() );
		
	
		console.log(checkVals);
	});
    --%>
    
    
    
    <%--
    function count(type) {
        // 결과를 표시할 element
        const p_numElement = document.getElementsByClassName("p_num");

        // 현재 화면에 표시된 값
        let number = $(".p_num").val();

        // 더하기/빼기
        if (type === "plus") {
          $(".p_num").val() = parseInt( $(".p_num").val() ) + 1;
        } else if (type === "minus") {
          $(".p_num").val() = parseInt( $(".p_num").val() ) - 1;
        }
       
      }
    --%>
    
    $(".btnPlus").on("click", function(){
    	
    	console.log($(".p_num").val());
    	
    	parseInt($(".p_num").val()) = parseInt($(".p_num").val()) + 1;
    	
    	console.log($(".p_num").val());
    	
    	
    });
    
    $(".btnMinus").on("click", function(){
    	console.log("-");
    	
		console.log($(".p_num").val());
    	
    	parseInt($(".p_num").val()) = parseInt($(".p_num").val()) + 1;
    	
    	
    });
    
    
    $("#btnDelete").on("click", function(){
    	
    	let con = confirm("이 물품들을 장바구니에서 삭제하시겠습니까?");
    	
    	if(con){
    	
    		let checkval = "";
    		let checkVals = [];
    		
        	$("input:checkbox:checked").each(function(){
        		
        		checkVals.push( $(this).val() );
        		
        	
        		console.log(checkVals);
        	});
    		
        
        	
        	$.ajax({
        		url: "/deleteCart.cart"
            	,	type:"post"
            	,	traditional :true
            	,	data: {
            		checkVals
            	}
            	
            	,	success: function(data){
            		
            		let list = JSON.parse(data);
            		console.log(list);
          
            	<%--	
            		for(let dto of list){
            			
            			console.log(dto.user_id);
            			console.log(dto.price);
            			console.log(dto.item_no);
            			console.log("${loginSession}");      			
            			
            		}
            		--%>
            	
            		
            		$(".body-list").empty();
            		       	
            		for(let dto of list){
            			
            			if("${loginSession}" == dto.user_id){ 
            				
            				let list = $("<div>").addClass("row list-row");
            				
            				let col_3 =  $("<div>").addClass("col-3");
            				let checkBox = $("<input>").attr({class:"form-check-input", type:"checkbox" ,id:dto.price}).val(dto.item_no).prop("checked", true);
            				
            				let img = $("<img>").attr({ src:"/resources/images/items/"+ dto.item_name +".png"});
            				col_3.append(checkBox, img);
            				
            				
            				let itemName = $("<div>").addClass("col-5 itemName");
            				let nameSpan = $("<span>").html(dto.item_name);
            				itemName.append(nameSpan);
 
            				let quantityBox = $("<div>").addClass("col-2 quantityBox");
            				let plus = $("<input>").attr({class:"plus" ,type:"button"}).val('+');
            				let quantity = $("<input>").attr({ class:"p_num", type:"text" }).val(dto.quantity);
            				let minus = $("<input>").attr({class:"minus" , type:"button"}).val('-');
            				quantityBox.append(plus, quantity, minus);
            				
            				let priceName = $("<div>").addClass("col-2 priceName");
            				let priceSpan = $("<span>").html(dto.price);
            				priceName.append(priceSpan);
            				
            				list.append(col_3, itemName, quantityBox, priceName);
            				
            				$(".body-list").append(list);           				
            				
            		}
            		
            	}   
            		
            		
            	}		
        		,	error:function(e){
        			console.log(e);
        		}
            		
        	});
 
    	}
    	
    	
    	
    	
    	
    });
    
    
    </script>





</body>
</html>