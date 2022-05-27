<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />

<%
request.setCharacterEncoding("utf-8");
String gameIdStr = request.getParameter("gameId");
int gameId = 0;
int sessionIdx = 0;
if (gameIdStr != null) {
	gameId = Integer.parseInt(gameIdStr);
}
String sessionId = (String) session.getAttribute("id");
if (sessionId != null) {
	memberDto = memberDao.getMemberInfo(sessionId, memberDto);
	sessionIdx = memberDto.getMember_idx();
} 

if (memberDto.getMember_auth() == 1) {
	out.write("<script>alert('권한이 없습니다.')</script>");
	out.write("<script>history.back()</script>");
} else {

if (gameId != 0 && sessionIdx != 0) {
	gameDto = gameDao.getGameInfo(gameId, gameDto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	body {
		background-image: url("../images/background.png");
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
	
	div#game-title-wrap {
		display: flex;
		justify-content: space-between;
		position: relative;
		width: 100%;
		height: 200px;
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
	div#img-wrap {
		position: absolute;
		left: 0px;
	}
	img#game-cover {
		height: 200px;
		border-radius: 15px;
	  -webkit-mask-image: linear-gradient(to top, transparent 30%, black 100%);
	  mask-image: linear-gradient(to top, transparent 30%, black 100%);*/
		z-index: 8;
	}
		
	div.game-logo-wrap {
		position: absolute;
		right: 0px;
		z-index: 10;
		display: flex;
		justify-content: flex-end;
		align-items: center;
	}
	
	div.game-logo {
		display: flex;
		align-items: center;
	}
	
	div#buttons {
		position: relative;
		display: flex;
		justify-content: space-between;
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
	
	input[name=guildName] {
		width: 100%;
		font-size: 18px;
		background-color: rgba(255, 255, 255, 0.0);
		border: 0px;
		border-radius: 3px;
		margin: 20px 0px;
		padding: 10px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	textarea {
		resize: none;
		width: 100%;
		min-height: 150px;
		background-color: rgba(255, 255, 255, 0.0);
		border: 0px;
		border-radius: 3px;
		margin: 20px 0px;
		padding: 10px;
		font-size: 16px;
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
	
	.outter-button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
</style>
<script src="<%=request.getContextPath() %>/jquery/jquery-3.6.0.min.js"></script>
<script>
function formReset() {
	$(makeGuildForm)[0].reset();
}
</script>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div id="wrapper">
	
		<div id="game-title-wrap">
			<div id="game-title">
		<h1>길드 만들기</h1>
			</div>
			<div class="game-logo-wrap">
				<div class="game-logo">
					<img src="<%=request.getContextPath() %>/images/<%=gameDto.getGame_Platform() %>_logo.png" width="50px">
				</div>
			</div>
			<div id="buttons">
			</div>
		<div id="img-wrap">
		<img id="game-cover" src="<%=gameDto.getGame_img_src()%>">
		</div>
		</div>
		
		<div id="content-wrap">
			<form method="post" action="make_guild_process.jsp" name="makeGuildForm" id="make-guild-form">
				<input type="hidden" name="gameId" value="<%=gameId%>">
				<table>
					<tr>
						<td>
							<div>
								<input type="text" name="guildName" placeholder="길드명" required/>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div>
								<textarea name="guildDesc" placeholder="길드 설명"></textarea>
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		
	<div class="outter-buttons-wrap">
		<div class="buttons">
			<button class="outter-button outter-button-reset" onclick="formReset()">다시쓰기</button>
			<button class="outter-button" onclick="javascript: $(makeGuildForm).submit()">등록</button>
		</div>
	</div>
	
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
}
%>