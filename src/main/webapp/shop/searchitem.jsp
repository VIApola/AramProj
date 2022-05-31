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
<title>Search item</title>
 <style>
        /* div {
            border: 1px solid black;
        } */
        *{
            font-size: small;
        }

        /*searchBox*/
        .searchBox {
            width: auto;
            height: 250px;
            border-top: 1px solid lightgray;
            border-bottom: 1px solid lightgray;
        }

        .searchBox>* {
            margin: 1px;
        }

        .searchBox button {
            width: 120px;
            height: 55px;
        }

        .searchPart>* {
            margin-right: 3px;
            padding: 5px;
        }

        .searchPart .priceInput input {
            width: 100px;
            height: 25px;
        }

        .searchPart .keywordInput input {

            width: 200px;
            height: 25px;
        }

        /*classifyBox*/
        .classifyBox {
            height: 100px;
        }

        .classifyBox a {
            padding: 10px;
            text-decoration: none;
            color: black;
        }

        /*contentBox*/
        /* .contentBox {
            height: 800px;
        } */

        .contentBox .card {
            margin-bottom: 15px;
            border: none;
        }

        .contentBox .card-body {
            text-align: center;
        }


        /*paginBox*/

        .paginBox {
            height: 100px;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="searchBox d-flex justify-content-center align-items-center">
                    <div class="searchPart">
                        <div class="row priceInput">
                            <div class="col-lg-12 d-flex justify-content-between">
                                <span>가격대</span>
                                <input type="text" class="form-control" placeholder=""> ~
                                <input type="text" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="row keywordInput">
                            <div class="col-lg-12 d-flex justify-content-between">
                                <span style="margin-right: 25px;">제품명 / 키워드</span>
                                <input type="text" class="form-control" placeholder="">
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-secondary" rowspan="2">검색</button>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- 비반응형 -->
            <div class="col-12 d-none d-lg-block">
                <div class="classifyBox d-flex justify-content-end align-items-center">
                    <a href="">낮은 가격</a>
                    <span> | </span>
                    <a href="">높은 가격</a>
                    <span> | </span>
                    <a href="">제품명</a>
                </div>
            </div>
            <!-- 반응형 -->
            <div class="col-12 d-lg-none">
                <div class="classifyBox d-flex justify-content-start align-items-center">
                    <a href="">낮은 가격</a>
                    <span> | </span>
                    <a href="">높은 가격</a>
                    <span> | </span>
                    <a href="">제품명</a>
                </div>
            </div>
        </div>
        <div class="contentBox">
            <div class="row">
                <div class="col-6 col-lg-3 d-flex justify-content-center">
                    <div class="card" style="width: 16rem;">
                        <img src="/media/동백나무.png" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-text col-lg-12">화분세트</h5>
                            <p class="card-text col-12 d-lg-none">열매를 맺어</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3 d-flex justify-content-center">
                    <div class="card" style="width: 16rem;">
                        <img src="/media/동백나무.png" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-text">멋쟁이 토마토</h5>
                            <p class="card-text col-12 d-lg-none">열매를 맺어</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3 d-flex justify-content-center">
                    <div class="card" style="width: 16rem;">
                        <img src="/media/동백나무.png" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-text">화분세트</h5>
                            <p class="card-text col-12 d-lg-none">열매를 맺어</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3 d-flex justify-content-center">
                    <div class="card" style="width: 16rem;">
                        <img src="/media/동백나무.png" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-text">멋쟁이 토마토</h5>
                            <p class="card-text col-12 d-lg-none">열매를 맺어</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col">
            <div class="paginBox d-flex justify-content-center align-items-center">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    </div>
</body>

</html>