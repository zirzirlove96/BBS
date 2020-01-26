<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%><!-- script를 사용할 수 있게 해준다. -->
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
	
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int bbsID = 0;
		if(request.getParameter("bbsID")!=null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}//BbsDAO에서 만든 getBbs를 가지고 사용자의 아이디가 같지 않다면 수정이 불가능하므로 이 alert문을 쓴다.
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

			<!--userID를 확인하는 작업은 위의 명령문에서 작업하므로 여기에서는 중복할 필요 없다. -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="carot"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li><!-- logoutAction.jsp로 가서 해당 세션을 해지하는 것 -->
					</ul>
				</li>
			</ul>
		

		</div>
	</nav>

	<div class="container">
		<div class="row">
		<form method="post" action="updateAction.jsp?bbsID=<%=bbsID%>"><!-- updateAction을 위해 bbsID를 보내준다. -->
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
					<th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 수정 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<!-- 수정을 위해 수정 전의 제목과 글 내용을 띄워 주기 위해 value에 값을 넣어준다. -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"
						value = "<%=bbs.getBbsTitle() %>">글 제목</td>
					</tr>
					<tr>	
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px"
						><%=bbs.getBbsContent()%></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글수정">	
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>