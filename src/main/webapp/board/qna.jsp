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

<%-- Style영역 --%>
<link href="${pageContext.request.contextPath}/resources/css/qna.css"
	rel="stylesheet" type="text/css">
<title>QnA</title>
</head>
<body>
	<div class="container">
		<%-- 헤더 부분 
		<jsp:include page="/frame/header.jsp"></jsp:include>
		--%>
		<div class="row">
			<div class="col-md-12">
				<div class="imgBox">
					<img src="/resources/images/Board_Q&A.png" class="d-block w-100"
						alt="...">
				</div>
			</div>
		</div>
		<div class="qnaBox">
			<div class="row d-flex align-items-center">
				<div class="col-4 col-md-12 d-flex align-items-center">
					<h5>QnA</h5>
				</div>
				<div class="col-8 d-md-none mt-2">
					<div
						class="resSearchBox d-flex align-items-center justify-content-end">
						<div class="selectBox" style="margin-right: 10px;">
							<select class="form-select" id="resSearchInput"
								name="resSearchInput">
								<option value="id">ID</option>
								<option value="title">제목</option>
							</select>
						</div>
						<div class="inputPart">
							<div class="input-group mb-3">
								<input type="text" class="form-control" id="resSearchText">
								<span class="btn btn-outline-secondary" id="resSearchBtn">검색</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12 d-none d-md-block">
				<div
					class="searchBox d-flex justify-content-end align-items-end pb-2">
					<div class="selectBox">
						<select class="form-select" id="searchInput" name="searchInput">
							<option value="id">ID</option>
							<option value="title">제목</option>
						</select>
					</div>
					<div class="inputPart">
						<div class="input-group mb-3">
							<input type="text" class="form-control" id="searchText">
							<span class="btn btn-outline-secondary" id="searchBtn">검색</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="boardBox">
					<div class="row">
						<div class="col-1 d-none d-md-block">No.</div>
						<div class="col-3 d-none d-md-block">title</div>
						<div class="col-3 d-none d-md-block">content</div>
						<div class="col-2 d-none d-md-block">id</div>
						<div class="col-3 d-none d-md-block">date</div>
					</div>
					<div class="body_board">
						<c:choose>
							<c:when test="${list.size() == 0}">
								<div class="row">
									<div class="col d-flex justify-content-center">등록된 게시글이
										없습니다.</div>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${qnalist}" var="dto">
									<div class="row">
										<div class="col-1 d-none d-md-block">${dto.qna_no}</div>
										<div class="col-3 d-none d-md-block">${dto.title}</div>
										<div class="col-12 col-md-3">
											<a href="/detailViewQna.bo?qna_no=${dto.qna_no}">${dto.content}</a>
										</div>
										<div class="col-12 col-md-2">${dto.user_id}</div>
										<div class="col-3 d-none d-md-block">${dto.write_date}</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
		<c:if test="${not empty loginSession.user_id}">
			<div class="row">
				<div class="col-md-12">
					<div
						class="writeBtnBox d-flex justify-content-end align-items-start pt-1">
						<button type="button" id="writeBtn" class="btn btn-outline-secondary">글쓰기</button>
					</div>
				</div>
			</div>
			<script>
		    	const writeBtn = document.getElementById("writeBtn");
		    	
		    	writeBtn.addEventListener("click", function(e){
		    		console.log("click");
		    		location.href = "/writeQna.bo";
		    	})
			</script>
		</c:if>
		<div class="row">
			<div class="col-md-12">
				<div
					class="paginBox d-flex justify-content-center align-items-center">
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
							<li class="page-item"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>

	<%--풋터영역 --%>
	<jsp:include page="/frame/footer.jsp"></jsp:include>
	<script>
	
		// 반응형일때, 검색 기능
		$("#resSearchBtn").on("click", function(){
    		let searchInput = $("#resSearchInput option:selected").val();
    		let searchText = $("#resSearchText").val();
    		console.log(searchInput);
    		console.log(searchText);
    		
    		$.ajax({
    			url: "/qnaSearchProc.bo?search" + searchInput + "=" + searchText
    			, type: "get"
    			, dataType: "json"
    			, success: function(data){
    				$(".body_board").empty();
    				if(data.length == 0){
    					let row = $("<div class='row'>");
    					let col = $("<div class='col-12 d-flex justify-content-center'>").html("검색된 게시글이 없습니다.");
    					row.append(col);
    					$(".body_board").append(row);
    				}else{
    					for(let dto of data){
    						let row = $("<div class='row'>");
    						let col1 = $("<div class='col-1 d-none d-md-block'>").html(dto.qna_no);
    						let col2 = $("<div class='col-3 d-none d-md-block'>").html(dto.title);
    						let col3 = $("<div class='col-12 col-md-3'>");
    						let a = $("<a href=''>").html(dto.content);
    						let col4 = $("<div class='col-12 col-md-2'>").html(dto.user_id);
    						let col5 = $("<div class='col-3 d-none d-md-block'>").html(dto.write_date);
    						
    						col3.append(a);
    						row.append(col1, col2, col3, col4, col5);
    						$(".body_board").append(row);
 
    						    						
    					}
    				}
    			}, error: function(e){
    				console.log(e);
    			}
    		
    		});
    		
    	})
	
    	// 비반응형일때, 검색 기능
    	$("#searchBtn").on("click", function(){
    		let searchInput = $("#searchInput option:selected").val();
    		let searchText = $("#searchText").val();
    		console.log(searchInput);
    		console.log(searchText);
    		
    		$.ajax({
    			url: "/qnaSearchProc.bo?search" + searchInput + "=" + searchText
    			, type: "get"
    			, dataType: "json"
    			, success: function(data){
    				$(".body_board").empty();
    				if(data.length == 0){
    					let row = $("<div class='row'>");
    					let col = $("<div class='col-12 d-flex justify-content-center'>").html("검색된 게시글이 없습니다.");
    					row.append(col);
    					$(".body_board").append(row);
    				}else{
    					for(let dto of data){
    						let row = $("<div class='row'>");
    						let col1 = $("<div class='col-1 d-none d-md-block'>").html(dto.qna_no);
    						let col2 = $("<div class='col-3 d-none d-md-block'>").html(dto.title);
    						let col3 = $("<div class='col-12 col-md-3'>");
    						let a = $("<a href=''>").html(dto.content);
    						let col4 = $("<div class='col-12 col-md-2'>").html(dto.user_id);
    						let col5 = $("<div class='col-3 d-none d-md-block'>").html(dto.write_date);
    						
    						col3.append(a);
    						row.append(col1, col2, col3, col4, col5);
    						$(".body_board").append(row);
 
    						
    						
    					}
    				}	
    			}, error: function(e){
    				console.log(e);
    			}
    		
    		});
    		
    	})
 
    </script>
</body>

</html>

