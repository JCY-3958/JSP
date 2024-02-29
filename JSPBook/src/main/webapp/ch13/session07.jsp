<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<h4>----- 세션 유효 시간 변경 전 -----</h4>
	<%
		//60은 초이기 때문에 나누면 분이 나옴
		int time = session.getMaxInactiveInterval() / 60;
		out.println("세션 유효 시간 : " + time + "분<br>");
	%>
	
	<h4>----- 세션 유효 시간 변경 후 -----</h4>
	<%
		session.setMaxInactiveInterval(60 * 60);
		time = session.getMaxInactiveInterval() / 60;
		
		out.println("세션 유효 시간 : " + time + "분<br>");
	%>
</body>
</html>