<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Processing</title>
</head>
<body>
	<form action="process.jsp" method="get">
		<p>독서<input type="checkbox" name="reading">
			운동<input type="checkbox" name="exercise">
			영화<input type="checkbox" name="movie"></p>
		<p><input type="submit" value="전송"></p>
	</form>
</body>
</html>