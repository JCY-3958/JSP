<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<%
	String id = request.getParameter("id");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://192.168.111.200:3306/WebMarketDB"
	driver="com.mysql.cj.jdbc.Driver" user="root" password="1234" />

<sql:query dataSource="${dataSource}" var="resultSet">
	select * from member where id=?
	<sql:param value="<%=id %>"/>
</sql:query>

<c:set var="result" value="0"/>
<c:forEach var="row" items="${resultSet.rows}">
	<c:set var="result" value="1"/>
</c:forEach>

<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<title>중복 체크</title>
</head>
<body>
	<br>
	<div class="container" align="center">
		<h6 class="alert alert-danger">
			<c:if test="${result == 0}">아이디를 사용할 수 있습니다.</c:if>
			<c:if test="${result == 1}">아이디를 사용할 수 없습니다.</c:if>
		</h6>
	</div>
	<div class="container" align="center">
		<input type="button" onclick="window.close()"
			class="btn btn-secondary" value="닫기">
	</div>
</body>
</html>