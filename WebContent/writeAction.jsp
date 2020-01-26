<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO"%><!-- userDAO를 사용한다-->
<%@page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%><!-- 넘어오는 정보를 utf-8로 변환 -->

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<!-- 게시글을 적는데에 필요로한 객체를 가져온다.-->
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
		if (userID == null) {//게시글을 쓰기위해서는 로그인이 된 상태에서 해야만한다.
			//로그인이 안된 상태에서 로그인을 할 수 있게끔 login.jsp로 이동시켜 준다.
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 먼저 해주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		else {
			if (bbs.getBbsTitle()==null || bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력하지 않은 정보가 있습니다.')");
				script.println("history.back()");
				script.println("</script>");//제목이나 글 내용을 하나라도 안적었을 때 반응
			} else {//만약 게시글이 입력이 완료 되었다면
				BbsDAO bbsdao = new BbsDAO();//데이터베이스에 접근할 수 있는 객체를 가져온다
				int result = bbsdao.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				//result는 executeUpdate()로 인해 생겨난 결과값이다.
				if (result == -1) {//값이 -1인 경우는 데이터베이스 오류인데 데이터 베이스 오류이다
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}

				else { //입력이 완료되어 write.jsp로 이동
					
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