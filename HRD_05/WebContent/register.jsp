<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Import 먼저 하기 -->
<%@ page import="java.sql.*, java.util.*" %>

<%
	// JSP에 Java Code를 사용하면 예외처리를 하지 않아도 됩니다.
	// 
	
	// Sequence의 다음 값 가져오기
		
	// 1. Driver Class를 Load 하기 - Oracle Database Connection Code
	Class.forName("oracle.jdbc.OracleDriver");

	// 2. Database 연결
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.100:1521/xe", "user04", "user04");
	
	// 3. PreparedStatement를 생성하여 SQL을 실행
	
	// 입력 받아야 하는 항목이 있으면 ?로 작성 합니다.
	PreparedStatement pstmt = con.prepareStatement("select memberseq.nextval from dual");
	
	// ?가 있으면 ?를 채우고 SQL을 실행합니다.
	// select 구문은 ResultSet 으로 받아야 하고,
	// 나머지는 '정수'로 받으면 됩니다.
	// 실행할 때 select는 executeQuery() 이고,
	// 나머지는 executeUpdate() 입니다.
	ResultSet rs = pstmt.executeQuery();	
	
	// 4. 결과를 사용(Select 에서만 사용)
	int custno = -1;
	if(rs.next()){
		// 첫번째 Column의 값을 custno에 대입 합니다.
		custno = rs.getInt(1);
	}
	
	// 5. 모든 객체를 닫기
	rs.close();
	pstmt.close();
	con.close();
	
	// 오늘 날짜를 숫자 8자리 문자열로 만들기
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMdd");
	String joindate = sdf.format(new java.util.Date());
	
	
	
	/*
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
	*/
	
%>	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원등록</title>
</head>
<body>
	<h2 align="center">홈쇼핑 회원 등록</h2>
	<form id="registerform" action="insert.jsp">
		<table align="center" border="1">
			<tr>
				<td align="center" width="250">회원번호(자동발생)</td>
				<td width="400">
				<input type="text" name="custno" id="custno" value='<%=custno %>' width="300" /> <!-- readonly="true"  -->
				</td>
			</tr>
			<tr>
				<td align="center">회원성명</td>
				<td><input type="text" name="custname" id="custname" /></td>
			</tr>
			<tr>
				<td align="center">회원전화</td>
				<td><input type="text" name="phone" id="phone" size="25"/></td>
			</tr>
			<tr>
				<td align="center">회원주소</td>
				<td><input type="text" name="address" id="address" size="40"/></td>
			</tr>
			<tr>
				<td align="center">가입일자</td>
				<td><input type="text" name="joindate" id="joindate" value='<%=joindate %>'/></td>
			</tr>			
			<tr>
				<td align="center">고객등급 [A:VIP, B:일반, C:직원]</td>
				<td><input type="text" name="grade" id="grade" /></td>
			</tr>			
			<tr>
				<td align="center">도시코드</td>
				<td><input type="text" name="city" id="city" /></td>
			</tr>			
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="등록" id="registerbtn"/>
				<input type="button" value="조회" id="listbtn"/>
				</td>
			</tr>			
		</table>
	</form>
</body>

<script>
	
	//조회 Button을 눌렀을 때의 Page 이동
	document.getElementById("listbtn")
		.addEventListener("click", function(e){
			//Page 이동
			location.href = "list.jsp";
		});

	//등록 Button을 눌렀을 때의 Page 이동
	document.getElementById("registerbtn")
		.addEventListener("click", function(e){
			
			//회원성명 입력란을 찾아오기
			var custno = document.getElementById('custno');
			var custname = document.getElementById('custname');
			var phone = document.getElementById('phone');
			var address = document.getElementById('address');
			var joindate = document.getElementById('joindate');
			var grade = document.getElementById('grade');
			var city = document.getElementById('city');
			
			// 입력된 Data가 없으면 입력란으로 Focus 설정
			if(custno.value.trim().length < 1){
				alert("회원번호가 입력되지 않았습니다.");
				custno.focus();
				return;
			}

			if(custname.value.trim().length < 1){
				alert("회원성명이 입력되지 않았습니다.");
				custname.focus();
				return;
			}

			if(phone.value.trim().length < 1){
				alert("회원전화가 입력되지 않았습니다.");
				phone.focus();
				return;
			}
			
			if(address.value.trim().length < 1){
				alert("회원주소가 입력되지 않았습니다.");
				address.focus();
				return;
			}
			
			if(joindate.value.trim().length < 1){
				alert("가입일자가 입력되지 않았습니다.");
				joindate.focus();
				return;
			}			
			
			if(grade.value.trim().length < 1){
				alert("고객등급이 입력되지 않았습니다.");
				grade.focus();
				return;
			}
			
			if(city.value.trim().length < 1){
				alert("도시코드가 입력되지 않았습니다.");
				city.focus();
				return;
			}
			
			
			
			/*
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
			*/
			
			//form의 Data 전송
			//submit();을 하게 되면 화면에 변화가 생깁니다.
			//document.getElementById("registerform").submit();
			
			//form의 Data를 가지고 insert.jsp File에 ajax 요청
			//ajax 객체 생성 
			var request = new XMLHttpRequest();
			
			//전송할 URL 생성
			var url = "insert.jsp?"
			//URL에 Parameter 붙이기
			url += "custno=" + document.getElementById("custno").value;
			url += "&custname=" + document.getElementById("custname").value;
			url += "&phone=" + document.getElementById("phone").value;
			url += "&address=" + document.getElementById("address").value;
			url += "&joindate=" + document.getElementById("joindate").value;
			url += "&grade=" + document.getElementById("grade").value;
			url += "&city=" + document.getElementById("city").value;
			
			//AJAX 요청 생성
			request.open('GET', encodeURI(url));
			request.send(' '); 

			//요청에 성공했을 때 수행할 내용 작성
			request.onreadystatechange = function(){
				if(request.readyState == 4){
					alert("회원등록이 완료 되었습니다!")
				}
			}
		});

</script>

</html>