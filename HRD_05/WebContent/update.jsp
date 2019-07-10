<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*, java.util.*" %>

<%
	// Parameter Encoding 설정
	request.setCharacterEncoding("utf-8");
	
	// 전송된 Parameter 읽기 - 읽을 때는 기본적으로 모두 문자열(String) 입니다.
	String custno = request.getParameter("custno");
	String custname = request.getParameter("custname");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String joindate = request.getParameter("joindate");
    String grade = request.getParameter("grade");
    String city = request.getParameter("city");
	
    /*
    // 앞의 숫자 4개를 가져와서 년도 4자리 정수 만들기
    int year = Integer.parseInt(joindate.substring(0,4));
    int month = Integer.parseInt(joindate.substring(5,7));
    int day = Integer.parseInt(joindate.substring(8));
	*/
	
    // Joindate에서 연도 4자리, 월 2자리, 일 2자리를 추출하여 java.sql.Date 로 만들기
    // Date(1900년도 지나온 연도, 월 -1, 일) - 19, 7, 10 수정
    
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
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user04", "user04");
   	
	// SQL 만들기
	PreparedStatement pstmt = con.prepareStatement("update member_tbl_02 set custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno=?");
	
	// 물음표에 값을 Binding
	pstmt.setString(1, custname);
	pstmt.setString(2, phone);
	pstmt.setString(3, address);
	pstmt.setDate(4, registerDate);
	pstmt.setString(5, grade);
	pstmt.setString(6, city);
	pstmt.setInt(7, Integer.parseInt(custno));

	// SQL 실행 - '삽입', '삭제'를 할 때는 executeQuery(); 를 이용 합니다.
	pstmt.executeQuery();
	
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