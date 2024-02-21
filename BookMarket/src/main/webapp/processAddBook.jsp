<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Book" %>
<%@ page import="dao.BookRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String bookId = request.getParameter("bookId");
		String name = request.getParameter("name");
		String unitPrice = request.getParameter("unitPrice");
		String author = request.getParameter("author");
		String description = request.getParameter("description");
		String publisher = request.getParameter("publisher");
		String category = request.getParameter("category");
		String unitsInStock = request.getParameter("unitsInStock");
		String totalPages = request.getParameter("totalPages");
		String releaseDate = request.getParameter("releaseDate");
		String condition = request.getParameter("condition");
		
		Integer price;
		if(unitPrice.isEmpty()) {
			price = 0;
		} else {
			price = Integer.valueOf(unitPrice);
		}
		
		long stock;
		if(unitsInStock.isEmpty()) {
			stock = 0;
		} else {
			stock = Long.valueOf(unitsInStock);
		}
		
		long Pages;
		if(totalPages.isEmpty()) {
			Pages = 0;
		} else {
			Pages = Long.valueOf(unitsInStock);
		}
		
		BookRepository dao = BookRepository.getInstance();
		
		Book newBook = new Book();
		newBook.setBookId(bookId);
		newBook.setName(name);
		newBook.setUnitPrice(price);
		newBook.setAuthor(author);
		newBook.setDescription(description);
		newBook.setPublisher(publisher);
		newBook.setCategory(category);
		newBook.setUnitsInStock(stock);
		newBook.setTotalPages(Pages);
		newBook.setReleaseDate(releaseDate);
		newBook.setCondition(condition);
		
		dao.addBook(newBook);
		
		response.sendRedirect("books.jsp");
	%>
</body>
</html>