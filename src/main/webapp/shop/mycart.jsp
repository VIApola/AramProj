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
    
    <title>장바구니</title>
<style>
    .title-row{
        border-top: 1px solid gray;
        border-bottom: 1px solid gray;
        margin-bottom: 100px;
    }
    p{
        text-align: center;
    }
    #btnDelete{
        width: 70%;
        float: right;
    }

    img{
        height: 80px;
        width: 110px;
    }
    #selectBox{
        margin-top: 25px;
        margin-right: 50px;
    }
    .list-row{
        margin-top: 20px;
        margin-bottom: 20px;
       
    }
    .price-row{
        border-top: 1px solid gray;
        margin-top: 50px;
        text-align: right;
    }
    .button-row{
        margin-top: 50px;
        text-align: center;
    }
     .itemName{
        margin-top: 25px;
         text-align: left;
    }
  
    .quantityBox{
       text-align: center;
        margin-top: 25px;
    }
    .priceName{
        margin-top:25px; 
        text-align: center;
    }
     .p_num{

        size: 20px;
        text-align : center;
        max-width: 50px;
    }
  	.form-check-input{
       margin-right: 20px;
       
    }
  

    /* div{
        border: 1px solid black;
    } */
</style>
</head>
<body>
    <div class="container">

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

<div class="body-list">
        
        <c:forEach items="${list}" var="dto">
      
        <c:if test="${loginSession eq dto.user_id}">
        

         <div class="row list-row">
             
             
             <div class="col-3">
                <input class="form-check-input" type="checkbox" checked="checked" id="${dto.price}" name ="checkBox"  value="${dto.item_no}">
                <img src="/resources/images/items/${dto.item_name}.png">
            </div>
              

            <div class="col-5 itemName">
                <span>${dto.item_name}</span>
            </div>

            <div class="col-2 quantityBox">
             <input type='button' class="btnPlus" value='+' />
                    <input type="text" class="p_num" value="${dto.quantity}">
             <input type='button' class="btnMinus" value='-' />
            </div>

           
            <div class="col-2 priceName" >
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
                <button type="button" class="btn btn-secondary btn-lg" id="btnShopping">쇼핑 계속하기</button>
                <button type="button" class="btn btn-secondary btn-lg" id="btnOrder"> &nbsp&nbsp&nbsp주문하기&nbsp&nbsp&nbsp </button>
            </div>
        </div>

    </div>
    
    <script>
    
    
    $("input:checkbox:checked").each(function(){
		
		checkVals.push( $(this).val() );
		
	
		console.log(checkVals);
	});
    
    
    
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