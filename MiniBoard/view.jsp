<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page import="mvc.model.BoardReply"%>
<%
	BoardDTO notice = (BoardDTO) request.getAttribute("board");
	List commentlist = (List) request.getAttribute("boardcommentlist");
	int num = ((Integer) request.getAttribute("num")).intValue();
	int nowpage = ((Integer) request.getAttribute("page")).intValue();
%>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>Board</title>
</head>
<body>
	<jsp:include page="Menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">게시판</h1>
		</div>
	</div>

	<div class="container">
		<form name="newUpdate"
			action="BoardUpdateAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"
			class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2 control-label" >성명</label>
				<div class="col-sm-3">
					<input name="name" class="form-control"	value=" <%=notice.getName()%>">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label" >제목</label>
				<div class="col-sm-5">
					<input name="subject" class="form-control"	value=" <%=notice.getSubject()%>" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 control-label" >내용</label>
				<div class="col-sm-8" style="word-break: break-all;">
					<textarea name="content" class="form-control" cols="50" rows="5"> <%=notice.getContent()%></textarea>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<c:set var="userId" value="<%=notice.getId()%>" />
					<!-- 여기 sessionId는 위에 include page="Menu.jsp"에 있기 때문에 바로 사용 가능 -->
					<c:if test="${sessionId==userId}">
						<p>
							<a	href="./BoardDeleteAction.do?num=<%=notice.getNum()%>&pageNum=<%=nowpage%>"	class="btn btn-danger"> 삭제</a> 
							<input type="submit" class="btn btn-success" value="수정 ">
					</c:if>
					<a href="./BoardListAction.do?pageNum=<%=nowpage%>"		class="btn btn-primary"> 목록</a>
				</div>
			</div>
		</form>
		<hr>
		<div style="padding-top: 50px">
		<table class="table table-hover">
			<tr>
				<th>이름</th>
				<th>내용</th>
				<th>시간</th>
			</tr>
			<%
			for (int j = 0; j < commentlist.size(); j++) {
				BoardReply notice2 = (BoardReply) commentlist.get(j);
			%>
			<tr>
				<td><%=notice2.getName()%></td>
				<td><%=notice2.getReplycontent()%></td>
				<td><%=notice2.getTime()%></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

	<!-- 댓글 입력하고 등록하는 곳 -->
	<!-- 2번째 form -->
	<div class="container">
		<form name="reply" action="ReplyAction.do?num=<%=num%>" class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2 control-label">댓글</label>
				<div class="col-sm-5">
					<!-- 여기에서 지금 페이지의 게시물 번호(num)과 list 상에서 게시물이 있는 페이지(pageNum)을 넘겨줘야함 -->
					<input name="id" type="hidden" class="form-control" value="${sessionId}">
					<input name="name" type="hidden" class="form-control" value="${sessionName}">
					<input name="num" type="hidden" value="<%=num%>">
 					<input name="pageNum" type="hidden" value="<%=nowpage%>">
 					<input name="reply" class="form-control" type="text">
 					
				</div>
				<input type="submit" class="btn btn-success" value="등록">
			</div>
		</form>
		<hr>
	</div>
	</div>
	
	<jsp:include page="Footer.jsp" />
</body>
</html>