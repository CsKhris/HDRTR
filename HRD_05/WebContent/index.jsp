<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원관리</title>
</head>
<style type="text/css">

header {
	background-color:navy;
	color:white;
}

nav {
	background-color:skyblue;
	color:white;
}

footer {
	background-color:navy;
	color:white;
	text-align:center;
}

a {
	text-decoration:none;
}

</style>
<body>
	<header>
		<h2 align="center">쇼핑몰 회원관리 ver1.0</h2>
	</header>
	<nav>
		<a href="register.jsp" target="content" style="color:white;">회원등록</a>&nbsp;&nbsp;
		<a href="list.jsp" target="content" style="color:white;">회원목록 조회/수정</a>&nbsp;&nbsp; 
		<a href="" target="content" style="color:white;">회원매출 조회</a>&nbsp;&nbsp; 
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="main.jsp" target="content" style="color:white;">홈으로.</a>
	</nav>
	<section>
		<iframe width="100%" height="300px" src="main.jsp" name="content" id="content" ></iframe>
	</section>
	<footer>HRDKOREA Copyright©2019 All rights reserved. Human Resources Development Service of Korea. </footer>
</body>
</html>