<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.sql.*" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
a {
	text-decoration:none;
}
</style>
<body>
	<!-- <h2 align="center">회원목록조회/수정</h2>
	<table align="center" border="1">
		<tr>
			<th width="70">회원번호</th>
			<th width="70">회원성명</th>
			<th>전화번호</th>
			<th width="300">주소</th>
			<th width="100">가입일자</th>
			<th width="100">고객등급</th>
			<th width="100">거주지역</th>
		</tr> -->														
	<%
	
	// Database에 위의 정보를 이용하여 Data 삽입
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user04", "user04");
	
	// 전체 Data를 가져오는 SQL 생성
	//PreparedStatement pstmt = con.prepareStatement("select * from member_tbl_02 order by custno");
	
	// 전체 Data를 가져오는 SQL 생성 - 19, 7, 9 수정
	PreparedStatement pstmt = con.prepareStatement("select custno, custname, phone, address, joindate, grade, city from member_tbl_02" );
	
	// select 구문 실행 - 19, 7, 9 수정
	ResultSet rs = pstmt.executeQuery();
	
	out.println("<h3 align='center'>회원목록조회/수정</h3>");
	out.println("<table align='center' border='1'>");
	
	out.println("<tr><th width='70'>회원번호</th>");
	out.println("<th width='70'>회원성명</th>");
	out.println("<th>전화번호</th>");
	out.println("<th width='300'>주소</th>");
	out.println("<th width='100'>가입일자</th>");
	out.println("<th width='100'>고객등급</th>");
	out.println("<th width='100'>거주지역</th></tr>");
	
	// 결과 읽기
	while(rs.next()){
		out.println("<tr>");
		out.println("<td align='center'>" + "<a href='detail.jsp?custno=" + rs.getInt("custno") + " '>" +
			rs.getString("custno") + "</a></td>");
		
		out.println("<td align='center'>" +
			rs.getString("custname") + "</td>");
		
		out.println("<td align='center'>" +
			rs.getString("phone") + "</td>");
		
		out.println("<td align='center'>" +
			rs.getString("address") + "</td>");
		
		out.println("<td align='center'>" +
			rs.getDate("joindate") + "</td>");
		
		//고객등급 - 19, 7, 9 수정
		String grade = "";
		if("A".equals(rs.getString("grade"))){
			grade = "VIP";
		}else if("B".equals(rs.getString("grade"))){
			grade = "일반";
		}else if("C".equals(rs.getString("grade"))){
			grade = "직원";
		}
		
		/*
		//고객등급
		String grade = "";
		if(rs.getString("grade").equals("A"))
			grade = "VIP";
		else if(rs.getString("grade").equals("B"))
			grade = "일반";
		else if(rs.getString("grade").equals("C"))
			grade = "직원";
		*/
		
		out.println("<td align='center'>" + grade + "</td>");
		out.println("<td align='center'>" +
				rs.getString("city") + "</td>");
		out.println("</tr>");	
	}
	out.println("</table>");
	rs.close();
	pstmt.close();
	con.close();
	%>
	
</body>
</html>