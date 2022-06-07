<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<style>
.p_num{
width: 20px;
text-align:center;
}
</style>

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
					<input class="form-check-input checkBox" type="checkbox" id="${dto.price}" name="checkBox" value="${dto.item_no}">
				</div>
				<div class="col-2">
					<img src="/resources/images/items/${dto.item_name}.png">
				</div>
				<div class="col-5 itemName d-flex align-items-center">
					<span>${dto.item_name}</span>
				</div>
				<div class="col-2 quantityBox d-flex align-items-center justify-content-center">
					<input type='button' class="btnPlus" value='+' />
					<input type="text" class="p_num" value="${dto.quantity}" readonly>
					<input type='button' class="btnMinus" value='-' />
					<input type='hidden' class="individualPrice" value="${dto.quantity * dto.price}">
					<input type="hidden" class="price" value="${dto.price}">
					<%-- quantity 는 p_num.val() --%>
				</div>
					<div class="col-2 priceName d-flex align-items-center justify-content-center">
					<span>${dto.price}</span>
					</div>				
			</div>
			</c:if>
		</c:forEach>
	</div>
	<div class="row price-row">
		<div class="col totalPrice">총 가격<h1 class="total">0</h1></div>
	</div>
	<div class="row button-row">
		<div class="col btnRow">
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
	});
	
	
	
		
		// 수량 및 금액계산		
		
		let listSize = parseInt("${listSize}");
		let total = 0;
	for(let i = 0; i < listSize; i++){
		
		 total = parseInt($(".total").html());
		
		let price1 = $(".price").eq(i).val();
		let quantity1 = parseInt($(".p_num").eq(i).val());
		let individualPrice1 = parseInt(price1) * parseInt(quantity1);  
		console.log("individualPrice1 : " + individualPrice1);
		console.log("total : " + total);
		// 체크박스 적용하려면 처음 총 금액을 여기서 구해야될듯 (DAO 말고) 
		
		total = total + (price1 * quantity1);
		
		console.log(total);

		$(".total").html(total);
		
			$(".btnPlus").eq(i).on("click",function(){
				
				
				total = parseInt($(".total").html());
				console.log("total before : " + total);
				
				quantity1 = quantity1 + 1;
				console.log(quantity1);
				$(".p_num").eq(i).val(quantity1);
				
				total = total + parseInt(price1);
				$(".total").html(total);
				console.log(total);
				
				console.log("total after : " + total);
				
			});					
		
		
			$(".btnMinus").eq(i).on("click",function(){
						
			if(quantity1 <= 1){
				quantity1 = 1;
				return false;
			}
	     		total = parseInt($(".total").html());			
				quantity1 = quantity1 - 1;
				console.log(quantity1);
				$(".p_num").eq(i).val(quantity1);
			
				total = total - parseInt(price1);
				$(".total").html(total);

			});			
			
	
	}	
		
	
	
	


<%--// ajax 로 수량 및 금액 계산 시 과부하 걸림

	let totalPrice = parseInt( $(".totalPrice").html() );		
$.ajax({
	url: "/individualPrice.cart"
	   	,	type:"post"
	   	,	data: {"number" : number, "item_no" : item_no}
	    ,	dataType:"json"
		, success: function(data){	
			
			$(".individualPrice").eq(i).val(parseInt(data));		
					
					totalPrice = parseInt(totalPrice) + parseInt($(".individualPrice").eq(i).val());
					
			console.log("totalPrice : " + totalPrice);
			$(".totalPrice").html(parseInt(totalPrice));
		}
	    ,	error: function(e){
	    	console.log(e);
	    }


});  --%>
	

 
    <%-- 물품 삭제 --%>
    
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
          			
            		
            		console.log("list 길이 : " + list.length);
            		
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
            				
            				let col_1 =  $("<div>").addClass("col-1 d-flex align-items-center justify-content-center");
            				let checkBox = $("<input>").attr({class:"form-check-input checkBox", type:"checkbox"}).val(dto.item_no);
            				col_1.append(checkBox);
            				
            				let col_2 = $("<div>").addClass("col-2");
             				let img = $("<img>").attr({ src:"/resources/images/items/"+ dto.item_name +".png"});
             				col_2.append(img);
             			
            				
            				let itemName = $("<div>").addClass("col-5 itemName d-flex align-items-center");
            				let nameSpan = $("<span>").html(dto.item_name);
            				itemName.append(nameSpan);
 
            				let quantityBox = $("<div>").addClass("col-2 quantityBox d-flex align-items-center justify-content-center");
            				let plus = $("<input>").attr({class:"btnPlus" ,type:"button"}).val('+');
            				let quantity = $("<input>").attr({ class:"p_num", type:"text" , "readonly":true}).val(dto.quantity);
            				let minus = $("<input>").attr({class:"btnMinus" , type:"button"}).val('-');
            				let individualPrice = $("<input>").attr({class:"individualPrice", type:"hidden"}).val(dto.quantity * dto.price);
            				let price = $("<input>").attr({class:"price", type:"hidden"}).val(dto.price);				
            				
            				quantityBox.append(plus, quantity, minus, individualPrice, price);
            				
            				let priceName = $("<div>").addClass("col-2 d-flex align-items-center justify-content-center");
            				let priceSpan = $("<span>").html(dto.price);
            				priceName.append(priceSpan);
            				
            				list.append(col_1,col_2, itemName, quantityBox, priceName);
            				
            				$(".body-list").append(list);           				
				
            		}
            		
            	}	
            		
            		let total = 0;
            	for(let i = 0; i < list.length; i++){
            		
            		let price1 = $(".price").eq(i).val();
            		let quantity1 = parseInt($(".p_num").eq(i).val());
            		let individualPrice1 = parseInt(price1) * parseInt(quantity1);  
            		console.log("individualPrice1 : " + individualPrice1);
            		console.log("total : " + total);
            		// 체크박스 적용하려면 처음 총 금액을 여기서 구해야될듯 (DAO 말고) 
            		
            		total = total + (price1 * quantity1);
            		
            		console.log(total);

            		$(".total").html(total);
            		
            			$(".btnPlus").eq(i).on("click",function(){
            				
            				
            				total = parseInt($(".total").html());
            				console.log("total before : " + total);
            				
            				quantity1 = quantity1 + 1;
            				console.log(quantity1);
            				$(".p_num").eq(i).val(quantity1);
            				
            				total = total + parseInt(price1);
            				$(".total").html(total);
            				console.log(total);
            				
            				console.log("total after : " + total);
            				
            			});					
            		
            		
            			$(".btnMinus").eq(i).on("click",function(){
            						
            			if(quantity1 <= 1){
            				quantity1 = 1;
            				return false;
            			}
            	     		total = parseInt($(".total").html());			
            				quantity1 = quantity1 - 1;
            				console.log(quantity1);
            				$(".p_num").eq(i).val(quantity1);
            			
            				total = total - parseInt(price1);
            				$(".total").html(total);

            			});			
            			
            	
            	}	     		
           	}		
        		,	error:function(e){
        			console.log(e);
       	}
            		
        	});
 
    	}
    	
    });
    
    
    
    $("#btnShopping").on("click", function(){
    	location.href="/air.item";
    });
    
    
    </script>
    

</body>
</html>