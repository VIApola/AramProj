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
<title>Insert title here</title>
<style>
        *{
            margin: auto;
            box-sizing: border-box;
        }
        div{
            border: 1px solid black;
        }
            /*상단 네비바의 검색창*/
       .search {
       position: relative;
        width: 200px;
       }
    
       .search input {
        width: 100%;
        border: 1px solid #bbb;
       border-radius: 8px;
       padding: 10px 12px;
        font-size: 14px;
       }
    
       .search img {
       position : absolute;
        width: 17px;
        top: 5px;
        right: 12px;
        margin: 0;
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
        <div class="row">
            <div class="col">
                <h2>Q&A관리</h2>
            </div>
        </div>
        <!--상단바 목록/검색창-->
        <div class="header">
        <div class="row">
            <div class="col-1">리뷰관리</div>
            <div class="col-1"><strong>Q&A관리</strong></div>
            <div class="col-1">계정관리</div>
            <div class="col-3" style="display:block; text-align: justify;">
                <select name="">
                  <option value="상품평">아이디</option>
                <option value="상품번호">카테고리</option>
                  <option value="카테고리">내용</option>
                </select></div>
            <div class="col">
            <nav class="navbar">
                <div class="search">
                    <input style="height:30px;" type="text" placeholder="검색어 입력">
                    <a href=""><img style="width: 20px;" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></a>
                  </div>
                </nav>
            </div>
        </div>
        </div>
        <!--콘텐츠 타이틀-->
        <div class="contents-header">
            <div class="row">
                <div class="col-1">
                    <input type="checkbox">
                </div>
                <div class="col-2">
                    글번호
                </div>
                <div class="col-2">
                    카테고리
                </div>
                <div class="col-2">
                    내용
                </div>
                <div class="col-3">
                    등록 날짜
                </div>
                <div class="col-2">
                    댓글 등록
                </div>
            </div>
        </div>
        <!--콘텐츠-->
        <div class="contents">
            <div class="row">
                <div class="col-1">
                    <input type="checkbox">
                </div>
                <div class="col-2">
                    1
                </div>
                <div class="col-2">
                    상품문의
                </div>
                <div class="col-2">
                    문의합니다.
                </div>
                <div class="col-3">
                    ABC초콜릿
                </div>
                <div class="col-2">
                   <button>등록</button>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <button>삭제</button>
                </div>
            </div>
        </div>
        <!--페이징-->
        <div class="row">
            <div class="col">
                페이징
            </div>
        </div>
        <!--풋터-->
            <div class="row">
                <div class="col">
                    풋터
                </div>
            </div>
    </div>
</html>