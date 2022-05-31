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
    <title>공지사항 관리</title>
    <style>
        *{
        margin: auto;
        box-sizing: border-box;
    }
    div{
        border: 1px solid black;
    }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col">
                로고
            </div>
        </div>
        <!--상단 네비바-->
    <div class="row adminItem-nav justify-content-center">
        <div class="col-5">
            <ul class="nav">
                <li class="nav-item">
                  <a class="nav-link active" style="color: black;" href="#">로그아웃</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" style="color: black;" href="#">고객 관리</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" style="color: black;" href="#">상품 관리</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" style="color: black;" href="#">공지사항 관리</a>
                </li>
              </ul>      
          </div>
    </div>
    <!--콘텐츠-->
    <div class="contents">
        <div class="row">
            <div class="col">
                <h2>공지사항 관리</h2>
            </div>
        </div>
        <div class="content-in">
        <div class="row">
            <div class="col-3">제목</div>
            <div class="col"><input type="text"></div>
        </div>
        <div class="row">
            <div class="col-3">파일첨부</div>
            <div class="col"><input type="file"></div>
        </div>
        <div class="row">
            <div class="col">내용</div>
            <div class="col">
                <textarea></textarea>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <button>등록</button>
        </div>
    </div>
    <div class="row">
        <div class="col">
            <h2>.</h2>
        </div>
    </div>
</div>

<!--풋터영역-->
<div class="row">
    <div class="col">
        풋터
    </div>
</div>
</div>
</body>
</html>