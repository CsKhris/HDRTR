<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, java.util.*" %>

<%
	// Parameter Encoding 설정
	request.setCharacterEncoding("utf-8");
	
	// 전송된 Parameter 읽기
	String custno = request.getParameter("custno");
	String custname = request.getParameter("custname");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String joindate = request.getParameter("joindate");
    String grade = request.getParameter("grade");
    String city = request.getParameter("city");

	// 연도 4자리 가져오기
	String year = joindate.substring(0,4);
	// 월 2자리 가져오기
	String month = joindate.substring(4,6);
	// 일 2자리 가져오기
	String day = joindate.substring(6);
    
	// 입력한 날짜를 가지고 Date 객체 만들기
	Calendar cal = new GregorianCalendar(
			Integer.parseInt(year),
			Integer.parseInt(month) - 1,
			Integer.parseInt(day));
	
	java.sql.Date registerDate = new java.sql.Date(cal.getTimeInMillis());
	
    // Database 접속
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(
		"jdbc:oracle:thin:@192.168.0.100:1521/xe",
		"user04", "user04");
	
	// SQL 만들기
	PreparedStatement pstmt = con.prepareStatement("INSERT INTO MEMBER_TBL_02(CUSTNO, CUSTNAME, PHONE, ADDRESS, JOINDATE, GRADE, CITY) VALUES(?, ?, ?, ?, ?, ?, ?)");
	
	// 물음표에 값을 Binding
	pstmt.setInt(1, Integer.parseInt(custno));
	pstmt.setString(2, custname);
	pstmt.setString(3, phone);
	pstmt.setString(4, address);
	pstmt.setDate(5, registerDate);
	pstmt.setString(6, grade);
	pstmt.setString(7, city);
	//SQL 실행
	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>