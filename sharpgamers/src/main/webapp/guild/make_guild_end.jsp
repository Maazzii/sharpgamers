<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String gameId = request.getParameter("gameId");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>길드 생성 완료</title>
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
	<%@ include file="../../../header.jsp"%>
	<div id="wrapper">
	<div id="message">
	
		<h3>길드가 생성되었습니다.</h3><br>
		<a href="guild_list.jsp?gameId=<%=gameId %>"><button>길드 목록</button></a>
	</div>
	</div>
	<%@ include file="../../../footer.jsp"%>
</body>
</html>