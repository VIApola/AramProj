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
    <title>아이디 비밀번호 찾기</title>
    <style>
        .findIdInput [class*=col]{
            border: 1px solid lightgrey;
            border-left: none;
            border-right: none;
        }
        .form-control{
            width: 250px;
        }
        .findPwInput [class*=col]{
            border: 1px solid lightgrey;
            border-left: none;
            border-right: none;
        }
        button{
            margin: 15px;
            width: 200px;
        }
        .id{
            margin-top: 30px;
        }
        .pw{
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row header">
            <div class="col">여기는 Header</div>
        </div>
        <div class="row body">
            <form id="searchToForgotIdForm" action="/searchToForgotId.user" method="get">
                <div class="row id">
                    <div class="row">
                        <div class="col">
                            <h5>아이디 찾기</h5>
                        </div>
                    </div>
                    <div class="row findIdInput">
                          <div class="row">
                              <div class="col-3 col-md-2"><span>이름</span></div>
                              <div class="col-9 col-md-10">
                                  <input type="text" name="name" id="name" class="form-control" placeholder="이름을 입력해주세요.">
                              </div>
                          </div>
                          <div class="row">
                              <div class="col-3 col-md-2"><span>이메일</span></div>
                              <div class="col-9 col-md-10">
                                  <input type="text" name="email" id="email" class="form-control" placeholder="이메일을 입력해주세요.">
                              </div>
                          </div>
                      </div>
                      <div class="row">
                          <div class="col-12 d-flex justify-content-center">
                              <button type="button" id="searchId" class="btn btn-outline-dark">아이디 찾기</button>
                          </div>
                      </div>
                </div>
            </form>
            <script>
            	$("#searchId").on("click", function(){
            		
            		let regexName = /[a-zA-Z가-힣]/;
            		let regexEmail = /[]/;
            		
            		if($("#name").val() === ""){
            			alert("이름을 입력해주세요.");
            			return;
            		} else if($("#email").val() === ""){
            			alert("이메일을 입력해주세요.");
            			return;
            		}
            		
            		document.getElementById("searchToForgotIdForm").submit();
            	})
            	
            	
            	
            	
            	
            	
            </script>


          <div class="row pw">
            <div class="row">
                <div class="col">
                    <h5>비밀번호 찾기</h5>
                </div>
            </div>
            <div class="row findPwInput">
                <div class="row">
                    <div class="col-3 col-md-2"><span>아이디</span></div>
                    <div class="col-9 col-md-10">
                        <input type="text" class="form-control" placeholder="이름을 입력해주세요.">
                    </div>
                </div>
                <div class="row">
                    <div class="col-3 col-md-2"><span>이메일</span></div>
                    <div class="col-9 col-md-10">
                        <input type="text" class="form-control" placeholder="이메일을 입력해주세요.">
                    </div>
                 </div>
            </div>
            <div class="row">
                <div class="col d-flex justify-content-center">
                    <button type="button" class="btn btn-outline-dark">비밀번호 변경</button>
                </div>
            </div>
          </div>
        </div>
        <div class="row footer">
            <div class="col">여기는 Footer</div>
        </div>
    </div>
</body>
</html>