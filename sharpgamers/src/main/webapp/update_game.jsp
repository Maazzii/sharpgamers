<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:useBean id="memberDao" class="dao.MemberDao" />
	<jsp:useBean id="memberDto" class="dao.MemberDto" />
	<jsp:useBean id="gameDao" class="dao.GameDao" />
	<jsp:useBean id="gameDto" class="dao.GameDto" />

<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("id") == null) {
		response.sendRedirect("login.jsp");
	} else {
		memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
		if (memberDto.getMember_auth() != 2) {
			out.write("<script>alert('접근 권한이 없습니다.')</script>");
			out.write("<script>history.back()</script>");
		} else {
			gameDto = gameDao.getGameInfo(Integer.parseInt(request.getParameter("gameId")), gameDto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
	div#game-title-wrap {
		display: flex;
		justify-content: space-between;
		position: relative;
		width: 100%;
	}
	div#game-title {
		position: relative;
		width: 100%;
	}
	
	h1 {
		position: absolute;
		bottom: 30px; 
		margin: 20px;
		z-index: 9;
	}
	
	div.buttons {
		position: relative;
		display: flex;
		align-items: flex-end;
	}
	
	.title-button {
		margin-left: 15px;
		height: 40px;
		width: 100px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
		position: relative;
		bottom: 50px;
	}
	
	.title-button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
	
	div.content-wrap {
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
	
	table a {
		text-decoration: none;
		color: black;
	}
	
	tr {
		height: 50px;
	}
	
	tr:not(tr:last-child) {
		border-bottom: 1px solid lightgray;
	}
	
	td:nth-child(2n) {
		border-left: 1px solid lightgray;
		width: 75%;
	}
	
	td>div {
		padding: 0px 20px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	td.title-wrap {
		height: 80px;
	}
	
	div.title {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 5px;
	}
	div.title-desc {
		font-size: 14px;
	}
	
	div.platform {
		display: flex;
		align-items: center;
	}
	
	label.platform-wrap {
		display: flex;
		justify-content: center;
		align-items: center;
		margin-right: 20px;
	}
	
	label.platform-wrap input {
		margin-left: 0px;
	}
	
	input[type=text] {
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
	.outter-buttons-wrap {
		width: 100%;
		padding: 50px 0px;
		display: flex;
		justify-content: flex-end;
	}
	
	.outter-button {
		margin-left: 15px;
		height: 40px;
		width: 100px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
		position: relative;
	}
	
	.outter-button-reset {
		background-color: rgba(255, 255, 255, 0.1);
	}
	
	
	.outter-button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
</style>
<script src="<%=request.getContextPath() %>/jquery/jquery-3.6.0.min.js"></script>
<script>
	$(function() {
		console.log("<%=gameDto.getGame_Platform()%>")
		$("input[value=<%=gameDto.getGame_Platform()%>]").prop("checked", true);
		$("input[name=name]").val("<%=gameDto.getGame_name()%>");
		$("input[name=imgSrc]").val("<%=gameDto.getGame_img_src()%>");
		$("input[name=link]").val("<%=gameDto.getGame_link()%>");
	});
	
	function removeGame() {
		if (confirm("게임 게시판과 모든 게시물이 삭제되며 되돌릴 수 없습니다.\r\n계속하시겠습니까?")) {
			location.href="delete_game.jsp?gameId=<%=gameDto.getGame_id()%>";
		}
	}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="wrapper">
		<div id="game-title-wrap">
			<div id="game-title">
			
		<h1>게임 정보 수정</h1>
			</div>
			<div class="buttons">
				<input class="title-button" type="button" style="visibility: hidden">
			</div>
		</div>
		
	<div id="add-game">
		<form name="update-game" action="update_game_process.jsp" method="post">
			<input type="hidden" name="gameId" value="<%=gameDto.getGame_id()%>">
			<div class="content-wrap">
					<table>
						<tr>
							<td class="title-wrap" colspan=2>
								<div class="title">
									게임 정보 수정
								</div>
								<div class="title-desc">
									상점 페이지에 등록된 내용을 그대로 입력해 주세요.
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									플랫폼
								</div>
							</td>
							<td>
								<div class="platform">
									<label class="platform-wrap"><input type="radio" name="platform" value="steam" required>Steam</label>
									<label class="platform-wrap"><input type="radio" name="platform" value="switch">Nintendo Switch</label>
									<label class="platform-wrap"><input type="radio" name="platform" value="ps">Playstation</label>
									<label class="platform-wrap"><input type="radio" name="platform" value="xbox">Xbox</label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									이름
								</div>
							</td>
							<td>
								<div>
									<input type="text" class="game-title-input" name="name" placeholder="입력" required>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									헤더 이미지 링크
								</div>
							</td>
							<td>
								<div>
									<input type="text" class="game-header-input" name="imgSrc" placeholder="입력" required>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div>
									상점 페이지 링크
								</div>
							</td>
							<td>
								<div>
									<input type="text" class="game-link-input" name="link" placeholder="입력" required>
								</div>
							</td>
						</tr>
					</table>
			</div>
			<div class="outter-buttons-wrap">
				<div class="buttons">
					<input type="reset" class="outter-button outter-button-reset" value="다시쓰기">
					<input type="button" class="outter-button" value="게임 삭제" onclick="removeGame()">
					<input type="submit" class="outter-button" value="수정">
				</div>
			</div>
		</form>
	</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
<%
		}
	}
%>