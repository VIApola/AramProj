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

<title>상품 검색페이지</title>

 <style>
        /* div {
            border: 1px solid black;
        } */
        *{
            font-size: small;
        }


        /*searchBox*/
        .searchBox {
            width: auto;
            height: 250px;
            border-top: 1px solid lightgray;
            border-bottom: 1px solid lightgray;
        }

        .searchBox>* {
            margin: 1px;
        }

        .searchBox button {
            width: 120px;
            height: 55px;
        }

        .searchPart>* {
            margin-right: 3px;
            padding: 5px;
        }

        .searchPart .priceInput input {
            width: 100px;
            height: 25px;
        }

        .searchPart .keywordInput input {

            width: 200px;
            height: 25px;
        }

        /*classifyBox*/
        .classifyBox {
            height: 100px;
        }

        .classifyBox a {
            padding: 10px;
            text-decoration: none;
            color: black;
        }

        /*contentBox*/
        /* .contentBox {
            height: 800px;
        } */

        .contentBox .card {
            margin-bottom: 15px;
            border: none;
        }

        .contentBox .card-body {
            text-align: center;
        }


        /*paginBox*/

        .paginBox {
            height: 100px;
        }
        .search{
        text-align: right;
    }

    .search{
        display: flex;
        justify-content: end;
        text-align: right;
    }
    .search a{
    margin-left:5px;
    margin-right:5px;
    color:black;
    text-decoration:none;
    cursor:pointer;
    }
    #count{
        font-size: small;
        
    }
    .countBox{
        text-align: left;
    </style>
</head>
<body>

<div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="searchBox d-flex justify-content-center align-items-center">
                    <div class="searchPart">
                        <div class="row priceInput">
                            <div class="col-lg-12 d-flex justify-content-between">
                                <span>가격대</span>
                                <input id="minPrice" type="text" class="form-control" placeholder=""> ~
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
                <span id="count">총 ${allItemsCount}개의 상품이 검색되었습니다.</span>
            </div>

            <div class="col-6 search">
                <a id="rowPrice">낮은 가격</a>
          		<span>|</span>
                <a id="highPrice">높은 가격</a>
           		<span>|</span>
                <a id="">제품명</a>
            </div>
        </div>
        <!-- 상품 보이는 페이지 -->
        <div class="contentBox">
            <div class="row">
            <c:choose>
            <c:when test="${empty pageList}">
            <div class="row">
        	<div class="col d-flex justify-content-center">
        		<h2>등록된 제품이 없습니다.</h2>
        	</div> 
            </div>
            </c:when>
            <c:otherwise>
            <c:forEach items="${pageList}" var="dto">
       		  <div class="col-6 col-lg-3 d-flex justify-content-center">
                    <div class="card" style="width: 16rem;">
                        <img src="" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-text">${dto.item_name}</h5>
                            <p class="card-text col-12 d-lg-none">${dto.price}</p>
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
    	<li class="page-item"><a class="page-link" href="/toSearchPage.item?curPage=${naviMap.startNavi-1}"></a></li>  	
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
        </div>
<script>

	
	//낮은가격순
	$("#rowPrice").on("click",function(){
	  $.ajax({
		url:"/searchRowPrice.item"
	   ,type:"get"
	   ,success:function(){
		   console.log(data);
	   }
	   ,error:function(){
		   console.log(e);
	   }
	  })
	})
	
	//높은가격순
	$("#highPrice").on("click",function(){
	  $.ajax({
		url:"/searchHighPrice.item"
	   ,type:"get"
	   ,success:function(){
		   console.log(data);
	   }
	   ,error:function(){
		   console.log(e);
	   }
	  })
	})
	
	//이름순으로
	$("#highPrice").on("click",function(){
	  $.ajax({
		url:"/searchName.item"
	   ,type:"get"
	   ,success:function(){
		   console.log(data);
	   }
	   ,error:function(){
		   console.log(e);
	   }
	  })
	})

	
    //검색 버튼을 클릭했을 때
	$("#searchBtn").on("click",function (){
	
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
		
		$.ajax({
			url:"/searchItemPrice.item?minPrice="+minPrice+"&maxPrice="+maxPrice
			,type:"get"
			,success:function(data){
				//console.log(data);
			}
			,error:function(e){
				console.log(e);
			}
		})
		
	
	//키워드만 입력
	}else if($("#minPrice").val()===""&&$("#maxPrice").val()===""&&$("#searchKeyword").val()!==""){
		console.log("키워드만 입력");
		let searchKeyword = $("#searchKeyword").val();
		console.log(searchKeyword);
		
		$.ajax({
			url:"/searchItem.item?searchKeyword="+searchKeyword
			,type:"get"
			,success:function(data){
				//console.log(data);
			}
			,error:function(e){
				console.log(e);
			}
		})
		
		
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
		
		$.ajax({
			url:"/searchItem.item?searchKeyword="+searchKeyword+"&maxPrice="+maxPrice+"$searchKeyword"+searchKeyword
			,type:"get"
			,success:function(data){
				//console.log(data);
			}
			,error:function(e){
				console.log(e);
			}
		})
				
	}

})

</script>
</body>
</html>