<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Book" %>
<%@ page import="dao.BookRepository" %>
<%@ page errorPage="exceptionNoBookId.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "./resources/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>상품 상세 정보</title>
</head>
<body>
	<jsp:include page="menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		String id = request.getParameter("id");
		BookRepository dao = BookRepository.getInstance();
		Book book = dao.getBookById(id);
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img src="/upload/<%=book.getFilename() %>" style="width:70%">
				<!--  
				<img src="./resources/images/<%=book.getFilename() %>" style="width:70%">
				-->
			</div>
			<div class="col-md-12">
				<p><h5><b>[<%=book.getCategory()%>]<%=book.getName()%></b></h5>
				<p style="padding-top:20px"><%=book.getDescription() %></p>
				<p><b>도서 코드 : </b><span class="badge badge-danger">
					<%=book.getBookId() %></span></p>
				<p><b>출판사</b> : <%=book.getPublisher() %></p>
				<p><b>저자</b> : <%=book.getAuthor() %></p>
				<p><b>재고 수</b> : <%=book.getUnitsInStock() %></p>
				<p><b>총 페이지 수</b> : <%=book.getTotalPages() %></p>
				<p><b>출판일</b> : <%=book.getReleaseDate() %></p>
				<h4><%=book.getUnitPrice() %>원</h4>
				<p><a href="http://www.google.com" class="btn btn-info">도서 주문 &raquo;</a>
				   <a href="./books.jsp" class="btn btn-secondary">도서 목록 &raquo;</a>
				</p>
			</div>
		</div>
		<hr>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>