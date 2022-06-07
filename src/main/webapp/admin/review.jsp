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
    <title>관리자 - 리뷰관리</title>
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
                            <a class="nav-link active" style="color: black;" href="/toLogout.user">로그아웃</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toUserManage.admin">고객관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toItemPage.admin">상품관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toQnAManagePage.admin">공지사항 관리</a>
                        </li>
                    </ul>    
              </div>
            </div>
        </div> <!-- 헤더 끝 -->



        <div class="row box-title"> <!-- 바디타이틀 -->
            <div class="col">
                <h2>리뷰관리</h2>
            </div>
        </div>


        <!--상단바 목록/검색창-->
        <div class="row header">
            <div class="row">
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="/toReviewManage.admin" class="header-menu">리뷰관리</a>
                </div>
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="/toQnAManagePage.admin" class="header-menu">Q&A관리</a>
                </div>
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="/toUserManage.admin" class="header-menu">계정관리</a>
                </div>
                
                <div class="col-2 col-xl-1 d-flex align-self-center justify-content-end" style="display:block; text-align: justify;">
                    <select id="searchSelect">
                        <option value="번호">번호</option>
                        <option value="아이디">아이디</option>
                        <option value="내용">내용</option>
                    </select>
                </div>
                <div class="col-4 col-xl-3">
                    <nav class="navbar">
                        <div class="search">
                            <input id="searchInput" style="height:30px;" type="text" placeholder="검색어 입력">
                            <img id="searchBtn" style="width: 20px; cursor:pointer;" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
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
                    <span>게시글번호</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>아이디</span>
                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <span>첨부사진</span>
                </div>
                <div class="col-5 d-flex align-self-center justify-content-center">
                    <span>내용</span>
                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <span>평점</span>
                </div>
            </div>
        </div>
        <!--콘텐츠-->
       
             <div class="row">
             <form id="ReviewlistForm" action="/deleteReviewlist.admin" method="post">
              <c:choose>
        <c:when test="${empty ReviewList}">
              <div class="col d-flex align-self-center justify-content-center">
            	<h2>등록된 리뷰가 없습니다.</h2>
             </div>
              </div>
            </c:when>
            <c:otherwise>
            <c:forEach items="${ReviewList}" var="reviewList">
        <div class="contents-box">
            <div class="row contents">
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <input type="checkbox" class="clicks" name="review_no" value="${reviewList.review_no}">
                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <span>${reviewList.review_no}</span>

                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>${reviewList.user_id}</span>
                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <img src="" style="width:50px height:50px">
                </div>

                <div class="col-4 d-flex align-self-center justify-content-center">
                    <span><a href="">${reviewList.content}</a></span>

                </div>
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <span>${reviewList.score}</span>
                </div>
            </div>
            </c:forEach>
         </c:otherwise>
         </c:choose>
         </form>
            <!-- 신규상품등록 버튼 -->
            <div class="row box-btn-addItem">
                <div class="col d-flex align-self-center justify-content-end">
                    <button type="button" id="toItemInput" class="btn btn-outline-success">삭제</button>
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
                $(".clicks").prop("checked", true);
            } else {
                $(".clicks").prop("checked", false);
            }
        });
      //체크박스에 체크된 id값만 가져오기
    	$(".clicks:checked").each(function(){
    		let id = $(this).val();
    		console.log(id);
    			
    	})
    	
    	//checkBox가 선택되지않은 경우
    	if($(".clicks").val() === ""){
    		alert("삭제할 리뷰를 선택해 주세요.");
    		return;
    	}
    	
    	//확인창 띄우기
         let anwser = confirm("선택한 리뷰를 삭제하시겠습니까?");
        if(anwser){
        $("#ReviewlistForm").submit();
    		
    	//리뷰 추가된 행 삭제하기
    	$(".clicks:checked").each(function(e){
    		let check = $(this);
    	    check.parent().parent().remove();
    	})
    	
    	
    	}
    		
    });

    </script>
</body>

</html>