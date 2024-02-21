<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Processing</title>
</head>
<body>
	<form action="#" method="get">
		<p><select name="city" size="0">
			<optgroup label="서울특별시">
				<option value="서울시">서울특별시</option>
				<option value="경기도">경기도</option>
				<option value="인천시">인천광역시</option>
			</optgroup>
			<optgroup label="창원특례시">
				<option value="마산">합포구</option>
				<option value="진해">땡땡구</option>
				<option value="창원">의창구</option>
			</optgroup>
		
		</select></p>
		<p><input type="submit" value="전송"></p>
	</form>
</body>
</html>