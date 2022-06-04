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
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
<title>Header</title>
</head>
<body>
	<div class="row main-header">
		<!-- 상단바 sm크기에서 생기는 네비바-->
		<div class="col-1 d-md-none header-side">
			<div id="mySidenav" class="sidenav">
				<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
				<nav class="navbar">
					<!--네비 검색창-->
					<div class="search">
						<input type="text" placeholder="상품명을 입력하세요" id="searchKeyword">
						<a><img id="searchBtn"
							src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></a>
					</div>
				</nav>
				<!--네비 메뉴-->
				<div class="row search-menu">
					<span>Shop</span> <a href="/air.item" class="fromLeft"><span>공기
							정화 (Air Purifying)</span></a> <a href="/interior.item" class="fromLeft"><span>실내
							식물 (Indoor Plants)</span></a> <a href="/outside.item" class="fromLeft"><span>실외
							식물(Outdoor Plants)</span></a> <span>Community</span> <a href=""
						class="fromLeft"><span>Q & A</span></a> <a href=""
						class="fromLeft" id="noticeNav"><span>Notice</span></a>
					<c:choose>
						<c:when test="${not empty loginSession}">
							<a href="/toLogout.user" class="fromLeft bottom" id="logoutNav"><span>로그아웃</span></a>
						</c:when>
						<c:otherwise>
							<a href="/login.user" class="fromLeft bottom" id="loginNav"><span>로그인</span></a>
						</c:otherwise>
					</c:choose>
					<a href="/join.user" class="fromLeft bottom"><span>회원가입</span></a>
					<c:choose>
						<c:when test="${not empty loginSession}">
							<a href="/toMypage.user" class="fromLeft bottom"><span>마이페이지</span></a>
						</c:when>
						<c:otherwise>
							<a href="/login.user"
								onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')"
								class="fromLeft bottom" id="toMypage"><span>마이페이지</span></a>
						</c:otherwise>
					</c:choose>



				</div>
			</div>
			<span style="font-size: 20px; cursor: pointer" onclick="openNav()">&#9776;</span>
		</div>
		<!--상단바 로고 영역-->
		<div class="header-logo col-9">
			<a href="/main"><img src="/resources/images/Logo_md.png"
				class="d-none d-sm-block" alt="..."></a> <a href="/main"><img
				src="/resources/images/Logo_sm.png" class="d-block d-sm-none"
				style="margin-right: 100px;" alt="..."></a>
		</div>
		<!-- 상단바 cart 영역-->
		<div class="col-2 d-md-none header-left">
			<c:choose>
				<c:when test="${not empty loginSession}">
					<a href="/mycart.cart" class="nav-link" style="color: black;">Cart(0)</a>
				</c:when>
				<c:otherwise>
					<a href="/login.user"
						onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')"
						class="nav-link" style="color: black;">Cart(0)</a>
				</c:otherwise>
			</c:choose>
		</div>
		<!--네비게이션-->
		<div class="col-4 d-none d-md-block">
			<ul class="nav">
				<li class="nav-item"><c:choose>
						<c:when test="${not empty loginSession}">
							<a class="nav-link active" style="color: black;"
								href="/toLogout.user">Logout</a>
						</c:when>
						<c:otherwise>
							<a class="nav-link active" style="color: black;"
								href="/login.user">Login</a>
						</c:otherwise>
					</c:choose></li>
				<c:choose>
					<c:when test="${not empty loginSession}">
						<li class="nav-item"><a href="/toMypage.user" class="nav-link"
							style="color: black;">Mypage</a></li>
					</c:when>
					<c:otherwise>
						<li class="nav-item"><a href="/login.user"
							onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')"
							class="nav-link" id="toMypage" style="color: black;">Mypage</a></li>
					</c:otherwise>
				</c:choose>
				<li class="nav-item"><a class="nav-link" style="color: black;"
					href="/toSearchPage.item?curPage=1">Search</a></li>
				<li class="nav-item"><c:choose>
						<c:when test="${not empty loginSession}">
							<a href="/mycart.cart" class="nav-link" style="color: black;">Cart (0)</a>
						</c:when>
						<c:otherwise>
							<a href="/login.user"
								onclick="return confirm('로그인 후 사용이 가능합니다. 로그인 화면으로 이동하시겠습니까?')"
								class="nav-link" style="color: black;">Cart (0)</a>
						</c:otherwise>
					</c:choose></li>
			</ul>
		</div>
	</div>
</body>
</html>