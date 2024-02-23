<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function checkLogin() {
		var form = document.loginForm;
		
		for(i = 0; i < form.id.value.length; i++) {
			var ch = form.id.value.charAt(i);
			
			if((ch < 'a' || ch > 'z') && (ch > 'A' || ch < 'Z') && (ch > '0' || ch < '9')) {
				alert("하남자는 영문 소문자만 입력 가능");
				form.id.select();
				return;
			}
		}
		
		if(isNaN(form.passwd.value)) {
			alert("상남자는 비밀번호 숫자만 입력한다.");
			form.passwd.select();
			return;
		}
		
		form.submit();
	}
</script>
<body>
	<form name="loginForm" action="validation04_process.jsp" method="post">
		<p>아이디 : <input type="text" name="id">
		<p>비밀번호 : <input type="password" name="passwd">
		<p> <input type="button" value="전송" onclick="checkLogin()">
		<!-- type을 submit으로 하면 바로 전송이 되어서 button으로 만들고 함수 안에서 submit -->
</body>
</html>