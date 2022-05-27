<%@page import="java.util.ArrayList"%>
<%@page import="dao.GameDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
    
<%
request.setCharacterEncoding("UTF-8");
String platform = request.getParameter("game-platform");
String gameName = request.getParameter("game-name");
String type = request.getParameter("type");
List<GameDto> gameList = new ArrayList<GameDto>();
List<GameDto> steamGameList = new ArrayList<GameDto>();
List<GameDto> switchGameList = new ArrayList<GameDto>();
List<GameDto> psGameList = new ArrayList<GameDto>();
List<GameDto> xboxGameList = new ArrayList<GameDto>();

String title = "";

if (type.equals("all")) {
	title = "모든 게임 목록";
	gameList = gameDao.getAllGames();
	
} else if (type.equals("search")) {
	title = gameName + " 검색 결과";
	if (platform != null && gameName != null) {
		gameDto = gameDao.getGameInfo(platform, gameName, gameDto);
	} else {
		response.sendRedirect("main.jsp");
	}
	int game_id = gameDto.getGame_id();
	
	if (game_id != 0) {
		String url = "game_bbs.jsp?id=" + game_id + "&pageNum=1";
		response.sendRedirect(url);
	}
	
	gameList = gameDao.searchGames(gameName);
}

steamGameList = 
	gameList.stream().filter(dto -> dto.getGame_Platform().equals("steam")).collect(Collectors.toList());
switchGameList =
	gameList.stream().filter(dto -> dto.getGame_Platform().equals("switch")).collect(Collectors.toList());
psGameList =
	gameList.stream().filter(dto -> dto.getGame_Platform().equals("ps")).collect(Collectors.toList());
xboxGameList =
	gameList.stream().filter(dto -> dto.getGame_Platform().equals("xbox")).collect(Collectors.toList());
		%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=title %></title>
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
	
	summary:hover {
		cursor: pointer;
	}
	
	#content-wrap > details {
		font-size: 20px;
		padding: 20px;
	}
	
	ul.game-name {
		font-size: 16px;
		list-style: none;
	}
	li {
		min-height: 2em;
	}
	li a {
		text-decoration: none;
		color: black;
	}
		
</style>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div id="wrapper">
	
		<div id="game-title-wrap">
			<div id="game-title">
		<h1><%=title %></h1>
			</div>
			<div id="buttons">
				<input type="button" style="visibility: hidden;">
			</div>
		</div>
		
		<div id="content-wrap">
			<details id="steam-list">
				<summary>Steam (<%=steamGameList.size() %>)</summary>
				<ul class="game-name">
				<%
				for (int i = 0; i < steamGameList.size(); i++) {
				%>
					<li><a href="game_bbs.jsp?id=<%=steamGameList.get(i).getGame_id()%>&pageNum=1"><%=steamGameList.get(i).getGame_name() %></a></li>
				<%
				}
				%>
				</ul>
			</details>
			<details id="switch-list">
				<summary>Nintendo Switch (<%=switchGameList.size() %>)</summary>
				<ul class="game-name">
				<%
				for (int i = 0; i < switchGameList.size(); i++) {
				%>
					<li><a href="game_bbs.jsp?id=<%=switchGameList.get(i).getGame_id()%>&pageNum=1"><%=switchGameList.get(i).getGame_name() %></a></li>
				<%
				}
				%>
				</ul>
			</details>
			<details id="ps-list">
				<summary>Playstation (<%=psGameList.size() %>)</summary>
				<ul class="game-name">
				<%
				for (int i = 0; i < psGameList.size(); i++) {
				%>
					<li><a href="game_bbs.jsp?id=<%=psGameList.get(i).getGame_id()%>&pageNum=1"><%=psGameList.get(i).getGame_name() %></a></li>
				<%
				}
				%>
				</ul>
			</details>
			<details id="xbox-list">
				<summary>Xbox (<%=xboxGameList.size() %>)</summary>
				<ul class="game-name">
				<%
				for (int i = 0; i < xboxGameList.size(); i++) {
				%>
					<li><a href="game_bbs.jsp?id=<%=xboxGameList.get(i).getGame_id()%>&pageNum=1"><%=xboxGameList.get(i).getGame_name() %></a></li>
				<%
				}
				%>
				</ul>
			</details>
		</div>
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>