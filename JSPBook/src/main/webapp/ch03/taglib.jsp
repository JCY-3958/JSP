<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<c:forEach var = "k" begin="1" end="100" step="3">
		<c:out value="${k}" />
	</c:forEach>
</body>
</html>