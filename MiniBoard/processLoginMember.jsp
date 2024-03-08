<!-- Login 페이지에서 로그인 버튼을 눌렀을 때의 액션으로
	 오는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!-- jstl.jar 파일과 mysql-connector.jar 파일 필요 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	request.setCharacterEncoding("UTF-8");

	//Login 폼에서 받은 id와 password request로 받아오기
	String id = request.getParameter("id");
	String passwd = request.getParameter("password");
%>
<%@ include file="/dbconn.jsp" %>
<!-- DB와 연결 
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://192.168.111.200:3306/noticeboard"
	driver="com.mysql.cj.jdbc.Driver" user="root" password="1234" />
	-->

<!-- DB에 쿼리를 날리고 select로 가져온 행들을 resultSet에 저장 -->
<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=? and password=?  
  	<sql:param value="<%=id%>" />
	<sql:param value="<%=passwd%>" />
</sql:query>

<!-- 위에서 ID는 pk이기 때문에 있다면 1행만 가져오고
	 id와 password가 같은 것이 있다면 1행이 resultSet에 저장이 된다.-->
<c:forEach var="row" items="${resultSet.rows}">
	<!-- 행을 가져오는데 성공했으면 for문이 1번 돌면서 session 값 설정 -->
	<c:set var="sessionId" value="${row.id}" scope="session"  />
   	<c:set var="sessionName" value="${row.name}" scope="session"  />
	
	<%
		//세션 유지 시간은 10분으로 설정
		session.setMaxInactiveInterval(60 * 10);
	%>
	<!-- 성공하고 세션 id 부여에 성공했다면 resultMember로 가는데 msg=2 값을 넘겨주며 감 -->
	<c:redirect url="resultMember.jsp?msg=2" />
</c:forEach>

<!-- 행을 가져오는데 실패했다면 for문이 실행이 안되고 Login 페이지로 가면서 error=1 값을 넘겨줌 -->
<c:redirect url="Login.jsp?error=1" />

<!-- forEach에 resultSet.rows 와 resultSet.rowsByIndex 차이 
	rows하면 컬럼 이름을 키 값으로 사용해서 해당 컬럼의 데이터에 접근 가능
	ex)row.id	
-->