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
<link href="${pageContext.request.contextPath}/resources/css/searchitem.css" rel="stylesheet" type="text/css">
<title>상품 검색페이지</title>
</head>
<body>


<div class="container">
	<jsp:include page="/frame/header.jsp"></jsp:include>
        <div class="row">
            <div class="col-lg-12">
                <div class="searchBox d-flex justify-content-center align-items-center">
                    <div class="searchPart">
                        <div class="row priceInput">
                            <div class="col-lg-12 d-flex justify-content-between">
                                <span>가격대</span>
                                <input id="minPrice" type="text" class="form-control" placeholder=""> -
                                <input id="maxPrice" type="text" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="row keywordInput">
                            <div class="col-lg-12 d-flex justify-content-between">
                                <span style="margin-right: 25px;">제품명 / 키워드</span>
                                <input id="searchKeyword" type="text" class="form-control" placeholder="">
                            </div>
                        </div>
                    </div>
                    <button id="searchBtn" type="button" style="border:1px black solid;" class="btn btn-light" rowspan="2">검색</button>
                </div>
            </div>
        </div>
        <!-- 상단바 밑 메뉴 -->
         <div class="row" id="links">
          
            <div class="col-6 countBox">
                <c:choose>
           <c:when test="${empty itemList}">
           	<span id="count">총 0개의 상품이 검색되었습니다.</span>
           </c:when>
           <c:otherwise>
                <span id="count">총 ${itemCount}개의 상품이 검색되었습니다.</span>           
           </c:otherwise>
           </c:choose>
            </div>

            <div class="col-6 search">
                <a id="rowPrice">낮은 가격</a>
          		<span>|</span>
                <a id="highPrice">높은 가격</a>
           		<span>|</span>
                <a id="itemName">제품명</a>
            </div>
        </div>
        <!-- 상품 보이는 페이지 -->
        <div class="contentBox">
            <div class="row content-body">
            <c:choose>
            <c:when test="${empty itemList}">
            <div class="row">
        	<div class="col d-flex justify-content-center">
        		<h2>등록된 제품이 없습니다.</h2>
        	</div> 
            </div>
            </c:when>
            <c:otherwise>
            <c:forEach items="${itemList}" var="dto">
       		  <div class="col-6 col-lg-3 d-flex justify-content-center">
                    <div class="card" style="width: 16rem;">
                    	<a href="/detail.item?item_no=${dto.item_no}">
                        <img src="/resources/images/items/${dto.itemImgDTO.sys_name}" class="card-img-top">
                        </a>
                        <div class="card-body">
                            <h5 class="card-text">${dto.item_name}</h5>
                            <p class="card-text col-12 ">${dto.price}</p>
                        </div>
                    </div>
                </div>
             </c:forEach> 
            </c:otherwise>
            </c:choose> 
            </div>
        </div>
        <!-- 페이징 -->
        <nav aria-label="Page navigation example">
  		<ul class="pagination justify-content-center">
  
  			<c:if test="${naviMap.needPrev eq true}">
    	<li class="page-item"><a class="page-link" href="/toSearchPage.item?curPage=${naviMap.startNavi-1}"><<</a></li>  	
  			</c:if>
  		<%-- 현재  --%>
    		<c:forEach var="pageNum" begin="${naviMap.startNavi}" end="${naviMap.endNavi}" step="1">
    	<li class="page-item"><a class="page-link" href="/toSearchPage.item?curPage=${pageNum}">${pageNum}</a></li>
    		</c:forEach>
    
    		<c:if test="${naviMap.needNext eq true}">
    	<li class="page-item"><a class="page-link" href="/toSearchPage.item?curPage=${naviMap.endNavi+1}">>></a></li>    
    		</c:if>
    	</ul>
		</nav>
		<!-- 페이징끝 -->
		<jsp:include page="/frame/footer.jsp"></jsp:include>

        </div>
<script>

	
	//낮은가격순
	$("#rowPrice").on("click",function(){
	  $.ajax({
		url:"/searchRowPrice.item"
	   ,type:"get"
	   ,success:function(data){
		   selectPriceAndName(data);
	   }
	   ,error:function(e){
		   console.log(e);
	   }
	  })
	})
	
	
	//높은가격순
	$("#highPrice").on("click",function(){
	  $.ajax({
		url:"/searchHighPrice.item"
	   ,type:"get"
	   ,success:function(data){
		   selectPriceAndName(data);
	   }
	   ,error:function(e){
		   console.log(e);
	   }
	  })
	})
	
	//이름순으로
	$("#itemName").on("click",function(){
	  $.ajax({
		url:"/searchName.item"
	   ,type:"get"
	   ,success:function(data){
		   selectPriceAndName(data);
	   }
	   ,error:function(e){
		   console.log(e);
	   }
	  })
	})

	
    //검색 버튼을 클릭했을 때
	$("#searchBtn").on("click",function (){
	
		if($("#minPrice").val()===""&&$("#maxPrice").val()===""&&$("#searchKeyword").val()===""){
			location.href = "/toSearchPage.item";
		}	
		
		
	//가격대에서 숫자만 입력하도록 유효성 검사
	let regexPrice =/[0-9]/;

	
	//가격범위만 입력.
	if($("#minPrice").val()!==""&&$("#maxPrice").val()!==""&&$("#searchKeyword").val()===""){
		if(!regexPrice.test($("#minPrice").val())&&!regexPrice.test($("#maxPrice").val())){
			alert("숫자로 입력해주세요.");
			return;
		}else if($("#minPrice").val()>$("#maxPrice").val()){
			alert("범위를 올바르게 입력하여 주세요.");
			return;
		}
		let minPrice = $("#minPrice").val();
		let maxPrice = $("#maxPrice").val();
		console.log(minPrice+" : "+maxPrice);
		
		location.href = "/searchItemPrice.item?minPrice="+minPrice+"&maxPrice="+maxPrice;
		

	//키워드만 입력
	}else if($("#minPrice").val()===""&&$("#maxPrice").val()===""&&$("#searchKeyword").val()!==""){
		console.log("키워드만 입력");
		let searchKeyword = $("#searchKeyword").val();
		console.log(searchKeyword);
		
		location.href = "/searchItem.item?searchKeyword="+searchKeyword;
				
	//가격범위와 키워드 입력
	}else if($("#minPrice").val()!==""&&$("#maxPrice").val()!==""&&$("#searchKeyword").val()!==""){
		 
		if(!regexPrice.test($("#minPrice").val())&&!regexPrice.test($("#maxPrice").val())){
			alert("숫자로 입력해주세요.");
			return;
		}	

		let minPrice = $("#minPrice").val();
		let maxPrice = $("#maxPrice").val();
		let searchKeyword = $("#searchKeyword").val();
		
		console.log(minPrice+" : "+maxPrice+" : "+searchKeyword); 
		
		location.href = "/searchPriceItem.item?searchKeyword="+searchKeyword+"&minPrice="+minPrice+"&maxPrice="+maxPrice;
			
	}

})

	
	
	
	function selectPriceAndName(data){
		
	
		let list = JSON.parse(data);
		console.log(list);
		
		$(".content-body").empty();
		
		  if(list.length == 0){ //등록된 게시물이 없을때
			  let row2 = $("<div>").addClass('row');
			  let col = $("<div>").addClass('col d-flex justify-content-center');
			  let h2 = $("<h2>").html("등록된 제품이 없습니다.");
			  
			  col.append(h2);
			  row2.append(col);
			  $(".content-body").append(row2);
			  $(".contentBox").append($(".content-body"));
			  
			  
		  }else{ //등록된 게시물이 있을때
			  for(let dto of list){
					 let col = $("<div>").addClass('col-6 col-lg-3 d-flex justify-content-center');
					 let card = $("<div>").addClass('card').css({"width":"16rem"}); 
					 let a = $("<a>").attr("href","/detail.item?item_no="+dto.item_no);
					 let img = $("<img>").attr("src","/resources/images/items/"+dto.itemImgDTO.sys_name).addClass('card-img-top');
					 
					 let card2 = $("<div>").addClass('card-body');
					 let h5 = $("<h5>").addClass('card-text').html(dto.item_name);
					 let p = $("<p>").addClass('card-text col-12').html(dto.price);
					 
					 card2.append(h5,p);
					 a.append(img);
					 
					 card.append(a,card2);
					 col.append(card);
					 
					 $(".content-body").append(col);
					 $(".contentBox").append($(".content-body"));
					 
			}
		  }
		
	}
	

</script>

</body>
</html>