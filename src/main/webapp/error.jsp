
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    
  

<title>Error</title>
<style>
	
	.imgCol> img{
	height:90%;
	width:90%;
	margin-right: 70px;
	}
	.container{
		margin: auto;
		height: 900px;
	}
	.titleCol{
		width: 100%;
		height: 10%;
		text-align: center;
	}
	.titleCol > span{
		font-size:50px;
		vertical-align: middle;
	}
	.imgCol{
		text-align: center;
		height: 70%;
	}
	.homeCol{
		text-align: center;
		height: 15%;
	}
	.homeCol > button{
		width: 300px;
	}


</style>

</head>

<body  style="overflow:hidden;">
	<div class="container">
			<div class="col-12 titleCol">
				<span>Sorry, I'm Error</span>
			</div>
		
			<div class="col-12 imgCol">
				<img src="/resources/images/errorIcon.png">
			</div>
		
			<div class="col-12 homeCol">
				<button class="btn btn-success btn-lg" id="btnHome">Go Home</button>
			</div>
	</div>

<script>
$("#btnHome").on("click", function(){
	location.href = "/main.jsp";
});
</script>

</body>
</html>