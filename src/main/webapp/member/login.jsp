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
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">

<title>로그인</title>
<style>
      /* 폰트 스타일 */
@font-face {
    font-family: 'GowunBatang-Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Bold.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
	*{
	font-family: 'Roboto Mono', monospace;
	font-family: 'GowunBatang-Bold';} 
       /* 로그인 박스 영역*/
        .body{
            text-align: center;
            margin: none;
        }
        /* 회원가입, ID/PW 찾기 a 태그*/
        a{
            text-decoration: none;
            color: black;
        }
        a:hover{
            color: black;
        }
        /* 버튼 */
        button{
            width: 300px;
            margin: 10px;
        }
        /* 로그인 글씨 */
        h3{
            border-bottom: 2px solid lightgray;
            padding-bottom: 15px;
        }
        /* id, pw input 창*/
        .idInput{
            margin-bottom: 10px;
        }
        .pwInput{
            margin-bottom: 10px;
        }
        /* 카카오 로그인 이미지*/
        img{
            width: 250px;
            cursor: pointer;
        }
        /* 또는 글씨 양옆으로 선 그리기*/
                .line {
            display: flex;
            flex-basis: 100%;
            align-items: center;
            color: black;
            margin: 8px 0px;
        }
        .line::before,
        .line::after {
            content: "";
            flex-grow: 1;
            background: rgba(0, 0, 0, 0.35);
            height: 1px;
            font-size: 0px;
            line-height: 0px;
            margin: 0px 16px;
        }
        li{
        	list-style: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row header">
            <div class="col">여기는 Header</div>
        </div>
        <!-- 로그인 박스 부분-->
        <div class="row body">
            <div class="row">
                <div class="col">
                    <h3>LOGIN</h3>
                </div>
            </div>
            <form id="loginForm" action="/loginProc.user" method="post">
            <div class="row idInput d-flex justify-content-center">
                <div class="col-2 col-md-2">
                    <span>ID</span>
                </div>
                <div class="col-5 md-5 d-flex justify-content-center">
                    <input type="text" id="id" name="id" class="form-control" placeholder="ID">
                </div>
            </div>
            <div class="row pwInput d-flex justify-content-center">
                <div class="col-2 col-md-2">
                    <span>PW</span>
                </div>
                <div class="col-5 col-md-5">
                    <input type="password" id="pw" name="pw" class="form-control" placeholder="password">
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-md-12">
                    <button type="button" id="loginBtn" class="btn btn-outline-success">Login</button>
                </div>
            </div>
            </form>
            <div class="row">
                <div class="col-12 order-1 col-sm-6">
                    <span><a href="/join.user">회원가입</a></span>
                </div>
                <div class="col-12 order-2 col-sm-6">
                    <span><a href="">ID / PW 찾기</a></span>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <p class="line">또는</p>
                </div>
            </div>
            <!--카카오 로그인-->
        
            <div class="row">
                <div class="col-12 col-md-12">
		  <ul>
		      <a class="btn btnkakao" id="kakao-login-btn" href="javascript:kakaoLogin()">
		         <img
					src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
					 width="222"
					alt="카카오 로그인 버튼"/>
		      </a>
		</ul>
                </div>
            </div>
        </div>
        <div class="row footer">
            <div class="col">여기는 Footer</div>
        </div>
    </div>
	<script>
	 $("#loginBtn").on("click", function(){
		 if($("#id").val() === "" || $("#pw").val() === ""){
			 alert("아이디 혹은 비밀번호를 입력하세요.");
			 return;
		 }
		 $("#loginForm").submit();
	 })
	</script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
window.Kakao.init('00ff75810173b90025a2b65babb862d9'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단

function kakaoLogin(){
	
	 Kakao.Auth.login({
	        success: function(response) {
	            Kakao.API.request({ // 사용자 정보 가져오기 
	                url: '/v2/user/me',
	                success: (response) => {
	                	var kakaoid = response.id+"K";
	                    $.ajax({
	    					type : "post",
	    					url : '/kakaoLogin.user', // ID중복체크를 통해 회원가입 유무를 결정한다.
	    					data : {"userid":kakaoid},
	    					dataType:"text",
	    					success : function(data){   
	    						console.log(data);
	    						if(data === "ok"){
	    							
	    							location.href = '/main';
	    						}else if(data === "fail"){// 회원가입
	    							location.href = '/kakaoSignup.user?userid='+kakaoid+ '&name='+response.properties.nickname+'&email='+response.kakao_account.email;

	    						}						
	    					},
	    					error: function(request, status, error){
	    						console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    		                }
	    				});
	                }
	            });
	        },
	        fail: function(error) {
	            alert(error);
	        }
	    });
}

}

</script>
</body>
</html>