<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Implicit Objects</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		//name 파라미터의 값을 변수 name에 저장
		String name = request.getParameter("name");
	%>
	<p>process.jsp 파일</p>
	<p> 이 름 : <%=name %>
</body>
</html>