<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.userDAO"%><!-- userDAO를 사용한다-->
<%@page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%><!-- 넘어오는 정보를 utf-8로 변환 -->

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<!-- 회원가입에 필요한 객체를 다 가져온다 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");//로그인한 user의 userID에 대한
			//세션값을 userID에 저장시킨다
		}
		if (userID != null) {//session을 통해 고유한 값을 받았음에도 불구 하고, 다시 로그인을 하려고 시도했을 때.
			//또 다시 로그인 하는 것을 막기 위해 해준다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 된 상태입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
				|| user.getUserGender() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력하지 않은 정보가 있습니다.')");
			script.println("history.back()");
			script.println("</script>");//회원가입을 하는데에 있어 입력하지 않은 정보가 있을 때 반응한다
		} else {//회원가입 정보를 입력했을 때
			userDAO userdao = new userDAO();//데이터베이스에 접근할 수 있는 객체를 가져온다
			int result = userdao.join(user);//위의 serProperty로 인해 입력된 정보가 user라는 객체에 저장되기 대문에 join에 넣을 수 있다
			if (result == -1) {//값이 -1인 경우는 데이터베이스 오류인데 데이터 베이스 오류는 primary 값으로 지정해준 ID가 중복됐을 경우이다
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 아이디가 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}

			else { //회원가입 정보를 다 입력했을 경우 main.jsp로 이동하게 한다.
				session.setAttribute("userID", user.getUserID());//세션값을 준다
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href= 'main.jsp' ");
				script.println("</script>");
			}

		}
	%>
</body>
</html>