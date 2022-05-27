<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 스크립트릿: _jspService() 메소드 내에서 실행되는 자바 소스 코드
	request.setCharacterEncoding("UTF-8");
	%>

	<jsp:useBean id="dto" class="dao.MemberDto" />
	<jsp:setProperty name="dto" property="*" />
	<jsp:useBean id="dao" class="dao.MemberDao" />

	<%
	String member_pw1 = request.getParameter("member_pw1");
	String member_pw2 = request.getParameter("member_pw2");

	// 비밀번호 일치 여부 확인
	if (member_pw1.equals(member_pw2)) {
		dto.setMember_pw(member_pw1);
		int result = dao.joinMember(dto);
		if (result == 1) {
%>
<style>
	body {
		background-image: url("<%=request.getContextPath()%>/images/background.png");
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
	
	input[type=button], input[type=submit], input[type=reset], button:hover {
		cursor: pointer;
	}
	
	button {
		margin-left: 15px;
		height: 40px;
		width: 100px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
		position: relative;
	}
	
	button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
	
	#message {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="wrapper">
	<div id="message">
	
		<h3>회원가입이 완료되었습니다.</h3><br>
		<a href="login.jsp"><button>로그인</button></a>
	</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
<%
		}
	} else {
		out.println("<script>alert('회원정보 입력 실패.')</script>");
		out.println("<script>history.back()</script>");
	}
	%>