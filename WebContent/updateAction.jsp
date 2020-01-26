<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO"%><!-- userDAO를 사용한다-->
<%@page import="bbs.Bbs" %>
<%@page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!-- 자바 빈즈를 삭제함으로써 위의 update.jsp에서 날라오는 name을 가지고 받아서 사용해야 한다. -->
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			//세션값을 userID에 저장시킨다
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 먼저 해주세요.')");
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
		} else {
			if (request.getParameter("bbsTitle")==null || request.getParameter("bbsContent")==null
		|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("") ) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력하지 않은 정보가 있습니다.')");
				script.println("history.back()");
				script.println("</script>");//제목이나 글 내용을 하나라도 안적었을 때 반응
			} else {//만약 게시글이 입력이 완료 되었다면
				BbsDAO bbsdao = new BbsDAO();//데이터베이스에 접근할 수 있는 객체를 가져온다
				int result = bbsdao.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				//update.jsp의 name에서 가져온 값을 가지고 result값을 낼 수 있다.
				if (result == -1) {//값이 -1인 경우는 데이터베이스 오류인데 데이터 베이스 오류이다
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}

				else { 
					
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href= 'bbs.jsp' ");
					script.println("</script>");
				}

			}		
		}
	%>
</body>
</html>