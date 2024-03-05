<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>문자열 검색
	<p>RTX 4080 사줘 => ${fn:contains("RTX 4080", "rtx")}
	<p>RTX 4080 사줘 => ${fn:containsIgnoreCase("RTX 4080", "rtx")}
</body>
</html>