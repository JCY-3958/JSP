<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Implicit Objects</title>
</head>
<body>
<!--form에서 데이터를 전달하는 방식에는 post 방식과 get 방식이 있다 -->
	<form action="process.jsp" method="post">
		<p>request.jsp 파일</p>
		<p>
			이 름 : <input type="text" name="name">
			<input type="submit" value="전송">
	</form>
</body>
</html>