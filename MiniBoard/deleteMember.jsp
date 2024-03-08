<!-- 회원 정보 수정할 때 회원 탈퇴 버튼 클릭 시 실행 -->
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://192.168.111.200:3306/noticeboard"
	driver="com.mysql.cj.jdbc.Driver" user="root" password="1234" />

<sql:update dataSource="${dataSource}" var="resultSet">
   DELETE FROM member WHERE id = ?
   <sql:param value="<%=sessionId%>" />
</sql:update>

<c:if test="${resultSet>=1}">
	<c:import var="url" url="logoutMember.jsp" />
	<c:redirect url="resultMember.jsp" />
</c:if>