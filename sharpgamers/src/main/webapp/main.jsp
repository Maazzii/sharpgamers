<%@page import="dao.GameDto"%>
<%@page import="dao.GuildDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("id") == null) {
	response.sendRedirect("login.jsp");
} else {
%>
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="guildDao" class = "dao.GuildDao" />
<jsp:useBean id="guildDto" class = "dao.GuildDto" />
<%-- jsp 주석 --%>
<!-- HTML 주석 -->
<%-- 지시어, 스크립트 요소, 내장 객체, 액션 태그, 자바 빈, 세션, 예외처리 등등 --%>
<%-- 지시어: page, include, taglib
    	** page: jsp 페이지 설정에 대한 지시
    		- language: 스크립트 요소에서 사용할 언어 지정
    		- contentType: JSP 페이지가 생성할 문서 타입과 문자셋 지정
    		- pageEncoding: jsp 페이지의 문자 인코딩 지정
    		- import: jsp페이지에 import할 패키지, 클래스 지정
    		- esxtends: 상속받을 클래스 설정
    		- session: HttpSession 사용여부 지정(기본값: true)
    		- buffer: jsp페이지의 출력 버퍼 크기 지정(기본값: 8kb)
    		- autoFlush: 자동 플러시 기능 지정 (기본값: true)
    		- isThreadSafe: 다중 스레드의 동시 실행 여부 지정(기본값: true)
    		 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	background-image: url("./images/background.png");
	margin: 0px;
}

div#wrapper {
	min-width: 700px;
	max-width: 900px;
	min-height: 75vh;
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

div#search {
	width: 100%;
}
div#buttons {
	width: fit-content;
	margin: 30px auto;
	cursor: pointer;
}
div#searchbox {
	position: relative;
	height: fit-content;
	width: fit-content;
	margin: 0px auto;
}
input.searchbox {
	width: 660px;
	margin-top: 30px;
	height: 22px;
	padding: 10px;
	font-size: 20px;
	border: 4px solid rgba(27, 165, 124, 1);
	border-radius: 10px;
	background-color: rgba(255, 255, 255, 1);
	color: gray;
}
button#search-button {
	position: absolute;
	margin-top: 30px;
	width: 50px;
	height: 50px;
	padding: 0px;
	right: 0px;
	border: 4px solid rgba(27, 165, 124, 1);
	border-radius: 0px 10px 10px 0px;
	background-color: rgba(27, 165, 124, 1);
	font-size: 20px;
}
button#search-button div {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

div.platform-button {
	float: left;
	position: relative;
	display: flex;
	margin: 20px;
	width: 118px;
	height: 118px;
	border: 1px solid lightgray;
	border-radius: 70px;
	background-color: rgba(255, 255, 255, 0.6);
	justify-content: center;
	align-items: center;
	z-index: 9;
}

div.platform-button:hover {
	width: 110px;
	height: 110px;
	border: 5px solid rgba(27, 165, 124, 1);
}

img.platform-icon {
	width: 75px;
}

img.platform-icon-switch {
	width: 70px;
}

div.show-all-games {
	height: 90px;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 0px 0px 30px 0px;
}

button.button-show-all-games {
	width: 200px;
	height: 40px;
	border: 2px solid rgba(0, 191, 134, 0.2);
	border-radius: 5px;
	background-color: rgba(0, 191, 134, 0.1);
}

button.button-show-all-games:hover {
	border: 2px solid rgba(0, 191, 134, 0.4);
}

button:hover {
	cursor: pointer;
}

div.content-wrap-wrap {
	position: relative;
	width: 100%;
	-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
	-moz-box-sizing: border-box;    /* Firefox, other Gecko */
	box-sizing: border-box;         /* Opera/IE 8+ */
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
}

div.content-wrap {
	position: relative;
	width: 45%;
	border: 1px solid lightgray;
	border-radius: 15px;
	background: rgba(255, 255, 255, 0.7);
	-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
	-moz-box-sizing: border-box;    /* Firefox, other Gecko */
	box-sizing: border-box;         /* Opera/IE 8+ */
	overflow: hidden;
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

tr.favorite-game-list > td > div, tr.guild-list > td > div {
	font-size: 14px;
}

tr:not(tr:last-child) {
	border-bottom: 1px solid lightgray;
}

tr.guild-list:hover, tr.favorite-game-list:hover {
	cursor: pointer;
	background-color: rgba(27, 165, 124, 0.2);
}

td>div {
	padding: 0px 20px;
	-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
	-moz-box-sizing: border-box;    /* Firefox, other Gecko */
	box-sizing: border-box;         /* Opera/IE 8+ */
}

div.favorite-game-title-wrapper, div.guild-name-wrapper {
	display: flex;
	align-items: center;
}

div.favorite-game-platform-wrapper, div.guild-platform-wrapper {
	margin-right: 10px;
	display: flex;
	align-items: center;
}
div.guild-game-name {
	font-size: 10px;
}
</style>
<script src="./jquery/jquery-3.6.0.min.js"></script>
<script>

	$(function() {
		$(document).on("click", ".platform-button", function() {
			$(".platform-button").css("background-color", "rgba(255, 255, 255, 0.6)")
			var platform = $(this).find("img").attr("alt");
			$("input[name=game-platform]").val(platform);
			$("input#game-name-input").attr("list", platform + "-list");
			$(this).css("background-color", "rgba(27, 165, 124, 0.5)");
		});
		

		$.ajax({
			type : "post",
			url : "game_favorite_process.jsp",
			data : "favorite=load&gameId=1",
			success : function (data) {
				favorites = data.split(",,,");
				favoriteIdxs = favorites[0].split(":");
				favoriteNames = favorites[1].split("::");
				platforms = favorites[2].split(":");
				platforms.pop();
				favoriteList = "<tr><td><div>즐겨찾는 게임</div></td></tr>";
				
				if (platforms[0] == '') {
					favoriteList += "<tr><td><div>즐겨찾는 게임이 없습니다.</div></td></tr>"
				} else {
					
					for (var i = 0; i < platforms.length; i++) {
						var location = "bbs/game_bbs.jsp?id=" + favoriteIdxs[i].trim() + "&pageNum=1";
						
						favoriteList += "<tr class='favorite-game-list'><td><div class='favorite-game-title-wrapper'><div class='favorite-game-platform-wrapper'><img src='images/" + platforms[i] + "_logo.png' height='20px'></div><div><a href='bbs/game_bbs.jsp?id=" + favoriteIdxs[i].trim() + "&pageNum=1'>" + favoriteNames[i].trim() + "</a></div></div></td></tr>"
					}
				}
				$("#favorite-games").html(favoriteList);
				
				if (platforms[0] != '') {
					for (var i = 0; i < platforms.length; i++) {
						$("tr.favorite-game-list").eq(i).attr("onclick", "location.href='bbs/game_bbs.jsp?id=" + favoriteIdxs[i].trim() + "&pageNum=1'");
					}
				}
			}
		});
	});

</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="wrapper">
		<div id="top-margin"></div>
		<div id="search">
			<form name="title" action="bbs/bbssearch.jsp">
				<input type="hidden" name="type" value="search">
				<div id="buttons">
					<div id="platform-sel-steam" class="platform-button" style="background-color: rgba(27, 165, 124, 0.5);">
						<img src="images/steam_logo.png" class="platform-icon" alt="steam">
					</div>
					<div id="platform-sel-switch" class="platform-button">
						<img src="images/switch_logo.png" class="platform-icon platform-icon-switch" alt="switch">
					</div>
					<div id="platform-sel-ps" class="platform-button">
						<img src="images/ps_logo.png" class="platform-icon" alt="ps">
					</div>
					<div id="platform-sel-xbox" class="platform-button">
						<img src="images/xbox_logo.png" class="platform-icon" alt="xbox">
					</div>
					<br>
					<input type="hidden" name="game-platform" value="steam">
				</div>
				<input type="hidden" name="pageNum" value="1">
				<div id="searchbox">
				<input class="searchbox" type="text" id="game-name-input" name="game-name" list="steam-list" autocomplete="off" required>
				
				<datalist id="steam-list">
					<%
					out.write(gameDao.getGamesList("steam"));
					%>
				</datalist>
				<datalist id="switch-list">
					<%
					out.write(gameDao.getGamesList("switch"));
					%>
				</datalist>
				<datalist id="ps-list">
					<%
					out.write(gameDao.getGamesList("ps"));
					%>
				</datalist>
				<datalist id="xbox-list">
					<%
					out.write(gameDao.getGamesList("xbox"));
					%>
				</datalist>
				<button id="search-button"><div><img src="images/search.png" width="20px" onclick="$(title).submit()"></div></button>
				<!-- input id="search-button" type="submit" -->
				</div>
			</form>
		</div>
		<div class="show-all-games">
			<button class="button-show-all-games" onclick="location.href='bbs/bbssearch.jsp?type=all'">모든 게임 보기</button>
		</div>
		<div class="content-wrap-wrap">
			<div class="content-wrap">
				<table id="favorite-games">
					<tr>
						<td><div>즐겨찾는 게임</div></td>
					</tr>
				</table>
			</div>
			<div class="content-wrap">
				<table>
					<tr>
						<td><div>내 길드</div></td>
					</tr>
					
					<%
						List<GuildDto> guildList = null;
						memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
						int guildCount = guildDao.countGuildsForMember(memberDto.getMember_idx());
						
						if (guildCount == 0) { // 1
					%>
					<tr>
						<td><div>가입한 길드가 없습니다.</div></td>
					</tr>
					<%
						} else { // 1
							guildList = guildDao.getGuildsForMember(memberDto.getMember_idx());
							
							for (int i = 0; i < guildList.size(); i++) { // 2
								gameDto = gameDao.getGameInfo(guildList.get(i).getGame_id(), gameDto);
								String platform = gameDto.getGame_Platform();
					%>
					<tr class="guild-list" onclick="location.href = 'guild/guild_main.jsp?guildId=<%=String.valueOf(guildList.get(i).getGuildId())%>'">
						<td>
							<div class='guild-name-wrapper'>
								<div class='guild-platform-wrapper'>
									<img src='images/<%=platform %>_logo.png' height='20px'>
								</div>
								<div>
									<div class='guild-name'>
										<%=guildList.get(i).getGuildName() %>
									</div>
									<div class='guild-game-name'>
										<%=gameDto.getGame_name() %>
									</div>
								</div>
							</div>
						</td>
					</tr>
					<%
								
								
							} // 2
						}
					
					%>
					
					
					
				</table>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
<% } %>