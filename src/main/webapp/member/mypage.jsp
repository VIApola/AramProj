<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap"
	rel="stylesheet">
<title>MY PAGE</title>
<style>
/* 폰트 스타일 */
@font-face {
	font-family: 'GowunBatang-Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Bold.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'Roboto Mono', monospace;
	font-family: 'GowunBatang-Bold';
	box-sizing: none;
}
/* 마이페이지 글씨 밑 선 */
h3 {
	border-bottom: 2px solid black;
	padding-bottom: 10px;
	cursor: pointer;
}

h5 {
	border-bottom: 2px solid lightgray;
	padding: 5px;
}

span {
	margin: 10px;
	cursor: pointer;
}

span::after {
	display: block;
	content: '';
	width: 50%;
	border-bottom: solid 2px #7cc09c;
	transform: scaleX(0);
	transition: transform 250ms ease-in-out;
}

span:hover::after {
	transform: scaleX(1);
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">여기는 Header</div>
		<div class="row">
			<div class="col-12 d-md-none">
				<select id="selectbox" class="form-select"
					aria-label="Default select example"
					onchange="myFunction(this.value)">
					<option value="1">MY PAGE</option>
					<option value="2">주문내역, 배송조회</option>
					<option value="3">Q&A</option>
					<option value="4">Review</option>
					<option value="5">회원 정보 수정</option>
					<option value="6">회원 탈퇴</option>
				</select>
			</div>
			<div class="row">
				<div class="col-12 d-none d-md-block" id="mypage">
					<h3>MY PAGE</h3>
				</div>
			</div>
			<div class="row">
				<div class="col-5 d-none d-md-block col-md-5">
					<div class="row">
						<div class="col">
							<h5>Shopping page</h5>
						</div>
						<div class="row">
							<div class="col" id="shopping">
								<span class="list">주문내역, 배송조회</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<h5>Post Page</h5>
						</div>
						<div class="row">
							<div class="col" id="qa">
								<span class="list">Q&A</span>
							</div>
						</div>
						<div class="row">
							<div class="col" id="review">
								<span class="list">Review</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<h5>Info page</h5>
						</div>
						<div class="row">
							<div class="col" id="modify">
								<span class="list">회원 정보 수정</span>
							</div>
						</div>
						<div class="row">
							<div class="col" id="delete">
								<span class="list">회원탈퇴</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-7" id="content">
					<p>님, 환영합니다.</p>
				</div>
			</div>
		</div>
		<div class="row">여기는 footer</div>
	</div>
	<script>
    $("#mypage").on("click", function(){
        location.href= "마이페이지로 가기";
    })
    /* 주문내역, 배송 조회*/
     $("#shopping").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("주문내역 & 배송 조회");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");;
        let p =  $("<p>").html("님이 쇼핑몰에서 주문한 내역입니다.");
        let tableRow = $("<div>").addClass('row');
        let tableCol = $("<div>").addClass("col-12").css("text-align", "center");;
        let table = $("<table>");
        let tr1 = $("<tr>");
        let thNum = $("<th>").html("번호");
        let thDate = $("<th>").html("주문일자");
        let thProduct = $("<th>").html("상품명");
        let thPrice = $("<th>").html("결제금액");
        let thDelivery = $("<th>").html("배송현황");
        let tr2 = $("<tr>");
        // 조건문 돌려서 주문내역 있으면 td 생성
            col.append(p);
            row.append(col);
            tr1.append(thNum, thDate, thProduct, thPrice, thDelivery);
            table.append(tr1);
            tableCol.append(table);
            tableRow.append(tableCol);
            $("#content").append(h3); 
            $("#content").append(row);
            $("#content").append(tableRow);

     });
     /* Q & A*/
     $("#qa").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("Q & A");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");
        let p =  $("<p>").html("님이 작성하신 글입니다.");
        let tableRow = $("<div>").addClass('row');
        let tableCol = $("<div>").addClass("col-12").css("text-align", "center");;
        let table = $("<table>");
        let tr1 = $("<tr>");
        let thNum = $("<th>").html("번호");
        let thTitle = $("<th>").html("제목");
        let thDate = $("<th>").html("상품명");
        let tr2 = $("<tr>");
        // 조건문 돌려서 문의내역 있으면 td 생성
            col.append(p);
            row.append(col);
            tr1.append(thNum, thTitle, thDate);
            table.append(tr1);
            tableCol.append(table);
            tableRow.append(tableCol);
            $("#content").append(h3); 
            $("#content").append(row);
            $("#content").append(tableRow);
     })
     /* 리뷰 */
     $("#review").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("Review");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");
        let p =  $("<p>").html("님이 작성하신 리뷰입니다.");
            let tableRow = $("<div>").addClass('row');
        let tableCol = $("<div>").addClass("col-12").css("text-align", "center");;
        let table = $("<table>");
        let tr1 = $("<tr>");
        let thNum = $("<th>").html("번호");
        let thProduct = $("<th>").html("상품");
        let thTitle = $("<th>").html("제목");
        let thScore = $("<th>").html("별점");
        let tr2 = $("<tr>");
        // 조건문 돌려서 리뷰 있으면 td 생성
            col.append(p);
            row.append(col);
            tr1.append(thNum, thProduct, thTitle, thScore);
            table.append(tr1);
            tableCol.append(table);
            tableRow.append(tableCol);
            $("#content").append(h3); 
            $("#content").append(row);
            $("#content").append(tableRow);
     })
     /* 회원정보 수정*/
     $("#modify").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("회원 정보 수정");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");
        let img = $("<img>").addClass('d-none d-md-block').attr("src", "/resources/images/password.png").css({"width": "200px", "margin": "0px auto"});
        let p =  $("<p>").html("<br>본인확인을 위해 비밀번호를 입력해주세요.");
        let input = $("<input>").addClass('form-control pw').attr({'type':'password', 'name' : 'pw', "placeholder" : "비밀번호를 입력해주세요"}).css("margin-left", "10px");
        let btn = $("<button>").addClass('btn btn-secondary pwBtn').html('비밀번호 확인').css("margin", "10px");
            col.append(img);
            col.append(p);
            col.append(input);
            col.append(btn)
            row.append(col);
            $("#content").append(h3);
            $("#content").append(row);
            
            $(".pwBtn").on("click", function(){
                alert("비밀번호 확인");
                //   $.ajax({
                //       url: "/modify.user"
                //      , type: "post"
                //      , data: {'pw' : 'pw'}
                //   })
            })
        
     })
     // 회원정보 탈퇴
     $("#delete").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("회원 탈퇴");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");
        let img = $("<img>").addClass('d-none d-md-block').attr("src", "/resources/images/sad.png").css({"width": "150px", "margin": "0px auto"});
        let h4 =  $("<h4>").html("정말 탈퇴하시겠어요?").css('margin', '10px');
        let p =  $("<p>").html("본인 확인을 위해 회원정보를 입력해주세요.").css('margin', '10px');
        let idInput = $("<input>").addClass('form-control id').attr({'type':'password', 
                        'name' : 'id', "placeholder" : "ID를 입력해주세요"}).css({"margin-left": "10px", "margin": "10px"});
        let pwInput = $("<input>").addClass('form-control pw').attr({'type':'password', 
                        'name' : 'pw', "placeholder" : "비밀번호를 입력해주세요"}).css("margin-left", "10px");
        let btn = $("<button>").addClass('btn btn-secondary deletBtn').html('확인').css("margin", "10px");
            col.append(img);
            col.append(h4);
            col.append(p);
            col.append(idInput);
            col.append(pwInput);
            col.append(btn)
            row.append(col);
            $("#content").append(h3);
            $("#content").append(row);

            $(".deletBtn").on("click", function(){
                let rs = confirm("탈퇴하시겠습니까?");
                if(rs){
                //   $.ajax({
                //       url: "/delete.user"
                //      , type: "post"
                //      , data: {'pw' : 'pw'}
                //   })
                }
               
            })
     })
     /* 반응형 됐을경우 select 이벤트*/
      function myFunction(str){
         if(str == 1){
            location.href= "마이페이지로 가기";
         }else if(str == 2){
            alert("shop"); // 예시...
         }
     }

    </script>
</body>
</html>