<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--cdn-->
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
     <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <title>Admin 상품등록 / 수정</title>
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
        /* border: 1px solid gray; */
    }

    form{
        overflow: hidden;
    }
    
    
    /* 바디 타이틀 */
    .box-title {
        margin-top: 30px;
        margin-bottom: 20px;
        background-color: lightgray;
    }
    .box-title h2 {
        margin-top: 5px;
    }


    /* 인풋창 */

    div[class*=input] {
        width: 75%;
        padding: 0px;
    }

    .clsInputRow { /* 인풋 위아래 라인 */
        border-top: 1px solid lightgray;
        border-bottom: 1px solid lightgray;
        margin-top: 5px;
        margin-bottom: 25px;
    }

    .item-admin-contents .row .col-3 {
        padding-left: 0px;
        padding-right: 0px;
    }

    .clsInput { 
        margin-top: 3px;
        margin-bottom: 3px;
    }


    /* 라벨 배경 */
    .clsLabelCol {
        background-color: lightgray;
    }

    label {
        margin-top: 9px;
    }



    /* 이미지 정보 */
    .clsImgInfo {
        background-color: lightgray;
    }

    .clsImgTitle {
        background-color: #bbbbbb;
    }

    .clsImgContent {
        background-color: white;
    }

    #btn-deleteItem{ /* 삭제버튼 */
        border: none;
        border-radius: 5px;
        background-color: lightgray;
    }

    
</style>

<body>
    <div class="container">
        <!--헤더영역-->
        <div class="row main-header d-flex justify-content-center align-self-center">
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





        <!--콘텐츠 영역-->
        <div class="item-admin-contents">
            <!-- 바디타이틀 -->
            <div class="row box-title">
                <div class="col-12">
                    <h2>상품등록 / 수정</h2>
                </div>
            </div>
        </div>
        <!-- form태그 시작 -->
        <form id="itemUploadForm" action="/insert.item" method="post" enctype="multipart/form-data">
        <div class="row">
            <div class="col-12">기본정보</div>
            <div class="col-3">상품명</div>
            <div class="col-8 input"><input type="text" placeholder="상품 이름을 입력하세요." id="item_name" name="item_name"></div>
        </div>
        <div class="row">
            <div class="col-12">상품분류</div>
            <div class="col-3">카테고리</div>
            <div class="col-8" ><select name="itemCategory">
              <option value="P100">공기정화식물</option>
            <option value="P200">실내식물</option>
              <option value="P300">실외식물</option>
            </select></div>
            <input type="text" id="category_select" name="category_name" style="display:none;">
        </div>
        <div class="row">
            <div class="col-12">상품 가격</div>
            <div class="col-3">판매가격</div>
            <div class="col-8 input"><input type="text" placeholder="상품의 가격을 입력하세요." name="itemPrice"></div>
        </div>
        <div class="row">
            <div class="col-12">상품 재고</div>
            <div class="col-3">재고 개수</div>
            <div class="col-8 input"><input type="text" placeholder="상품 재고 개수를 입력하세요." id="item_stock" name="itemStock"></div>
        </div>
        <div class="row">
            <div class="col-12">상품 설명/이미지 설정</div>
            <div class="col-3">설명 정보 입력</div>
            <div class="col-8 input"><input type="text" placeholder="상품 설명을 입력하세요." id="item_comment" name="itemDetail"></div>
        </div>
        <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">이미지 정보</div>
          <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3" style="padding:0px">
            <div class="short-div">이미지명</div>
            <div class="short-div">메인 이미지</div>
          </div>
          <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="padding:0px">
            <div class="short-div">이미지 선택</div>
            <div class="short-div"><input type="file" id="img_title" name="imgFile"></div>
          </div>
        </div>
        </form>
        <div class="row">
            <div class="col" style="text-align: end;">
                <button type="button" id="insertComplete">등록</button>
            </div>
        </div>
        </div>
        <!--footer 영역-->
        <div class="row">
            <div class="col">
                풋터
            </div>
        </div>

    </form>
    </div>
    <!--item-container 끝-->
    <script>
  //등록버튼 눌렀을때
    $("#insertComplete").on("click",function(){
    $("#category_select").val($("#category_name option:selected").val());   
       console.log($("#category_select").val());
       console.log($("#img_title").val());
       
    if($("#item_name").val() == ""){
       alert("상품 이름을 입력하세요")
       return;
    }else if($("#price").val() == ""){
       alert("상품 가격을 입력하세요.")
       return;
    }else if($("#item_stock").val() == ""){
       alert("상품 재고 개수를 입력하세요.")
       return;
    }else if($("#item_comment").val() == ""){
       alert("상품 설명을 입력하세요.")
       return;
    }
   $("#itemUploadForm").submit();
    
    })
    </script>
</body>

</html>