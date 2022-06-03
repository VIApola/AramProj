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
    <div class="main-container">
        <!--헤더영역-->
        <div class="row main-header">
        <!-- 상단바 sm크기에서 생기는 네비바-->
          <div class="col-1 d-md-none header-side">
            <div id="mySidenav" class="sidenav">
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                <nav class="navbar">
                <!--네비 검색창-->
                <div class="search">
                    <input type="text" placeholder="상품명을 입력하세요" id="searchKeyword">
                    <a><img id="searchBtn" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></a>
                  </div>
                </nav>
                <!--네비 메뉴-->
                <div class="row search-menu">
                <span>Shop</span>
                <a href="/air.item" class="fromLeft"><span>공기 정화 (Air Purifying)</span></a>
                <a href="/interior.item" class="fromLeft"><span>실내 식물 (Indoor Plants)</span></a>
                <a href="/outside.item" class="fromLeft"><span>실외 식물(Outdoor Plants)</span></a>    
                <span>Community</span>
                <a href="/qna.bo" class="fromLeft" ><span>Q & A</span></a>
                <a href="/notice.bo" class="fromLeft" id="noticeNav"><span>Notice</span></a>
                <c:choose>
                <c:when test="${not empty loginSession}">
                <a href="/toLogout.user" class="fromLeft bottom" id="logoutNav"><span>로그아웃</span></a>             
                </c:when>
                <c:otherwise>
                <a href="/login.user" class="fromLeft bottom" id="loginNav"><span>로그인</span></a> 
                </c:otherwise>
                </c:choose>
                <a href="/join.user" class="fromLeft bottom"><span>회원가입</span></a>
                <c:choose>
                <c:when test="${not empty loginSession}">
                <a href="" class="fromLeft bottom"><span>마이페이지</span></a>
                </c:when>
                <c:otherwise>
                <a href="/login.user" 
                onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')" class="fromLeft bottom" id="toMypage" ><span>마이페이지</span></a>
                </c:otherwise>
                </c:choose>
                
                
                
                </div>
              </div>
              <span style="font-size:20px;cursor:pointer" onclick="openNav()">&#9776;</span>     
          </div>
          <!--상단바 로고 영역-->
            <div class="header-logo col-9">
            <a href="/main"><img src="/resources/images/Logo_md.png" class="d-none d-sm-block" alt="..."></a>
            <a href="/main"><img src="/resources/images/Logo_sm.png" class="d-block d-sm-none" style="margin-right: 100px;" alt="..."></a>
          </div>
          <!-- 상단바 cart 영역-->
          <div class="col-2 d-md-none header-left">
            <c:choose>
                <c:when test="${not empty loginSession}">
                  <a href="/toMycart.main" class="nav-link" style="color: black;">Cart(0)</a>
                </c:when>
                <c:otherwise>
                <a href="/toLogin.main" 
                onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')" 
                class="nav-link" style="color: black;">Cart(0)</a>
                </c:otherwise>
                </c:choose>
          </div>
          <!--네비게이션-->
          <div class="col-4 d-none d-md-block">
            <ul class="nav">
                <li class="nav-item">
                <c:choose>
                <c:when test="${not empty loginSession}">
                  <a class="nav-link active" style="color: black;" href="/toLogout.user">Logout</a>
                </c:when>
                <c:otherwise>
                <a class="nav-link active" style="color: black;" href="/login.user">Login</a>
                </c:otherwise>
                </c:choose>
                </li>
                <c:choose>
                <c:when test="${not empty loginSession}">
                <li class="nav-item">
                <a href="" class="nav-link" style="color: black;" >Mypage</a>
                 </li>
                </c:when>
                <c:otherwise>
                <li class="nav-item">
                  <a href="/toLogin.main" onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')" class="nav-link" id="toMypage" style="color: black;">Mypage</a>
                </li>
                </c:otherwise>
                </c:choose>
                <li class="nav-item">
                  <a class="nav-link" style="color: black;" href="/toSearchPage.item?curPage=1">Search</a>
                </li>
                <li class="nav-item">
                <c:choose>
                <c:when test="${not empty loginSession}">
                  <a href="" class="nav-link" style="color: black;">Cart (0)</a>
                </c:when>
                <c:otherwise>
                <a href="/login.user" 
                onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')" 
                class="nav-link" style="color: black;">Cart (0)</a>
                </c:otherwise>
                </c:choose>
                </li>
              </ul>      
          </div>
        </div>
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
                <a href=""><img src="/resources/images/category_Air.png"alt="..."></a>
            </div>
            <div class="col-3 d-none d-sm-block">
                <a href=""><img src="/resources/images/category_In.png" alt="..."></a>
            </div>
            <div class="col-3 d-none d-sm-block">
                <a href=""><img src="/resources/images/category_Out.png" alt="..."></a>
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
            <div class="row footer">
                <div class="col-12 d-sm-none footer-small" >
                    <ul class="ft-ul">
                        <li>Aram 대표자 : 김당산</li>
                        <li>주소 : 서울특별시 영등포구 선유동2로 57 <br>이레빌딩(구관) 19F, 20F</li>
                        <li>FAX : 02-1234-5678</li>
                        <li>E-MAIL : aram@aram.co.kr</li>
                    </ul>
                </div>
                <div class="col-2 d-none d-sm-block">
                    <ul class="ft-ul">
                        <li><strong>상호명</strong></li>
                        <li><strong>대표</strong></li>
                        <li><strong>주소</strong></li>
                        <li><strong>FAX</strong></li>
                        <li><strong>E-MAIL</strong></li>
                    </ul>
                </div>
                <div class="col-4 d-none d-sm-block" >
                    <ul class="ft-ul">
                        <li>Aram[아람]</li>
                        <li>김당산</li>
                        <li>서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F, 20F</li>
                        <li>02-1234-5678</li>
                        <li>aram@aram.co.kr</li>
                    </ul>
                </div>
                <div class="col-2 d-none d-sm-block">
                    <ul class="ft-ul">
                        <li><strong>사이트맵</strong></li>
                        <a href="/notice.bo"><li>공지사항</li></a>
                        <a href="/qna.bo"><li>Q&A</li></a>
                    </ul>
                </div>
                <div class="col-3 d-none d-sm-block">
                    <ul class="ft-ul">
                        <li><strong>C/S</strong></li>
                        <li>1234-5678</li>
                        <li>상담시간:AM 10시~PM 05시</li>
                        <li>점심시간:PM 12시~PM 01시</li>
                    </ul>
                </div>
     		 </div>
     		 </div>
    

 	   
      <script>
      //팝업창
      /*
      function pop()
    	{
    	window.open("popup.jsp", "EVENT", "width=430,height=530,history=no,resizable=no,status=no,scrollbars=yes,menubar=no")
      }
	  */
      	//상품이미지 클릭했을때 -> 
      	$(".toSpecific").on("click",function(){
      		
      	})
      	//네비바 검색창 -> 상품검색페이지
      	$("#searchBtn").on("click",function(){
      		let searchKeyword = $("#searchKeyword").val();
      		if($("#searchKeyword").val()==""){
      			alert("검색어를 입력해 주세요");
      			return;
      		}else{
      			location.href ="/searchProc.item?searchKeyword="+searchKeyword;
      		}
      		
      	})
      
      	//더많은 상품 보러가기 버튼 클릭했을때
      	$("#toSerchItemBtn").on("click", function() {
      		location.href = "/toSearchPage.item";
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