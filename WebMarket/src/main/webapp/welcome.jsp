<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import = "java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet"
	href = "https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>Welcome</title>
</head>
<body>
	<%@ include file = "menu.jsp" %>
	<%!
	String greeting = "웹 쇼핑몰에 온걸 환영한다."; 
	String tagLine = "들어올 땐 마음대로지만 나갈 땐 아니란다.";
	%>
	
	<div class = "jumbotron">
		<div class = "container">
			<h1 class = "display-3">
				<%= greeting %>
			</h1>
		</div>
	</div>
	
	<main role = "main">
	<div class = "container">
		<div class = "text-center">
			<h3>
				<%= tagLine %>
			</h3>
			<%
				Date day = new java.util.Date();
				String am_pm;
				int hour = day.getHours();
				int minute = day.getMinutes();
				int second = day.getSeconds();
				if(hour / 12 == 0) {
					am_pm = "AM";
				} else {
					am_pm = "PM";
					hour = hour - 12;
				}
				String ct = hour + ":" + minute + ":" + second + " " + am_pm;
				out.println("현재 접속 시각:" + ct + "\n");
			%>
		</div>
	</div>
	</main>
	
	<%@ include file = "footer.jsp" %>
</body>
</html>