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
<link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">    
    <title>비밀번호 변경</title>
    
            <!--style영역-->
    		<link href="${pageContext.request.contextPath}/resources/css/change_pw.css" rel="stylesheet" type="text/css">

</head>
<body>
    <div class="container">
    
        <div class="row header">
            <div class="col">여기는 Header</div>
        </div>
        <div class="row body">
        <form id="completeChangePw" action="/completeChangePw.user" method="post">
         <div class="row boxChangePwAction">
            <div class="row signupTitleBox">
            <div class="row">
                <div class="col-12">
                                <label for="password">
                                    <h5>비밀번호 변경</h5>
                                </label>
                    <input type="text" id="userId" name="userId" class="fromServer" value="${idFromFindPw}">
                </div>
            </div>
            </div>
                    <div class="row changePwInput">
                        <div class="row clsInputRow">
                            <div class="col-4 col-md-3 clsLabel d-flex justify-content-center align-self-center">
                                <label for="password">변경할 비밀번호</label>
                </div>
                <div class="col-8 col-md-9">
                    <input type="password" id="password" name="password" class="form-control" placeholder="변경할 비밀번호 입력">
                </div>
            </div>
                                        <div class="row clsCheckInfo">
                                <div class="col-4 col-md-3"></div>
                                <div class="col-8 col-md-9 ">
                                    <span id="checkPw"></span>
                                </div>
                            </div>
                        <div class="row clsInputRow">
                            <div class="col-4 col-md-3 clsLabel d-flex justify-content-center align-self-center">
                                <label for="password2">비밀번호 확인</label>
                </div>
                <div class="col-8 col-md-9">
                    <input type="password" id="password2" class="form-control" placeholder="변경할 비밀번호 확인 입력">
                </div>
            </div>
            <div class="row">
                <div class="col-12 d-flex justify-content-center">
                    <button type="button" id="btnChangePw" class="btn btn-outline-success">비밀번호 변경</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <script>
        
    	// 비밀번호 조건 밑에 뜨게
    	$("#password").focus(function(){
    		$("#checkPw").html("비밀번호는 영어 대소문자 숫자 특수문자(~!@#$)를 이용해서 6~12자 이내로 작성해 주세요.");
    		$("#checkPw").css("color", "green");
    		
    	});
    	$("#password").blur(function(){
    		$("#checkPw").html("");
    	});
    	
    	
        // 비밀변호 변경버튼 눌렀을 때
        $("#btnChangePw").on("click", function(){
        	let userId = $("#userId").val();
        	let regexPw = /^[a-zA-z0-9~!@#$]{6,12}$/;
        	let pw = $("#password").val();
        	let pw2 = $("#password2").val();
        	
        	if(!regexPw.test(pw)){
        		alert("양식에 맞는 비밀번호를 입력해주세요.");
        		return;        		
        	} else if(pw !== pw2){
        		alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
        		return;
        	}
        	document.getElementById("completeChangePw").submit();        	        	
        });
        // 비밀변호 변경이 잘 됐는지
        if("${rsChangePw}" == "y"){
        	alert("비밀번호 변경이 완료되었습니다. 로그인해주세요.");
        	location.href = "/member/login.jsp";
        } else if ("${rsChangePw}" == "n"){
        	alert("비밀변호 변경에 문제가 발생하였습니다.");
        	location.href = "/toFinduser.user";
        } else {
        	console.log("null값");
        }
        
        </script>
                <div class="row footer">
            <div class="col">여기는 Footer</div>
        </div>
    </div>
        
</body>
</html>