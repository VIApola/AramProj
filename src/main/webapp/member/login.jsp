<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
                crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"></script>
            <script src="https://code.jquery.com/jquery-3.6.0.js"
                integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
            <!-- 폰트 -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">

            <title>로그인</title>
            <!--style영역-->
    		<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">

        </head>

        <body>
            <div class="container">
                <div class="row header">
                    <div class="col">여기는 Header</div>
                </div>
                <!-- 로그인 박스 부분-->
                <div class="row body">
                    <div class="row titleLogin">
                        <div class="col">
                            <h3>LOGIN</h3>
                        </div>
                    </div>
                    <form id="loginForm" action="/loginProc.user" method="post">
                        <div class="row idInput d-flex justify-content-center">
                            <div class="col-2 col-md-2 align-self-center">
                            	<label for="id">ID</label>
                            </div>
                            <div class="col-5 md-5 d-flex justify-content-center">
                                <input type="text" id="id" name="id" class="form-control" placeholder="ID">
                            </div>
                        </div>
                        <div class="row pwInput d-flex justify-content-center">
                            <div class="col-2 col-md-2 align-self-center">
                                <label for="pw">PW</label>
                            </div>
                            <div class="col-5 col-md-5">
                                <input type="password" id="pw" name="pw" class="form-control" placeholder="password">
                            </div>
                        <div class="row rememberId d-flex justify-content-center">
			               <div class="col-8 d-flex justify-content-center">
			                  <input type="checkbox" class="" id="rememberId">
			                  <label for="rememberId" class="form-check-label">&nbsp;&nbsp;&nbsp;아이디 저장</label>
			               </div>
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
                            <span><a href="/toFinduser.user">ID / PW 찾기</a></span>
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
                                    <img src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
                                        width="222" alt="카카오 로그인 버튼" />
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
                $("#loginBtn").on("click", function () {
                    if ($("#id").val() === "" || $("#pw").val() === "") {
                        alert("아이디 혹은 비밀번호를 입력하세요.");
                        return;
                    }
                    $("#loginForm").submit();
                })
                
                
                //쿠키 가져오기
               $(document).ready(function(){
                  
                  let key = getCookie("key");
                  $("#id").val(key);
                  
                  if($("#id").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
                     $("#rememberId").attr("checked",true); //ID 저장하기를 체크상태로 두기
                  }
                  
                  $("#rememberId").change(function(){ //체크박스에 변화가 있다면
                     if($("#rememberId").is(":checked")){ //id저장하기 체크했을때
                        setCookie("key",$("#id").val(),30); //30일동안 쿠키 저장
                     }else{
                        deleteCookie("key");
                     }

                  })
                  
                  //ID 저장하기를 체크한 상태에서 id를 입력하는 경우 , 이럴때도 쿠키 저장.
                  $("#id").keyup(function(){ //ID 입력칸에 ID를 입력할 때
                     if($("#rememberId").is(":checked")){ //ID 저장하기를 체크한 상태라면
                        setCookie("key", $("#id").val(),30); //30일동안 쿠기 보관
                     }
                     
                     
                  })

               });
               // 쿠키 저장하기
               // setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
               function setCookie(cookieName, value, exdays){
                   var exdate = new Date();
                   exdate.setDate(exdate.getDate() + exdays);
                   var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
                   document.cookie = cookieName + "=" + cookieValue;
               }
                // 쿠키 삭제
               function deleteCookie(cookieName){
                   var expireDate = new Date();
                   expireDate.setDate(expireDate.getDate() - 1);
                   document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
               }
                // 쿠키 가져오기
               function getCookie(cookieName) {
                   cookieName = cookieName + '=';
                   var cookieData = document.cookie;
                   var start = cookieData.indexOf(cookieName);
                   var cookieValue = '';
                   if(start != -1){ // 쿠키가 존재한다면
                       start += cookieName.length;
                       var end = cookieData.indexOf(';', start);
                       if(end == -1)end = cookieData.length; // if(end == -1) -> 쿠키 값의 마지막 위치 인덱스 번호 설정
                       cookieValue = cookieData.substring(start, end);
                   }
                   return unescape(cookieValue);
               }
                
            </script>
            <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
            <script>
                window.Kakao.init('00ff75810173b90025a2b65babb862d9'); //발급받은 키 중 javascript키를 사용해준다.
                console.log(Kakao.isInitialized()); // sdk초기화여부판단

                function kakaoLogin() {

                    Kakao.Auth.login({
                        success: function (response) {
                            Kakao.API.request({ // 사용자 정보 가져오기 
                                url: '/v2/user/me',
                                success: (response) => {
                                    var kakaoid = response.id + "K";
                                    $.ajax({
                                        type: "post",
                                        url: '/kakaoLogin.user', // ID중복체크를 통해 회원가입 유무를 결정한다.
                                        data: { "userid": kakaoid },
                                        dataType: "text",
                                        success: function (data) {
                                            console.log(data);
                                            if (data === "ok") {

                                                location.href = '/main';
                                            } else if (data === "fail") {// 회원가입
                                                location.href = '/kakaoSignup.user?userid=' + kakaoid + '&name=' + response.properties.nickname + '&email=' + response.kakao_account.email;

                                            }
                                        },
                                        error: function (request, status, error) {
                                            console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                                        }
                                    });
                                }
                            });
                        },
                        fail: function (error) {
                            alert(error);
                        }
                    });
                }


            </script>
        </body>

        </html>
