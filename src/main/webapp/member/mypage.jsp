<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!-- 우편번호 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap"
	rel="stylesheet">
<title>MY PAGE</title>
<style>
/* 폰트 스타일 */
@font-face {
	font-family: 'GowunBatang-Bold';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/GowunBatang-Bold.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'Roboto Mono', monospace;
	font-family: 'GowunBatang-Bold';
	box-sizing: none;
}
/* 마이페이지 글씨 밑 선 */
h3 {
	border-bottom: 2px solid black;
	padding-bottom: 10px;
	cursor: pointer;
}


h5 {
	border-bottom: 2px solid lightgray;
	padding: 5px;
}

span {
	margin: 10px;
	cursor: pointer;
}

span::after {
	display: block;
	content: '';
	width: 50%;
	border-bottom: solid 2px #7cc09c;
	transform: scaleX(0);
	transition: transform 250ms ease-in-out;
}

span:hover::after {
	transform: scaleX(1);
}
.reviewImg{
width:50%;
height:50%;
margin-top:5px;
}
.list-row{
height:70px;
border-top: 1px solid lightgray;
}
.list-row:last-child{
border-bottom: 1px solid lightgray;
}
.imgDiv{

padding-left:40px;
padding-right:0;
padding-top:10px;

}
.imgDiv>img{
height:70%;

}

.nameDiv{
margin-top:25px;
padding-left:0;
padding-right:0;

}
.titleDiv{
margin-top:25px;

}
.scoreDiv{
margin-top:25px;

}
.write_dateDiv{
margin-top:25px;

}
.bottom-line{
margin-bottom:20px;
}
.listTitle{
margin-bottom:20px;
}
.listTitle>.nameDivT{
text-align:center;

}
.listTitle>.titleDivT{
text-align:left;
padding-left:25px;
}
.scoreDivT{
text-align:70%;
}
.listTitle>.write_dateDivT{
padding-left:50px;
text-align:left;
}

a {
	margin: 10px;
	cursor: pointer;
	color: #000;
	text-decoration:none;
}
a:visited { color: #000; }

a::after {
	display: block;
	content: '';
	width: 50%;
	border-bottom: solid 2px #7cc09c;
	transform: scaleX(0);
	transition: transform 250ms ease-in-out;
}

a:hover::after {
	transform: scaleX(1);
}






</style>
</head>
<body>
	<div class="container">
		<div class="row">여기는 Header</div>
		<div class="row">
			
			<div class="col-12 d-md-none">
				<select id="selectbox" class="form-select"
					aria-label="Default select example"
					onchange="myFunction(this.value)">
					<option value="1">MY PAGE</option>
					<option value="2">주문내역, 배송조회</option>
					<option value="3">Q&A</option>
					<option value="4">Review</option>
					<option value="5">회원 정보 수정</option>
					<option value="6">회원 탈퇴</option>
				</select>
			</div>
			<div class="row">
				<div class="col-12 d-none d-md-block" id="mypage">
					<h3>MY PAGE</h3>
				</div>
			</div>
			<div class="row">
				<div class="col d-none d-md-block col-md-5">
					<div class="row">
						<div class="col">
							<h5>Shopping page</h5>
						</div>
						<div class="row">
							<div class="col" id="shopping">
								<span class="list">주문내역, 배송조회</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<h5>Post Page</h5>
						</div>
						<div class="row">
							<div class="col" id="qa">
								<span class="list">Q&A</span>
							</div>
						</div>
						<div class="row">
							<div class="col" id="review">
								<span class="list">Review</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<h5>Info page</h5>
						</div>
						<div class="row">
							<div class="col" id="modify">
								<span class="list">회원 정보 수정</span>
							</div>
						</div>
						<div class="row">
							<div class="col" id="delete">
								<span class="list">회원탈퇴</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-md-7" id="content">
					<p>${loginSession.nickname}님, 환영합니다.</p>
				</div>
			</div>
		</div>
		<div class="row">여기는 footer</div>
	</div>
	
	
	
	
	<script>
	
    /*글자수 처리*/
    function CheckMaxString(obj, maxNum){               
         var li_str_len = obj.length;
         var li_byte = 0;
         var li_len = 0;
         var ls_one_char = "";
         var ls_str2 = "";
         for( var j=0; j<li_str_len; j++){
                 ls_one_char = obj.charAt(j);
                 if(escape(ls_one_char).length > 4 ) {
                       li_byte += 2;
                       }else{
                         li_byte++;
                        }
                         if(li_byte <= maxNum){
                            li_len = j+1;
                      }
                    }
                    if(li_byte > maxNum){
                              ls_str2 = obj.substr(0, li_len)+"...";
                    }else{
                              ls_str2 = obj;
                    }
                    return ls_str2;
          }
	

    $("#mypage").on("click", function(){
        location.href= "/toMypage.user";
    })
    /* 주문내역, 배송 조회*/
     $("#shopping").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("주문내역 & 배송 조회");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");;
        let p =  $("<p>").html("${loginSession.nickname}님이 쇼핑몰에서 주문한 내역입니다.");
        let tableRow = $("<div>").addClass('row');
        let tableCol = $("<div>").addClass("col-12").css("text-align", "center");;
        let table = $("<table>");
        let tr1 = $("<tr>");
        let thNum = $("<th>").html("번호");
        let thDate = $("<th>").html("주문일자");
        let thProduct = $("<th>").html("상품명");
        let thPrice = $("<th>").html("결제금액");
        let thDelivery = $("<th>").html("배송현황");
        let tr2 = $("<tr>");
        // 조건문 돌려서 주문내역 있으면 td 생성
            col.append(p);
            row.append(col);
            tr1.append(thNum, thDate, thProduct, thPrice, thDelivery);
            table.append(tr1);
            tableCol.append(table);
            tableRow.append(tableCol);
            $("#content").append(h3); 
            $("#content").append(row);
            $("#content").append(tableRow);

     });
     /* Q & A*/
     $("#qa").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("Q & A");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");
        let p =  $("<p>").html("${loginSession.nickname}님이 작성하신 글입니다.");
        let tableRow = $("<div>").addClass('row');
        let tableCol = $("<div>").addClass("col-12").css("text-align", "center");;
        let table = $("<table>");
        let tr1 = $("<tr>");
        let thNum = $("<th>").html("번호");
        let thTitle = $("<th>").html("제목");
        let thDate = $("<th>").html("상품명");
        let tr2 = $("<tr>");
        // 조건문 돌려서 문의내역 있으면 td 생성
            col.append(p);
            row.append(col);
            tr1.append(thNum, thTitle, thDate);
            table.append(tr1);
            tableCol.append(table);
            tableRow.append(tableCol);
            $("#content").append(h3); 
            $("#content").append(row);
            $("#content").append(tableRow);
     })
     /* 리뷰 */
  
     $("#review").on("click", function(){ 
    	
    	 $.ajax({
    		 
    			url: "/review.user"
    			   	,	type:"post"
    			   	,	data:""
    			    ,	dataType:"json"
					, success: function(data){				
						console.log(data);	
						console.log(data.list);
						console.log(data.list2);
						
					
						 $("#content").empty();
					        let h3 = $("<h5>").html("Review");
					        let row = $("<div>").addClass('row');
					        let col = $("<div>").addClass("col-12").css("text-align", "center");
					        let p =  $("<p>").html("${loginSession.nickname}님이 작성하신 리뷰입니다.");
					        let tableRow = $("<div>").addClass('row');
					        let tableCol = $("<div>").addClass("col-12 bottom-line").css("text-align", "center");
					        col.append(p);
				            row.append(col);       
				            tableRow.append(tableCol);
				            $("#content").append(h3); 
				            $("#content").append(row);
				            $("#content").append(tableRow);
				            
				            let listTitle = $("<div>").addClass("row listTitle"); 
				       
				            let nameDivT = $("<div>").addClass("col-4 nameDivT").html("상품");
				            let titleDivT =  $("<div>").addClass("col-3 titleDivT").html("제목");
				            let scoreDivT = $("<div>").addClass("col-2 scoreDivT").html("평점");
				            let write_dateDivT = $("<div>").addClass("col-3 write_dateDivT").html("날짜");
				            listTitle.append(nameDivT, titleDivT, scoreDivT, write_dateDivT);
				            $("#content").append(listTitle);  
					
						for(let dto of data){
							
							let list = $("<div>").addClass("row list-row");
            				
            				let imgDiv =  $("<div>").addClass("col-2 imgDiv");
            				
            				let img = $("<img>").attr({class:"reviewImg", src:"/resources/images/items/"+ dto.sys_name});
            				imgDiv.append(img);

            				let nameDiv = $("<div>").addClass("col-2 nameDiv");
            				let nameSpan = $("<span>").html(CheckMaxString(dto.item_name, 10));
            				nameDiv.append(nameSpan);
 
            				let titleDiv = $("<div>").addClass("col-3 titleDiv");
            				let title = $("<a>").attr("href","/detail.item?item_no="+dto.item_no).html(CheckMaxString(dto.title, 12));
            				titleDiv.append(title);
            				
            				let scoreDiv = $("<div>").addClass("col-2 scoreDiv");
            				let score = $("<span>").html(dto.score);
            				scoreDiv.append(score);
            				
            				let write_dateDiv = $("<div>").addClass("col-2 write_dateDiv");
            				let write_date = $("<span>").html(dto.write_date);
            				write_dateDiv.append(write_date);
            				
            				list.append(imgDiv,nameDiv, titleDiv, scoreDiv, write_dateDiv);
            				
            				$("#content").append(list);           			
      	
						}
									
				
				}
				, error: function(e){
					console.log(e);
				}

    	 });

         
     })
     /* 회원정보 수정*/
     $("#modify").on("click", function(){
        $("#content").empty();
        let h3 = $("<h5>").html("회원 정보 수정");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12 col-md-12").css("text-align", "center");
        let img = $("<img>").addClass('d-none d-md-block').attr("src", "/resources/images/password.png").css({"width": "200px", "margin": "0px auto"});
        let p =  $("<p>").html("<br>본인확인을 위해 비밀번호를 입력해주세요.");
        let p2 =  $("<p>").addClass("kakao").html("카카오 로그인은 여기를 눌러주세요.").css({"cursor": "pointer", "color": "#ffd600", "font-size" : "15px"});
        let input = $("<input>").addClass('form-control pw').attr({'type':'password', 'name' : 'pw', "placeholder" : "비밀번호를 입력해주세요"}).css("margin-left", "10px");
        let btn = $("<button>").addClass('btn btn-secondary pwBtn').html('비밀번호 확인').css("margin", "10px").attr("type", "button");
            col.append(img);
            col.append(p);
            col.append(p2);
            col.append(input);
            col.append(btn)
            row.append(col);
            $("#content").append(h3);
            $("#content").append(row);
            // 카카오 로그인 했을경우 (세션에서 social 컬럼 비교..?)
           
            
            $(".kakao").on("click", function(){
            	if("${loginSession.social_login}" == "${loginSession.user_id}"){
               		
            		modifyUser();
   	
            }else{
            	alert("카카오 회원이 아닙니다.");
            }	
            
            });
            $(".pwBtn").on("click", function(){
               $.ajax({
            	   url : "/pwCheck.user"
               , type: "post"
               , data : {"pwCheck" : input.val()}
               ,dataType : "text"
               ,success: function(pwCheck){
            	   if(pwCheck === "pwOk"){
            		   modifyUser();
            	   }else if(pwCheck === "pwNo"){
            		   alert("비밀번호가 틀렸습니다. 다시입력해주세요.");
            		   input.focus();
            	   }
               }, error: function(e){
            	   console.log(e);
               }
               })
               
            })
        
     })
     // 회원정보 탈퇴
     $("#delete").on("click", function(){ // 카카오 탈퇴는 어떤방식으로 할까
        $("#content").empty();
        let h3 = $("<h5>").html("회원 탈퇴");
        let row = $("<div>").addClass('row');
        let col = $("<div>").addClass("col-12").css("text-align", "center");
        let img = $("<img>").addClass('d-none d-md-block').attr("src", "/resources/images/sad.png").css({"width": "150px", "margin": "0px auto"});
        let h4 =  $("<h4>").html("정말 탈퇴하시겠어요?").css('margin', '10px');
        let p =  $("<p>").html("본인 확인을 위해 회원정보를 입력해주세요.").css('margin', '10px');
        let p2 =  $("<p>").addClass("kakao").html("카카오 로그인은 여기를 눌러주세요.").css({"cursor": "pointer", "color": "#ffd600", "font-size" : "15px"});
        let idInput = $("<input>").addClass('form-control id').attr({'type':'text', 
                        'name' : 'id', "placeholder" : "ID를 입력해주세요"}).css({"margin-left": "10px", "margin": "10px"});
        let pwInput = $("<input>").addClass('form-control pw').attr({'type':'password', 
                        'name' : 'pw', "placeholder" : "비밀번호를 입력해주세요"}).css("margin-left", "10px");
        let btn = $("<button>").addClass('btn btn-secondary deletBtn').html('확인').css("margin", "10px").attr("type", "button");
            col.append(img);
            col.append(h4);
            col.append(p);
            col.append(p2);
            col.append(idInput);
            col.append(pwInput);
            col.append(btn)
            row.append(col);
            $("#content").append(h3);
            $("#content").append(row);

            // 카카오 로그인 탈퇴
            $(".kakao").on("click", function(){           	
            	console.log("${loginSession.social_login}");
            	
            	// 일반회원이 클릭 시 alert 및 접근불가(return)
            	if( "${loginSession.social_login}" == "" ){
            		alert("일반회원은 이용 불가합니다.");
            		return false;
            	}
            	
                $("#content").empty();
                let row =  $("<div>").addClass('row');
                let col = $("<div>").addClass("col-12").css("text-align", "center");
                let h5 = $("<h5>").html("탈퇴를 원하시면 아래 문구를 작성해주세요.").css({"border": "none", "margin-top" : "50px"});
                let p = $("<p>").html("'탈퇴하겠습니다'").css("color" , "#2e7d32");
                let input = $("<input>").addClass("form-control deleteInput").attr("placeholder", "탈퇴하겠습니다");
                let deletBtn = $("<button>").addClass('btn btn-outline-danger deleteBtn').html("탈퇴").css("margin-top" , "20px").attr("type", "button");
                    col.append(h5, p, input, deletBtn);
                    row.append(col);
                    $("#content").append(col);
                    $(deletBtn).on("click", function(){
                        if( input.val() !== "탈퇴하겠습니다"){
                            alert("문구를 정확히 입력해주세요.");
                        }else{
                        	console.log("true");
                        	
                        	 $.ajax({
                                 url: "/deleteKakao.user"
                                , type: "post"
                                , data: ""
                             	, dataType: 'text'
                             	, success: function(data){
                             		console.log(data);
                             		
                             		if(data === "success"){
                             			alert("탈퇴 처리 되었습니다.");
                             			location.href="/toLogout.user";
                             		}else{
                             			alert("탈퇴처리를 실패했습니다. 관리자에게 문의하세요");
                             			return false;
                             		}     		
                             		
                             	}
                             	, error: function(e){
                             		console.log(e);
                             	}
                             	
                             	});
                      
                        }
                    })

            });

            $(".deletBtn").on("click", function(){
                
            	if($(".id").val() == ""){
            		alert("회원 아이디를 입력해주세요.");
            		$(".id").focus();
            		return false;
            	}
            	if($(".pw").val() == ""){
            		alert("회원 비밀번호를 입력해주세요.");
            		$(".pw").focus();
            		return false;
            	}
            	
            	
            	  $.ajax({  //탈퇴 요건 검사
                      url: "/deleteProc.user"
                     , type: "post"
                     , data: {'id': $(".id").val(), 'pw' : $(".pw").val()}
                  	, dataType: 'text'
                  	, success: function(data){
                  		console.log(data);
                  		
                  		
                  		if(data === 'fail_id'){
                    		alert("입력하신 ID와 현재 아이디가 일치하지 않습니다. 다시 확인해주세요");   
                    		return false;
                    	}else if(data ==='fail_pw'){
                    		alert("입력하신 비밀번호와 현재 비밀번호가 일치하지 않습니다. 다시 확인해주세요");
                    		return false;
                  		
                  		}else if(data === 'pass'){
                  			
                  			
                  			let rs = confirm("정말 탈퇴하시겠습니까?");
                  			
                  		  if(rs){
                              $.ajax({
                                  url: "/delete.user"
                                 , type: "post"
                                 , data: {'id': $(".id").val()}
                              	, dataType: 'text'
                              	, success: function(data){
                              		console.log(data);
                              		
                              		if(data === "true"){
                              			
                              			alert("정상적으로 탈퇴되었습니다.");
                              			location.href="/toLogout.user";
                              			
                              		}else if(data === "false"){
                              			alert("탈퇴에 실패했습니다. 관리자에게 문의하세요")
                              		}
                              		
                              		
                              	}
                              	, error: function(e){
                              		console.log(e);
                              	}
                              })
                           }
                  			
                  			
                  		}
                  	
                  	}
                  	
                  	, error: function(e){
                  		console.log(e);
                  	}
                  })
            	          
          
                
               
            })
     })
     /* 반응형 됐을경우 select 이벤트*/
      function myFunction(str){
         if(str == 1){
            location.href= "/toMypage.user";
         }else if(str == 2){
            alert("shop"); // 예시...
         }else if(str == 3){
        	 selectByQnA();
         }else if(str == 4){
        	 
         }else if(str == 5){
        	 $("#content").empty();
             let h3 = $("<h5>").html("회원 정보 수정").css("margin-top", "30px");
             let row = $("<div>").addClass('row');
             let col = $("<div>").addClass("col-12").css("text-align", "center");
             let img = $("<img>").addClass('d-none d-md-block').attr("src", "/resources/images/password.png").css({"width": "200px", "margin": "0px auto"});
             let p =  $("<p>").html("<br>본인확인을 위해 비밀번호를 입력해주세요.");
             let p2 =  $("<p>").addClass("kakao").html("카카오 로그인은 여기를 눌러주세요.").css({"cursor": "pointer", "color": "#ffd600", "font-size" : "15px"});
             let input = $("<input>").addClass('form-control pw').attr({'type':'password', 'name' : 'pw', "placeholder" : "비밀번호를 입력해주세요"}).css("margin-left", "10px");
             let btn = $("<button>").addClass('btn btn-secondary pwBtn').html('비밀번호 확인').css("margin", "10px").attr("type", "button");
                 col.append(img);
                 col.append(p);
                 col.append(p2);
                 col.append(input);
                 col.append(btn)
                 row.append(col);
                 $("#content").append(h3);
                 $("#content").append(row);
                 // 카카오 로그인 했을경우 (세션에서 social 컬럼 비교..?)
                
                 
                 $(".kakao").on("click", function(){
                 	if("${loginSession.social_login}" == "${loginSession.user_id}"){
                    		
                 		modifyUser();
        	
                 }else{
                 	alert("카카오 회원이 아닙니다.");
                 }	
                 
                 });
                 $(".pwBtn").on("click", function(){
                    $.ajax({
                 	   url : "/pwCheck.user"
                    , type: "post"
                    , data : {"pwCheck" : input.val()}
                    ,dataType : "text"
                    ,success: function(pwCheck){
                 	   if(pwCheck === "pwOk"){
                 		   modifyUser();
                 	   }else if(pwCheck === "pwNo"){
                 		   alert("비밀번호가 틀렸습니다. 다시입력해주세요.");
                 		   input.focus();
                 	   }
                    }, error: function(e){
                 	   console.log(e);
                    }
                    })
                    
                 })
             
          }
     }
     function selectByQnA(){
    	 $("#content").empty();
         let h3 = $("<h5>").html("Q & A");
         let row = $("<div>").addClass('row');
         let col = $("<div>").addClass("col-12").css("margin", "20px");
         let p =  $("<p>").html("${loginSession.nickname}님이 작성하신 글입니다.");
         let p2 = $("<p>").html("* 제목을 클릭하시면, 게시글의 내용을 확인 할 수 있습니다.").css({"font-size": "small", "text-align" : "left"})
          let tableRow = $("<div>").addClass('row');
    		        let tableCol = $("<div>").addClass("col-12").css("text-align", "center");;
    		        let table = $("<table>").css({"width" : "100%", "border-top" : "1px solid grey", "border-collapse" : "collapse"});
    		        let tr1 = $("<tr>").css("background-color", "#E1F2E3");
    		        let thNum = $("<th>").html("번호").css({"padding" : "10px", "border-bottom" : "1px solid grey"});
    		        let thTitle = $("<th>").html("제목").css({"padding" : "10px", "border-bottom" : "1px solid grey"});
    		        let thDate = $("<th>").html("날짜").css({"padding" : "10px", "border-bottom" : "1px solid grey"});
    		        // 조건문 돌려서 문의내역 있으면 td 생성
    		        
    		            col.append(p);
    		            col.append(p2);
    		            row.append(col);
    		            tr1.append(thNum, thTitle, thDate);
    		            table.append(tr1);
    		            tableCol.append(table);
    		            tableRow.append(tableCol);
    		            $("#content").append(h3); 
    		            $("#content").append(row);
    		            $("#content").append(tableRow);
    		          let user_id = "${loginSession.user_id}";
    		          console.log(user_id);
    		        
    	 $.ajax({
    		 url: "/qnaSearchProc.bo?user_id=" + user_id
    		 , type: "get"
    		 , dataType: "json"
    		 , success: function(data){
    			 
    			 if(data.length == 0){
    				 let tr = $("<tr>");
    				 let td = $("<td>").attr("colspan", "3").html("작성하신 Q & A 글이 없습니다.").css({"padding" : "10px", "border-bottom" : "1px solid grey"});
    				 tr.append(td);
    				 table.append(tr); 
    			 }else{
    				 for(let dto of data){
    					 let tr = $("<tr>");
    					 let td1 = $("<td>").html(dto.qna_no).css({"padding" : "10px", "border-bottom" : "1px solid grey", "text-align" : "center"});
    					 let td2 = $("<td>").css({"padding" : "10px", "border-bottom" : "1px solid grey"});
    					 let anchor =  $("<a>").attr("href", "/"+dto.qna_no).html(CheckMaxString(dto.title, 12)).css({"text-decoration" : "none", "color": "black"});
    					 let td3 = $("<td>").html(dto.write_date).css({"padding" : "10px", "border-bottom" : "1px solid grey", "text-align" : "center"});
    					 td2.append(anchor);
    					 tr.append(td1, td2, td3);
        				 table.append(tr);
    				 }
    			 }
    			 
    		 }
    		 ,error: function(e){
    			 console.log(e);
    		 }
    	 })
     }
     // 글자수 처리
     function CheckMaxString(obj, maxNum){
         var li_str_len = obj.length;
         var li_byte = 0;
         var li_len = 0;
         var ls_one_char = "";
         var ls_str2 = "";
         for( var j=0; j<li_str_len; j++){
                 ls_one_char = obj.charAt(j);
                 if(escape(ls_one_char).length > 4 ) {
                       li_byte += 2;
                       }else{
                         li_byte++;
                        }
                         if(li_byte <= maxNum){
                            li_len = j+1;
                      }
                    }
                    if(li_byte > maxNum){
                              ls_str2 = obj.substr(0, li_len)+"...";
                    }else{
                              ls_str2 = obj;
                    }
                    return ls_str2;
          }
     function modifyUser(){
    	 
    	 $("#content").empty();
         let form = $("<form>");
             // 이름
         let clsInputRow = $("<div>").addClass("row clsInputRow").css("margin-top", "20px");
         let colName = $("<div>").addClass("col-4 col-md-3 align-self-center");
         let labelName = $("<label>").attr("for", "name").html("이름");
         let colNameInput = $("<div>").addClass("col-7 col-md-9").css("margin-bottom", "10px");
         let pName = $("<p>").html("${loginSession.username}").css("margin", "0");
             clsInputRow.append(colName);
             colName.append(labelName);
             colNameInput.append(pName);
             clsInputRow.append(colNameInput);
             // 닉네임
         let colNicknmae = $("<div>").addClass("col-4 col-md-3 align-self-center");
         let labelNickname = $("<label>").attr("for", "nickname").html("닉네임");
         let colNickInput = $("<div>").addClass("col-7 col-md-9");
         let inputNickname = $("<input>").addClass("form-control").attr({"type" : "text",
             "id" : "nickname", "name" : "nickname"}).val("${loginSession.nickname}");
         clsInputRow.append(colNicknmae);
         colNicknmae.append(labelNickname);
         clsInputRow.append(colNickInput);
         colNickInput.append(inputNickname);
         form.append(clsInputRow);

             // 휴대폰번호 값 쪼개서 넣기(셋팅)
     	let phone = "${loginSession.phone}"
     	let phone1 = phone.slice(0, 3);
     	let phone2 = phone.slice(3, 7);
     	let phone3 = phone.slice(7);
     	
     	
     	// 휴대폰
         let clsInputRow2 = $("<div>").addClass("row clsInputRow").css("margin-top", "20px");
         let colPhone = $("<div>").addClass("col-4 col-md-3 align-self-center");
         let labelPhone = $("<label>").attr("for", "phone1").html("휴대폰번호");
         clsInputRow2.append(colPhone);
         colPhone.append(labelPhone);
         let colSelect = $("<div>").addClass("col-3 col-md-3");
         let select = $("<select>").addClass("form-select").attr("id", "phone1").val(phone1).prop("selected", true);;
         let option1 = $("<option>").attr("value", "010").html("010");
         let option2 = $("<option>").attr("value", "011").html("011");
         let option3 = $("<option>").attr("value", "016").html("016");
         let option4 = $("<option>").attr("value", "017").html("017");
         let option5 = $("<option>").attr("value", "018").html("018");
         let option6 = $("<option>").attr("value", "019").html("019");
      
         select.append(option1, option2, option3, option4, option5, option6);
         colSelect.append(select);
      
         let colPhone2 = $("<div>").addClass("col-2 col-md-3");
         let inputPhone2 = $("<input>").addClass("form-control").attr({"type" : "text",
             "id" : "phone2", "maxlength" : "4"}).val(phone2);
             colPhone2.append(inputPhone2);
         let colPhone3 = $("<div>").addClass("col-2 col-md-3");
         let inputPhone3 = $("<input>").addClass("form-control").attr({"type" : "text",
             "id" : "phone3", "maxlength" : "4"}).val(phone3);
             colPhone3.append(inputPhone3);
         let phoneDnone =  $("<div>").addClass("col d-none");
         let dnonePhone = $("<input>").attr({"type" : "text",
             "id" : "phone", "name" : "phone"});
         
             phoneDnone.append(dnonePhone);
         clsInputRow2.append(colSelect);
         clsInputRow2.append(colPhone2, colPhone3, phoneDnone);
         form.append(clsInputRow2);
      
         // 이메일
         let clsInputRow3 = $("<div>").addClass("row clsInputRow").css("margin-top", "20px");
         let colEamil = $("<div>").addClass("col-4 col-md-3 align-self-center");
         let labelEmail = $("<label>").attr("for", "email").html("이메일");
         let colEmailInput = $("<div>").addClass("col-7 col-md-9");
         let inputEmail = $("<input>").addClass("form-control").attr({"type" : "text",
             "id" : "email", "name" : "email"}).val("${loginSession.email}");
             colEamil.append(labelEmail);
             colEmailInput.append(inputEmail);
             clsInputRow3.append(colEamil, colEmailInput);
             form.append(clsInputRow3);
         
         // 우편번호
         let clsInputRow4 = $("<div>").addClass("row clsInputRow").css("margin-top", "20px");
         let colPostcode = $("<div>").addClass("col-4 col-md-3 align-self-center");
         let labelPostcode = $("<label>").attr("for", "postcode").html("우편번호");
         let colPostcodeInput =  $("<div>").addClass("col-5 col-md-4");
         let inputPostcode = $("<input>").addClass("form-control").attr({"type" : "text",
             "id" : "postcode", "name" : "postcode", "readonly" : true}).val("${loginSession.post_no}");
         
         let colPostcodeBtn =  $("<div>").addClass("col-4 col-md-5");
         let PostcodeBtn = $("<button>").addClass("btn btn-outline-success").attr({"id": "btnPostcode", "type" : "button"}).html("우편번호 검색");
             colPostcode.append(labelPostcode);
             colPostcodeInput.append(inputPostcode);
             colPostcodeBtn.append(PostcodeBtn);
             clsInputRow4.append(colPostcode, colPostcodeInput, colPostcodeBtn);
             form.append(clsInputRow4);

         // 주소
         let clsInputRow5 = $("<div>").addClass("row clsInputRow").css("margin-top", "20px");
         let colRoadAddr = $("<div>").addClass("col-4 col-md-3 align-self-center");
         let labelRoadAddr = $("<label>").attr("for", "roadAddr").html("주소");
         let colRoadAddrInput =  $("<div>").addClass("col-7 col-md-9");
         let inputRoadAddr = $("<input>").addClass("form-control").attr({"type" : "text",
             "id" : "roadAddr", "name" : "roadAddr", "readonly" : true, "placeholder" : "도로명주소"}).val("${loginSession.addr}");
             colRoadAddr.append(labelRoadAddr);
             colRoadAddrInput.append(inputRoadAddr);
             clsInputRow5.append(colRoadAddr, colRoadAddrInput);
             form.append(clsInputRow5);
         // 상세 주소
         let clsInputRow6 = $("<div>").addClass("row clsInputRow").css("margin-top", "20px");
         let colDetailAddr = $("<div>").addClass("col-4 col-md-3 align-self-center");
         let labelDetailAddr = $("<label>").attr("for", "detailAddr").html("상세주소");
         let colDetailAddrInput =  $("<div>").addClass("col-7 col-md-9");
         let inputDetailAddr = $("<input>").addClass("form-control").attr({"type" : "text",
             "id" : "detailAddr", "name" : "detailAddr", "placeholder" : "도로명주소"}).val("${loginSession.addr_detail}");
             colDetailAddr.append(labelDetailAddr);
             colDetailAddrInput.append(inputDetailAddr);
             clsInputRow6.append(colDetailAddr, colDetailAddrInput);
             form.append(clsInputRow6);
            
         // 뒤로가기 수정 버튼
         let row = $("<div>").addClass("row").css("margin-top", "20px");
         let colBtn =  $("<div>").addClass("col-12 d-flex justify-content-center");
         let backBtn = $("<button>").addClass("btn btn-secondary").attr({"id": "backBtn" ,"type" : "button"}).html("뒤로가기").css("margin-left", "5px");
         let modifyBtn = $("<button>").addClass("btn btn-outline-success").attr({"id": "modifyBtn", "type" : "button"}).html("수정").css("margin-left", "10px");
         
         colBtn.append(backBtn, modifyBtn);
         row.append(colBtn);
         form.append(row);
         $("#content").append(form);
         // 뒤로가기 버튼
         backBtn.on("click", function(){
             location.href ="/toMypage.user";
         })
         // 수정 버튼
			modifyBtn.on("click", function(){
				// 유효성 검사
				let regexNickname = /^[a-zA-z0-9ㄱ-흫]{2,6}$/;
	    		let regexPw = /^[a-zA-z0-9~!@#$]{6,12}$/;
	    		let regexEmail = /^[a-zA-z][\w]+@[a-zA-z]+\.(com|net|co\.kr|or\.kr)$/;
				let regexPhone = /^[0-9]{11}$/;
				let phone = $("#phone1 option:selected").val() + $("#phone2").val() + $("#phone3").val();
				console.log(phone);
				$("#phone").val(phone);
				 if(!regexNickname.test($("#nickname").val())){
		    			alert("닉네임은 영어대소문자 또는 한글 또는 숫자를 이용해서 2~6자 이내로 작성해 주세요.");
		    			$("#nickname").focus();
		    			return;
		    		}else if(!regexPhone.test(phone)){ // 숫자 데이터에 대한 별도의 형변환이 필요없음
						alert("휴대폰번호는 각각 4자리의 숫자로 입력해주세요.");
						return;
		    		}else if(!regexEmail.test($("#email").val())){
		    			alert("이메일 형식에 맞게 입력해주세요.");
		    			$("#email").focus();
		    			return;
		    		}else if($("#postcode").val() === "" || $("#roadAddr").val() === ""){
						alert("주소를 입력해 주세요.");
						return;
					}
				let data = form.serialize();
				$.ajax({
					url: "/modify.user"
					, type: "post"
					, data: data
					, dataType: "text"
					, success: function(modify){
					if(modify === "y"){
						alert("수정 완료되었습니다!");
						location.href = "/toMypage.user";
					}else if(modify === "n"){
						alert("수정에 실패하였습니다. 다시 시도해주세요.");
					}
				}
				, error: function(e){
					console.log(e);
				}
				})
			})
             /* 우편번호 api */
             $("#btnPostcode").on("click", function () {
     new daum.Postcode({
         theme: {
             searchBgColor: "#7CC09C", //검색창 배경색
             queryTextColor: "#FFFFFF" //검색창 글자색
     }
     ,oncomplete: function(data) {

         // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

         // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
         // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
         var roadAddr = data.roadAddress; // 도로명 주소 변수
         var extraRoadAddr = ''; // 참고 항목 변수

         // 법정동명이 있을 경우 추가한다. (법정리는 제외)
         // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
         if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
             extraRoadAddr += data.bname;
         }
         // 건물명이 있고, 공동주택일 경우 추가한다.
         if(data.buildingName !== '' && data.apartment === 'Y'){
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
         }
         // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
         if(extraRoadAddr !== ''){
             extraRoadAddr = ' (' + extraRoadAddr + ')';
         }

         // 우편번호와 주소 정보를 해당 필드에 넣는다.
         document.getElementById('postcode').value = data.zonecode;
         document.getElementById("roadAddr").value = roadAddr;
     }
 }).open();
});
     }

    </script>
</body>
</html>