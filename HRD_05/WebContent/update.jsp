<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>

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
	
    // 앞의 숫자 4개를 가져와서 년도 4자리 정수 만들기
    int year = Integer.parseInt(joindate.substring(0,4));
    int month = Integer.parseInt(joindate.substring(5,7));
    int day = Integer.parseInt(joindate.substring(8));
    Date updatedate = new Date(year-1900, month-1, day);
    
    // Database 접속
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user04", "user04");
   	
	// SQL 만들기
	PreparedStatement pstmt = con.prepareStatement("update member_tbl_02 set custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno=?");
	
	// 물음표에 값을 Binding
	pstmt.setString(1, custname);
	pstmt.setString(2, phone);
	pstmt.setString(3, address);
	pstmt.setDate(4, updatedate);
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