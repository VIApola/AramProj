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
    <title>Admin 수정</title>
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
    
    /* 아이템 넘버 불러오는 인풋창 */
    .item_no{
    	display: none;
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
    
    #preview {
    	display: none;
    	height: 200px;
    }
    
    #defaultImg {
    	height: 200px;
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
		<div
			class="row main-header d-flex justify-content-center align-self-center">
			<!--상단바 로고 영역-->
			<div class="row d-flex justify-content-center">
				<div class="header-logo d-flex justify-content-center">
					<a href="/main"><img src="/resources/images/Logo_md.png" class="imgLogo d-none d-sm-block" alt="..."></a>
					<a href="/main"><img src="/resources/images/Logo_sm.png" class="imgLogo d-block d-sm-none" style="" alt="..."></a>
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
		</div>
		<!-- 헤더 끝 -->





		<!--콘텐츠 영역-->
		<div class="item-admin-contents">
			<!-- 바디타이틀 -->
			<div class="row box-title">
				<div class="col-12">
					<h2>상품수정</h2>
				</div>
			</div>
		</div>
		<!-- form태그 시작 -->
		<form id="itemModifyForm" action="/update.item" method="post" enctype="multipart/form-data">
			<div class="row clsBlockRow">
				<div class="row">
					<div class="col-12">기본정보</div>
					<input type="text" id="item_no" class="item_no" name="item_no" value="${dto.item_no}">
				</div>
				<div class="row clsInputRow">
					<div class="col-3 clsLabelCol d-flex justify-content-center">
						<label for="itemName">상품명</label>
					</div>
					<div class="col-8 clsInput">
						<input type="text" class="form-control" value="${dto.getItem_name()}" id="itemName" name="itemName" placeholder="상품 이름을 입력하세요.">
					</div>
				</div>
			</div>
			
			<div class="row clsBlockRow">
				<div class="row">
					<div class="col-12">상품분류</div>
				</div>
				<div class="row clsInputRow">
					<div class="col-3 clsLabelCol d-flex justify-content-center">
						<label for="category">카테고리</label>
					</div>
					<div class="col-8 clsInput">
						<select class="form-select" id="itemCategory" name="itemCategory">
							<option value="p100">공기정화식물</option>
							<option value="p200">실내식물</option>
							<option value="p300">실외식물</option>
						</select>
					</div>
					<input type="text" id="category_select" name="category_name" style="display: none;">
				</div>
			</div>
			
			<div class="row clsBlockRow">
				<div class="row">
					<div class="col-12">상품 가격</div>
				</div>
				<div class="row clsInputRow">
					<div class="col-3 clsLabelCol d-flex justify-content-center">
						<label for="price">판매가격</label>
					</div>
					<div class="col-8 clsInput">
						<input type="number" class="form-control" id="price" name="itemPrice" value="${dto.getPrice()}" placeholder="상품 가격을 입력하세요.">
					</div>
				</div>
				
				<div class="row clsBlockRow">
					<div class="row">
						<div class="col-12">상품 재고</div>
					</div>
					<div class="row clsInputRow">
						<div class="col-3 clsLabelCol d-flex justify-content-center">
							<label for="stock">상품 개수</label>
						</div>
						<div class="col-8 clsInput">
							<input type="number" class="form-control" id="item_stock" name="itemStock" value="${dto.getItem_stock()}" placeholder="상품 개수를 입력하세요.">
						</div>
					</div>
				</div>
			</div>
				
				<div class="row clsBlockRow">
					<div class="row">
						<div class="col-12">상품 설명 / 이미지 설정</div>
					</div>
					<div class="row clsInputRow">
						<div class="col-3 clsLabelCol d-flex justify-content-center">
							<label for="itemInfo">상품 설명</label>
						</div>
						<div class="col-8 clsInput">
							<input type="text" class="form-control" id="item_comment" name="itemDetail" value="${dto.getItem_comment()}" placeholder="상품 설명을 입력하세요.">
						</div>
					</div>
				</div>
				
				<div class="row clsInputRow clsImgInfo">
					<div class="clsLabelCol col-lg-3 col-md-3 col-sm-3 col-xs-3 d-flex justify-content-center align-self-center">
						이미지 정보
					</div>
					<div class="col-lg-9 col-md-9 col-sm-9 col-xs-9" style="padding:0px">
						<div class="row clsImgTitle">
							<div class="col-5 d-flex justify-content-center align-self-center">이미지 미리보기</div>
							<div class="col-5 d-flex justify-content-center align-self-center">이미지 선택</div>
							<div class="col-2 d-flex justify-content-center align-self-center">삭제</div>
						</div>
						<div class="row clsImgContent">
							<div class="col-5 d-flex justify-content-center align-self-center">
								<input type="text" class="item_no" name="defaultImg" value="${dto.itemImgDTO.img_no}">
								<img id="preview" src="${pageContext.request.contextPath}/saveFile/${noticeVO.filename}">
								<img id="defaultImg" src="/resources/images/items/${dto.itemImgDTO.sys_name}">
							</div>
							<div class="col-5 d-flex justify-content-center align-self-center"><input type="file" id="img_title" name="imgFile"></div>
							<div class="col-2 d-flex justify-content-center align-self-center"><button type="button" id="btn-deleteItem">삭제</button></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-12" style="text-align: end;">
						<button type="button" class="btn btn-outline-success" id="modifyComplete">수정완료</button>
					</div>
				</div>
		</form>
	
		<!--footer 영역-->
		<jsp:include page="/frame/footer.jsp"></jsp:include>
	</div>

    <script>
    
    // 이미지 삭제버튼 눌렀을 때 
    $("#btn-deleteItem").on("click", function(){
    	$("#img_title").val("");
    	$("#preview").attr("src", "");
        $("#defaultImg").css("display", "inline");
        $("#preview").css("display", "none");
    });
    
  //수정완료 버튼 눌렀을때
    $("#modifyComplete").on("click",function(){
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
   $("#itemModifyForm").submit();
    
    })
    
    // 셀렉트 박스에 defalut selected 값 주기
    
    let itemCategory = "${dto.getCategory_id()}";
    
    $("#itemCategory").val(itemCategory).prop("selected", true);
    </script>
</body>
	<script type="text/javascript"> // 이미지 미리보기 (프리뷰)
        $(function() {
            $("#img_title").on('change', function(){
                readURL(this);
                $("#defaultImg").css("display", "none");
                $("#preview").css("display", "inline");
            });
        });
        function readURL(input) {
            if (input.files && input.files[0]) {
               var reader = new FileReader();
               reader.onload = function (e) {
                  $('#preview').attr('src', e.target.result);
               }
               reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</html>