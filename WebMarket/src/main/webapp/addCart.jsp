<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")) {
		response.sendRedirect("products.jsp");
		return;
	}
	
	ProductRepository dao = ProductRepository.getInstance();
	
	Product product = dao.getProductById(id);
	//id를 받아와서 제품에 대한 정보가 없다면 오류페이지로 넘김
	if(product == null) {
		response.sendRedirect("exceptionNoProductId.jsp");
	}
	
	//id가 같은 것을 찾아서 해당하는 제품의 정보를 담는다.
	ArrayList<Product> goodsList = dao.getAllProducts();
	Product goods = new Product();
	for(int i = 0; i < goodsList.size(); i++) {
		goods = goodsList.get(i);
		if(goods.getProductId().equals(id)) {
			break;
		}
	}
	//그 정보는 카트에 담는데 list로 만들어 준다.
	
	ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
	if(list == null) {
		list = new ArrayList<Product>();
		session.setAttribute("cartlist", list);
	}
	
	//장바구니에 기존에 있다면 + 1
	int cnt = 0;
	Product goodsQnt = new Product();
	for(int i = 0; i < list.size(); i++) {
		goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)) {
			cnt++;
			int orderQuantity = goodsQnt.getQuantity() + 1;
			goodsQnt.setQuantity(orderQuantity);
		}
	}
	
	//기존에 없다면 setQuantity를 1
	if(cnt == 0) {
		goods.setQuantity(1);
		list.add(goods);
	}
	
	response.sendRedirect("product.jsp?id=" + id);
%>
