<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background-image: url("./images/background.png");
	}

div.wrap {
	display: flex;
	min-height: 95vh;
	justify-content: center;
	align-items: center;
}

div.login_content {
	width: 400px;
	height: 500px;
	background: rgba(255, 255, 255, 0.6); 
	backdrop-filter: blur(10px);
	position: relative;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.2);	
}
input[type=button], input[type=submit], input[type=reset], button:hover {
	cursor: pointer;
}

form[name=login] {
	margin-bottom: 200px;
}

@keyframes slideintofindpw {
from {
 left:-455px;
	
}

to {
	left: -25px;
}
}

@keyframes slideoutfromfindpw {
from { 
left:-25px;
	
}

to {
	left: -455px;
}
}

@keyframes slideintojoin {
from {
 left:-455px;
	
}

to {
	left: -885px;
}

}
@keyframes slideoutfromjoin {
from {
 left:-885px;
	
}

to {
	left: -455px;
}

}
div.animation_wrap {
	position: absolute;
	width: 1500px;
	left: -455px;
	animation-duration: 0.5s;
}

div.login_section {
	position: relative;
	width: 400px;
	bottom: 30px;
	display: inline-block;
}

div.join_section {
	position: relative;
	width: 450px;
	visibility: hidden;
	display: inline-block;
}

div.findpw_section {
	position: relative;
	width: 450px;
	bottom: 100px;
	visibility: hidden;
	display: inline-block;
}

div.logo {
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	bottom: 20px;
}
img.logo {
	width: 250px;
}

div.login_field {
	margin: 10px auto;
	padding: 5px;
	width: fit-content;
}

input.login-input {
	height: 35px;
	width: 250px;
	border: 2px solid rgba(113, 156, 143, 0.2);
	border-radius: 5px;
	background-color: rgba(113, 156, 143, 0.1);
	color: gray;
	padding-left: 5px;
}

input.login-input:hover {
	border: 2px solid rgba(113, 156, 143, 0.4);
}

.login-button1>input {
	height: 40px;
	width: 260.5px;
	border: 2px solid rgba(0, 191, 134, 0.2);
	border-radius: 5px;
	background-color: rgba(0, 191, 134, 0.1);
	color: gray;
	height: 40px;
}

.login-button1>input:hover {
	border: 2px solid rgba(0, 191, 134, 0.4);
}

.login-button>input {
	margin: 0px 7px;
	height: 40px;
	width: 120.5px;
	border: 2px solid rgba(0, 191, 134, 0.2);
	border-radius: 5px;
	background-color: rgba(0, 191, 134, 0.1);
	color: gray;
	height: 40px;
}

.login-button>input:hover {
	border: 2px solid rgba(0, 191, 134, 0.4);
}

div.login-header {
	margin: 10px;
	padding-left: 20px;
}

div.join_arrowwrap {
	position: absolute;
	width: 30px;
	height: 30px;
	left: 905px;
	top: 235px;
	z-index: 99;
	cursor: pointer;
}

div.join_arrow {
	transform: rotate(45deg);
	width: 10px;
	height: 10px;
	margin: 10px auto;
	border-left: 3px solid gray;
	border-bottom: 3px solid gray;
	border-radius: 2px;
}

div.findpw_arrowwrap {
	position: absolute;
	width: 30px;
	height: 30px;
	left: 375px;
	top: 235px;
	z-index: 99;
	cursor: pointer;
}

div.findpw_arrow {
	transform: rotate(225deg);
	width: 10px;
	height: 10px;
	margin: 10px auto;
	border-left: 3px solid gray;
	border-bottom: 3px solid gray;
	border-radius: 2px;
}

div.join_field {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 10px auto;
	padding: 5px;
	width: 271px;
	height: 41px;
	overflow: 
}

input.join-input {

	height: 35px;
	width: 100%;
	border: 2px solid rgba(113, 156, 143, 0.2);
	border-radius: 5px;
	background-color: rgba(113, 156, 143, 0.1);
	color: gray;
	padding-left: 5px;
}

input.join-input:hover {
	border: 2px solid rgba(113, 156, 143, 0.4);
}

input.narrow {
	width: 204px;
}

.join-button {
	margin: 0px;
	height: 41px;
	width: 126px;
	border: 2px solid rgba(0, 191, 134, 0.2);
	border-radius: 5px;
	background-color: rgba(0, 191, 134, 0.1);
	color: gray;
}

.join-button:hover {
	border: 2px solid rgba(0, 191, 134, 0.4);
}

.findpw-button {
	margin: 0px;
	height: 41px;
	width: 100%;
	border: 2px solid rgba(0, 191, 134, 0.2);
	border-radius: 5px;
	background-color: rgba(0, 191, 134, 0.1);
	color: gray;
}

.findpw-button:hover {
	border: 2px solid rgba(0, 191, 134, 0.4);
}

div.join-header {
	margin: 10px;
	color: gray;
	text-align: center;
	font-size: 20px;
	margin-top: 50px;
}

input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

.join-input-button {
	height: 42px;
	width: 42px;
	border: 2px solid rgba(113, 156, 143, 0.2);
	border-radius: 5px;
	background-color: rgba(113, 156, 143, 0.1);
	color: gray;
	position: relative;
}
.join-input-button:hover {
	border: 2px solid rgba(113, 156, 143, 0.4);
}

div.copyright {
	position: fixed;
	bottom: 5px;
	left: 5px;
	width: fit-content;
	font-size: 10px;
	background: rgba(255, 255, 255, 0.6); /*네이버 색상 코드표 활용*/
	backdrop-filter: blur(10px);
	border-radius: 5px;
	padding: 5px;
	z-index: -99;
}

div.copyright>a {
	text-decoration: none;
	color: gray;
	z-index: -98;
}
</style>

<script src="./jquery/jquery-3.6.0.min.js"></script>
<script>


	function slideInToFindPw() {
		$(".findpw_section").css("visibility", "visible");
		$(".animation_wrap").css("left", "-25px");
		$(".animation_wrap").css("animation-name", "slideintofindpw");
		setTimeout(() => {
			$(".login_section").css("visibility", "hidden");
		}, 500);
	}
	
	function slideOutFromFindPw() {
		$(".login_section").css("visibility", "visible");
		$(".animation_wrap").css("left", "-455px");
		$(".animation_wrap").css("animation-name", "slideoutfromfindpw");
		setTimeout(() => {
			$(".findpw_section").css("visibility", "hidden");
		}, 500);
	}

	function slideInToJoin() {
		$(".join_section").css("visibility", "visible");
		$(".animation_wrap").css("left", "-885px");
		$(".animation_wrap").css("animation-name", "slideintojoin");
		setTimeout(() => {
			$(".login_section").css("visibility", "hidden");
		}, 500);
	}
	
	function slideOutFromJoin() {
		$(".login_section").css("visibility", "visible");
		$(".animation_wrap").css("left", "-455px");
		$(".animation_wrap").css("animation-name", "slideoutfromjoin");
		setTimeout(() => {
			$(".join_section").css("visibility", "hidden");
		}, 500);
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
	
	function loginFn() {
		$.ajax({
			type : "post",
			url : "process_login.jsp",
			data : $("form[name=login]").serialize(),
			success : function (data) {
				console.log(data);
				if (data.trim() == '0') {
					location.href="main.jsp";
				} else {
					alert("회원정보가 올바르지 않습니다.");
				}
			}
		});
	}
	
	var idChecked = false;
	var pwChecked = false;
	var nameChecked = false;
	
	function requireIdCheck(input) {
		idChecked = false;
		$(input).next().css("border-color", "rgba(255, 0, 0, 0.4)");
		$(input).next().css("background-color", "rgba(255, 0, 0, 0.1)");
	}

	function requireNameCheck(input) {
		nameChecked = false;
		$(input).next().css("border-color", "rgba(255, 0, 0, 0.4)");
		$(input).next().css("background-color", "rgba(255, 0, 0, 0.1)");
	}
	
	function idCheck() {
		var id = $("#join-email-input");
		var regExp = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;
		if ($(id).val() != '') {
			if(!regExp.test(id.val())) {
				alert('올바른 형식의 이메일을 입력해주세요.');
			} else {
				$.ajax({
					type : "post",
					url : "idcheck.jsp",
					data : "check=id&value=" + id.val(),
					success : function (data) {
						if (data.trim() == 0) {
							alert('사용가능한 이메일입니다.');
							idChecked = true;
							$("#idcheck-button").css("border-color", "rgba(113, 156, 143, 0.2)");
							$("#idcheck-button").css("background-color", "rgba(113, 156, 143, 0.1)");
						} else {
							alert('이미 존재하는 이메일입니다.');
						}
					}
				});
			}
			
			
		} else {
			alert('이메일을 입력해 주세요.');
		}
	}
	
	function checkSymbols(obj) {
		var reg = /[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/ ]/gim;
		$(obj).val($(obj).val().replaceAll(reg, ""));
	}

	function nameCheck() {
		var name = $("#join-name-input");
		if ($(name).val() != '') {
			$.ajax({
				type : "post",
				url : "idcheck.jsp",
				data : "check=name&value=" + name.val(),
				success : function (data) {
					if (data.trim() == 0) {
						alert('사용가능한 닉네임입니다.');
						nameChecked = true;
						$("#namecheck-button").css("border-color", "rgba(113, 156, 143, 0.2)");
						$("#namecheck-button").css("background-color", "rgba(113, 156, 143, 0.1)");
					} else {
						alert('이미 존재하는 닉네임입니다.');
					}
				}
			})
		} else {
			alert('닉네임을 입력해 주세요.');
		}
	}
	
	function chkPw() {
		var pwReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;

		pwChecked = false;
		if($("#pw1").val() == $("#pw2").val() && pwReg.test($("#pw1").val())) {
			pwChecked = true;
			$("#pw1").css("border-color", "rgba(113, 156, 143, 0.2)");
			$("#pw1").css("background-color", "rgba(113, 156, 143, 0.1)");
			$("#pw2").css("border-color", "rgba(113, 156, 143, 0.2)");
			$("#pw2").css("background-color", "rgba(113, 156, 143, 0.1)");
		} else {
			if($("#pw2").val() != '') {
				$("#pw1").css("border-color", "rgba(255, 0, 0, 0.2)");
				$("#pw1").css("background-color", "rgba(255, 0, 0, 0.4)");
				$("#pw2").css("border-color", "rgba(255, 0, 0, 0.2)");
				$("#pw2").css("background-color", "rgba(255, 0, 0, 0.4)");
			}
		}
	}
	
	function sendPwMail() {
		var param = $("form[name=findpw]").serialize();
		var button = $("#findpw-button");
		$(button).attr("disabled", true);
		$(button).val("메일을 보내는 중...");
		$.ajax({
			type : "post",
			url : "mailServicePw",
			data : param,
			success : function (data) {
				var result = data.trim();
				if (result == 0) {
					alert("임시 비밀번호를 메일로 보냈습니다.");
				} else if (result == 1) {
					alert("해당 이메일로 가입한 회원이 없습니다.");
				} else if (result == 2) {
					alert("휴대폰 번호가 맞지 않습니다.");
				} else if (result == 3) {
					alert("메일을 보내는 중 오류가 발생했습니다.");
				}
				$(button).attr("disabled", false);
				$(button).val("임시 비밀번호 보내기");
			}
		});
	}
	
	function joinFn() {
		if (idChecked && pwChecked && nameChecked) {
			$("form[name=join]").submit();
		}
	}
</script>
</head>
<body>
	<div class="wrap">
		<div class="login_content">
			<div class="animation_wrap">
				<div class="findpw_section">
					<div class="join-header">비밀번호 찾기</div>

					<form name="findpw" action="process_join.jsp" method="post">

						<div class="join_field">
							<input type="email" class="join-input" name="member_id" value=""
								maxlength="80" placeholder="아이디(이메일)" required />
						</div>

						<div class="join_field">
							<input type="number" class="join-input" name="phone_no"
								id="findpw-phone-input" value="" autocomplete="off"
								oninput="maxLengthCheck(this)" onfocus="chkPhoneType('focus', this)"
								onblur="chkPhoneType('blur', this)" min="0"
								placeholder="휴대폰 번호 (숫자만 입력)" required>
						</div>
							<div class="join_field"> <input type="button" id="findpw-button"
								class="findpw-button" onclick="sendPwMail()" value="임시 비밀번호 보내기">
						</div>
						
					</form>
				</div>
				<div class="login_section">
					
					<div class="logo"><img class="logo" src="images/logo.png"></div>
					<form name="login" action="process_login.jsp" method="post">

						<div class="login_field">
							<input type="email" class="login-input" name="member_id"
								id="login-email-input" value="" maxlength="80"
								placeholder="아이디(이메일)" />
						</div>

						<div class="login_field">
							<input type="password" class="login-input" name="member_pw"
								id="login-password-input" value="" maxlength="20"
								placeholder="비밀번호">
						</div>

						<div class="login_field">
							<span class="login-button1"> <input type="submit"
								class="login-button-submit" onclick="loginFn()" value="로그인">
							</span>
						</div>

						<div class="login_field">
							<span class="login-button"> <input type="button"
								class="login-button-submit" onclick="slideInToFindPw()"
								value="비밀번호 찾기">
							<!--  <input
							type="button" class="login-button-join" value="회원가입"
							onclick="location.href='join.jsp'">  -->
								<input type="button" class="login-button-join" value="회원가입"
								onclick="slideInToJoin()">
							</span>
						</div>
					</form>
				</div>
				<div class="join_section">


					<div class="join-header">회원가입</div>

					<form name="join" action="process_join.jsp" method="post">

						<div class="join_field">
							<input type="email" class="join-input narrow" name="member_id"
								id="join-email-input" value="" maxlength="80"
								placeholder="아이디(이메일)" onchange="requireIdCheck(this)" required />
							<input type="button" id="idcheck-button" class="join-input-button" onclick="idCheck()" value="체크">
						</div>

						<div class="join_field">
							<input type="password" class="join-input" id="pw1" name="member_pw1"
								id="join-password-input" value="" maxlength="20"
								placeholder="비밀번호 (문자+숫자+기호 포함 8자 이상)" onchange="chkPw()" required>
						</div>

						<div class="join_field">
							<input type="password" class="join-input" id="pw2" name="member_pw2"
								id="verify-join-password-input" value="" maxlength="20"
								placeholder="비밀번호 확인" onchange="chkPw()" required>
						</div>

						<div class="join_field">
							<input type="Name" class="join-input narrow" name="member_name"
								id="join-name-input" maxlength="40" value="" oninput="checkSymbols(this)" onchange="requireNameCheck(this)" placeholder="닉네임"
								required>
							<input type="button" id="namecheck-button" class="join-input-button" onclick="nameCheck()" value="체크">
						</div>

						<div class="join_field">
							<input type="number" class="join-input" name="phone_no"
								id="join-phone-input" value="" autocomplete="off"
								oninput="maxLengthCheck(this)" onfocus="chkPhoneType('focus', this)"
								onblur="chkPhoneType('blur', this)" min="0"
								placeholder="휴대폰 번호 (숫자만 입력)" required>
						</div>

						<div class="join_field"> <input type="button"
								class="join-button" value="가입하기" onclick="joinFn()"> <input
								type="reset" class="join-button" value="다시입력">
						</div>
					</form>
				</div>

				<div class="join_arrowwrap" onclick="slideOutFromJoin()">
					<div class="join_arrow"></div>
				</div>
				<div class="findpw_arrowwrap" onclick="slideOutFromFindPw()">
					<div class="findpw_arrow"></div>
				</div>
			</div>
		</div>
		<div class=copyright>
			<a href="https://www.vecteezy.com/free-vector/video-game">Video Game Vectors by Vecteezy</a>
		</div>
	</div>
</body>
</html>