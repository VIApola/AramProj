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
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <!-- 폰트 -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">

            <title>회원가입</title>
            <style>
                /* 폰트 스타일 */
                @font-face {
                    font-family: 'GowunBatang-Bold';
                    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Bold.woff') format('woff');
                    font-weight: normal;
                    font-style: normal;
                }

                * {
                    font-family: 'Roboto Mono', monospace;
                    font-family: 'GowunBatang-Bold';
                }

                /* 회원가입 타이틀 */
                .titleSignup {
                    display: inline;
                    margin-right: 30px;
                }

                .signupTitleBox {
                    padding-bottom: 10px;
                    margin-bottom: 20px;
                    margin-top: 40px;
                    border-bottom: 1px solid grey;
                }
                
                /* 인풋창 */
                .clsInputRow { /* 인풋창 마진 */
                	margin-top: 30px;
                }
                
                .signupInputBox {
                    margin-bottom: 50px;
                }
                
                
                input::-webkit-outer-spin-button, /* 휴대전화 인풋창에 화살표 안나오게 */
				input::-webkit-inner-spin-button {
				  -webkit-appearance: none;
				}
                


				/* 인풋확인(check) ajax */
				.clsCheckInfo span{
					font-size: small;
				}
				
				/* 이용약관 */
				.agreementContentBox { /*이용약관box 마진설정*/
                	margin-top: 70px;
                    margin-bottom: 50px;
                }
				
				/* 체크박스 색상 */
				input {
					accent-color: grey;
				}
				
                .container {
                    margin: 5%;
                }

                #btnPostcode {
                    width: 100%;
                }

                .textarea {
                    width: 100%;
                    height: 200px;
                    resize: none;
                }

                .star {
                    color: red;
                }



                

                .col-12 button {
                    margin: 10px;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <!-- 컨테이너 -->
                <div class="row header">
                    <!-- 헤더부분 -->

                </div><!-- 헤더부분 끝 -->
                <div class="row body">
                    <!-- 바디부분 -->
                    <form id="signupForm" action="/signup.user" method="post">
                        <div class="row signupTitleBox">
                            <div class="col-12 col-md-12">
                                <h2 class="titleSignup">회원가입</h2>
                                <span class="star">*</span>
                                <span>표시는 필수로 작성해주세요.</span>
                            </div>
                        </div>


                        <div class="signupInputBox">
                            <!-- 사용자 입력 박스-->

                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="name">이름</label>
                                </div>
                                <div class="col-7 col-md-9">
                                    <input type="text" class="form-control" id="name" name="name">
                                </div>
                            </div>
                            <div class="row clsCheckInfo">
                                <div class="col-4 col-md-3"></div>
                                <div class="col-7 col-md-9 ">
                                    <span id="checkName"></span>
                                </div>
                            </div>


                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="id">아이디</label>
                                </div>
                                <div class="col-5 col-md-7">
                                    <input type="text" class="form-control" id="id" name="id">
                                </div>
                                <div class="col-3 col-md-2">
                                    <button type="button" id="idCheckBtn" class="btn btn-outline-success">중복확인</button>
                                </div>
                            </div>
                            <div class="row clsCheckInfo">
                                <div class="col-4 col-md-3"></div>
                                <div class="col-8 col-md-9 ">
                                    <span id="checkId"></span>
                                </div>
                            </div>


                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="nickname">닉네임</label>
                                </div>
                                <div class="col-7 col-md-9 ">
                                    <input type="text" class="form-control" id="nickname" name="nickname">
                                </div>
                            </div>
                            <div class="row clsCheckInfo">
                                <div class="col-4 col-md-3"></div>
                                <div class="col-8 col-md-9 ">
                                    <span id="checkNickname"></span>
                                </div>
                            </div>
                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="password">비밀번호</label>
                                </div>
                                <div class="col-7 col-md-9 ">
                                    <input type="password" class="form-control" id="password" name="password">
                                </div>
                            </div>
                            <div class="row clsCheckInfo">
                                <div class="col-4 col-md-3"></div>
                                <div class="col-8 col-md-9 ">
                                    <span id="checkPw"></span>
                                </div>
                            </div>

                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="password2">비밀번호 확인</label>
                                </div>
                                <div class="col-7 col-md-9 ">
                                    <input type="password" class="form-control" id="password2">
                                </div>
                            </div>
                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="phone1">휴대폰번호</label>
                                </div>
                                <div class="col-3 col-md-3">
                                    <select class="form-select" id="phone1">
                                        <option value="010">010</option>
                                        <option value="011">011</option>
                                        <option value="016">016</option>
                                        <option value="017">017</option>
                                        <option value="018">018</option>
                                        <option value="019">019</option>
                                    </select>
                                </div>
                                <div class="col-2 col-md-3">
                                    <input type="number" class="form-control" id="phone2" maxlength="4">
                                </div>
                                <div class="col-2 col-md-3">
                                    <input type="number" class="form-control" id="phone3" maxlength="4">
                                </div>
                                <div class="col d-none">
                                    <input type="text" id="phone" name="phone">
                                </div>
                            </div>
                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="email">이메일</label>
                                </div>
                                <div class="col-7 col-md-9 ">
                                    <input type="text" class="form-control" id="email" name="email">
                                </div>
                            </div>
                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="postcode">우편번호</label>
                                </div>
                                <div class="col-3 col-md-3">
                                    <input type="text" class="form-control" id="postcode" name="postcode" readonly>
                                </div>
                                <div class="col-4 col-md-3">
                                    <button type="button" id="btnPostcode" class="btn btn-outline-success">우편번호
                                        검색</button>
                                </div>
                            </div>
                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <span class="star">*</span>
                                    <label for="roadAddr">주소</label>
                                </div>
                                <div class="col-7 col-md-9 ">
                                    <input type="text" class="form-control" name="roadAddr" id="roadAddr"
                                        placeholder="도로명주소" readonly>
                                </div>
                            </div>
                            <div class="row clsInputRow">
                                <div class="col-4 col-md-3 align-self-center">
                                    <label for="detailAddr">상세주소</label>
                                </div>
                                <div class="col-7 col-md-9 ">
                                    <input type="text" class="form-control" id="detailAddr" placeholder="상세주소">
                                </div>
                            </div>
                        </div> <!-- 사용자 입력 박스 끝-->

                        <div class="agreementContentBox">
                            <!-- 이용약관내용-->
                            <div class="row signupTitleBox">
                                <div class="col-12">
                                    <h5>이용약관</h5>
                                </div>
                            </div>
                            <div class="row ">
                                <!-- 이용약관 -->
                                <div class="col-11 col-md-12 d-flex justify-content-center">
                                    <textarea class="textarea" cols="30" rows="10" readonly>
    전자상거래(인터넷사이버몰) 표준약관    
                        </textarea>
                                </div>
                            </div> <!-- 이용약관 끝-->

                            <div class="row signupTitleBox">
                                <div class="col-12">
                                    <h5>개인정보 수집 및 이용 안내</h5>
                                </div>
                            </div>
                            <div class="row ">
                                <!-- 개인정보수집 -->
                                <div class="col-11 col-md-12 d-flex justify-content-center">
                                    <textarea class="textarea" cols="30" rows="10" readonly>
    전자상거래(인터넷사이버몰) 표준약관
                        </textarea>
                                </div>
                            </div> <!-- 개인정보수집 끝-->
                        </div> <!-- 이용약관내용 끝-->
                        <div class="row signupTitleBox">
                            <!-- 약관 동의 박스 -->
                            <div class="col-12">
                                <h5>
                                    <input type="checkbox" id="agreeAll">
                                    <label for="agreeAll" class="form-check-label">전체동의</label>
                                </h5>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12  col-md-4 order-1">
                                <input type="checkbox" id="termsOfUse">
                                <label for="termsOfUse" class="form-check-label">이용약관(필수)</label>
                            </div>
                            <div class="col-12  col-md-5 order-2">
                                <input type="checkbox" id="personalDataAgree">
                                <label for="personalDataAgree" class="form-check-label">개인정보 수집 및 이용 안내(필수)</label>
                            </div>
                            <div class="col-12 col-md-3 order-3">
                                <input type="checkbox" id="marketingAgree">
                                <label for="marketingAgree" class="form-check-label">마케팅 수신동의</label>
                            </div>
                        </div> <!-- 약관 동의 박스 끝 -->
                        <div class="row">
                            <div class="col-12 d-flex justify-content-center">
                                <button type="button" class="btn btn-secondary" id="backBtn">취소</button>
                                <button type="button" class="btn btn-outline-success" id="joinBtn">회원가입</button>
                            </div>
                        </div>
                    </form>
                </div><!-- 바디부분 끝 -->
                <div class="row footer">
                    <!-- 풋터부분 -->
                </div><!-- 풋터부분 끝 -->
            </div><!-- 컨테이너 끝 -->
            <script>
                // 이름 조건 밑에 뜨게
                $("#name").focus(function () {
                    $("#checkName").html("한글 및 영문으로 2~10자 이내로 작성해주세요.");
                    $("#checkName").css("color", "green");
                });
                $("#name").blur(function () {
                    $("#checkName").html("");
                });
                // 아이디 조건 밑에 뜨게
                $("#id").focus(function () {
                    if ($("#checkId").html() !== "사용가능한 아이디 입니다.") {
                        $("#checkId").html("아이디는 영어소문자와 숫자로 5~12자 이내로 작성해주세요.");
                        $("#checkId").css("color", "green");
                        $("#id").blur(function () {
                            $("#checkId").html("");
                        });
                    }
                });
                // 아이디 중복 검사
                $("#idCheckBtn").on("click", function () {
                    // 아이디 유효성 검사
                    let regexId = /^[a-z0-9]{5,12}$/;
                    if (!regexId.test($("#id").val())) {
                        $("#checkId").html("형식에 맞지않는 아이디 입니다. 다시 입력해주세요.");
                        $("#checkId").css("color", "red");
                        $("#id").val("");
                        return;
                    }
                    // ajax로 중복값 검사
                    $.ajax({
                        url: "/idCheck.user"
                        , type: "post"
                        , data: { id: $("#id").val() }
                        , dataType: "text"
                        , success: function (data) {
                            console.log(data);
                            if (data === "nope") {
                                $("#checkId").html("이미 사용중인 아이디 입니다.");
                                $("#checkId").css("color", "red");
                                $("#id").val("");
                            } else if (data === "ok") {
                                $("#checkId").html("사용가능한 아이디 입니다.");
                                $("#checkId").css("color", "green");
                            }
                        }
                        , error: function (e) {
                            console.log(e);
                        }
                    })
                });
                // 닉네임 조건 밑에 뜨게
                $("#nickname").focus(function () {
                    $("#checkNickname").html("닉네임은 영어대소문자 또는 한글 또는 숫자를 이용해서 3~ 10자 이내로 작성해 주세요.");
                    $("#checkNickname").css("color", "green");
                });
                $("#nickname").blur(function () {
                    $("#checkNickname").html("");
                });
                // 비밀번호 조건 밑에 뜨게
                $("#password").focus(function () {
                    $("#checkPw").html("비밀번호는 영어 대소문자 숫자 특수문자(~!@#$)를 이용해서 6~12자 이내로 작성해 주세요.");
                    $("#checkPw").css("color", "green");

                });
                $("#password").blur(function () {
                    $("#checkPw").html("");
                });
                // 약관 동의
                $("#agreeAll").change(function () {
                    if ($("#agreeAll").is(":checked")) {
                        $("#termsOfUse").prop("checked", true);
                        $("#personalDataAgree").prop("checked", true);
                        $("#marketingAgree").prop("checked", true);
                    } else {
                        $("#termsOfUse").prop("checked", false);
                        $("#personalDataAgree").prop("checked", false);
                        $("#marketingAgree").prop("checked", false);
                    }
                });
                // 취소 버튼을 눌렀을때
                $("#backBtn").on("click", function () {
                    location.href = "";
                });
                // 회원가입 버튼을 눌렀을때
                $("#joinBtn").on("click", function () {
                    let regexName = /[a-zA-Z가-힣]{2,10}$/;
                    let regexId = /^[a-z0-9]{5,12}$/;
                    let regexNickname = /^[a-zA-z0-9ㄱ-흫]{3,10}$/;
                    let regexPw = /^[a-zA-z0-9~!@#$]{6,12}$/;
                    let regexEmail = /^[a-zA-z][\w]+@[a-zA-z]+\.(com|net|co\.kr|or\.kr)$/;
                    let regexPhone = /^[0-9]{11}$/;

                    // phone번호 합쳐주는 작업
                    // select박스에서 선택된 값을 가져오는 방법
                    //console.log($("#phone1 option:selected").val());
                    let phone = $("#phone1 option:selected").val() + $("#phone2").val() + $("#phone3").val();
                    console.log(phone);
                    $("#phone").val(phone);

                    if ($("#name").val() === "") {
                        alert("이름을 입력해주세요.");
                        $("#name").focus();
                        return;
                    } else if (!regexName.test($("#name").val())) {
                        alert("이름은 한글 및 영문으로 2~10자 이내로 작성해주세요.");
                        $("#name").focus();
                        return;
                    } else if (!regexId.test($("#id").val())) {
                        alert("아이디는 영어소문자와 숫자로 5~12자 이내로 작성해주세요.");
                        $("#id").focus();
                        return;
                    } else if ($("#checkId").html() !== "사용가능한 아이디 입니다.") {
                        alert("아이디 중복확인을 해주세요.");
                        $("#id").focus();
                        return;
                    } else if (!regexNickname.test($("#nickname").val())) {
                        alert("닉네임은 영어대소문자 또는 한글 또는 숫자를 이용해서 3~ 10자 이내로 작성해 주세요.");
                        $("#nickname").focus();
                        return;
                    } else if (!regexPw.test($("#password").val())) {
                        alert("비밀번호는 영어 대소문자 숫자 특수문자(~!@#$)를 이용해서 6~12자 이내로 작성해 주세요.");
                        $("#password").focus();
                        return;
                    } else if ($("#password").val() !== $("#password2").val()) {
                        alert("비밀번호와 비밀번호 확인창에 있는 값이 일치하지 않습니다.");
                        return;
                    } else if (!regexPhone.test(phone)) { // 숫자 데이터에 대한 별도의 형변환이 필요없음
                        alert("휴대폰번호는 각각 4자리의 숫자로 입력해주세요.");
                        return;
                    } else if (!regexEmail.test($("#email").val())) {
                        alert("이메일 형식에 맞게 입력해주세요.");
                        $("#email").focus();
                        return;
                    } else if ($("#postCode").val() === "" || $("#roadAddr").val() === "") {
                        alert("주소를 입력해 주세요.");
                        return;
                    } else if ($("#termsOfUse").is(":checked") == false || $("#personalDataAgree").is(":checked") == false) {
                        alert("이용약관과 개인정보 수집 및 이용 안내에 동의해주세요");
                        return;
                    }
                    $("#signupForm").submit();
                    alert("인증이메일이 작성하신 이메일로 발송되었습니다.");

                });

                // 우편번호 API
                $("#btnPostcode").on("click", function () {
                    new daum.Postcode({
                        theme: {
                            searchBgColor: "#7CC09C", //검색창 배경색
                            queryTextColor: "#FFFFFF" //검색창 글자색
                        }
                        , oncomplete: function (data) {

                            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                            var roadAddr = data.roadAddress; // 도로명 주소 변수
                            var extraRoadAddr = ''; // 참고 항목 변수

                            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                                extraRoadAddr += data.bname;
                            }
                            // 건물명이 있고, 공동주택일 경우 추가한다.
                            if (data.buildingName !== '' && data.apartment === 'Y') {
                                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                            if (extraRoadAddr !== '') {
                                extraRoadAddr = ' (' + extraRoadAddr + ')';
                            }

                            // 우편번호와 주소 정보를 해당 필드에 넣는다.
                            document.getElementById('postcode').value = data.zonecode;
                            document.getElementById("roadAddr").value = roadAddr;
                        }
                    }).open();
                });


            </script>
        </body>

        </html>
