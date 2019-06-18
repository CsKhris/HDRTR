<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Import 먼저 하기 -->
<%@ page import="java.sql.*, java.util.*" %>

<!-- Oracle Database Connection Code -->
<%
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(
		"jdbc:oracle:thin:@192.168.0.100:1521/xe",
		"user04", "user04");
	// 입력 받아야 하는 항목이 있으면 ?로 작성 합니다.
	PreparedStatement pstmt = con.prepareStatement(
			"select max(custno) from member_tbl_02");
	// ?가 있으면 ?를 채우고 SQL을 실행합니다.
	// select 구문은 ResultSet 으로 받아야 하고,
	// 나머지는 정수로 받으면 됩니다.
	// 실행할 때 select는 executeQuery() 이고,
	// 나머지는 executeUpdate() 입니다.
	ResultSet rs = pstmt.executeQuery();
	
	// 반복문 실행 전, 결과를 저장할 변수 생성
	int maxno = -1;
	
	// 가장 큰 글번호 찾기(행이 하나면 'if' 여러개 이면 'while')
	if(rs.next()){
		maxno = rs.getInt("max(custno)");
	}
	
	// (찾아온 가장 큰 글번호)마지막 번호 + 1
	maxno = maxno + 1;
	
	// 현재 날짜 가져오기(시간도 가져와야 한다면 java.util.Date)
	java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
	//toString을 호출하면 yyyy-MM-DD 형식의 문자열로 Return
	String disp = today.toString();
	// - 를 "" 로 변환
 	disp = disp.replace("-", "");
	
	
	
%>	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2 align="center">홈쇼핑 회원 등록</h2>
	<form action="" id="registerform">
		<table align="center" border="1">
			<tr>
				<td align="center" width="250">회원번호(자동발생)</td>
				<td width="400"> <input type="text" value='<%=maxno %>' width="300"
				name="custno" id="custno" readonly="true" />
				</td>
			</tr>
			<tr>
				<td align="center">회원성명</td>
				<td> 
				<input type="text" name="custname" id="custname" />
				</td>
			</tr>
			<tr>
				<td align="center">회원전화</td>
				<td> 
				<input type="text" name="phone" id="phone" size="25"/>
				</td>
			</tr>
			<tr>
				<td align="center">회원주소</td>
				<td> 
				<input type="text" name="address" id="address" size="40"/>
				</td>
			</tr>
			<tr>
				<td align="center">가입일자</td>
				<td> 
				<input type="text" value='<%=disp %>' name="joindate" id="joindate" />
				</td>
			</tr>			
			<tr>
				<td align="center">고객등급 [A:VIP, B:일반, C:직원]</td>
				<td> 
				<input type="text" name="grade" id="grade" />
				</td>
			</tr>			
			<tr>
				<td align="center">도시코드</td>
				<td> 
				<input type="text" name="city" id="city" />
				</td>
			</tr>			
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="등록" id="registerbtn"/>
				<input type="button" value="조회" id="searchbtn"/>
				</td>
			</tr>			
		</table>
	</form>
</body>
<script>
	//등록 Button을 Click하면
	document.getElementById("registerbtn")
		.addEventListener("click", function(e){
			//회원성명 입력란을 찾아오기
			var n = document.getElementById('custname')
			if(n.value.trim().length == 0){
				alert("회원성명이 입력되지 않았습니다.");
				n.focus();
				return;
			}
			//회원전화 입력란을 찾아오기
			var o = document.getElementById('phone')
			if(o.value.trim().length == 0){
				alert("회원전화가 입력되지 않았습니다.");
				o.focus();
				return;
			}
			//회원주소 입력란을 찾아오기
			var p = document.getElementById('address')
			if(p.value.trim().length == 0){
				alert("회원주소가 입력되지 않았습니다.");
				p.focus();
				return;
			}
			//가입일자 입력란을 찾아오기
			var q = document.getElementById('joindate')
			if(q.value.trim().length == 0){
				alert("가입일자가 입력되지 않았습니다.");
				q.focus();
				return;
			}
			//고객등급 입력란을 찾아오기
			var r = document.getElementById('grade')
			if(r.value.trim().length == 0){
				alert("고객등급이 입력되지 않았습니다.");
				r.focus();
				return;
			}
			//도시코드 입력란을 찾아오기
			var s = document.getElementById('city')
			if(s.value.trim().length == 0){
				alert("도시코드가 입력되지 않았습니다.");
				s.focus();
				return;
			}
		});
	
	
</script>
</html>