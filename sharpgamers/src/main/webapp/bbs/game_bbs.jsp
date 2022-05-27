<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.GamesBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="board.PagingUtil"%>

	
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="boardDao" class="board.GamesBoardDao" />
<jsp:useBean id="boardDto" class="board.GamesBoardDto" />
<jsp:useBean id="commentDao" class="board.GamesCommentDao" />

<%request.setCharacterEncoding("UTF-8");
	String platform = request.getParameter("game-platform");
	String gameName = request.getParameter("game-name");
	int game_id = Integer.parseInt(request.getParameter("id"));
	int sessionIdx = 0;
	String sessionId = (String) session.getAttribute("id");
	if (sessionId != null) {
		memberDto = memberDao.getMemberInfo(sessionId, memberDto);
		sessionIdx = memberDto.getMember_idx();
	} 
	gameDto = gameDao.getGameInfo(game_id, gameDto);
	%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=gameDto.getGame_name() %></title>
</head>
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

input[type=button], input[type=submit], input[type=reset] {
	cursor: pointer;
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

div.article-count-wrap {
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

.title-button-favorite {
	width: 40px;
	font-size: 18px;
	background: rgba(255, 255, 255, 0.2);
}

.title-admin-button {
	width: 120px;
	bottom: 0px;
	margin: 0px 10px;
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

table a {
	text-decoration: none;
	color: black;
}


tr {
	height: 50px;
}

tr:last-child {
	height: 80px;
}

tr:not(tr:last-child) {
	border-bottom: 1px solid lightgray;
}

tr.liked {
	background-color: rgba(0, 191, 134, 0.1);
	color: #FF4F7B;
}

tr.liked a {
	color: #FF4F7B;
	}

td:not(td:nth-child(6n-4)) {
	text-align: center;
}

div.search-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 50px; 
}

select.search-type {
	border: 2px solid rgba(0, 191, 134, 0.4);
	border-radius: 5px;
	height: 30px;
	width: 88px;
	background-color: rgba(255, 255, 255, 0.7);
	-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
	-moz-box-sizing: border-box;    /* Firefox, other Gecko */
	box-sizing: border-box;         /* Opera/IE 8+ */
}
input.search-text {
	border: 2px solid rgba(0, 191, 134, 0.4);
	border-radius: 5px;
	margin: 0px 5px;
	padding: 5px;
	height: 30px;
	width: 250px;
	background-color: rgba(255, 255, 255, 0.7);
	-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
	-moz-box-sizing: border-box;    /* Firefox, other Gecko */
	box-sizing: border-box;         /* Opera/IE 8+ */
}
input.search-submit {
	border: 2px solid rgba(0, 191, 134, 0.4);
	border-radius: 5px;
	height: 30px;
	width: 88px;
	background-color: rgba(0, 191, 134, 0.4);
	-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
	-moz-box-sizing: border-box;    /* Firefox, other Gecko */
	box-sizing: border-box;         /* Opera/IE 8+ */
}

</style>
<script src="<%=request.getContextPath() %>/jquery/jquery-3.6.0.min.js"></script>
<script>
	var favorite = false;
	var favorites = "<%=memberDto.getFav_game()%>";
	var favoriteGameIdArr = favorites.split(":");
	favoriteGameIdArr.pop();
	favoriteGameIdArr.forEach(function(gameId) {
		if (gameId == <%=game_id%>) {
			favorite = true;
		}
	});
	
	$(function() {
		if (favorite) {
			$(".title-button-favorite").css("background-color", "rgba(0, 191, 134, 1)");
		}
	});
	
	function favoriteFn() { 
		if (<%=sessionIdx%> == 0) {
			return;
		}
		if (!favorite) {
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/game_favorite_process.jsp",
				data : "favorite=add&gameId=<%=game_id%>",
				success : function (data) {
					favorite = true;
					$(".title-button-favorite").css("background-color", "rgba(0, 191, 134, 1)");
				}
			});
		} else {
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/game_favorite_process.jsp",
				data : "favorite=remove&gameId=<%=game_id%>",
				success : function (data) {
					favorite = false;
					$(".title-button-favorite").css("background-color", "rgba(0, 191, 134, 0.1)");
				}
			});
			
		}
	}
</script>
<body>
	<%@ include file="../header.jsp"%>
	<div id="wrapper">
	
	<% 
	int currPageNum = Integer.parseInt(request.getParameter("pageNum"));
	int totalNum = boardDao.countArticles(game_id);
	int listSize = 15;
	
	PagingUtil pu = new PagingUtil(totalNum, currPageNum, listSize);
	
	List<GamesBoardDto> articleList = null;
	
	if (totalNum > 0) {
	    articleList = boardDao.getArticles(game_id, pu.getStart(), pu.getEnd());
	}
	
	
%>
	<div id="game-title-wrap">
		<div id="game-title">
	<h1><%=gameDto.getGame_name()%></h1>
		</div>
			<div class="game-logo-wrap">
			<%
				if (memberDto.getMember_auth() == 2) {
			%>
				<div class="admin-button">
					<input type="button" class="title-button title-admin-button" value="게임 정보 수정" onclick="location.href='../update_game.jsp?gameId=<%=game_id%>'">
				</div>
			<%} %>
				<div class="article-count-wrap">
						<div class="article-count">전체글 <%=totalNum %> 
						</div>
				</div>
				<div class="game-logo">
					<img src="<%=request.getContextPath() %>/images/<%=gameDto.getGame_Platform() %>_logo.png" width="50px">
				</div>
			</div>
		<div id="buttons">
			<input class="title-button title-button-favorite" type="button" value="⭐" onclick="favoriteFn()">
			<input class="title-button" type="button" value="상점 페이지" onclick="location.href='<%=gameDto.getGame_link()%>'">
			<input class="title-button" type="button" value="길드 보기" onclick="location.href='<%=request.getContextPath()%>/guild/guild_list.jsp?gameId=<%=game_id%>'">
			<input class="title-button" type="button" value="글쓰기" onclick="javascript: location.href='game_bbs_write.jsp?id=<%=game_id %>&pageNum=<%=currPageNum%>'">
		</div>
	<div id="img-wrap">
	<img id="game-cover" src="<%=gameDto.getGame_img_src()%>">
	</div>
	</div>



<div id="content-wrap">
<table>
	<tr>
		<th width="8%">글번호</th>
		<th width="45%">글제목</th>
		<th>작성자</th>
		<th width="15%">작성일</th>
		<th width="8%">조회수</th>
		<th width="8%">추천수</th>
	</tr>



<%

if(articleList == null){
%>	
	<tr>
		<td colspan="6">게시판에 올린 글이 없습니다.</td>
	</tr>

<%
}else{
	
	List<GamesBoardDto> likedArticleList = boardDao.getLikedArticles(game_id);	

	for(int i=0; i<likedArticleList.size();i++){
	   boardDto = (GamesBoardDto) likedArticleList.get(i);
	   
	   if (boardDto.getLikes() == 0) {
	  	 continue;
	   }
	   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	   String reg_date = sdf.format(boardDto.getReg_date());
	   if (sdf.format(new Date()).equals(reg_date)) {
	  	 sdf = new SimpleDateFormat("HH:mm");
		   reg_date = sdf.format(boardDto.getReg_date());
	   }
	   String[] likesStr = boardDto.getLikedUsers().split(":");
	   String count = "";
	   if (commentDao.countArticles(boardDto.getNum()) != 0) {
	  	 count = "[" + commentDao.countArticles(boardDto.getNum()) + "]";
	   }
%>
    <tr class="liked">
    	<td><%=boardDto.getNum() %></td>
    	<td><a href="game_bbs_content.jsp?id=<%=game_id %>&pageNum=<%=currPageNum %>&bbsNum=<%=boardDto.getNum() %>">
    				[추천] <%=boardDto.getSubject() %> <%=count %>
    			</a></td>
    	<td><a href="../profile.jsp?id=<%=boardDto.getWriterId()%>"><%=boardDto.getWriter() %></a></td>
    	<td><%=reg_date %></td>
    	<td><%=boardDto.getReadCount() %></td>
    	<td><%=likesStr.length%></td>
    </tr>
<%
	}//for문의 닫힘 괄호
	
	
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
	   
	   
	   String[] likesStr = boardDto.getLikedUsers().split(":");
%>
    <tr>
    	<td><%=boardDto.getNum() %></td>
    	<td><a href="game_bbs_content.jsp?id=<%=game_id %>&pageNum=<%=currPageNum %>&bbsNum=<%=boardDto.getNum() %>">
    		<%=boardDto.getSubject() %> <%=count %>
    		</a></td>
    	<td><a href="../profile.jsp?id=<%=boardDto.getWriterId()%>"><%=boardDto.getWriter() %></a></td>
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
        <a href="game_bbs.jsp?id=<%=game_id %>&pageNum=<%=i%>"> [<%=i%>] </a>&nbsp;
<%
    							}
        }
    }else{
    	
        if(pu.getStartPage() > 10){
%>
					<a href="game_bbs.jsp?id=<%=game_id %>&pageNum=1"> [1] </a>&nbsp;
        	<a href="game_bbs.jsp?id=<%=game_id %>&pageNum=<%= (pu.getStartPage() - 1) %>"> &lt;이전&nbsp;</a> 
<%   
        }
        
		for (int i = pu.getStartPage(); i <= pu.getEndPage(); i++){
			if (i == currPageNum) {
%>        
        <b>[<%= i %>]</b>&nbsp;
<%
			} else {
%>        
        <a href="game_bbs.jsp?id=<%=game_id %>&pageNum=<%= i %>"> [<%= i %>] </a>&nbsp;
<%
				
				
			}
        }
        
        if(pu.getEndPage() < pu.getLastPage()){
%>
            <a href="game_bbs.jsp?id=<%=game_id %>&pageNum=<%= (pu.getEndPage()+1) %>"> 다음&gt;&nbsp; </a>
						<a href="game_bbs.jsp?id=<%=game_id %>&pageNum=<%=pu.getLastPage() %>"> [<%=pu.getLastPage() %>] </a>&nbsp;
<% 
         }
    }
%>
	</td></tr>
	</table>
</div>
	<form name="bbsSearch" action="game_bbs_search.jsp">
		<input type="hidden" name="id" value="<%=game_id %>">
		<input type="hidden" name="pageNum" value="1">
		<div class="search-wrap">
			<select name="searchType" class="search-type">
				<option value="subject">제목</option>
				<option value="content">제목+내용</option>
				<option value="writer">작성자</option>	
			</select>
			<input type="text" class="search-text" name="searchText">
			<input type="submit" class="search-submit" value="검색">
		</div>
	</form>
</div>
	<%@ include file="../footer.jsp"%>
	
	
</body>
</html>