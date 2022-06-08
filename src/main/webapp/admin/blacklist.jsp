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
    <title>고객계정관리</title>
</head>
<!-- style 영역 -->
<link href="${pageContext.request.contextPath}/resources/css/blacklist.css" rel="stylesheet" type="text/css">
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
                            <a class="nav-link" style="color: black;" href="/toQnAManagePage.admin">게시판 관리</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" style="color: black;" href="/main">메인</a>
                        </li>
                    </ul>    
            </div>
            </div>
        </div> <!-- 헤더 끝 -->



        <div class="row box-title"> <!-- 바디타이틀 -->
            <div class="col">
                <h2>고객관리</h2>
            </div>
        </div>


        <!--상단바 목록/검색창-->
        <div class="row header">
            <div class="row">
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="/toReviewManage.admin" class="header-menu">리뷰관리</a>
                </div>
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="/toQnAManagePage.admin" class="header-menu">Q&A관리</a>
                </div>
                <div class="col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center">
                    <a href="/toUserManage.admin" class="header-menu">계정관리</a>
                </div>
                
                <div class="col-2 col-xl-1 d-flex align-self-center justify-content-end" style="display:block; text-align: justify;">
                    <select id="searchSelect">
                        <option value="아이디">아이디</option>
                        <option value="이름">이름</option>
                        <option value="이메일">이메일</option>
                    </select>
                </div>
                <div class="col-4 col-xl-3">
                    <nav class="navbar">
                        <div class="search">
                            <input id="searchInput" style="height:30px;" type="text" placeholder="검색어 입력">
                            <img id="searchBtn" style="width: 20px; cursor:pointer;" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
                        </div>
                    </nav>
                </div>
            </div>
        </div>


        
        <!--콘텐츠 타이틀-->
        <div class="contents-header-box">
            <div class="row contents-header">
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <input type="checkbox" id="checkAll">
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>아이디</span>
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    <span>이름</span>
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                    <span>이메일</span>
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                    <span>가입일</span>
                </div>
            </div>
        </div>
        <!--콘텐츠 (회원정보)-->
        <!-- form -->
        <div class="contents-box">
<form id="blacklistForm" action="/addBlacklist.admin" method="post">
            
            <c:choose>
            <c:when test="${empty userList}">
             <div class="row">
              <div class="col d-flex align-self-center justify-content-center">
            	<h2>등록된 회원이 없습니다.</h2>
             </div>
              </div>
            </c:when>
            <c:otherwise>
            	
              <c:forEach items="${userList}" var="list">
              <div class="row contents">
            	<div class="col-2 d-flex align-self-center justify-content-center">
                    <input type="checkbox" class="clicks" name="user_id" value="${list.user_id}">
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    ${list.user_id}
                </div>
                <div class="col-2 d-flex align-self-center justify-content-center">
                    ${list.username}
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                     ${list.email}
                </div>
                <div class="col-3 d-flex align-self-center justify-content-center">
                    ${list.join_date}
                </div>
                 </div> 
               </c:forEach>
               
            </c:otherwise>
            </c:choose>     
           
        <!-- 블랙리스트 이유적는 칸 -->
              <div class="row box-blacklist-detail">
                <div class="col d-flex align-self-center justify-content-end">
                   <textarea id="blacklistDetail" name="black_detail" style="width:100%; margin-top:10px;" placeholder="블랙리스트에 추가되는 이유를 적어주세요. 회원 한명씩 추가가 가능합니다."></textarea>
                	
                </div>
            </div>
            
        
</form>
</div>
        <!-- 블랙리스트 버튼 -->
         <div class="row box-btn-blacklist justify-content-end">
                <div class="col-4 d-flex align-self-center justify-content-end">
                    <button type="button" id="toBlacklistBtn" class="btn btn-outline-success">블랙리스트목록</button>
                </div>
                <div class="col-4 d-flex align-self-center justify-content-end">
                    <button type="button" id="addBlacklistBtn" class="btn btn-outline-danger">블랙리스트추가</button>
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
    	//검색버튼을 클릭했을 때 - 검색하는게 젤루 무서웡
    	$("#searchBtn").on("click",function(){
    		let searchInput = $("#searchInput").val();
    		
    		if(searchInput === ""){
    			location.href = "/toUserManage.admin";
    			return;
    		}
    		let select = $("#searchSelect option:checked").text()
    		
    		if(select === "아이디"){
    		  console.log("아이디 : "+searchInput);
    		  $.ajax({
    			  url:"/searchUserlist.admin?user_id="+searchInput
    			 ,type:"get"
    			 ,success:function(data){
    	    		console.log(data);
    	    		makeUserlist(data)	
    	    	}
    	    	,error:function(e){
    	    		console.log(e);
    	    	}
    		  });

    		}else if(select === "이름"){
    			console.log("이름 : "+searchInput);
    			$.ajax({
      			  url:"/searchUserlist.admin?username="+searchInput
      			 ,type:"get"
      			 ,success:function(data){
      	    		console.log(data);
      	    		makeUserlist(data)
      	    		
      	    	}
      	    	,error:function(e){
      	    		console.log(e);
      	    	}
      		  });
    			
    		}else if(select === "이메일"){
    			console.log("이메일 :"+searchInput);
    			$.ajax({
        			  url:"/searchUserlist.admin?email="+searchInput
        			 ,type:"get"
        			 ,success:function(data){
        	    		console.log(data);
        	    		makeUserlist(data)
        	    		
        	    	}
        	    	,error:function(e){
        	    		console.log(e);
        	    	}
        		  });
    		}
    		
    	});
    
        // 전체체크
        $("#checkAll").change(function () {
            if ($("#checkAll").is(":checked")) {       	
            	$(".clicks").prop("checked",true);
            } else {
            	$(".clicks").prop("checked",false);
            }
        });
        
        //블랙리스트 추가버튼을 눌렀을때
        $("#addBlacklistBtn").on("click",function(e){
        	
        	//블랙리스트 사유
        	let detail = $("#blacklistDetail").val();
        	console.log(detail);
        	
        	if($("#blacklistDetail").val()===""){
        		alert("사유를 입력해 주세요.");
        		return;
        	}
        	
        	//체크박스에 체크된 id값만 가져오기
        	$(".clicks:checked").each(function(){
        		let id = $(this).val();
        		console.log(id);
        			
        	})
        	
        	//checkBox가 선택되지않은 경우
        	if($(".clicks").val() === ""){
        		alert("블랙리스트에 추가할 회원을 선택해 주세요.");
        		return;
        	}
        	
        	//확인창 띄우기
             let anwser = confirm("선택한 회원을 블랙리스트로 등록하겠습니까?");
            if(anwser){
            $("#blacklistForm").submit();
        		
        	//블랙리스트 추가된 행 삭제하기
        	$(".clicks:checked").each(function(e){
        		let check = $(this);
        	    check.parent().parent().remove();
        	})
        	
        	
        	}
        		
        });
        
        //블랙리스트 목록으로 가는 버튼을 눌렀을 때
        $("#toBlacklistBtn").on("click",function(){
        	$.ajax({
        		url : "/showBlacklist.admin"
        	  ,type:"get"
        	  ,success:function(data){
        		  console.log(data);
        		  makeBlacklist(data);
       		
        		
        	  }//success 끝나는 부분
        	
        	  ,error:function(e){
        		  console.log(e);
        	  }//error 끝나는 부분
        	})      	
        })
      
        function makeBlacklist(data){
        	let list = JSON.parse(data);
        	console.log(data);
        	
        	//상단바 목록/검색창
  		  $(".header").empty();
  		  let row = $("<div>").addClass("row");
  		  let col5 = $("<div>").addClass("col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center");
  		  let a1 = $("<a>").attr({href:""}).addClass("header-menu").html("리뷰관리");
  		  let col6 = $("<div>").addClass("col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center");
  		  let a2 = $("<a>").attr({href:""}).addClass("header-menu").html("Q&A관리");
  		  let col7 = $("<div>").addClass("col-xs-3 col-sm-2 col-xl-1 d-flex align-self-center justify-content-center");
  		  let a3 = $("<a>").attr({href:""}).addClass("header-menu").html("계정관리");
  		  col5.append(a1);
  		  col6.append(a2);
  		  col7.append(a3);
  		  
  		  let col8 = $("<div>").addClass("col-2 col-xl-1 d-flex align-self-center justify-content-end").css({display:"block","text-align":"justify"});
  		  let select = $("<select>").attr({id:"searchBlack"});
  		  let option1 = $("<option>").attr({value:"아이디"}).html("아이디");
  		  let option2 = $("<option>").attr({value:"블랙리스트사유"}).html("사유");
  		  let option3 = $("<option>").attr({value:"등록일"}).html("등록일");
  		  
  		  select.append(option1,option2,option3);
  		  col8.append(select);
  		  
  		  let col9 = $("<div>").addClass("col-4 col-xl-3");
  		  let nav = $("<nav>").addClass("navbar");
  		  let div = $("<div>").addClass("search");
  		  let input2 = $("<input>").attr({id:"searchInput",type:"text",placeholder:"검색어 입력"}).css({height:"30px"});
  		  let img = $("<img>").attr({id:"searchBtn",src:"https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"}).css({width:"20px",cursor:"pointer"});
  		  
  		  div.append(input2,img);
  		  nav.append(div);
  		  col9.append(nav);
  		  
  		  row.append(col5,col6,col7,col8,col9);
  		  $(".header").append(row);
  		  //상단바 목록/검색창 끝
  		  
  		  //상단바 시작 - 아이디 블랙리스트사유 블랙리스트 등록일
  		  $(".contents-header").empty();
  		  
  		  let col1 = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center");
  		  let input = $("<input>").attr({type:"checkbox",id:"checkAll"});
  		  
  		  col1.append(input);
  		  
  		  let col2 = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center");
  		  let span1 = $("<span>").html("아이디");
  		  
  		  col2.append(span1);
  		  
  		  let col3 = $("<div>").addClass("col-4 d-flex align-self-center justify-content-center");
  		  let span2 = $("<span>").html("블랙리스트 사유");
  		  
  		  col3.append(span2);
  		  
  		  let col4 = $("<div>").addClass("col-3 d-flex align-self-center justify-content-center");
  		  let span3 = $("<span>").html("블랙리스트 등록일");
  		  
  		  col4.append(span3);
  		  
  		  $(".contents-header").append(col1,col2,col3,col4);
  		  $(".contents-header-box").append($(".contents-header"));
  		  //상단바 끝 - 아이디 블랙리스트사유 블랙리스트 등록일
  		  
  		  $(".contents-box").empty();//정보칸 지우기
  		  $(".box-blacklist-detail").empty(); //블랙리스트 사유 입력칸 지우기
  		  
  		  
  		  if(list.length == 0){//등록된 블랙리스트 회원이 없다면 등록된 회원이 없다는 문구 띄워주기
  			  let row = $("<div>").addClass("row");
  		  	  let col = $("<div>").addClass("col d-flex align-self-center justify-content-center");
  		  	  let h2 = $("<h2>").html("블랙리스트로 등록된 회원이 없습니다.");
  		  	  
  		  	  col.append(h2);
  		  	  row.append(col);
  		  	  $(".contents-box").append(row);
  		  	$(".box-btn-blacklist").empty();//블랙리스트 목록, 블랙리스트 추가 버튼 없애기
		      //블랙리스트 버튼부분 (회원목록으로 돌아가기, 블랙리스트 해제)
			  let col5 = $("<div>").addClass("col-4 d-flex align-self-center justify-content-end");
		  	  let button1 = $("<button>").attr({type:"button",id:"toUserlistBtn"}).addClass("btn btn-outline-success").html("회원리스트목록");
		  	  let col6 = $("<div>").addClass("col-4 d-flex align-self-center justify-content-end");
 		  	  let button2 = $("<button>").attr({type:"button",id:"notBlacklistBtn"}).addClass("btn btn-outline-danger").html("블랙리스트해제");
 		  	  col5.append(button1);
 		  	  col6.append(button2);
 		  	  let input2 = $("<input>").addClass("d-none").attr({"id":"sendUserlistId"});
 		  	  
 		  	  $(".box-btn-blacklist").append(col5,col6,input2);
  		  
  		  	  
  		  }else{//블랙리스트로 등록된 회원 정보부분
  			
  				  let form = $("<form>").attr({id:"notBlackForm",action:"/noMoreBlacklist.admin",method:"post"})
  			  for(let blacklist of list){ //for문을 이용하여 tbl_blacklist 출력하기
  				  //블랙리스트 콘텐츠 부분
  				  let row = $("<div>").addClass("row contents");
  				  let col1 = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center");
          		  let input = $("<input>").attr({type:"checkbox",value:blacklist.user_id,name:"user_id"}).addClass("clicks");
          		  col1.append(input);
          		  let col2 = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center").html(blacklist.user_id);
          		  let col3 = $("<div>").addClass("col-4 d-flex align-self-center justify-content-center").html(blacklist.black_detail);
          		  let col4 = $("<div>").addClass("col-3 d-flex align-self-center justify-content-center").html(blacklist.black_date);
          		  row.append(col1,col2,col3,col4)
          		  form.append(row);
  				  $(".contents-box").append(form);
  				$(".box-btn-blacklist").empty();//블랙리스트 목록, 블랙리스트 추가 버튼 없애기
    		      //블랙리스트 버튼부분 (회원목록으로 돌아가기, 블랙리스트 해제)
    			  let col5 = $("<div>").addClass("col-4 d-flex align-self-center justify-content-end");
    		  	  let button1 = $("<button>").attr({type:"button",id:"toUserlistBtn"}).addClass("btn btn-outline-success").html("회원리스트목록");
    		  	  let col6 = $("<div>").addClass("col-4 d-flex align-self-center justify-content-end");
     		  	  let button2 = $("<button>").attr({type:"button",id:"notBlacklistBtn"}).addClass("btn btn-outline-danger").html("블랙리스트해제");
     		  	  col5.append(button1);
     		  	  col6.append(button2);
     		  	  let input2 = $("<input>").addClass("d-none").attr({"id":"sendUserlistId"});
     		  	  
     		  	  $(".box-btn-blacklist").append(col5,col6,input2);
  					  
  			  }
  			  
  		  }//블랙리스트로 등록된 회원 정보부분 끝
        	
  		// 전체체크
          $("#checkAll").change(function () {
              if ($("#checkAll").is(":checked")) {       	
              	$(".clicks").prop("checked",true);
              } else {
              	$(".clicks").prop("checked",false);
              }
          }); //전체체크 끝
		
		//회원리스트목록 버튼을 눌렀을때
		$("#toUserlistBtn").on("click",function(){
			location.href = "/toUserManage.admin";
		});//회원리스트목록 버튼을 눌렀을때 끝
		
		//블랙리스트해제 버튼을 눌렀을때
		$("#notBlacklistBtn").on("click",function(){
			//체크박스에 체크된 id값만 가져오기
        	$(".clicks:checked").each(function(){
        		let id = $(this).val();
        		console.log(id);
      
        	})
        	
        	//checkBox가 선택되지않은 경우
        	if($(".clicks").val() === ""){
        		alert("블랙리스트를 해제할 회원을 선택해 주세요.");
        		return;
        	}
        	
        	//확인창 띄우기
        	let anwser = confirm("선택한 회원을 블랙리스트에서 해제하시겠습니까?");
        	if(anwser){
        		$("#notBlackForm").submit();
        		
        		//블랙리스트 추가된 행 삭제하기
            	$(".clicks:checked").each(function(e){
            		let check = $(this);
            		check.parent().parent().remove();
            	})
        	}
        });	//블랙리스트해제 버튼을 눌렀을때 끝
  		  
		//블랙리스트 -  검색버튼 클릭했을떄
		$("#searchBtn").on("click",function(){
    		let searchInput = $("#searchInput").val();
    		
    		
    		
    		if(searchInput === ""){
    			location.href = "/toUserManage.admin";
    			return;
    		}
    		
    		let select = $("#searchBlack option:checked").text()
    		
    		if(select === "아이디"){
    		  console.log("아이디 : "+searchInput);	
    		  $.ajax({
    			  url:"/searchBlacklist.admin?user_id="+searchInput
    			 ,type:"get"
    			,success:function(data){
    	    		console.log(data);
    	    		makeBlacklist(data);
    	    		
    	    	}
    	    	,error:function(e){
    	    		console.log(e);
    	    	}
    		  })
    		  
    		  
    		}else if(select === "사유"){
    			console.log("사유 : "+searchInput);
    			$.ajax({
      			  url:"/searchBlacklist.admin?black_detail="+searchInput
      			,type:"get"
      			,success:function(data){
      				console.log(data);
      				makeBlacklist(data);
    	    
        		}
        		,error:function(e){
        			console.log(e);
        		}
      			
      		  })
    			
    			
    		}else if(select === "등록일"){
    			console.log("등록일 : "+searchInput);
    			$.ajax({
      			  url:"/searchBlacklist.admin?black_date="+searchInput
      			,type:"get"
      			,success:function(data){
      				console.log(data);
      				makeBlacklist(data);

        		}
        		,error:function(e){
        			console.log(e);
        		}
      			
      		  })
    			
    			
    		}
    		
    	}); 
  		  
        }
        
        function makeUserlist(data){
        	let list = JSON.parse(data);
        	
        	$(".contents-box").empty();
    		if(list.length == 0){//검색된 회원이 없을 때
    			 let UserRow = $("<div>").addClass("row");
     		  	  let UserCol = $("<div>").addClass("col d-flex align-self-center justify-content-center");
     		  	  let UserH2 = $("<h2>").html("검색된 등록된 회원이 없습니다.");
     		  	  
     		  	UserCol.append(UserH2);
     		  	UserRow.append(UserCol);
    		  	$(".contents-box").append(row);
    		}else{//검색된 회원 정보 출력
    			for(let userlist of list){//for문을 이용하여 정보 출력
    				let row = $("<div>").addClass("row contents");
    				let col1 = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center");
            	    let input = $("<input>").attr({type:"checkbox",value:userlist.user_id}).addClass("clicks");
            		col1.append(input);
    				
            		let col2 = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center").html(userlist.user_id);
     				let col3 = $("<div>").addClass("col-2 d-flex align-self-center justify-content-center").html(userlist.username);
     		 		let col4 = $("<div>").addClass("col-3 d-flex align-self-center justify-content-center").html(userlist.email);
     		 		let col5 = $("<div>").addClass("col-3 d-flex align-self-center justify-content-center").html(userlist.join_date);
    				
    				row.append(col1,col2,col3,col4,col5);
    				$(".contents-box").append(row);
    				   	    				
    			} 	    			
    		}
        	
        }
        
    </script>
</body>
</html>