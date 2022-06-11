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
    <title>관리자 - 공지사항 디테일뷰</title>
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
    /* 페이징 */
    .box-paging {
        margin-top: 30px;
    }

    div {
         /*border: 1px solid black;*/ 
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
    .heder-contents { /*고객관리 메뉴 백그라운드*/
        background-color: lightgray;
    }

    /* 체크박스 색상 */
    input {
        accent-color: green;
    }

    /* 콘텐츠 헤더 */
    .header{
        border: 1px solid black;
        border-top: none;
    }
    .contents-header {
        margin-top: 30px;
        background-color: lightgray;
    }
    .heder-contents .col{
        width: 50px;
    }

    /* 콘텐츠 */
    .contents {
        margin-top: 10px;
    }
    /*콘텐츠 박스*/
    .contents-box-header{
        border-top: 1px solid black;
        border-bottom: 1px solid black;
        width: 90%;
        margin-left: 5%;
        margin-top: 20px;
    }


    #contents-textarea{
        resize: none;
        width: 100%;
        height: 500px;
    }

    /* 수정/삭제 버튼 */
    .btn-modify {
        margin-right: 10px;
    }
    
    /* 블랙리스트 버튼 */
    .box-btn-addItem {
        margin-top: 30px;
        margin-bottom: 30px;
    }
    
    
    
            
    
</style>
<script>
	window.onload = function(){
		if(${empty loginSession}){
			alert("관리자 계정으로 로그인해주세요.");
			location.href = "/login.user";
		}else if ("${loginSession.getIsAdmin()}" === "n") {
			alert("관리자 계정으로 로그인해주세요.");
			location.href = "/login.user";
		}
	};
</script>

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
                            <a class="nav-link active" style="color: black;" href="/toLogout.user">로그아웃</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toReviewManage.admin">고객/게시판관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toItemPage.admin">상품관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/main">메인</a>
                        </li>
                    </ul>    
            </div>
            </div>
        </div> <!-- 헤더 끝 -->

        <!--상단바 목록/검색창-->
        <div class="row header">
          <div class="heder-contents">
            <div class="row">
                <div class="col-xs-3 col-sm-3 col-xl-3 d-flex align-self-center justify-content-first">
                    <h2>공지사항 관리</h2>
                </div>
            </div>
        </div>


 
        <!--콘텐츠-->
        <div class="contents-box">
            <div class="row contents-box-header">
                <div class="col-3 d-flex align-self-center justify-content-center box-header">
                    제목
                </div>
                <div class="col-5 d-flex align-self-center justify-content-first">
                    <input type="text" class="w-100" placeholder="제목을 입력하세요.">
                </div>
                
            </div>
            <div class="row contents-box-header">
                <div class="col-3 d-flex align-self-center justify-content-center box-header">
                    내용
                </div>
                <div class="col-9 d-flex align-self-center justify-content-first">
                    <textarea placeholder="내용을 입력 해 주세요" id="contents-textarea"></textarea>
                </div>
                
            </div>
            
            <!-- 공지사항 등록 버튼 -->
            <div class="row box-btn-addNotice">
                <div class="col d-flex align-self-center justify-content-end">
                    <button type="button" id="toNoticeInput" class="btn btn-outline-success">등록</button>
                </div>
            </div>
        </div>

    </div>
   <!--헤더 콘텐츠 끝-->
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
</body>
</html>