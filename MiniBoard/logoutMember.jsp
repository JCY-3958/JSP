<%@ page contentType="text/html; charset=utf-8"%>

<%
	//웹 페이지에 들어온 모든 유저의 세션 정보 삭제
	session.invalidate();

	response.sendRedirect("Welcome.jsp");
%>s