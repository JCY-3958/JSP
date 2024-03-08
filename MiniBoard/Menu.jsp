<!-- 어느 페이지에서나 상단에 보이는 메뉴바 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//여기 세션id는 process에서 오는 값을 받음
	String sessionId = (String) session.getAttribute("sessionId");
	String sessionName = (String) session.getAttribute("sessionName");
%>
<nav class="navbar navbar-expand navbar-dark bg-dark">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="Welcome.jsp">CodeHows 게시판</a>
		</div>
		<div>
			<ul class="navbar-nav mr-auto">
				<c:choose>
					<c:when test="${empty sessionId}">
						<li class="nav-item"><a class="nav-link"
							href="<c:url value="Login.jsp"/>">로그인</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value="NewMember.jsp"/>">회원 가입</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value="/BoardListAction.do?pageNum=1"/>">게시판</a></li>
					</c:when>
					<c:otherwise>
						<li style="padding-top: 7px; color:white">[<%=sessionName%>님]</li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value="logoutMember.jsp"/>">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value="updateMember.jsp"/>">회원 수정</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<c:url value="/BoardListAction.do?pageNum=1"/>">게시판</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</nav>