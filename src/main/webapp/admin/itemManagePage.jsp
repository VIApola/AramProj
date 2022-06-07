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
    <title>관리자 - 상품관리</title>
</head>
<style>
    /* 폰트 스타일 */
    @font-face {
        font-family: 'GowunBatang-Bold';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Bold.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

    * {
        font-family: 'Roboto Mono', monospace;
        font-family: 'GowunBatang-Bold';
    }



    /* 전체설정 */
    * {
        box-sizing: border-box;
    }

    div {
        /* border: 1px solid black; */
    }

    /* 타이틀 */
    .box-title {
        margin-top: 20px;
        margin-bottom: 10px;
    }


    /*상단 네비바의 검색창*/
    .nav {
        position: relative;
    }
    .search {
        position: relative;
        right: 0px;
        width: 100%;
    }

    .search input {
        width: 100%;
        border: 1px solid #bbb;
        border-radius: 8px;
        padding: 10px 12px;
        font-size: 14px;
    }

    .search img {
        position: absolute;
        width: 17px;
        top: 5px;
        right: 12px;
        margin: 0;
    }

    /* 고객관리 메뉴 */
    a {
        text-decoration: none;
        color: black;
    }
    a:hover{
        color: green;
    }
    .header { /*고객관리 메뉴 백그라운드*/
        background-color: lightgray;
    }

    /* 체크박스 색상 */
    input {
        accent-color: green;
    }

    /* 콘텐츠 헤더 */
    .contents-header {
        margin-top: 30px;
        background-color: lightgray;
    }

    /* 콘텐츠 */
    .contents {
        margin-top: 10px;
    }

    /* 수정/삭제 버튼 */
    .btn-modify {
        margin-right: 10px;
    }
    
    /* 블랙리스트 버튼 */
    .box-btn-addItem {
        margin-top: 30px;
    }
    
    
    /* 페이징 */
    .box-paging {
        margin-top: 30px;
    }
            
    
</style>
<body>
    <div class="container">
        <!--헤더영역-->
        <div class="row main-header">
            <!--상단바 로고 영역-->
            <div class="row d-flex justify-content-center">
                <div class="header-logo d-flex justify-content-center">
                    <a href="/main"><img src="/resources/images/Logo_md.png" class="imgLogo d-none d-sm-block" alt="..."></a>
                    <a href="/main"><img src="/resources/images/Logo_sm.png" class="imgLogo d-block d-sm-none"
                            style="" alt="..."></a>
                </div>
            </div>
            <!--네비게이션-->
            <div class="row d-flex justify-content-center">
                <div class="col-12 col-md-8 col-xl-6 d-flex justify-content-center">
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link active" style="color: black;" href="#">로그아웃</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toUserManage.admin">고객관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="#">상품관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="#">공지사항 관리</a>
                        </li>
                    </ul>    
              </div>
            </div>
        </div> <!-- 헤더 끝 -->



        <div class="row box-title"> <!-- 바디타이틀 -->
            <div class="col">
                <h2>상품관리</h2>
            </div>
        </div>


        <!--상단바 목록/검색창-->
        <div class="row header">
            <div class="row">
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    전체목록
                </div>
                <div class="col-xs-6 col-sm-4 col-xl-2 d-flex align-self-center justify-content-center">
                    등록된 상품 00건
                </div>
                <div class="d-none d-xl-block col-xl-5 d-flex align-self-center"></div>
                <div class="col-2 col-xl-1 d-flex align-self-center justify-content-end" style="display:block; text-align: justify;">
                    <select name="">
                        <option value="상품평">상품명</option>
                        <option value="상품번호">상품번호</option>
                        <option value="카테고리">카테고리</option>
                    </select>
                </div>
                <div class="col-4 col-xl-3">
                    <nav class="navbar">
                        <div class="search">
                            <input style="height:30px;" type="text" placeholder="검색어 입력">
                            <a href=""><img style="width: 20px;" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></a>
                        </div>
                    </nav>
                </div>
            </div>
        </div>


        
        <!--콘텐츠 타이틀-->
        <div class="contents-header-box">
            <div class="row contents-header">
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <input type="checkbox" id="checkAll">
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>상품번호</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>분류</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>상품이미지</span>
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                    <span>상품명</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>수정/삭제</span>
                </div>
            </div>
        </div>
        <!--콘텐츠-->
        <div class="contents-box">
            <div class="row contents">
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <input type="checkbox" id="1">
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>001</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>정원용</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>이미지</span>
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                    <span>멋쟁이 토마토</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <button type="button" class="btn-modify btn btn-success">수정</button>
                    <button type="button" class="btn-delete btn btn-secondary">삭제</button>
                </div>
            </div>
            <div class="row contents">
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <input type="checkbox" id="1">
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>002</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>정원용</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>이미지</span>
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                    <span>스위트바질</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <button type="button" class="btn-modify btn btn-success">수정</button>
                    <button type="button" class="btn-delete btn btn-secondary">삭제</button>
                </div>
            </div>
            <!-- 신규상품등록 버튼 -->
            <div class="row box-btn-addItem">
                <div class="col d-flex align-self-center justify-content-end">
                    <button type="button" id="toItemInput" class="btn btn-outline-success">신규상품등록</button>
                </div>
            </div>
        </div>
        <!--페이징-->
        <div class="row box-paging">
            <div class="col d-flex align-self-center justify-content-center">
                페이징
            </div>
        </div>
        <!--풋터-->
        <div class="row">
            <div class="col">
                풋터
            </div>
        </div>
    </div>

    <script>
        // 전체체크
        $("#checkAll").change(function () {
            if ($("#checkAll").is(":checked")) {
                $("#1").prop("checked", true);
                $("#2").prop("checked", true);
            } else {
                $("#1").prop("checked", false);
                $("#2").prop("checked", false);
            }
        });
        
        // 신규상품 등록버튼 클릭
        $("#toItemInput").on("click", function(){
        	location.href = "/toItemInput.item";
        });
    </script>
</body>

</html>