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
    <title>관리자 - 상품관리</title>
</head>
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



    /* 전체설정 */
    * {
        box-sizing: border-box;
    }

    div {
        /* border: 1px solid black; */
    }

    /* 타이틀 */
    .box-title {
        margin-top: 20px;
        margin-bottom: 10px;
    }


    /*상단 네비바의 검색창*/
    .nav {
        position: relative;
    }
    .search {
        position: relative;
        right: 0px;
        width: 100%;
    }

    .search input {
        width: 100%;
        border: 1px solid #bbb;
        border-radius: 8px;
        padding: 10px 12px;
        font-size: 14px;
    }

    .search img {
        position: absolute;
        width: 17px;
        top: 5px;
        right: 12px;
        margin: 0;
    }

    /* 상품관리 메뉴 */

    .body-header { /*고객관리 메뉴*/
        background-color: lightgray;
        margin-bottom: 20px;
    }

    /* 체크박스 색상 */
    input {
        accent-color: green;
    }

    /* 콘텐츠 헤더 */
    .contents-header {
        background-color: lightgray;
    }

    /* 콘텐츠 */
    .contents {
        margin-top: 10px;
    }
    
    /* 상품번호 불러오는 input */
    .cls-item_no {
    	display: none;
    }

    /* 수정/삭제 버튼 */
    .btn-modify {
        margin-right: 10px;
    }
    
    /* 블랙리스트 버튼 */
    .box-btn-addItem {
        margin-top: 30px;
    }
    
    /* 선택삭제, 신규상품등록 쪽 버튼*/
    .cls-lastBtn {
    	margin-left: 10px;
    }
    
    /* 페이징 */
    .box-paging {
        margin-top: 30px;
    }
            
    
</style>
<body>
    <div class="container">
        <!--헤더영역-->
        <div class="row main-header">
            <!--상단바 로고 영역-->
            <div class="row d-flex justify-content-center">
                <div class="header-logo d-flex justify-content-center">
                    <a href="/main"><img src="/resources/images/Logo_md.png" class="imgLogo d-none d-sm-block" alt="..."></a>
                    <a href="/main"><img src="/resources/images/Logo_sm.png" class="imgLogo d-block d-sm-none"
                            style="" alt="..."></a>
                </div>
            </div>
            <!--네비게이션-->
            <div class="row d-flex justify-content-center">
                <div class="col-12 col-md-8 col-xl-6 d-flex justify-content-center">
                    <ul class="nav">
                        <li class="nav-item">
                            <a class="nav-link active" style="color: black;" href="/toLogout.user">로그아웃</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toUserManage.admin">고객관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toItemPage.admin">상품관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/toNoticeManage.admin">공지사항 관리</a>
                        </li>
                    </ul>    
            </div>
            </div>
        </div> <!-- 헤더 끝 -->



        <div class="row box-title"> <!-- 바디타이틀 -->
            <div class="col">
                <h2>상품관리</h2>
            </div>
        </div>


        <!--상단바 목록/검색창-->
        <div class="row body-header">
            <div class="row">
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    
                </div>
                <div class="col-xs-6 col-sm-4 col-xl-2 d-flex align-self-center justify-content-center"></div>
                <div class="d-none d-xl-block col-xl-5 d-flex align-self-center"></div>
                <div class="col-2 col-xl-1 d-flex align-self-center justify-content-end" style="display:block; text-align: justify;">
                    <select id="searchSelect">
                        <option value="상품명">상품명</option>
                        <option value="상품번호">상품번호</option>
                        <!-- <option value="카테고리">카테고리</option>  -->
                    </select>
                </div>
                <div class="col-4 col-xl-3">
                    <nav class="navbar">
                        <div class="search">
                            <input style="height:30px;" id="searchInput" type="text" placeholder="검색어 입력">
                            <img id="searchBtn" style="width: 20px; cursor:pointer;" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                        </div>
                    </nav>
                </div>
            </div>
        </div>
        
        <div class="row countBox">
        	<div class="col">
        		등록된 상품 ${count}건
        	</div>
        </div>
        
        <!--콘텐츠 타이틀-->
        <div class="contents-header-box">
            <div class="row contents-header">
                <div class="col-1 d-flex align-self-center justify-content-center">
                    <input type="checkbox" id="checkAll">
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>상품번호</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>분류</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>상품이미지</span>
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                    <span>상품명</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>수정/삭제</span>
                </div>
            </div>
        </div>
        <!--콘텐츠-->
        <div class="contents-box">
			<c:choose>
				<c:when test="${mngItemList.size() == 0}">
					<div class="row">
						<div class="col">
							등록된 상품이 없습니다.
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach items="${mngItemList}" var="dto">
						
							<div class="row contents">
								<div class="col-1 d-flex align-self-center justify-content-center"> <!-- 체크박스 = id -->
									<input type="checkbox" class="clsCheckbox" id="${dto.item_no}">
								</div>
								<div class="col-2 d-flex align-self-center justify-content-center"> <!-- 상품번호 -->
									<span>${dto.item_no}</span>
								</div>
								<div class="col-2 d-flex align-self-center justify-content-center"> <!-- 분류 -->
									<span>${dto.category_id}</span>
								</div>
								<div class="col-2 d-flex align-self-center justify-content-center"> <!-- 이미지 -->
	                            	<img src="/resources/images/items/${dto.itemImgDTO.sys_name}" class="card-img-top">
								</div>
								<div class="col-3 d-flex align-self-center justify-content-center"> <!-- 상품명 -->
									<span>${dto.item_name}</span>
								</div>
								<div class="col-2 d-flex align-self-center justify-content-center"> <!-- 버튼 -->
									<form id="formModifyItem${dto.item_no}" action="/toModifyItem.admin" method="post">
										<input type="number" class="cls-item_no" id="${dto.item_no}" name="item_no" value="${dto.item_no}"readonly>
										<button type="button" id="modifyItem${dto.item_no}" value="${dto.item_no}" class="btn-modify btn btn-success">수정</button>
									</form>
									<form>
										<input type="number" class="cls-item_no" id="${dto.item_no}" name="item_no" value="${dto.item_no}"readonly>
										<input type="text" class="cls-item_no" id="${dto.itemImgDTO.img_no}" value="${dto.itemImgDTO.img_no}" name="img_no">
										<button type="button" id="deleteItem${dto.item_no}" value="${dto.item_no}" class="btn-delete btn btn-secondary">삭제</button>
									</form>
								</div>
							</div>
					</c:forEach>
					
				</c:otherwise>
				
			</c:choose>

            <!-- 신규상품등록 버튼 -->
            <div class="row box-btn-addItem">
                <div class="col d-flex align-self-center justify-content-end">
                	<!-- <button type="button" id="del-selected" class="cls-lastBtn btn btn-outline-secondary">선택삭제</button>  -->
                    <button type="button" id="toItemInput" class="cls-lastBtn btn btn-outline-success">신규상품등록</button>
                </div>
            </div>
        </div>
        <!--페이징-->
        <div class="row box-paging">
            <div class="col d-flex align-self-center justify-content-center">
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

    <script>
    
    //검색버튼을 클릭했을 때
    $("#searchBtn").on("click", function () {
        let searchInput = $("#searchInput").val();

        if (searchInput === "") {
            location.href = "/toUserManage.admin";
            return;
        }
        let select = $("#searchSelect option:selected").val();
        
        console.log(searchInput + " : " + select);
        
        if (select === "상품명") {
            console.log("상품명 : " + searchInput);
            $.ajax({
                url: "/searchMng.admin?item_name=" + searchInput
                , type: "get"
                , dataType: "json"
                , success: function (data) {
                    console.log(data);
                    makeList(data);
                }
                , error: function (e) {
                    console.log(e);
                }
            });

        } else if (select === "상품번호") {
            console.log("이름 : " + searchInput);
            $.ajax({
                url: "/searchMng.admin?item_no=" + searchInput
                , type: "get"
                , dataType: "json"
                , success: function (data) {
                    console.log(data);
                    makeList(data)

                }
                , error: function (e) {
                    console.log(e);
                }
            });

        }

    });
    
    
        // 전체체크
        $("#checkAll").change(function () {
            if ($("#checkAll").is(":checked")) {
            	for(let i = 0; i < ${mngItemList.size()}; i++) {
            		$(".clsCheckbox").prop("checked", true);
            	}
            } else {
            	for(let i = 0; i < ${mngItemList.size()}; i++) {
            		$(".clsCheckbox").prop("checked", false);
            	}
            }
        });
        
        
        
    	
    	// 개별수정버튼
    	$(".btn-modify").click(function(){
    		$(this).parent().submit();
    	});
    	
    	
    	// 개별삭제버튼
    	$(".btn-delete").click(function(){
    		let item_no = $(this).val();
    		let img_no = $(this).prev().val();
    		console.log(item_no + " : " + img_no);
    	
    		
    		let delCheck = confirm("정말 삭제하시겠습니까?");
    		
    		if(delCheck) {
        		$.ajax({
        			url : "/delete.item"
        			, type : "post"
        			, data : {item_no : item_no, img_no : img_no}
        			, success : function(data){
        				console.log(data);
        				
        				if(data === "fail"){
        					alert("상품 삭제에 실패했습니다.");
        				} else {
        					makeList(data);
        				}
        				
        			}
        			, error: function(e){
        				console.log(e);
        			}
        		});
    		}
    		

    	});
        
        
        
        // 신규상품 등록버튼 클릭
        $("#toItemInput").on("click", function(){
        	location.href = "/toItemInput.item";
        });
        
        // 선택된 상품들 삭제 클릭
        $("#del-selected").on("click", function(){
        	let selcheck = confirm("정말 삭제하시겠습니까?");
        	console.log(selcheck);
        	
        	if(selcheck){
        		
        	} else {
        		alert("선택된 상품이 없습니다.");
        		return;
        	}
        });
        
        
        function makeList(data){ // 전체리스트 다시 뿌려주는 작업 (삭제 시)
        	let list = JSON.parse(data);
        
        	$(".countBox").empty();
        	
        	$(".contents-box").empty();
        	
			let rowCount = $("<div>").addClass("row countBox");
			let colCount = $("<div>").addClass("col").html("등록된 상품 ${count}건");
			
			rowCount.append(colCount);
			$(".countBox").append(rowCount);
			
        	
        	if(list.length == 0){ // 상품목록이 없을 때
        		let row = $("<div>").addClass("row");
        		let col = $("<div>").addClass("col").html("등록된 상품이 없습니다.");
        		
        		row.append(col);
        		$(".contents-box").append(row);
        	} else { // 상품목록이 있을 때
        		for(let dto of list){
        			
        			let rowCon = $("<div>").addClass("row contents");
        			// 체크박스
        			let colCheckbox = $('<div>').addClass("col-1 d-flex align-self-center justify-content-center");
        			let inputCheckbox = $("<input>").attr({class: "clsCheckbox", type: "checkbox", id: ""})
        			
        			colCheckbox.append(inputCheckbox);
        			rowCon.append(colCheckbox);
        			
        			// 상품번호
        			let colItemNo = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center"); 
        			let spanItemNo = $("<span>").html(dto.item_no);
        			
        			colItemNo.append(spanItemNo);
        			rowCon.append(colItemNo);
        			
        			// 분류
        			let colCategory = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center");
        			let spanCategory = $("<span>").html(dto.category_id);
        			
        			colCategory.append(spanCategory);
        			rowCon.append(colCategory);
        			
        			// 이미지
        			let colImg = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center");
        			let img = $("<img>").attr("src", "/resources/images/items/"+dto.itemImgDTO.sys_name).addClass("card-img-top");
        			
        			colImg.append(img);
        			rowCon.append(colImg);
        			
        			// 상품명
        			let colItemName = $("<div>").addClass("col-3 d-flex align-self-center justify-content-center");
        			let spanItemName = $("<span>").html(dto.item_name);
        			
        			colItemName.append(spanItemName);
        			rowCon.append(colItemName);
        			
        			// 버튼
        			let colBtn = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center");
        			let formModifyBtn = $("<form>").attr({id: "formModifyItem"+dto.item_no, action: "/toModifyItem.admin", method: "post"});
        			let inputModify = $("<input>").attr({type: "number", class: "cls-item_no", id: dto.item_no, name: "item_no", value: dto.item_no, readonly: true});
        			let btnModify = $("<button>").attr({id: "modifyItem"+dto.item_no, class: "btn-modify btn btn-success"}).html("수정");
        			
        			formModifyBtn.append(inputModify).append(btnModify);
        			colBtn.append(formModifyBtn);
        			
        			let formDeleteBtn = $("<form>");
        			let inputDelete = $("<input>").attr({type: "number", class:  "cls-item_no", id: dto.item_no, name: "item_no", value: dto.item_no, readonly: true});
        			let inputDeleteImg = $("<input>").attr({type: "text", class: "cls-item_no", id: dto.itemImgDTO.img_no, name: "img_no", value: dto.itemImgDTO.img_no});
        			let btnDelete = $("<button>").attr({type: "button", id: "deleteItem"+dto.item_no, value: dto.item_no, class: "btn-delete btn btn-secondary"}).html("삭제");
        			
        			formDeleteBtn.append(inputDelete).append(inputDeleteImg).append(btnDelete);
        			colBtn.append(formDeleteBtn);
        			rowCon.append(colBtn);
        			$(".contents-box").append(rowCon);
        			
        			
        			
        			
                    
        		}
        	
            	
        	
        	
        	}
        	
        	
        	// 개별수정버튼
        	$(".btn-modify").click(function(){
        		$(this).parent().submit();
        	});
        	
        	
        	// 개별삭제버튼
        	$(".btn-delete").click(function(){
        		let item_no = $(this).val();
        		let img_no = $(this).prev().val();
        		console.log(item_no + " : " + img_no);
        	
        		
        		let delCheck = confirm("정말 삭제하시겠습니까?");
        		
        		if(delCheck) {
            		$.ajax({
            			url : "/delete.item"
            			, type : "post"
            			, data : {item_no : item_no, img_no : img_no}
            			, success : function(data){
            				console.log(data);
            				
            				if(data === "fail"){
            					alert("상품 삭제에 실패했습니다.");
            				} else {
            					makeList(data);
            				}
            				
            			}
            			, error: function(e){
            				console.log(e);
            			}
            		});
        		}
        		

        	});
        	
        	
        	
        	
        }
        
        
        
        
        
    </script>
</body>

</html>