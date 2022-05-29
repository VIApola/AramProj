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
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="../resources/css/join.css">
</head>
<body>
    <div class="container"> <!-- 컨테이너 -->
        <div class="row header"> <!-- 헤더부분 -->

        </div><!-- 헤더부분 끝 -->
        <div class="row body"> <!-- 바디부분 -->
        <form id="signupForm" action="" method="post">
            <div class="row signupTitleBox">
                <div class="col-12">
                    <h2>회원가입</h2>
                </div>
            </div>
            <div class="signupInputBox"> <!-- 사용자 입력 박스-->
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="name">이름</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="id">아이디</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="text" class="form-control" id="id" name="id">
                        <button type="button" id="idCheck" class="btn btn-outline-warning">중복확인</button>
                        <span id="checkId"></span>   
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="nickname">닉네임</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="text" class="form-control" id="nickname" name="nickname">
                        <span id="nicknameCheck"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="password">비밀번호</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="password" class="form-control" id="password" name="password">
                        <span id="pwCheck"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="password2">비밀번호 확인</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="password" class="form-control" id="password2" name="checkPassward">
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="phone1">휴대폰번호</label>
                    </div>
                    <div class="col col-md-3">
                        <select class="form-select" id="phone1">
                            <option value="010">010</option>
                            <option value="011">011</option>
                            <option value="016">016</option>
                            <option value="017">017</option>
                            <option value="018">018</option>
                            <option value="019">019</option>
                        </select>    
                    </div>
                    <div class="col col-md-3">
                        <input type="text" class="form-control" id="phone2">
                    </div>
                    <div class="col col-md-3">
                        <input type="text" class="form-control" id="phone3">
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="email">이메일</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="text" class="form-control" id="email">
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="postcode">우편번호</label>
                    </div>
                    <div class="col-4 col-md-3">
                        <input type="text" class="form-control" id="postcode" readonly>
                    </div>
                    <div class="col-4 col-md-3">
                        <button type="button" id="btnPostcode" class="btn btn-outline-success">우편번호 검색</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <span class="star">*</span>
                        <label for="roadAddr">주소</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="text" class="form-control" id="roadAddr" placeholder="도로명주소" readonly>
                    </div>
                </div>
                <div class="row">
                    <div class="col-4 col-md-3">
                        <label for="detailAddr">상세주소</label>
                    </div>
                    <div class="col-8 col-md-9 ">
                        <input type="text" class="form-control" id="detailAddr" placeholder="상세주소">
                    </div>
                </div>
            </div> <!-- 사용자 입력 박스 끝-->

            <div class="agreementContentBox"> <!-- 이용약관내용-->
                <div class="row signupTitleBox">
                    <div class="col-12">
                        <h5>이용약관</h5>
                    </div>
                </div>
                <div class="row "> <!-- 이용약관 -->
                    <div class="col-12 d-flex justify-content-center">
                        <textarea class="textarea" name="" id="" cols="30" rows="10" readonly>
   
                        </textarea>
                    </div>
                </div>  <!-- 이용약관 끝-->
    
                <div class="row signupTitleBox">
                    <div class="col-12">
                        <h5>개인정보 수집 및 이용 안내</h5>
                    </div>
                </div>
                <div class="row "> <!-- 개인정보수집 -->
                    <div class="col-12 d-flex justify-content-center">
                        <textarea class="textarea" name="" id="" cols="30" rows="10" readonly>
    
    
                        </textarea>
                    </div>
                </div>  <!-- 개인정보수집 끝-->    
            </div> <!-- 이용약관내용 끝-->
            <div class="row signupTitleBox"> <!-- 약관 동의 박스 -->
                <div class="col-12">
                    <h5>
                        <input type="checkbox" class="form-check-input" id="agreeAll">
                        <label for="agreeAll" class="form-check-label">전체동의</label>
                    </h5>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <input type="checkbox" class="form-check-input" id="termsOfUse">
                    <label for="termsOfUse" class="form-check-label">이용약관</label>
                </div>
                <div class="col-4">
                    <input type="checkbox" class="form-check-input" id="personalDataAgree">
                    <label for="personalDataAgree" class="form-check-label">개인정보 수집 및 이용 안내</label>
                </div>
                <div class="col-4">
                    <input type="checkbox" class="form-check-input" id="marketingAgree">
                    <label for="marketingAgree" class="form-check-label">마케팅 수신동의</label>
                </div>
            </div> <!-- 약관 동의 박스 끝 -->
            <div class="row">
                <div class="col-12 d-flex justify-content-center">
                    <button type="button" class="btn btn-secondary">취소</button>
                    <button type="button" class="btn btn-outline-success">회원가입</button>
                </div>
            </div>
            </form>
        </div><!-- 바디부분 끝 -->
	  	<div class="row footer"> <!-- 풋터부분 -->
        </div><!-- 풋터부분 끝 -->
    </div><!-- 컨테이너 끝 -->
    <script>
    	// 아이디 중복확인
    	$("#id").focusIn(function(){
    		$("#checkId").html("아이디는 영소문자와 숫자로 작성해주세요");
    		$("#checkId").attr("color", "red");
    	})
    	$("#idChekc").on("click", function(){
			let id = $("#id").val();
    		
    		$.ajax({
    			url: "/idCheck.user"
    			, type: "post"
    			, data: {id: id}
    			, dataType: "json"
    			, success: function(data){
    				if(data == 0){
    					$("#checkId").html("사용할 수 없는 아이디 입니다.");
    					$("#checkId").attr("color", "red");
    				}else{
    					$("#checkId").text("사용가능한 아이디 입니다.");
    					$("#checkId").attr("color", "green");
    				}
    			}
    			, error: function(e){
    				console.log(e);
    			}
    		})
    	})
    	
    </script>
</body>

</html>