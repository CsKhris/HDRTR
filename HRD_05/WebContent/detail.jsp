<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSP File을 만들 때 무조건 추가하기 -->
<%@ page import="java.sql.*" %>

<%
	//custno를 이용하여 Data 찾아오기
	int custno = Integer.parseInt(request.getParameter("custno"));

	// Database 접속
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(
	"jdbc:oracle:thin:@192.168.0.100:1521/xe", "user04", "user04");
	
	//기본Key를 가지고 Data 찾아오기
	PreparedStatement pstmt = con.prepareStatement("select * from member_tbl_02 where custno=?");
	pstmt.setInt(1, custno);
	
	//SQL 실행
	ResultSet rs = pstmt.executeQuery();
	
	rs.next();
	String custname = rs.getString("custname");
	String phone = rs.getString("phone");
	String address = rs.getString("address");
	String grade = rs.getString("grade");
	String city = rs.getString("city");
	Date joindate = rs.getDate("joindate");
	
	rs.close();
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

	<h2 align="center">홈쇼핑 회원 정보 수정</h2>
	<form id="updateform">
		<table align="center" border="1">
			<tr>
				<td align="center" width="250">회원번호</td>
				<td width="400"> <input type="text" value='<%=custno %>' width="300"
				name="custno" id="custno" readonly="true" />
				</td>
			</tr>
			<tr>
				<td align="center">회원성명</td>
				<td> 
				<input type="text" name="custname" id="custname" value='<%=custname %>'/>
				</td>
			</tr>
			<tr>
				<td align="center">회원전화</td>
				<td> 
				<input type="text" name="phone" id="phone" size="25" value='<%=phone %>'/>
				</td>
			</tr>
			<tr>
				<td align="center">회원주소</td>
				<td> 
				<input type="text" name="address" id="address" size="40" value='<%=address %>'/>
				</td>
			</tr>
			<tr>
				<td align="center">가입일자</td>
				<td> 
				<input type="text" name="joindate" id="joindate" value='<%=joindate %>'/>
				</td>
			</tr>			
			<tr>
				<td align="center">고객등급 [A:VIP, B:일반, C:직원]</td>
				<td> 
				<input type="text" name="grade" id="grade" value='<%=grade %>'/>
				</td>
			</tr>			
			<tr>
				<td align="center">도시코드</td>
				<td> 
				<input type="text" name="city" id="city" value='<%=city %>'/>
				</td>
			</tr>			
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="수정" id="updatebtn"/>
				<input type="button" value="조회" id="searchbtn"/>
				</td>
			</tr>			
		</table>
	</form>
	
	<script>
	
	//수정 Button을 Click하면
	document.getElementById("updatebtn")
		.addEventListener("click", function(e){
			
			//입력란 찾아오기
			//유효성 검사를 할 필요가 없으므로 register.jsp에서 복사 하였다면 if문을 지웁니다.
			
			//회원성명 입력란을 찾아오기 
			var n = document.getElementById('custname')
			//회원전화 입력란을 찾아오기
			var o = document.getElementById('phone')
			//회원주소 입력란을 찾아오기
			var p = document.getElementById('address')			
			//가입일자 입력란을 찾아오기
			var q = document.getElementById('joindate')			
			//고객등급 입력란을 찾아오기
			var r = document.getElementById('grade')			
			//도시코드 입력란을 찾아오기
			var s = document.getElementById('city')
			
			//form의 Data 전송
			//submit();을 하게 되면 화면에 변화가 생깁니다.
			//document.getElementById("registerform").submit();
			
			//form의 Data를 가지고 insert.jsp File에 ajax 요청
			//ajax 객체 생성 
			var request = new XMLHttpRequest();
			
			//전송할 URL 생성
			var url = "update.jsp?"
			//URL에 Parameter 붙이기
			url += "custno=" + document.getElementById("custno").value; // + no.value; 를 사용해도 됩니다.
			url += "&custname=" + document.getElementById("custname").value; // + n.value; 를 사용해도 됩니다.
			url += "&phone=" + document.getElementById("phone").value;	// + o.value; 를 사용해도 됩니다.
			url += "&address=" + document.getElementById("address").value;	// + p.value; 를 사용해도 됩니다.
			url += "&joindate=" + document.getElementById("joindate").value;	// + q.value; 를 사용해도 됩니다.
			url += "&grade=" + document.getElementById("grade").value;	// + r.value; 를 사용해도 됩니다.
			url += "&city=" + document.getElementById("city").value;	// + s.value; 를 사용해도 됩니다.
			
			//AJAX 요청 생성
			request.open('GET', encodeURI(url));
			request.send(' '); 

			//요청에 성공했을 때 수행할 내용 작성
			request.onreadystatechange = function(){
				if(request.readyState == 4){
					alert("회원정보수정이 완료 되었습니다!")
				}
			}	
			
		});

	//조회 Button을 Click하면
	document.getElementById("searchbtn")
		.addEventListener("click", function(e){
			//Page 이동
			location.href = "list.jsp";
		});
	
</script>	
	
</body>
</html>