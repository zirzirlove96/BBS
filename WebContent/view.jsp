<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %><!-- 데이터베이스와 연결할 수 있는 객체를 가져온다 -->
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
		
		int bbsID=0;
		if(request.getParameter("bbsID")!=null){//게시글을 읽을 때 bbsID가 필요로 하다
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID==0){//BbsID가 0일때는 게시글이 없는 것
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('없는 게시글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);//bbsID에 해당하는 글을 Bbs객체에 저장
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
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
					<th colspan="3" style="background-color:#eeeeee; text-align:center;">게시판 글쓰기 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성 일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					<tr>
						<td>글 내용</td>		
						<td colspan="2" style="min-height: 200px; text-align:left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID!=null && userID.equals(bbs.getUserID())){//userID가 자신의 아이디일 때 수정과 삭제 버튼이 나오도록 한다.
			%>
				<a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>