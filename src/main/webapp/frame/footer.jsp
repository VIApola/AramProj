<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link href="${pageContext.request.contextPath}/resources/css/footer.css"
	rel="stylesheet" type="text/css">
<title>footer</title>
</head>
<body>
	<div class="row footer">
		<div class="col-12 d-sm-none footer-small">
			<ul class="ft-ul">
				<li>Aram 대표자 : 김당산</li>
				<li>주소 : 서울특별시 영등포구 선유동2로 57 <br>이레빌딩(구관) 19F
				</li>
				<li>FAX : 02-1234-5678</li>
				<li>E-MAIL : aramproj@gmail.com</li>
			</ul>
		</div>
		<div class="col-2 d-none d-sm-block">
			<ul class="ft-ul">
				<li><strong>상호명</strong></li>
				<li><strong>대표</strong></li>
				<li><strong>주소</strong></li>
				<li><strong>FAX</strong></li>
				<li><strong>E-MAIL</strong></li>
			</ul>
		</div>
		<div class="col-4 d-none d-sm-block">
			<ul class="ft-ul">
				<li>Aram[아람]</li>
				<li>김당산</li>
				<li>서울특별시 영등포구 선유동2로 57 이레빌딩(구관) 19F</li>
				<li>02-1234-5678</li>
				<li>aramproj@gmail.com</li>
			</ul>
		</div>
		<div class="col-2 d-none d-sm-block">
			<ul class="ft-ul">
				<li><strong>사이트맵</strong></li>
				<a href="/notice.bo"><li>공지사항</li></a>
				<a href="/qna.bo"><li>Q&A</li></a>
			<c:if test="${loginSession.isAdmin eq 'y'}">
				<a href="/toItemPage.admin"><li>관리자페이지</li></a>
			</c:if>
			</ul>
		</div>
		<div class="col-3 d-none d-sm-block">
			<ul class="ft-ul">
				<li><strong>C/S</strong></li>
				<li>1234-5678</li>
				<li>상담시간 : AM 10시~PM 05시</li>
				<li>점심시간 : PM 12시~PM 01시</li>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>