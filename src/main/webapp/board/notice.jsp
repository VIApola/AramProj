<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

 <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
		<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery-3.6.0.js"
		integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
		crossorigin="anonymous"></script>
		<style>
			html, body {
				width: 100%;
				height: 100%;
			}
			
			* {
				font-size: small;
			}
			
			/* div {
						border: 1px solid black;
					} */
			
			/*imgBox_Q&A*/
			.imgBox {
				height: 120px;
				background-color: gray;
				/* background-image: url('이미지주소'); */
			}
			
			/*noticeBox*/
			.noticeBox {
				height: 50px;
				border-bottom: 1px solid lightgray;
			}
			
			.noticeBox h5 {
				margin: 0;
			}
			
			.resSearchBox * {
				height: 36px;
			}
			
			/*searchBox*/
			.searchBox {
				height: 100px;
				border-bottom: 1px solid lightgray;
			}
			
			.searchBox>* {
				height: 40px;
				margin: 5px;
			}
			
			/*boardBox*/
			.boardBox {
				height: 300px;
			}
			
			.boardBox>.row {
				padding-top: 2px;
				padding-bottom: 2px;
				border-bottom: 1px solid lightgray;
			}
			
			/*writeBtnBox*/
			.writeBtnBox {
				height: 80px;
			}
			
			/*paginBox*/
			.paginBox {
				height: 80px;
			}
			</style>

<title>Notice</title>

</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="imgBox">
                    <h1>Notice</h1>
                </div>
            </div>
        </div>
        <div class="noticeBox ">
            <div class="row d-flex align-items-center">
                <div class="col-4 col-md-12 d-flex align-items-center">
                    <h5>Notice</h5> 
                </div>
                <div class="col-8 d-md-none mt-2">
                    <div class="resSearchBox d-flex align-items-center justify-content-end">
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle" type="button" id="sectionDd"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                아이디
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                <li><a class="dropdown-item" href="#">제목</a></li>
                                <li><a class="dropdown-item" href="#">내용</a></li>
                            </ul>
                        </div>
                        <div class="inputPart">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
                                <span class="input-group-text" id="basic-addon1">@</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12 d-none d-md-block">
                    <div class="searchBox d-flex justify-content-end align-items-end pb-2">
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle" type="button" id="sectionDd"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                아이디
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                <li><a class="dropdown-item" href="#">제목</a></li>
                                <li><a class="dropdown-item" href="#">내용</a></li>
                            </ul>
                        </div>
                        <div class="inputPart">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
                                <span class="input-group-text" id="basic-addon1">@</span>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="boardBox">
                    <div class="row">
                        <div class="col-1 d-none d-md-block">No.</div>
                        <div class="col-3 d-none d-md-block">Product</div>
                        <div class="col-5 d-none d-md-block">content</div>
                        <div class="col-2 d-none d-md-block">name</div>
                        <div class="col-1 d-none d-md-block">date</div>
                    </div>
                    <div class="row">
                        <div class="col-1 d-none d-md-block">1</div>
                        <div class="col-3 d-none d-md-block">다육이</div>
                        <div class="col-12 col-md-5">배송 관련</div>
                        <div class="col-12 col-md-2">Aram</div>
                        <div class="col-1 d-none d-md-block">date</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="writeBtnBox d-flex justify-content-end align-items-start pt-1">
                    <button type="button" class="btn btn-secondary">글쓰기</button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
        crossorigin="anonymous"></script>


</body>

</html>

