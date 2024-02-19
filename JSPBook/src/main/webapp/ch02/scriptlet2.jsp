<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<% for( int i = 0; i <= 10; i++) {
		if(i % 2 == 0)
			out.println("<i>" + i + "</i><br>");
	} %>
</body>
</html>