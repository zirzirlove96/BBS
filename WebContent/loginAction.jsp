<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.userDAO" %><!-- userDAO를 사용한다-->
<%@page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("UTF-8"); %><!-- 넘어오는 정보를 utf-8로 변환 -->

<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/><!-- 여기 bean에서 사용할 수 있게 한다 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");//로그인한 user의 userID에 대한
			//세션값을 userID에 저장시킨다
		}
		if(userID!=null){//session을 통해 고유한 값을 받았음에도 불구 하고, 다시 로그인을 하려고 시도했을 때.
			//또 다시 로그인 하는 것을 막기 위해 해준다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 된 상태입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		userDAO userdao = new userDAO();
		int result = userdao.login(user.getUserID(), user.getUserPassword());
		if(result==1){//로그인이 성공했을 경우
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");//유동적으로 script를 써서 옮겨준다
		}
		
		else if(result==0){//비밀번호가 틀렸을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀렸습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else if(result==-1){//아이디가 존재하지 않을 때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않은 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		else if(result==-2){//데이터베이스에  존재하지 않을 때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB에 저장되지 않은 존재입니다')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>