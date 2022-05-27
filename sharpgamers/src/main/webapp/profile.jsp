<%@page import="dao.GuildDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.GamesBoardDto"%>
<%@page import="board.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:useBean id="memberDao" class="dao.MemberDao" />
	<jsp:useBean id="memberDto" class="dao.MemberDto" />
	<jsp:useBean id="gameDao" class="dao.GameDao" />
	<jsp:useBean id="gameDto" class="dao.GameDto" />
	<jsp:useBean id="guildDao" class="dao.GuildDao" />
	<jsp:useBean id="guildDto" class="dao.GuildDto" />
	<jsp:useBean id="boardDao" class="board.GamesBoardDao" />
	<jsp:useBean id="boardDto" class="board.GamesBoardDto" />
	<jsp:useBean id="commentDao" class="board.GamesCommentDao" />
<%
	request.setCharacterEncoding("UTF-8");
	int sessionIdx;
	int memberIdx = Integer.parseInt(request.getParameter("id"));
	if (memberIdx == 0) {
		response.sendRedirect("main.jsp");
	}

	boolean isOwner = false;
	boolean isAdmin = false;
	
	if (session.getAttribute("id") == null) {
		sessionIdx = 0;
	} else {
		memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
		sessionIdx = memberDto.getMember_idx();
		if (memberDto.getMember_auth() == 2) {
			isAdmin = true;
		}
	}
	
	if (sessionIdx == memberIdx) {
		isOwner = true;
	}
	
	memberDto = memberDao.getMemberInfo(memberIdx, memberDto);
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
	div#board-wrap {
		margin-top: 100px;
		position: relative;
		width: 100%;
		border: 1px solid lightgray;
		border-radius: 15px;
		background: rgba(255, 255, 255, 0.7);
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	div#board-wrap tr:last-child {
		height: 80px;
	}
	
		
	div#board-wrap td:not(td:nth-child(6n-4)) {
		text-align: center;
	}
	
	td.board-title {
		text-align: left;
		font-size: 18px;
	}
	
</style>
<script src="./jquery/jquery-3.6.0.min.js"></script>
<script>
$(function() {
	$.ajax({
		type : "post",
		url : "game_favorite_process.jsp",
		data : "favorite=loadMember&memberIdx=<%=memberIdx%>&gameId=1",
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

var blocked = false;
<%
if (memberDto.getMember_auth() == 1) {
%>
blocked = true;
<%
}
%>
function blockMember() {
	if (!blocked) {
		if (confirm('이 멤버에게서 글쓰기 권한을 없앱니다.')) {
			$.ajax({
				type: "post",
				url: "block_user.jsp",
				data: "fn=block&targetId=<%=memberDto.getMember_idx()%>",
				success: function(data) {
					if (data.trim() == 0) {
						alert('차단했습니다.');
						$(".block").val("차단 해제");
						blocked = true;
					} else if (data.trim() == 1) {
						alert('권한이 없습니다.');
					}
				}
			});
		}
	} else {
		if (confirm('차단을 해제하시겠습니까?')) {
			$.ajax({
				type: "post",
				url: "block_user.jsp",
				data: "fn=unblock&targetId=<%=memberDto.getMember_idx()%>",
				success: function(data) {
					if (data.trim() == 0) {
						alert('차단을 해제했습니다.');
						$(".block").val("차단하기");
						blocked = false;
					} else if (data.trim() == 1) {
						alert('권한이 없습니다.');
					}
				}
			});
		}
	}
}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="wrapper">
		<div id="game-title-wrap">
			<div id="game-title">
			
		<h1><%=memberDto.getMember_name()%>님의 프로필</h1>
			</div>
			<div class="buttons">
				<%
					if (isOwner) {
				%>
				<input class="title-button" type="button" value="메시지함" onclick="location.href='message.jsp'">
				<input class="title-button" type="button" value="정보 수정" onclick="location.href='update_info.jsp'">
				<%
					} else {
						if (isAdmin) {
							if (memberDto.getMember_auth() == 0) {
				%>
				<input class="title-button block" type="button" value="차단하기" onclick="blockMember()">
				<%
							} else if (memberDto.getMember_auth() == 1) {
				%>
				<input class="title-button block" type="button" value="차단 해제" onclick="blockMember()">
				<%				
							}
						}
				%>
				<input class="title-button" type="button" value="메시지 보내기" onclick="location.href='message.jsp?receiverId=<%=memberDto.getMember_idx()%>'">
				<%
					}
				%>
			</div>
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
						<td><div>가입한 길드</div></td>
					</tr>
					
					<%
						List<GuildDto> guildList = null;
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
		
	<% 
	int currPageNum = 1;
	if (request.getParameter("pageNum") != null) {
		currPageNum = Integer.parseInt(request.getParameter("pageNum"));
	}
	int totalNum = boardDao.countArticlesForMember(memberIdx);
	int listSize = 15;
	
	PagingUtil pu = new PagingUtil(totalNum, currPageNum, listSize);
	
	List<GamesBoardDto> articleList = null;
	
	if (totalNum > 0) {
	    articleList = boardDao.getArticlesForMember(memberIdx, pu.getStart(), pu.getEnd());
	}
%>
	
<div id="board-wrap">
<table>
	<tr>
		<td colspan="6" class="board-title">작성한 글 <%=totalNum %></td>
	</tr>
	<tr>
		<th width="8%">글번호</th>
		<th width="45%">글제목</th>
		<th>게임</th>
		<th width="15%">작성일</th>
		<th width="8%">조회수</th>
		<th width="8%">추천수</th>
	</tr>



<%

if(articleList == null){
%>	
	<tr>
		<td colspan="6">작성한 글이 없습니다.</td>
	</tr>

<%
}else{
	
	
	for(int i=0; i<articleList.size();i++){
	   boardDto = (GamesBoardDto) articleList.get(i);
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	   String reg_date = sdf.format(boardDto.getReg_date());
	   if (sdf.format(new Date()).equals(reg_date)) {
	  	 sdf = new SimpleDateFormat("HH:mm");
		   reg_date = sdf.format(boardDto.getReg_date());
	   }
	   String count = "";
	   if (commentDao.countArticles(boardDto.getNum()) != 0) {
	  	 count = "[" + commentDao.countArticles(boardDto.getNum()) + "]";
	   }
	   
	   int game_id = boardDto.getGame_id();
	   String[] likesStr = boardDto.getLikedUsers().split(":");
%>
    <tr>
    	<td><%=boardDto.getNum() %></td>
    	<td><a href="bbs/game_bbs_content.jsp?id=<%=game_id %>&pageNum=1&bbsNum=<%=boardDto.getNum() %>">
    		<%=boardDto.getSubject() %> <%=count %>
    		</a></td>
    	<td><a href="bbs/game_bbs.jsp?id=<%=game_id%>&pageNum=1"><%=gameDao.getGameInfo(game_id, gameDto).getGame_name() %></a></td>
    	<td><%=reg_date %></td>
    	<td><%=boardDto.getReadCount() %></td>
    	<td><%=likesStr.length%></td>
    </tr>
<%
	}//for문의 닫힘 괄호
}
%>
		<tr><td colspan=6>
<%

    if(pu.getLastPage() < 11){
        for (int i = pu.getStartPage(); i <= pu.getLastPage(); i++){
    			if (i == currPageNum) {
    				%>        
    				        <b>[<%= i %>]</b>&nbsp;
    				<%
    							} else {
    				%>        
        <a href="profile.jsp?id=<%=memberIdx %>&pageNum=1"> [<%=i%>] </a>&nbsp;
<%
    							}
        }
    }else{
    	
        if(pu.getStartPage() > 10){
%>
					<a href="profile.jsp?id=<%=memberIdx %>&pageNum=1"> [1] </a>&nbsp;
        	<a href="profile.jsp?id=<%=memberIdx %>&pageNum=<%= (pu.getStartPage() - 1) %>"> &lt;이전&nbsp;</a> 
<%   
        }
        
		for (int i = pu.getStartPage(); i <= pu.getEndPage(); i++){
			if (i == currPageNum) {
%>        
        <b>[<%= i %>]</b>&nbsp;
<%
			} else {
%>        
        <a href="profile.jsp?id=<%=memberIdx %>&pageNum=<%= i %>"> [<%= i %>] </a>&nbsp;
<%
				
				
			}
        }
        
        if(pu.getEndPage() < pu.getLastPage()){
%>
            <a href="profile.jsp?id=<%=memberIdx %>&pageNum=<%= (pu.getEndPage()+1) %>"> 다음&gt;&nbsp; </a>
						<a href="profile.jsp?id=<%=memberIdx %>&pageNum=<%=pu.getLastPage() %>"> [<%=pu.getLastPage() %>] </a>&nbsp;
<% 
         }
    }
%>
	</td></tr>
	</table>
</div>
		
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>