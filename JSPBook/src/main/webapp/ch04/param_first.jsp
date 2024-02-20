<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Action Tag</title>
</head>
<body>
	<h3>이 파일은 param_first.jsp 파일</h3>
	<jsp:include page="param_second.jsp">
		<jsp:param name="date" value="<%=new java.util.Date() %>" />
	</jsp:include>
	<p>Java Server Page</p>
</body>
</html>