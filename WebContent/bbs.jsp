<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%><!-- script를 사용할 수 있게 해준다. -->
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="java.util.ArrayList"%><!-- 게시판 글 목록을 만들기 위해 가져온다. -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	
	<% 
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}//main.jsp에서도 로그인이 안됐을 때 userID에 세션값을 부여하여 로그인이 된 것을 알린다.
		
		int pageNumber = 1;//기본적으로 1페이지를 생성해 준다.
		if(request.getParameter("pageNumber")!=null){//페이지의 개수를 int로 나타내 준다.
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
					<th style="background-color:#eeeeee; text-align:center;">번호</th>
					<th style="background-color:#eeeeee; text-align:center;">제목</th>
					<th style="background-color:#eeeeee; text-align:center;">작성자</th>
					<th style="background-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<% 
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i=0;i<list.size();i++){
					%>
					<tr><!-- 글 목록에 대한 데이터베이스에서 데이터를 가져오기 위해 -->
						<td><%=list.get(i).getBbsID() %></td>
						<!-- 글 제목을 눌렀을 경우 해당하는 글로 이동하기 위해 BbsID를 준다. -->
						<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></a></td>
						<td><%=list.get(i).getUserID() %></td>
						<!-- 시간을 지정해서 나타내 준다. -->
						<td><%=list.get(i).getBbsDate().substring(0,11)+ list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분"%></td>
					</tr>
					<%		
						}
					%>
					
				</tbody>	
			</table>
			<%
				if(pageNumber!=1){//페이지의 숫자가 1이 아니라고 한 다면 이전과 다음이 생길 수 있다.
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber-1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<% 		
				}if(bbsDAO.nextPage(pageNumber+1)){//만약 nextPage가 생기는 경우 10개까지는 1페이지에 수용
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber+1 %>" class="btn btn-success btn-arraw-right">다음</a>
			<% 		
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>