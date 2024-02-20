<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>이 파일은 include_first.jsp</h3>
	<jsp:include page="include_second.jsp" flush="false"/>
	<p>===first.jsp의 페이지===</p>
</body>
</html>