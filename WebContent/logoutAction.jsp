<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		session.invalidate();//만약 logoutAction.jsp에 접속된다면 세션을 빼앗기도록 하는 코드이다.
	%>
	<script>
		location.href="main.jsp";//세션을 빼앗긴 상태는 로그아웃이 된 상태이므로 main.jsp로 이동
	</script>
</body>
</html>