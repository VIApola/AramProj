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
<title>실내 식물</title>
<  <style>
    
     #category img{
         margin: 10px;
         width: 90%;
         height: 90%;
     }

     .card{
         border: none;
        text-align: center;
        margin-left: auto;
     }

    #category{
        margin-bottom: 50px;
    }
    #links{
        text-align: right;
        border-top: 1px solid gray;
        margin-bottom: 80px;
    }

    a{
        text-decoration-line: none;
        color: black;
    }
   
    /* *{
        border: 1px solid black;
    } */

  
    .search{
        text-align: center;
    }

    .search{
        display: flex;
        justify-content: center;
    }
    #count{
        font-size: x-small;
        
    }
    .countBox{
        text-align: left;
    }

    </style>

</head>
<body>
    <div class="container">

        <div class="row" id="category">
            
            <div class="col-4">
                <a href="/"> <img src="images/category2-실내 식물.png"></a>
            </div>
            <div class="col-4">
                <a href="/"><img src="images/category1-공기 정화 식물.png"></a>
                
            </div>
            <div class="col-4">
                <a href="/"><img src="images/category3-실외식물.png"></a>
            </div>
        </div>

        <div class="row" id="links">
          
            <div class="col-9 countBox">
                <span id="count">총 @@개의 상품이 검색되었습니다.</span>
            </div>

            <div class="col-1 search">
                <a href="/">낮은 가격</a>
            </div>
            <div class="col-1 search">
                <a href="/">높은 가격</a>
            </div>
            <div class="col-1 search">
                <a href="/">제품명</a>
            </div>


        </div>

       
            
            <div class="row">
            
                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>

                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>

                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>

                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>
            
   
            </div>

                   
                

            <div class="row">
            
                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>

                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>

                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>

                <div class="col-3 item">
                    <a href="/">
                        <div class="card" style="width: 10rem; height: 20rem;">
                            <img src="images/공기정화/개운죽.png" class="card-img-top">
                    </a>        
                            <div class="card-body">
                              <p class="card-text">No.1</p>
                              <p class="price">Price : xx</p>
                            </div>
                        </div>
                </div>
            
   
            </div>




        <div class="row" id="pacing"></div>
            
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                     
                      <li class="page-item">
                        <a class="page-link" href="/" aria-label="Previous">
                          <span aria-hidden="true">&laquo;</span>
                        </a>
                      </li>
     
                      
                      
                       <li class="page-item"><a class="page-link" href="/">1</a></li>
                       <li class="page-item"><a class="page-link" href="/">2</a></li>
                       <li class="page-item"><a class="page-link" href="/">3</a></li>
            
                      <li class="page-item">
                        <a class="page-link" href="/" aria-label="Next">
                          <span aria-hidden="true">&raquo;</span>
                        </a>
                      </li>
                     
                   
                    </ul>
                  </nav>
         
    </div>
</body>
</html>