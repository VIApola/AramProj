<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--cdn-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    
    <!--폰트-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
    
    <!--AOS 라이브러리-->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>

    <!--style영역-->
    <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css">
    
    <title>Main</title>
    <script type="text/javascript">
    

      //팝업창 스크립트
      /*
      function getCookie(name) {
          let cookie = document.cookie;
          
          if (document.cookie != "") {
              let cookie_array = cookie.split("; ");
              for ( var index in cookie_array) {
                  let cookie_name = cookie_array[index].split("=");
                  
                  if (cookie_name[0] == "popupYN") {
                      return cookie_name[1];
                  }
              }
          }
          return ;
      }
      
      
      
  
      function openPopup(url) { 
          let cookieCheck = getCookie("popupYN");
          if (cookieCheck != "N")
              window.open("popup.jsp", "EVENT", 'width=430,height=530,left=0,top=0')
      }
      */
  </script>
</head>
<body><!--  onLoad="javascript:pop()" -->
    <div class="container main-container">
        <!--헤더영역-->
        <jsp:include page="/frame/header.jsp"></jsp:include>
        <!-- 케로셀 영역 시작-->
        <div class="row">
          <div class="col">
            <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                  <div class="carousel-item active" data-bs-interval="10000">
                    <img src="/resources/images/banner1.png" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item" data-bs-interval="2000">
                    <img src="/resources/images/banner2.png" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item">
                    <img src="/resources/images/banner3.png" class="d-block w-100" alt="...">
                  </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button>
              </div>
          </div>
        </div>
        <!--사이트 대표사진, 설명 영역 시작-->
        <div class="row">
          <div class="col" style="text-align: center; margin-top: 50px;" data-aos="fade-up" data-aos-duration="1000">
            <h2>"반려식물의 가족이 되어주세요."</h2>
                <p>식물들은 우리들에게 희망을 주기도하고,<br> 친구가 되어 깊은 교감을 해요.</p>
                <p><strong>Aram</strong><br> 당신의 삶에 반려식물이라는 행복을 더해줍니다.</p>
          </div>
        </div>
        <div class="row main-content " data-aos="fade-up" data-aos-duration="1000">
            <div class="col-12 col-md-5">
                <img src="/resources/images/content-0.png" alt="..."> 
            </div>
            <div class="col-12 col-md-5 content-text">
                <div class="content-extra-box">
                  <div class="item">
                    <img src="/resources/images/content-3.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-2.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-8.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-6.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-1.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-9.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-5.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-7.png">
                  </div>
                  <div class="item">
                    <img src="/resources/images/content-4.png">
                  </div>
                </div>
            </div>
        </div>
        <!--사이트 대표사진, 설명영역 끝-->
        <!--카테고리 영역 시작-->
        <div class="row main-category" data-aos="fade-up" data-aos-duration="1000">
            <div class="col-3 d-none d-lg-block">
                <a href="/"><img src="/resources/images/category_Air.png"alt="..."></a>
            </div>
            <div class="col-3 d-none d-sm-block">
                <a href="/"><img src="/resources/images/category_In.png" alt="..."></a>
            </div>
            <div class="col-3 d-none d-sm-block">
                <a href="/"><img src="/resources/images/category_Out.png" alt="..."></a>
              </div>
        </div>
        <!--카테고리 영역 끝-->
        <!--전체 상품 설명 영역 시작-->
        <div class="row main-descript" data-aos="fade-up" data-aos-duration="1000">
            <div class="col">
                <h2>Aram Products</h2>
                <p>식물에게 자신의 공간 한편을 내어주는 사람들,<br>식물과함께 하는 사람들, 식물을 사랑하는 사람들에게</p> 
            </div>
        </div>
        <%--전체 상품 설명 영역 끝--%>
       <%--상품 재고별 1~8위 --%>
        <div class="row row-cols-2 row-cols-md-4 g-4">
        <c:forEach items="${itemList}" var="itemList">
            <div class="col-3">
              <div class="card toSpecific border-0">
                <a href="/detail.item?item_no=${itemList.item_no}"><img src="/resources/images/items/${itemList.itemImgDTO.sys_name}" class="card-img-top" alt="..."></a>
                <div class="card-body">
                  <h5 class="card-title">${itemList.item_name}</h5>
                  <p class="card-text">${itemList.price}</p>
                </div>
              </div>
            </div>
          </c:forEach>              
          </div>
          <%--상품 사진 영역 끝--%>
          <%--상품 검색 페이지 이동 버튼 --%>
          <div class="row main-BtnProduct">
            <div class="col d-flex justify-content-center">
                <button type="button" id="toSerchItemBtn" class="btn btn-light">더 많은 상품 보러가기</button>
            </div>
        </div>
        <%--풋터영역 --%>
        <jsp:include page="/frame/footer.jsp"></jsp:include>
      <script>
      //팝업창
      /*
      function pop()
    	{
    	window.open("popup.jsp", "EVENT", "width=430,height=530,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
      }
	  */
      	
      	//네비바 검색창 -> 상품검색페이지
      	$("#searchBtn").on("click",function(){
      		let searchKeyword = $("#searchKeyword").val();
      		if($("#searchKeyword").val()==""){
      			alert("검색어를 입력해 주세요");
      			return;
      		}else{
      			location.href ="/searchItem.item?searchKeyword="+searchKeyword;
      		}
      		
      	})
      
      	//더많은 상품 보러가기 버튼 클릭했을때
      	$("#toSerchItemBtn").on("click", function() {
      		location.href = "/toSearchPage.item?curPage=1";
      	})
      	


        //AOS
        AOS.init();

        //상단바 sm크기에서 생기는 navbar
        function openNav() {
          document.getElementById("mySidenav").style.width = "100%";
        }
        
        function closeNav() {
          document.getElementById("mySidenav").style.width = "0";
        }
        </script>
</body>
</html>