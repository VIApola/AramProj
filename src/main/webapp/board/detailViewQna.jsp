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
<title>Qna 상세보기</title>
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
				<h2>Qna</h2>
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
					<p>${dto.user_id}</p>
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
			<c:if test="${loginSession.user_id eq dto.user_id}">
				<button type="button" id="btnModify" class="btn btn-outline-warning">수정</button>
				<button type="button" id="btnDelete" class="btn btn-outline-danger">삭제</button>
			</div>
				<script>
		        	$("#btnModify").on("click", function(){ //수정 버튼을 눌렀을때 시퀀스 번호도 가져감
		            	location.href= "/modifyQna.bo?qna_no=${dto.qna_no}";
		          	});
		            $("#btnDelete").on("click", function(){ //삭제 버튼을 눌렀을때 시퀀스 번호도 가져감 
		                let answer = confirm("게시글을 삭제하시겠습니까?");
		                if(answer){
		                	location.href = "/deleteQna.bo?qna_no=${dto.qna_no}";
		                }
		          	});
		    	</script>
			</c:if>

		
		<%-- 
		<div class="row comment">
			<div class="row">
				<div class="col align-self-center">
					<p>댓글</p>
				</div>
			</div>
		--%>
		<%-- <c:if test="${loginSession.isAdmin eq 'y'}
            <div class="row">
                <div class="col">
                    <button type="button" class="btn btn-success">등록</button>
                </div>
            </div>
        </c:if>
        </div>
        <div class="row">
            <div class="col btns  d-flex justify-content-center">
                <button type="button" id="backBtn" class="btn btn-secondary">뒤로가기</button>
                
             <c:if test="${loginSession.id eq dto.writer_id}">
	                <button type="button" id="btnModify" class="btn btn-warning">수정</button>
	                <button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
	                
	                <script>
	                	$("#btnModify").on("click", function(){ <%-- 수정 버튼을 눌렀을때 시퀀스 번호도 가져감
	                		location.href="/modify.bo?seq_board=${dto.seq_board}";
	                	});
	                	$("#btnDelete").on("click", function(){<%-- 삭제 버튼을 눌렀을때 시퀀스 번호도 가져감 
	                		let answer = confirm("게시글을 삭제하시겠습니까?");
	                		if(answer){
	                			location.href = "/delete.bo?seq_board=${dto.seq_board}";
	                		}
	                	});
	                </script>
                </c:if> --%>
	</div>
	<%--풋터영역 --%>
	<jsp:include page="/frame/footer.jsp"></jsp:include>
	<script>
	$("#btnBack").on("click", function(){ // 뒤로가기 버튼을 눌렀을때
		location.href = "/qna.bo";
	});

</script>
</body>
</html>