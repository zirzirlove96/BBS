<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!-- 모바일이나 컴퓨터에서 웹페이지를 열때 자동으로 맞춰준다 -->
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<!-- css폴더에 있는 css파일을 기본적인 웹페이지 스타일로 쓰겠다. 디자인 담당 -->
<title>JSP 게시판 웹 사이트</title>

</head>
<body>
	<!-- navigation 바를 만들어 준다 -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<!-- 로고를 넣어준다 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
				<!-- 위의 바의 한부분 -->
				<!-- 화면이 작으면 navbar-toggle이 표시된다 -->
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<!-- 위와 같이 두개의 메뉴를 만들어 줬다 -->

			<!-- 오른쪽에 접속하기라고 하는 button을 만들어 준다 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="carot"></span></a> <!-- 접속하기 메뉴를 다운바로 만들어 누르면 로그인,회원가입이 뜨게 한다 -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<!-- 로그인 페이지에 들어와 있으면 파란색을 띈다 -->
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
		</div>
	</nav>

	<!-- 회원가입 화면이 띄워진다 -->
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="paddin-top: 20px;">
				<form method="post" action="joinAction.jsp"><!-- joinAction.jsp에서 회원가입에 대한 데이터를 처리한다 -->
					
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20">
					</div>

					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
					</div>
					
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름"
							name="userName" maxlength="20">
					</div>
					
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons"><!-- btn-group은 버튼이 묶여져서 표현, data-toggle은 input에서 정의한 radio를 버튼으로 변경해 주었다 -->
							<label class="btn btn-primary active">
								<input type="radio" name="userGender"  autocomplete="off" value="남자" checked>남자
							</label><!-- autocomplete는 자동완성기능 -->
							
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일"
							name="userEmail" maxlength="20"><!-- type을 email로 해서 진짜 이메일 주소를 적어야한다 -->
					</div>
					
					<input type="submit" class="btn btn-primary form-control"
						value="회원가입">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<!-- 여러 애니메이션을 사용하기 위해 사용하는 라이브러리 -->
</body>
</html>