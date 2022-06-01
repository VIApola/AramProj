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
            <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
            <title>아이디 비밀번호 찾기</title>
            <!--style영역-->
    		<link href="${pageContext.request.contextPath}/resources/css/finduser.css" rel="stylesheet" type="text/css">

        </head>
		
        <body>
            <div class="container">
                <div class="row header">
                    <div class="col">여기는 Header</div>
                </div>
                <div class="row body">
                    <form id="searchToForgotIdForm" action="/searchToForgotId.user" method="post">
                        <div class="row boxFindAction">
                            <div class="row">
                                <div class="col">
                                    <label for="name">
                                        <h5>아이디 찾기</h5>
                                    </label>
                                    <input type="text" id="fromServerFindId" class="fromServer" value="${rsFindId}">
                                </div>
                            </div>
                            <div class="row findIdInput">
                                <div class="row">
                                    <div class="row clsInputRow">
                                        <div
                                            class="col-4 col-md-3 clsLabel d-flex justify-content-center align-self-center">
                                            <label for="name">이름</label>
                                        </div>
                                        <div class="col-8 col-md-9">
                                            <input type="text" name="name" id="name" class="form-control"
                                                placeholder="이름을 입력해주세요.">
                                        </div>
                                    </div>
                                    <div class="row clsInputRow">
                                        <div
                                            class="col-4 col-md-3 clsLabel d-flex justify-content-center align-self-center">
                                            <label for="emailById">이메일</label>
                                        </div>
                                        <div class="col-8 col-md-9">
                                            <input type="text" name="email" id="emailById" class="form-control"
                                                placeholder="이메일을 입력해주세요.">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12 d-flex justify-content-center">
                                        <button type="button" id="searchId" class="btn btn-outline-success">아이디 찾기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <script> <%-- 아이디 찾기 스크립트 --%>
                            $("#searchId").on("click", function () {

                                let regexName = /[a-zA-Z가-힣]/;
                                let regexEmail = /^[a-zA-z][\w]+@[a-zA-z]+.(com|net|co.kr|or.kr)$/;

                                if ($("#name").val() === "") {
                                    alert("이름을 입력해주세요.");
                                    return;
                                } else if ($("#emailById").val() === "") {
                                    alert("이메일을 입력해주세요.");
                                    return;
                                } else if (!regexName.test($("#name").val())) {
                                    alert("형식에 맞지 않은 이름입니다.");
                                    return;

                                } else if (!regexEmail.test($("#emailById").val())) {
                                    alert("형식에 맞지 않은 이메일입니다.");
                                    return;
                                }

                                document.getElementById("searchToForgotIdForm").submit();


                                console.log("${rsFindId}");
                            });

                        if ($("#fromServerFindId").val() === "n") {
                            alert("해당 정보의 계정이 존재하지 않습니다.");
                            location.href = "/toFinduser.user";
                        } else if ($("#fromServerFindId").val() === "") {

                        }
                        else {
                            alert("해당 정보의 아이디 : ${rsFindId}");
                            location.href = "/toFinduser.user";
                        }
                    </script>


                    <div class="row pw">
                        <div class="row">
                            <div class="col">
                                <label for="id">
                                    <h5>비밀번호 찾기</h5>
                                </label>
                                <input type="text" id="fromServerFindPw" class="fromServer" value="${rsChangePw}">
                                <form id="idFromFindPw" action="/toChange_pw.user" method="post"><input type="text"
                                        name="rsId" class="fromServer" value="${rsChangePwIdValue}"></form>
                            </div>
                        </div>
                        <form id="searchToForgotPwForm" action="/searchToForgotPw.user" method="get">
                            <div class="findPwInput">
                                <div class="row clsInputRow">
                                    <div
                                        class="col-4 col-md-3 clsLabel d-flex justify-content-center align-self-center">
                                        <label for="id">아이디</label>
                                    </div>
                                    <div class="col-8 col-md-9">
                                        <input type="text" id="id" name="id" class="form-control"
                                            placeholder="아이디를 입력해주세요.">
                                    </div>
                                </div>
                                <div class="row clsInputRow">
                                    <div
                                        class="col-4 col-md-3 d-flex justify-content-center clsLabel align-self-center">
                                        <label for="emailByPw">이메일</label>
                                    </div>
                                    <div class="col-8 col-md-9">
                                        <input type="text" id="emailByPw" name="email" class="form-control"
                                            placeholder="이메일을 입력해주세요.">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col d-flex justify-content-center">
                                    <button type="button" id="searchPw" class="btn btn-outline-success">비밀번호 변경</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <script> <%-- 비밀번호 찾기 스크립트 --%>
                            $("#searchPw").on("click", function () {
                                let regexId = /^[a-z0-9]{5,12}$/;
                                let regexEmail = /^[a-zA-z][\w]+@[a-zA-z]+.(com|net|co.kr|or.kr)$/;

                                if ($("#id").val() === "") {
                                    alert("아이디를 입력해주세요.");
                                    return;
                                } else if ($("#emailByPw").val() === "") {
                                    alert("이메일을 입력해주세요.");
                                    return;
                                } else if (!regexId.test($("#id").val())) {
                                    alert("형식에 맞지 않은 아이디입니다.");
                                    return;
                                } else if (!regexEmail.test($("#emailByPw").val())) {
                                    alert("형식에 맞지 않은 이메일입니다.");
                                    return;
                                }

                                document.getElementById("searchToForgotPwForm").submit();

                            });

                        if ($("#fromServerFindPw").val() == "n") {
                            alert("해당 정보의 계정이 존재하지 않습니다.");
                            location.href = "/toFinduser.user";
                        } else if ($("#fromServerFindPw").val() === "y") {
                            document.getElementById("idFromFindPw").submit();
                        } else {

                        }



                    </script>
                </div>
                <div class="row footer">
                    <div class="col">여기는 Footer</div>
                </div>
            </div>
        </body>

        </html>