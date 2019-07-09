<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%		
	    // Database 접속
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con = DriverManager.getConnection(
			"jdbc:oracle:thin:@192.168.0.100:1521/xe",
			"user04", "user04");
		
		// Table 전체 Data를 가져오는 SQL 생성
		PreparedStatement pstmt = con.prepareStatement("SELECT mem.custno, mem.CUSTNAME, mem.GRADE, money.summary FROM MEMBER_TBL_02 mem,(SELECT custno, sum(price) summary FROM MONEY_TBL_02 GROUP BY CUSTNO ORDER BY summary DESC) money WHERE mem.CUSTNO = money.custno" );
		
		// SQL 실행 - 19, 7, 9 수정
		ResultSet rs = pstmt.executeQuery();
		
		out.println("<h2 align='center'>회원매출조회</h2>");
		out.println("<table border='1' align='center'>");
		
		out.println("<tr><th width='70'>회원번호</th>");
		out.println("<th width='70'>회원성명</th>");
		out.println("<th width='100'>고객등급</th>");
		out.println("<th width='100'>매출</th></tr>");
		
		// 결과 읽기 - 19, 7, 9 수정
		while(rs.next()){
			out.println("<tr>");
			out.println("<td align='center'>" + rs.getString(1) + "</td>");
			out.println("<td align='center'>" + rs.getString(2) + "</td>");
			
			String grade = "";
			
			if("A".equals(rs.getString(3))){
				grade = "VIP";
			}else if("B".equals(rs.getString(3))){
				grade = "일반";
			}else if("C".equals(rs.getString(3))){
				grade = "직원";
			}
			
			/*
			if(rs.getString("grade").equals("A"))
				grade = "VIP";
			else if(rs.getString("grade").equals("B"))
				grade = "일반";
			else if(rs.getString("grade").equals("C"))
				grade = "직원";
			*/
			
			out.println("<td align='center'>" + grade + "</td>");
			out.println("<td align='center'>" + rs.getString(4) + "</td>");
			out.println("</tr>");
			
		}
		out.println("</table>");	
		rs.close();
		pstmt.close();
		con.close();
	%>
</body>
</html>