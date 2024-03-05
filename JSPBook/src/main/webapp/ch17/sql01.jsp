<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<sql:setDataSource var="dataSource"
		url="jdbc:mysql://192.168.111.200:3306/JSPBookDB"
		driver="com.mysql.cj.jdbc.Driver" user="root" password="1234"/>
	
	<sql:query var="resultSet" dataSource="${dataSource}">
		select * from member
	</sql:query>
	
	<table border="1">
		<tr>
			<c:forEach var="columnName" items="${resultSet.columnNames}">
				<th width="100"><c:out value="${columnName}"/></th>
			</c:forEach>
		</tr>
		<!-- 한 행씩 가져옴 -->
		<c:forEach var="row" items="${resultSet.rowsByIndex}">
		<tr>
		<!-- varStatus가 처음엔 0이 된다 그래서 row가 0 -->
			<c:forEach var="column" items="${row}" varStatus="i">
			<td>
			<!-- 그 행의 column이 비어있지 않으면 그 값을 가져옴 -->
				<c:if test="${column != null }">
					<c:out value="${column}"/>
				</c:if>
				<c:if test="${column == null}">
					&nbsp;
				</c:if>
			</td>
			</c:forEach>
		</tr>
		</c:forEach>
	</table>
</body>
</html>