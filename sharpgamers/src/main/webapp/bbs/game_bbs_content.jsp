<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	request.setCharacterEncoding("utf-8");
	int game_id = Integer.parseInt(request.getParameter("id"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
	%>

	<jsp:useBean id="gameDao" class="dao.GameDao" />
	<jsp:useBean id="gameDto" class="dao.GameDto" />
	<jsp:useBean id="boardDao" class="board.GamesBoardDao" />
	<jsp:useBean id="boardDto" class="board.GamesBoardDto" />
	<jsp:useBean id="memberDao" class="dao.MemberDao" />
	<jsp:useBean id="memberDto" class="dao.MemberDto" />
	<jsp:useBean id="commentDao" class="board.GamesCommentDao"/>
	<jsp:useBean id="commentDto" class="board.GamesCommentDto" />

	<%
	gameDto = gameDao.getGameInfo(game_id, gameDto);
	boardDto = boardDao.getArticle(bbsNum);
	boardDao.updateReadCount(bbsNum);
	String sessionId = (String) session.getAttribute("id");
	int sessionIdx;
	if (sessionId != null) {
		memberDto = memberDao.getMemberInfo(sessionId, memberDto);
		sessionIdx = memberDto.getMember_idx();
	} else {
		sessionIdx = 0;
	}
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  String reg_date = sdf.format(boardDto.getReg_date());
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title><%=gameDto.getGame_name() %></title>
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
	button:hover {
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
	
	tr:last-child {
		height: 80px;
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
	
	div#writer-wrapper {
		width: 100%;
		display: flex;
		justify-content: space-between;
	}
	div#subject {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	div#content {
		min-height: 200px;
		padding: 20px;
	}
	div#like-wrap {
		position: relative;
		padding: 20px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	div#like-button {
		width: 50px;
		height: 50px;
		border: 2px solid rgba(0, 191, 134, 0.4);
		border-radius: 10px 0px 0px 10px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	div#like-button:hover {
		background-color: rgba(0, 191, 134, 0.4);
		cursor: pointer;
	}
	div#likes-list-button {
		width: 100px;
		height: 50px;
		border: 2px solid rgba(0, 191, 134, 0.4);
		border-left: 0px;
		border-radius: 0px 10px 10px 0px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	div#likes-list-button:hover {
		background-color: rgba(0, 191, 134, 0.4);
		cursor: pointer;
	}
	div#likes-count {
		font-size: 18px;
	}
	div#likes {
		position: absolute;
		top: 73px;
		width: 152px;
		height: 200px;
		background: white;
		border: 2px solid rgba(0, 191, 134, 0.4);
		border-top: 0px;
		border-radius: 0px 0px 10px 10px;
		z-index: 999;
		overflow: auto;
		display: none;
	}
	div.liked-member {
		padding: 10px;
		border-bottom: 1px solid lightgray;
	}
	div.liked-member:last-child {
		border: 0px;
	}
	
	div.comments {
		border-bottom: 1px solid lightgray;
		padding: 20px 0px;
	}
	
	div.comment-writer {
		font-weight: bold;
	}
	
	div.comment-content {
		padding: 10px 0px;
	}
	
	div.comment-third-row {
		height: 40px;
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
		
	}
	
	div.comment-reg-date {
		font-size: 12px;
	}
	
	.comment-button {
		margin-left: 15px;
		height: 40px;
		width: 120.5px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
		position: relative;
	}
	.comment-button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
	
	div.comments-insert {
		padding: 20px 0px;
	}
	
	div.comment-form-wrap {
		display: flex;
		justify-content: flex-end;
	}
	
	div.comment-form-buttons-wrap {
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		width: fit-content;
	}
	
	textarea {
		resize: none;
		height: 70px;
		width: 100%;
		padding: 10px;
		overflow: auto;
		font-size: 14px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
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
<script src="../jquery/jquery-3.6.0.min.js"></script>
<script>
	var liked = false;

	var likes = "<%=boardDto.getLikedUsers()%>";
	var likeIdxs = likes.split(":");
	var likeNames;
	likeIdxs.pop();
	var likeList = "";
	likeIdxs.forEach(function(idx) {
		if (idx == <%=sessionIdx%>) {
			liked = true;
		}
	})
	
	$(function () {
		
		$("div#subject>h2").html('<%=boardDto.getSubject() %>');
		$("div#content").html('<%=boardDto.getContent()%>');
		
		$.ajax({
			type : "post",
			url : "game_bbs_like_process.jsp",
			data : "like=load&bbsNum=<%=bbsNum%>",
			success : function (data) {
				likes = data.split(",,,");
				likeIdxs = likes[0].split(":");
				likeNames = likes[1].split(":");
				likeNames.pop();
				likeList = "";
				
				for (var i = 0; i < likeNames.length; i++) {
					likeList += "<div class='liked-member'><a href='../profile.jsp?id=" + likeIdxs[i].trim() + "'>" + likeNames[i].trim() + "</a></div>"
				}
				/* 
				likeNames.forEach(function(name) {
					likeList += "<div id='liked-member'>" + name.trim() + "</div>";
				}) */
				$("#likes").html(likeList);
				$("#likes-count").text(likeNames.length);
				if (likeList == "<div class='liked-member'><a href='../profile.jsp?id='></a></div>") {
					$("#likes-count").text("0");
				}
			}
		});
		if (liked) {
			$("#like-button").css("background-color", "rgba(0, 191, 134, 0.4)");
		}
		
		loadComments();
	});
	
	function likeFn() {
		if (<%=sessionIdx%> == 0) {
			return;
		}
		if (!liked) {
			$.ajax({
				type : "post",
				url : "game_bbs_like_process.jsp",
				data : "like=add&bbsNum=<%=bbsNum%>",
				success : function (data) {
					liked = true;
					likes = data.split(",,,");
					likeIdxs = likes[0].split(":");
					likeNames = likes[1].split(":");
					likeNames.pop();
					likeList = "";
					for (var i = 0; i < likeNames.length; i++) {
						likeList += "<div class='liked-member'><a href='../profile.jsp?id=" + likeIdxs[i].trim() + "'>" + likeNames[i].trim() + "</a></div>"
					}
					$("#likes").html(likeList);
					$("#likes-count").text(likeNames.length);
					if (likeList == "<div class='liked-member'><a href='../profile.jsp?id='></a></div>") {
						$("#likes-count").text("0");
					}
					$("#like-button").css("background-color", "rgba(0, 191, 134, 0.4)");
				}
			});
		} else {
			$.ajax({
				type : "post",
				url : "game_bbs_like_process.jsp",
				data : "like=remove&bbsNum=<%=bbsNum%>",
				success : function (data) {
					liked = false;
					likes = data.split(",,,");
					likeIdxs = likes[0].split(":");
					likeNames = likes[1].split(":");
					likeNames.pop();
					likeList = "";
					for (var i = 0; i < likeNames.length; i++) {
						likeList += "<div class='liked-member'><a href='../profile.jsp?id=" + likeIdxs[i].trim() + "'>" + likeNames[i].trim() + "</a></div>"
					}
					$("#likes").html(likeList);
					$("#likes-count").text(likeNames.length);
					if (likeList == "<div class='liked-member'><a href='../profile.jsp?id='></a></div>") {
						$("#likes-count").text("0");
					}
					$("#like-button").css("background-color", "");
				}
			});
			
		}
	}
	
	var listShown = false;
	function toggleLikedList() {
		if (listShown) {
			$("div#likes").css("display", "none");
			$("div#like-button").css("border-radius", "10px 0px 0px 10px");
			$("div#likes-list-button").css("border-radius", "0px 10px 10px 0px");
			listShown = false;
		} else {
			$("div#likes").css("display", "inline");
			$("div#like-button").css("border-radius", "10px 0px 0px 0px");
			$("div#likes-list-button").css("border-radius", "0px 10px 0px 0px");
			listShown = true;
		}
	}
	
	function loadComments() {
		$.ajax({
			type : "get",
			url : "game_comments_process.jsp",
			data : "fn=load&bbsNum=" + <%=bbsNum%>,
			success : function(data) {
				$(".comments-wrap").html(data.trim());
				$(".comments-count h3").text("댓글 " + $(".comments").length);
			}
		});
	}
	
	function insertComment(obj) {
		var content = $(obj).parent().prev().val().trim();
		var writerIdx = "<%=sessionIdx%>";
		if (content == "") {
			alert("내용을 입력해 주세요.");
			return;
		}
		$.ajax({
			type: "post",
			url : "game_comments_process.jsp",
			data : "fn=insert&bbsNum=<%=bbsNum%>&writerId=" + writerIdx + "&content=" + content,
			success : function (data) {
				switch(data.trim()) {
				case "0":
					loadComments();
					$(obj).parent().prev().val("");
					break;
				case "1":
					alert("등록 권한이 없습니다.");
					break;
				case "2":
					alert("오류가 발생했습니다.");
					break;
				}
			}
		});
	}
	
	function resetText(obj) {
		var content = $(obj).parent().prev().val("");
	}
	
	function showCommentUpdate(obj) {
		var formHtml = '<div class="comments-insert">' +
			'<div class="comment-form-wrap">' +
			'<textarea class="comment-textarea" name="content" placeholder="댓글을 입력하세요."></textarea>' +
			'<div class="comment-form-buttons-wrap">' +
			'<input type="button" class="comment-button" value="댓글 수정" onclick="updateComment(this)">' +
			'<input type="button" class="comment-button" value="지우기" onclick="resetText(this)">' +
			'</div></div></div>';
		
		if ($(obj).val() == "수정") {
			$(obj).parent().parent().parent().append(formHtml);
			$(obj).val("닫기");
		} else {
			$(obj).parent().parent().parent().find(".comments-insert").remove();
			$(obj).val("수정");
		}
	}
	
	function updateComment(obj) {
		var content = $(obj).parent().prev().val().trim();
		var commentId = $(obj).parent().parent().parent().parent().find(".comment-id").text();
		var writerIdx = "<%=sessionIdx%>";
		if (content == "") {
			alert("내용을 입력해 주세요.");
			return;
		}
		$.ajax({
			type: "post",
			url : "game_comments_process.jsp",
			data : "fn=update&bbsNum=<%=bbsNum%>&commentId=" + commentId + "&writerId=" + writerIdx + "&content=" + content,
			success : function (data) {
				switch(data.trim()) {
				case "0":
					loadComments();
					break;
				case "1":
					alert("등록 권한이 없습니다.");
					break;
				}
			}
		});
	}
	
	function removeComment(obj) {
		var commentId = $(obj).parent().parent().parent().find(".comment-id").text();
		var writerIdx = "<%=sessionIdx%>";
		
		if (!confirm("정말 삭제하시겠습니까?")) {
			return;
		}

		$.ajax({
			type: "post",
			url : "game_comments_process.jsp",
			data : "fn=remove&bbsNum=<%=bbsNum%>&writerId=" + writerIdx + "&commentId=" + commentId,
			success : function (data) {
				switch(data.trim()) {
				case "0":
					loadComments();
					break;
				case "1":
					alert("삭제 권한이 없습니다.");
					break;
				case "2":
					alert("오류가 발생했습니다.");
					break;
				}
			}
		});
	}
	
	function goDelete() {
		if (!confirm("정말 삭제하시겠습니까?")) {
			return;
		}
		window.location='game_bbs_deletePro.jsp?num=<%=bbsNum%>&game_id=<%=game_id%>&pageNum=<%=pageNum%>' ;
	}
	
</script>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div id="wrapper">
	
	<div id="game-title-wrap">
		<div id="game-title">
		
	<h1><a href="game_bbs.jsp?id=<%=game_id%>&pageNum=1"><%=gameDto.getGame_name()%></a></h1>
		</div>
		<div class="buttons">
			<input class="title-button" type="button" value="상점 페이지" onclick="location.href='<%=gameDto.getGame_link()%>'">
			<input class="title-button" type="button" value="길드 보기" onclick="location.href='<%=request.getContextPath()%>/guild/guild_list.jsp?gameId=<%=game_id%>'">
			<input class="title-button" type="button" value="글쓰기" onclick="javascript: location.href='game_bbs_write.jsp?id=<%=game_id %>&pageNum=<%=request.getParameter("pageNum")%>'">
		</div>
	</div>
	
	<div id="content-wrap">
		<table id="content">
			<tr>
				<td><div id="subject"><h2></h2><div>조회 <%=boardDto.getReadCount() %></div></div></td>
			</tr>
			<tr>
			<td>
				<div id="writer-wrapper">
					<div id="writer"><a href="../profile.jsp?id=<%=boardDto.getWriterId()%>"><b><%=boardDto.getWriter() %></b></a></div>
					<div id="reg_date"><%=reg_date %></div>
				</div>
			</td>
			</tr>
			<tr>
				<td>
					<div id="content"></div>
					<div id="like-wrap">
						<div id="like-button" onclick="likeFn()"><img src="../images/thumbsup_black.png" width="20px"></div>
						<div id="likes-list-button" onclick="toggleLikedList()"><div id="likes-count"></div></div>
					<div id="likes">
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td><div>
						<div class="comments-count"><h3>댓글 <%=commentDao.countArticles(bbsNum) %></h3></div>
						<div class="comments-wrap"></div>
						<div class="comments-insert">
							<div class="comment-form-wrap">
								<textarea class="comment-textarea" name="content" placeholder="댓글을 입력하세요."></textarea>
								<div class="comment-form-buttons-wrap">
									<input type="button" class="comment-button" value="댓글 등록" onclick="insertComment(this)">
									<input type="button" class="comment-button" value="지우기" onclick="resetText(this)">
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div class="outter-buttons-wrap">
	<div class="buttons">
		<button class="outter-button" onclick="window.location='game_bbs_update.jsp?id=<%=game_id%>&num=<%=bbsNum%>&pageNum=<%=pageNum%>' ">수정하기</button>
		<button class="outter-button" onclick="goDelete()">글삭제</button>
		<button class="outter-button" onclick="window.location='game_bbs.jsp?id=<%=game_id%>&pageNum=<%=pageNum%>' ">글목록</button>
	</div>
	</div>
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>
