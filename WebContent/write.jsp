<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%><!-- script를 사용할 수 있게 해준다. -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>

</head>
<body>
	
	<% 
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}//main.jsp에서도 로그인이 안됐을 때 userID에 세션값을 부여하여 로그인이 된 것을 알린다.
	%>
		

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<!-- main.jsp에 대한 메뉴바에 active를 달아준다. -->
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>

			<%
			if(userID==null) { //세션값이 없는 상태이므로 로그인이나 회원가입을 할 수 있는 상태이다. 세션값이 없는 상태에서 네비게이션에 로그인과 회원가입의 메뉴창이 뜨도록 하게끔 한다.
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="carot"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<% 
			}else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="carot"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li><!-- logoutAction.jsp로 가서 해당 세션을 해지하는 것 -->
					</ul>
				</li>
			</ul>
			<%	
			}
			%>

		</div>
	</nav>

	<div class="container">
		<div class="row">
		<form method="post" action="writeAction.jsp"><!-- form태그를 사용하여 글제목과 글 내용이 writeAction.jsp에 보내진다. -->
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
					<th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글쓰기 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr><!-- form-control을 사용하여 글을 쓰고 버튼을 눌렀을 때 내용이 Action.jsp로 이동한다. -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50">글 제목</td>
					</tr><!-- 글 제목과 글 내용이 테이블의 다른 줄을 차지 하도록 -->
					<tr>	
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px">글 제목</textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">	
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>