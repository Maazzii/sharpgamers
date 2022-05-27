<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- HTML5 적용 표시 -->
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>

<style> /* CSS 소스코드 */
body {
	background-image: url("./images/login_background.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

div.join_content {
	width: 400px;
	height: 500px;
	background: rgba(0, 0, 0, 0.6); /*네이버 색상 코드표 활용*/
	backdrop-filter: blur(10px);
	position: relative;
	margin: 10vh auto;
	border: 2px solid navy;
	border-radius: 10px;
}

div.join_field {
	margin: 10px auto;
	padding: 5px;
	width: fit-content;
}

input.join-input {
	height: 35px;
	width: 250px;
	border: 2px solid rgba(255, 255, 255, 0.2);
	border-radius: 5px;
	background-color: rgba(255, 255, 255, 0.1);
	color: lightgray;
	padding-left: 5px;
}

input.join-input:hover {
	border: 2px solid rgba(255, 255, 255, 0.4);
}

.join-button>input {
	margin: 0px 7px;
	height: 40px;
	width: 120.5px;
	border: 2px solid rgba(255, 255, 255, 0.2);
	border-radius: 5px;
	background-color: rgba(255, 255, 255, 0.1);
	color: lightgray;
}

.join-button>input:hover {
	border: 2px solid rgba(255, 255, 255, 0.4);
}

div.join-header {
	margin: 10px;
	padding-left: 20px;
}

input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>
<script src="./jquery/jquery-3.6.0.min.js"></script>
<script>
	function chkPhoneType(type) {
		var input = $("#join-phone-input").val();

		//focus out인 경우 
		//input type을 text로 바꾸고 '-'추가
		if (type == 'blur') {
			$("#join-phone-input").prop('type', 'text');
			var phone = chkItemPhone(input);
		}

		//focus인 경우
		//input type을 number로 바꾸고 '-' 제거
		if (type == 'focus') {
			var phone = input.replace(/-/gi, '');
			$("#join-phone-input").prop('type', 'number');
		}

		$("#join-phone-input").val(phone);
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
</script>
</head>

<body>

	<div class="join_content">

		<div class="join-header">회원정보를 입력해주세요</div>

		<form name="join" action="process_join.jsp" method="post">

			<div class="join_field">
				<input type="email" class="join-input" name="member_id"
					id="join-email-input" value="" maxlength="80"
					placeholder="아이디(이메일)" required />
			</div>

			<div class="join_field">
				<input type="password" class="join-input" name="member_pw1"
					id="join-password-input" value="" maxlength="20" placeholder="비밀번호"
					required>
			</div>

			<div class="join_field">
				<input type="password" class="join-input" name="member_pw2"
					id="verify-join-password-input" value="" maxlength="20"
					placeholder="비밀번호 확인" required>
			</div>

			<div class="join_field">
				<input type="Name" class="join-input" name="member_name"
					id="join-name-input" maxlength="40" value="" placeholder="이름"
					required>
			</div>

			<div class="join_field">
				<input type="number" class="join-input" name="phone_no"
					id="join-phone-input" value="" autocomplete="off"
					oninput="maxLengthCheck(this)" onfocus="chkPhoneType('focus')"
					onblur="chkPhoneType('blur')" min="0" placeholder="휴대폰 번호 (숫자만 입력)"
					required>
			</div>

			<div class="join_field">
				<span class="join-button"> <input type="submit"
					class="join-button-submit" value="가입하기"> <input
					type="reset" class="join-button-reset" value="취소하기">
				</span>
			</div>
		</form>
	</div>

</body>
</html>
