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

<title>Notice 상세보기</title>
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
/* 전체 */
.container {
	margin: auto;
	text-align: center;
}
/* Q & A 타이틀 부분*/
.title {
	border-bottom: 2px solid black;
	padding-bottom: 5px;
	text-align: left;
	margin-bottom: 20px;
}
/* 내용 들어가는 부분*/
.content {
	margin : 30px;
	border: 1px solid lightgrey;
}

#contentTitle {
	margin-top : 10px
}

.header-board {
	margin-top: 15px;
	margin-bottom: 15px;
}

.header-board p {
	margin-bottom : 0px;
}

textarea {
	height : 500px;
	resize: none;
}

/* 댓글 부분*/
.comment {
	text-align: center;
	border: 1px solid lightgrey;
	margin: 10px;
}

.btns button {
	margin: 5px;
}

.boxBtn {
	margin-bottom : 30px;
}
</style>
</head>
	<div class="container">
		<%-- 헤더 부분 --%>
		<jsp:include page="/frame/header.jsp"></jsp:include>
		<div class="row">
			<div class="col title">
				<h2>Notice</h2>
			</div>
		</div>
		<div class="row content">
			<div class="row header-board" id = "contentTitle">
				<div class="col-3 align-self-center">
					<p>제목</p>
				</div>
				<div class="col-9">
					<input type="text" name="title" value="${dto.title}" id="title"
						class="form-control" readonly>
				</div>
			</div>
			<div class="row header-board">
				<div class="col-3 align-self-center">
					<p>글쓴이</p>
				</div>
				<div class="col-3">
					<p>${dto.author }</p>
				</div>
				<div class="col-3 align-self-center">
					<p>작성일</p>
				</div>
				<div class="col-3">
					<p>${dto.write_date }</p>
				</div>
			</div>
			<div class="row header-board">
				<div class="col-3 align-self-center">
					<p>내용</p>
				</div>
				<div class="col-9">
					<textarea id="content" name="content" class="form-control" readonly>${dto.content}</textarea>
				</div>
			</div>
		</div>
		<div class="boxBtn">
				<button type="button" class="btn btn-outline-secondary" id="btnBack">뒤로가기</button>
			<c:if test="${loginSession.isAdmin eq 'y'}">
				<button type="button" id="btnModify" class="btn btn-outline-warning">수정</button>
				<button type="button" id="btnDelete" class="btn btn-outline-danger">삭제</button>
			</div>
				<script>
		        	$("#btnModify").on("click", function(){ //수정 버튼을 눌렀을때 시퀀스 번호도 가져감
		            	location.href= "/modifyNotice.bo?notice_no=${dto.notice_no}";
		          	});
		            $("#btnDelete").on("click", function(){ //삭제 버튼을 눌렀을때 시퀀스 번호도 가져감 
		                let answer = confirm("게시글을 삭제하시겠습니까?");
		                if(answer){
		                	location.href = "/deleteNotice.bo?notice_no=${dto.notice_no}";
		                }
		          	});
		    	</script>
			</c:if>

	</div>
	<%--풋터영역 --%>
	<jsp:include page="/frame/footer.jsp"></jsp:include>
	<script>
	$("#btnBack").on("click", function(){ // 뒤로가기 버튼을 눌렀을때
		location.href = "/notice.bo";
	});
	
</script>
</body>
</html>