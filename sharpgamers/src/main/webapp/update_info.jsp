<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
    
<%
request.setCharacterEncoding("utf-8");
int sessionIdx = 0;
String sessionId = (String) session.getAttribute("id");
if (sessionId != null) {
	memberDto = memberDao.getMemberInfo(sessionId, memberDto);
	sessionIdx = memberDto.getMember_idx();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
<style>

	body {
		background-image: url("<%=request.getContextPath() %>/images/background.png");
		margin: 0px;
	}
		
	div#wrapper {
		min-width: 700px;
		max-width: 900px;
		min-height: 70vh;
		margin: auto;
		padding: 150px 100px 100px; 
		background : rgba( 255, 255, 255, 0.6);
		backdrop-filter: blur(10px);
		position: relative;
		box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.2);
		background: rgba(255, 255, 255, 0.6);
	}
	
	footer {
		width: 100%;
		height: 200px;
		position: absolute;
		background-color: white;
		z-index: 99;
	}
		
	input[type=button], input[type=submit], input[type=reset] {
		cursor: pointer;
	}
	button:hover {
		cursor: pointer;
	}
	
	div#game-title-wrap {
		display: flex;
		justify-content: space-between;
		position: relative;
		width: 100%;
	}
	div#game-title {
		position: relative;
		height: 40px;
		width: 100%;
	}
	h1.game-title {
		position: absolute;
		bottom: 30px; 
		margin: 20px;
	}	
	div#content-wrap {
		position: relative;
		width: 100%;
		border: 1px solid lightgray;
		border-radius: 15px;
		background: rgba(255, 255, 255, 0.7);
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
		
	table {
		width: 100%;
		border-collapse: collapse;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	
	tr {
		height: 50px;
	}
	
	tr:not(tr:last-child) {
		border-bottom: 1px solid lightgray;
	}
	
	td>div {
		padding: 0px 20px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	td:nth-child(3n-2) {
		text-align: right;
		width: 20%;
	}
	td:nth-child(3n-1) {
		border-left: 1px solid lightgray;
	}
	td:nth-child(3n) {
		width: 120px;
		text-align: right;
	}
	td:nth-child(3n) > div{
		text-align: center;
	}
	
	input[type=password] {
		width: 160px;
		height: 2em;
		font-size: 14px;
		padding: 5px;
		background-color: rgba(255, 255, 255, 0.0);
		border: 2px solid rgba(0, 191, 134, 0.4);
		border-radius: 4px;
		margin: 0px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	input[type=text], input[type=number] {
		width: 100%;
		height: 2em;
		font-size: 16px;
		background-color: rgba(255, 255, 255, 0.0);
		border: 0px;
		border-radius: 3px;
		margin: 0px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
		{
		-webkit-appearance: none;
		margin: 0;
	}
	
	tr:not(tr:first-child) > td:nth-child(3n-1) > div:last-child {
		display: none;
	}
	tr:not(tr:first-child) > td:nth-child(3n) > div:last-child {
		display: none;
	}
	
	table input[type=button] {
		width: 80px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
	}
	
	table input[type=button]:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
	
	#password-input-wrap {
		justify-content: space-between;
		align-items: center;
		font-size: 12px;
	}
	
	.outter-buttons-wrap {
		width: 100%;
		padding: 50px 0px;
		display: flex;
		justify-content: flex-end;
	}
	
	.outter-button {
		margin-left: 15px;
		height: 40px;
		width: 120.5px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
		position: relative;
	}
	
	.outter-button-reset {
		background-color: rgba(255, 255, 255, 0.2);
	}
	
	.outter-button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
	
</style>
<script src="./jquery/jquery-3.6.0.min.js"></script>
<script>

function showInput (obj) {
	var buttonTd = $(obj).parent().parent();
	var buttonDiv1 = $(buttonTd).find("div").eq(0);
	var buttonDiv2 = $(buttonTd).find("div").eq(1);
	var inputTd = $(buttonTd).prev();
	var inputDiv1 = $(inputTd).find("div").eq(0);
	var inputDiv2 = $(inputTd).find("div").eq(1);
	
	$(buttonDiv1).css("display", "none");
	$(buttonDiv2).css("display", "flex");
	$(inputDiv1).css("display", "none");
	$(inputDiv2).css("display", "flex");
}

function checkSymbols(obj) {
	var reg = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ ]/gim;
	$(obj).val($(obj).val().replaceAll(reg, ""));
}

function chkPhoneType(type, obj) {
	var input = $(obj).val();

	//focus out인 경우 
	//input type을 text로 바꾸고 '-'추가
	if (type == 'blur') {
		$(obj).prop('type', 'text');
		var phone = chkItemPhone(input);
	}

	//focus인 경우
	//input type을 number로 바꾸고 '-' 제거
	if (type == 'focus') {
		var phone = input.replace(/-/gi, '');
		$(obj).prop('type', 'number');
	}

	$(obj).val(phone);
}

function chkItemPhone(temp) {
	var number = temp.replace(/[^0-9]/g, "");
	var phone = "";

	if (number.length < 9) {
		return number;
	} else if (number.length < 10) {
		phone += number.substr(0, 2);
		phone += "-";
		phone += number.substr(2, 3);
		phone += "-";
		phone += number.substr(5);
	} else if (number.length < 11) {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 3);
		phone += "-";
		phone += number.substr(6);
	} else {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 4);
		phone += "-";
		phone += number.substr(7);
	}

	return phone;
}

function maxLengthCheck(object) {
	if (object.value.length > 11) {
		object.value = object.value.slice(0, 11);
	}
}

function updatePw() {
	var currPw = $("input[name=currPw]").val();
	var newPw1 = $("input[name=newPw1]").val();
	var newPw2 = $("input[name=newPw2]").val();
	if (currPw == '' || newPw1 == '' || newPw2 == '') {
		return;
	}
	
	$.ajax({
		type: "post",
		url: "update_info_process.jsp",
		data: "fn=pw&currPw=" + currPw + "&newPw1=" + newPw1 + "&newPw2=" + newPw2,
		success: function(data) {
			result = data.trim();
			
			if (result == 0) {
				alert('비밀번호가 변경되었습니다.');
				location.href='';
			} else if (result == 1) {
				alert('현재 비밀번호가 맞지 않습니다.');
			} else if (result == 2) {
				alert('새 비밀번호가 맞지 않습니다.')
			} else if (result == 3) {
				alert('현재 비밀번호와 다르게 설정해주세요.')
			}
		}
		
	});
}

function updateName() {
	var name = $("input[name=name]").val();

	if (name == '') {
		return;
	}
	
	$.ajax({
		type: "post",
		url: "update_info_process.jsp",
		data: "fn=name&name=" + name,
		success: function(data) {
			result = data.trim();
			
			if (result == 1) {
				alert('이미 존재하는 닉네임입니다.');
			} else if (result == 0) {
				alert('닉네임이 변경되었습니다.');
				location.href='';
			}
		}
	})
}

function updatePhone() {
	var phone = $("input[name=phone_no]").val();

	if (phone == '') {
		return;
	}
	
	$.ajax({
		type: "post",
		url: "update_info_process.jsp",
		data: "fn=phone&phone=" + phone,
		success: function(data) {
			alert('휴대폰 번호가 변경되었습니다.');
			location.href='';
		}
	});
}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="wrapper">
		<div id="game-title-wrap">
			<div id="game-title">
		<h1 class="game-title">정보 수정</h1>
			</div>
		</div>

		<div id="content-wrap">
			<div>
					<table>
						<tr>
							<td><div>이메일</div></td>
							<td>
								<div><%=memberDto.getMember_id() %></div>
								<div style="display: none;"><input type="text" name="id" value="<%=memberDto.getMember_id() %>"></div>
							</td>
							<td><div>변경 불가</div>
						</tr>
						<tr>
							<td><div>비밀번호</div></td>
							<td>
								<div></div>
								<div id="password-input-wrap">
									<div class="password-input">
										<input type="password" name="currPw" placeholder="현재 비밀번호">
									</div>
									<div class="password-input">
										<input type="password" name="newPw1" placeholder="새로운 비밀번호">
									</div>
									<div class="password-input">
										<input type="password" name="newPw2" placeholder="한 번 더 입력">
									</div>
								</div>
							</td>
							<td>
								<div><input type="button" value="변경" onclick="showInput(this)"></div>
								<div><input type="button" value="확인" onclick="updatePw()"></div>
							</td>
						</tr>
						<tr>
							<td><div>닉네임</div></td>
							<td>
								<div id="nickname-view"><%=memberDto.getMember_name() %></div>
								<div id="nickname-input">
									<input type="text" name="name" oninput="checkSymbols(this)" placeholder="입력">
								</div>
							</td>							
							<td>
								<div><input type="button" value="변경" onclick="showInput(this)"></div>
								<div><input type="button" value="확인" onclick="updateName()"></div>
							</td>
						</tr>
						<tr>
							<td><div>휴대폰 번호</div></td>
							<td>
								<div id="phone-no-view"><%=memberDto.getPhone_no() %></div>
								<div id="phone-no-input">
									<input type="number" class="join-input" name="phone_no"
										id="join-phone-input" value="" autocomplete="off"
										oninput="maxLengthCheck(this)" onfocus="chkPhoneType('focus', this)"
										onblur="chkPhoneType('blur', this)" min="0"
										placeholder="숫자만 입력" required>
								</div>
							</td>
							<td>
								<div><input type="button" value="변경" onclick="showInput(this)"></div>
								<div><input type="button" value="확인" onclick="updatePhone()"></div>
							</td>
						</tr>
					</table>
			</div>
		</div>

<div class="outter-buttons-wrap">
	<div class="buttons">
		<button class="outter-button outter-button-submit" onclick="location.href='profile.jsp?id=<%=memberDto.getMember_idx()%>'">돌아가기</button>
	</div>
	</div>

</div>
	<%@ include file="footer.jsp"%>
</body>
</html>