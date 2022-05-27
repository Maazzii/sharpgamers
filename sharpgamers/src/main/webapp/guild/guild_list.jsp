<%@page import="dao.MemberDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.GuildDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />

<%
	request.setCharacterEncoding("utf-8");
	String gameIdStr = request.getParameter("gameId");
	int gameId = 0;
	if (gameIdStr != null) {
		gameId = Integer.parseInt(gameIdStr);		
	}
	int guildCount = guildDao.countGuildsForGame(gameId);
	String guildCountStr = String.valueOf(guildCount);
	gameDto = gameDao.getGameInfo(gameId, gameDto);
	
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
	
	div.guild-count-wrap {
		margin-right: 10px;
		text-align: right;
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
		cursor: pointer;
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
	
	
	tr:not(tr:last-child) {
		border-bottom: 1px solid lightgray;
	}
	
	td {
		width: 50%;
	}
	td:nth-child(2n) {
		border-left: 1px solid lightgray;
	}
	
	td.guilds:hover {
		cursor: pointer;
		background-color: rgba(0, 191, 134, 0.2);
	}

	td>div {
		padding: 20px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	div.guild-title {
	font-size: 18px;
	}
	
	div.guild-master-wrap {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 14px;
	}
	div.guild-desc {
		margin: 5px 0px;
		height: 65px;
		overflow: hidden;
	}
</style>

<script src="<%=request.getContextPath() %>/jquery/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="../../header.jsp"%>
	<div id="wrapper">
	
		<div id="game-title-wrap">
			<div id="game-title">
		<h1>길드 목록</h1>
			</div>
			<div class="game-logo-wrap">
				<div class="guild-count-wrap">
						<div class="guild-count">전체 <%=guildCountStr %>개</div>
				</div>
				<div class="game-logo">
					<img src="<%=request.getContextPath() %>/images/<%=gameDto.getGame_Platform() %>_logo.png" width="50px">
				</div>
			</div>
			<div id="buttons">
				<input class="title-button" type="button" value="게임 게시판" onclick="location.href='<%=request.getContextPath()%>/bbs/game_bbs.jsp?id=<%=gameId%>&pageNum=1'">
				<input class="title-button" type="button" value="길드 만들기" onclick="location.href='make_guild.jsp?gameId=<%=gameId%>'">
			</div>
		<div id="img-wrap">
		<img id="game-cover" src="<%=gameDto.getGame_img_src()%>">
		</div>
		</div>
	
	<%
		List<GuildDto> guildList = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if (guildCount > 0) {
			guildList = guildDao.getGuildsForGame(gameId);
		}
	%>
		<div id="content-wrap">
			<table>
			<%
				if (guildList == null) {
			%>
				<tr>
					<td><div>등록된 길드가 없습니다.</div></td>
				</tr>
			<%
				} else {
				
				for (int i = 0; i < guildList.size(); i += 2) {
					String guildMaster = memberDao.getMemberInfo(guildList.get(i).getGuildMasterIdx(), memberDto).getMember_name();
					List<MemberDto> memberList = guildDao.getMemberList(guildList.get(i).getGuildId());
					if (guildList.get(i).getGuildDesc() == null) {
						guildList.get(i).setGuildDesc("");
					}
				%>
				<tr>
					<td class="guilds" onclick="location.href='guild_main.jsp?guildId=<%=guildList.get(i).getGuildId()%>'">
						<div class='guild-wrap'>
							<div class='guild-title'><b><%=guildList.get(i).getGuildName() %></b></div>
							<div class='guild-desc'><%=guildList.get(i).getGuildDesc() %></div>
							<div class='guild-master-wrap'>
								<div class='guild-master'>마스터 <b><%=guildMaster %></b></div>
								<div class='guild-reg-date'>멤버 <b><%=memberList.size() %></b> 등록일 <%=sdf.format(guildList.get(i).getGuildRegDate()) %></div>
							</div>
						</div>
					</td>
					<%
					if (i == guildList.size() - 1) {
						%>
						<td>
							<div></div>
						</td>
						<%
					} else {
						guildMaster = memberDao.getMemberInfo(guildList.get(i + 1).getGuildMasterIdx(), memberDto).getMember_name();
						memberList = guildDao.getMemberList(guildList.get(i + 1).getGuildId());
						if (guildList.get(i + 1).getGuildDesc() == null) {
							guildList.get(i + 1).setGuildDesc("");
						}
						%>
						<td class="guilds" onclick="location.href='guild_main.jsp?guildId=<%=guildList.get(i + 1).getGuildId()%>'">
						<div class='guild-wrap'>
							<div class='guild-title'><b><%=guildList.get(i + 1).getGuildName() %></b></div>
							<div class='guild-desc'><%=guildList.get(i + 1).getGuildDesc() %></div>
							<div class='guild-master-wrap'>
								<div class='guild-master'>마스터 <b><%=guildMaster %></b></div>
								<div class='guild-reg-date'>멤버 <b><%=memberList.size() %></b> 등록일 <%=sdf.format(guildList.get(i + 1).getGuildRegDate()) %></div>
							</div>
						</div>
						</td>
						<%
					}
					%>
				</tr>
				<%
				}
				}
			%>
			</table>
		</div>

	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>