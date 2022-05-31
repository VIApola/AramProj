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
    <title>고객계정관리-블랙리스트</title>
</head>
<!-- style 영역 -->
<link href="${pageContext.request.contextPath}/resources/css/blacklist.css" rel="stylesheet" type="text/css">
<body>
    <div class="container">
        <!--헤더영역-->
        <div class="row main-header">
            <!--상단바 로고 영역-->
            <div class="row d-flex justify-content-center">
                <div class="col header-logo d-flex justify-content-center">
                    <a href="/main" class="d-none d-sm-block"><img src="/resources/images/Logo_md.png" alt="..."></a>
                    <a href="/main" class="d-block d-sm-none"><img src="/resources/images/Logo_sm.png" style="margin-right: 100px;" alt="..."></a>
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
                            <a class="nav-link" style="color: black;" href="#">고객관리</a>
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
                <h2>고객관리</h2>
            </div>
        </div>


        <!--상단바 목록/검색창-->
        <div class="row header">
            <div class="row">
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="" class="header-menu">리뷰관리</a>
                </div>
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="" class="header-menu">Q&A관리</a>
                </div>
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="" class="header-menu">계정관리</a>
                </div>
                <div class="d-none d-xl-block col-xl-5 d-flex align-self-center"></div>
                <div class="col-2 col-xl-1 d-flex align-self-center justify-content-end" style="display:block; text-align: justify;">
                    <select name="">
                        <option value="상품평">아이디</option>
                        <option value="상품번호">이름</option>
                        <option value="카테고리">이메일</option>
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
                    <span>회원번호</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>아이디</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>이름</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>이메일</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>가입일</span>
                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <span>블랙리스트</span>
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
                    1
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    아이디
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    이름
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    llll@gmail.com
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    2022/05/29
                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    N
                </div>
            </div>
            <div class="row contents">
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <input type="checkbox" id="2">
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    2
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    아이디
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    이름
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    llll@gmail.com
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    2022/05/29
                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    N
                </div>
            </div>
            <!-- 블랙리스트 버튼 -->
            <div class="row box-btn-blacklist">
                <div class="col d-flex align-self-center justify-content-end">
                    <button type="button" id="btn-delBlack" class="btn btn-outline-secondary">삭제</button>
                    <button type="button" class="btn btn-outline-success">블랙리스트추가</button>
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
    </script>
</body>
</html>