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
    <title>Aram - 메인페이지</title>
    <style>
        *{box-sizing: border-box;
          margin: auto;}
        div{
            border: 1px solid black;
        }
        /*footer 영역*/
        .footer{   
            overflow: hidden;
        }
        .ft-ul{
            float: left;
            list-style: none;
            text-align: center;
        }
        .ft-ul a{
            color: black;
            text-decoration: none;
        }
        
    </style>
</head>
<body>
    <div class="main-container">
        <!--헤더영역-->
        <div class="row main-header">
          <div class="col-1 d-md-none">
            =<!--수정필요 햄버거-->      
          </div>
            <div class="col-8 d-flex justify-content-center">
            <a href="/home.jsp"><img src="img/Logo.png" class="d-block w-40" alt="..."></a>
          </div>
          <div class="col-2 d-md-none">
            <span>cart(<!--장바구니에 담긴 카운트-->)</span>
          </div>
          <!--네비게이션-->
          <div class="col-6 d-none d-md-block">
            <ul class="nav">
                <li class="nav-item">
                  <a class="nav-link active" style="color: black;" href="#">Login</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" style="color: black;" href="#">Mypage</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" style="color: black;" href="#">Search</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" style="color: black;" href="#">Cart ( 0 )</a>
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
                    <img src="img/배너3.png" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item" data-bs-interval="2000">
                    <img src="img/배너2.png" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item">
                    <img src="img/배너1.png" class="d-block w-100" alt="...">
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
            
            <div class="col-12 col-md-6">
                <img src="img/쇼핑몰설명사진2.png" alt="..."> 
            </div>
            <div class="col-12 col-md-6">
                <h2>"반려식물의 가족이 되어주세요."</h2>
                <p>식물들은 우리들에게 희망을 주기도하고, 친구가 되어 깊은 교감을 해요.</p>
                <p>아람은 당신의 삶에 반려식물이라는 행복을 더해줍니다.</p>
            </div>
        </div>
        <!--사이트 대표사진, 설명영역 끝-->
        <!--카테고리 영역 시작-->
        <div class="row ">
            <div class="col-3 d-none d-lg-block ">
                <img src="img/category1-공기 정화 식물.png"alt="...">
            </div>
            <div class="col-3 d-none d-sm-block">
                <img src="img/category2-실내 식물.png" alt="...">
            </div>
            <div class="col-3 d-none d-sm-block">
                <img src="img/category3-실외식물.png" alt="...">
              </div>
        </div>
        <!--카테고리 영역 끝-->
        <!--전체 상품 설명 영역 시작-->
        <div class="row">
            <div class="col">
                <h2>Aram Products</h2>
                <p>식물에게 자신의 공간 한편을 내어주는 사람들, 식물과함께 하는 사람들, 식물을 사랑하는 사람들에게</p> 
            </div>
        </div>
        <!--전체 상품 설명 영역 끝-->
        <!-- 상품 사진 영역-->
        <div class="row row-cols-2 row-cols-md-4 g-4">
            <div class="col ">
              <div class="card border-0"><!--card 클래스에 border-0을 주면 테두리가 사라져욤-->
                <a href=""><img src="img/몬스테라.png" class="card-img-top" alt="..."></a>
                <div class="card-body">
                  <h5 class="card-title">상품명</h5>
                  <p class="card-text">가격</p>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="card">
                <a href=""><img src="img/무화과 나무.png" class="card-img-top" alt="..."></a>
                <div class="card-body">
                  <h5 class="card-title">상품명</h5>
                  <p class="card-text">가격</p>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="card">
                <a href=""><img src="img/베고니아 화이트 아이스.png" class="card-img-top" alt="..."></a>
                <div class="card-body">
                  <h5 class="card-title">상품명</h5>
                  <p class="card-text">가격</p>
                </div>
              </div>
            </div>
            <div class="col">
              <div class="card">
                <a href=""><img src="img/애플콩고.png" class="card-img-top" alt="..."></a>
                <div class="card-body">
                  <h5 class="card-title">상품명</h5>
                  <p class="card-text">가격</p>
                </div>
              </div>
            </div>
            <div class="col">
                <div class="card">
                  <a href=""><img src="img/토피어리.png" class="card-img-top" alt="..."></a>
                  <div class="card-body">
                    <h5 class="card-title">상품명</h5>
                    <p class="card-text">가격</p>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="card">
                  <a href=""><img src="img/제브리나.png" class="card-img-top" alt="..."></a>
                  <div class="card-body">
                    <h5 class="card-title">상품명</h5>
                    <p class="card-text">가격</p>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="card">
                  <a href=""><img src="img/유칼립투스.png" class="card-img-top" alt="..."></a>
                  <div class="card-body">
                    <h5 class="card-title">상품명</h5>
                    <p class="card-text">가격</p>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="card">
                  <a href=""><img src="img/오렌지자스민.png" class="card-img-top" alt="..."></a>
                  <div class="card-body">
                    <h5 class="card-title">상품명/h5>
                    <p class="card-text">가격</p>
                  </div>
                </div>
              </div>
          </div>
          <!--상품 사진 영역 끝-->
          <!-- 상품 검색 페이지 이동 버튼-->
          <div class="row">
            <div class="col d-flex justify-content-center">
                <button type="button" class="btn btn-light">More</button>
            </div>
        </div>
        <!--footer영역-->
            <div class="row footer">
                <div class="col-2">
                    <ul class="ft-ul">
                        <li><strong>상호명</strong></li>
                        <li><strong>대표</strong></li>
                        <li><strong>주소</strong></li>
                        <li><strong>FAX</strong></li>
                        <li><strong>E-MAIL</strong></li>
                        
                    </ul>
                </div>
                <div class="col-4" >
                    <ul class="ft-ul">
                        <li>Aram[아람]</li>
                        <li>김당산</li>
                        <li>서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F, 20F</li>
                        <li>02-2163-8560</li>
                        <li>aram@aram.co.kr</li>
                    </ul>
                </div>
                <div class="col-2">
                    <ul class="ft-ul">
                        <li><strong>사이트맵</strong></li>
                        <a href="#"><li>회사소개</li></a>
                        <a href="#"><li>공지사항</li></a>
                        <a href="#"><li>Q&A</li></a>
                    </ul>
                </div>
                <div class="col-3">
                    <ul class="ft-ul">
                        <li>C/S</li>
                        <li>1234-5678</li>
                        <li>상담시간:AM 10시~PM 05시</li>
                        <li>점심시간:PM 12시~PM 01시</li>
                    </ul>
                </div>
      </div>
</body>
</html>