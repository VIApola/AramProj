<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	<script language="JavaScript">
    function setCookie(name, value, expiredays) {
        let date = new Date();
        date.setDate(date.getDate() + expiredays);
        document.cookie = escape(name) + "=" + escape(value) + "; expires=" + date.toUTCString();
    }

    function closePopup() {
        if (document.getElementById("check").value) {
            setCookie("popupYN", "N", 7); //1은 하루 7은 일주일
            self.close();
        }
    }
	</script>
	</head>
<body>
    <img src="/resources/images/Event.png"><br/>
    <div style="text-align: center;">
    <input type="checkbox" id="check" onclick="closePopup();">
    <fontsize=3> <b>일주일동안 보지않기</b> </fontsize>
    </div>
</body>
</html>