<!-- 신규 회원 가입을 하는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<meta charset="UTF-8">
<script type="text/javascript">
	function checkForm() {
		//newMember 폼의 id 값이 없다면 false
		if (!document.newMember.id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}

		if (!document.newMember.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		
		if (document.newMember.password.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
	}
	
	function checkId() {
		if(!document.newMember.id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		/*
		window.name="IDCheckForm";
		window.open("./checkMember.jsp?id=" + document.newMember.id.value,
				"IDCheck", "width=300, height=160, resizable = no, scrollbars=no");
		*/
	}
	
	function reset() {
		
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="Menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>

	<div class="container">
		<!-- javascript에서 검사를 위해 form name을 newMember로 설정
			 onsubmit부분에서 submit 버튼을 눌렀을 때 javascript의 checkForm()으로 가게 만듦
			 false가 반환되면 서버로의 폼 제출이 중단 false가 아니면 processAddMember 실행 -->
		<form name="newMember" class="form-horizontal"  action="processAddMember.jsp" method="post" onsubmit="return checkForm()">
			<div class="form-group  row">
				<label class="col-sm-2 ">아이디</label>
				<div class="col-sm-3">
					<table>
						<tr>
						<td><input name="id" type="text" class="form-control" placeholder="id" ></td>
						
						<!-- 여기에서 회원가입을 할 때 id가 중복되는지 체크 -->
						<td><input type="button" class="btn btn-danger" onclick="checkId()" value="중복체크"></td>
						</tr>
					</table>
					
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input name="password" type="text" class="form-control" placeholder="password" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input name="password_confirm" type="text" class="form-control" placeholder="password confirm" >
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" placeholder="name" >
				</div>
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary " value="등록 " >
					<a href="Welcome.jsp" class="btn btn-primary">취소</a>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="/Footer.jsp"/>
</body>
</html>