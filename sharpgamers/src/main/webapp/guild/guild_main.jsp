<%@page import="dao.MemberDto"%>
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
	int guildId = Integer.parseInt(request.getParameter("guildId"));
	guildDto = guildDao.getGuildInfo(guildId, guildDto);
	gameDto = gameDao.getGameInfo(guildDto.getGame_id(), gameDto);
	int sessionIdx = 0;
	if (session.getAttribute("id") != null) {
		memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
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

input[type=button], input[type=submit], input[type=reset] {
	cursor: pointer;
}

a {
	text-decoration: none;
	color: black;
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

div#buttons {
	position: relative;
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	z-index: 9;
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
.title-button:hover, .join-guild-button:hover {
	border: 2px solid rgba(0, 191, 134, 0.4);
}

div.game-logo-wrap {
	position: absolute;
	right: 0px;
	z-index: 10;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

div.guild-members-wrap {
	margin-right: 10px;
	text-align: right;
}

div.game-logo {
	display: flex;
	align-items: center;
}

div#guild-desc {
	position: relative;
	top: -50px;
	width: 50%;
	padding: 0px 20px;
	font-weight: bold;
}

div#join-guild {
	width: fit-content;
	margin: 70px auto;
}

input.join-guild-button {
	height: 100px;
	width: 200px;
	font-size: 25px;
	border: 2px solid rgba(0, 191, 134, 0.2);
	border-radius: 5px;
	background-color: rgba(0, 191, 134, 0.1);
}

div.memo-board {
	width: 100%;
	display: flex;
	flex-wrap: wrap;
}

div.memo-wrap {
	flex: 1 1 30%;
	display: flex;
	justify-content: center;
	align-items: center;
}

div.memo-wrap:nth-child(3n-2) {
	margin: 7px 7px 7px 0px;
}

div.memo-wrap:nth-child(3n-1) {
	margin: 7px;
}

div.memo-wrap:nth-child(3n) {
	margin: 7px 0px 7px 7px;
}

div.memo {
	background-color: rgba(255, 255, 255, 0.7);
	border: 1px solid lightgray;
	border-radius: 10px;
	width: 100%;
	height: 260px;
	padding: 15px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

div.memo-content {
	height: 200px;
	overflow: auto;
	word-break: break-all;
}

div.memo-info {
	font-size: 14px;
	display: flex;
	justify-content: space-between;
	margin-top: 5px;
}

div.memo-buttons {
	text-align: right;
}

input.memo-button {
	border: 0px;
	border-radius: 3px;
	background-color: rgba(0, 191, 134, 0.2);
	margin-left: 3px;
}

div.memo-update {
	display: none;
}

div.memo-input-wrap {
	overflow: visible;
}

textarea.memo-input {
	width: 100%;
	height: 100%;
	padding: 5px;
	resize: none;
	background: rgba(255, 255, 255, 0.7);
	border: 2px solid rgba(0, 191, 134, 0.4);
	border-radius: 5px;
	margin: 0px;
	overflow: auto;
	-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
	-moz-box-sizing: border-box;    /* Firefox, other Gecko */
	box-sizing: border-box;         /* Opera/IE 8+ */
}


</style>
<script src="<%=request.getContextPath() %>/jquery/jquery-3.6.0.min.js"></script>
<script>
	var joined;
	$(function() {
		joined = <%=guildDao.isJoined(guildId, sessionIdx)%>;
		checkJoined();
		loadMemo();
	
	})

	function checkJoined() {
		if (joined) {
			$(".join-guild-button").css("font-size", "20px").val("이미 가입 신청함");
		} else {
			$(".join-guild-button").css("font-size", "25px").val("가입 신청");
		}
	}
	
	function joinGuild() {
		if (<%=sessionIdx%> == 0) {
			location.href = "<%=request.getContextPath()%>/login.jsp";
		}
		if (!joined) {
			$.ajax({
				type : "post",
				url : "guild_join.jsp",
				data : "fn=join&guildId=<%=String.valueOf(guildId)%>",
				success : function() {
					joined = true;
					checkJoined();
					$("#member-count").load(window.location.href + " #member-count");
				}
			});
		} else {
			$.ajax({
				type : "post",
				url : "guild_join.jsp",
				data : "fn=abort&guildId=<%=String.valueOf(guildId)%>",
				success : function() {
					joined = false;
					checkJoined();
					$("#member-count").load(window.location.href + " #member-count");
				}
			});
		}
	}
	
	function loadMemo() {
		$.ajax({
			type: "get",
			url: "guild_memo_process.jsp",
			data: "fn=load&guildId=<%=guildId%>",
			success : function(data) {
				$("#memo-board").html(data.trim());
			}
		})
	}
	
	function showUpdateForm(obj) {
		var memoWrap = $(obj).parent().parent().parent().parent();
		$(memoWrap).find(".memo-loaded").css("display", "none");
		$(memoWrap).find(".memo-update").css("display", "flex");
	}
	
	function closeUpdateForm(obj) {
		var memoWrap = $(obj).parent().parent().parent().parent();
		$(memoWrap).find(".memo-update").css("display", "none");
		$(memoWrap).find(".memo-loaded").css("display", "flex");
	}
	
	function resetUpdateForm(obj) {
		var memoWrap = $(obj).parent().parent().parent().parent();
		$(memoWrap).find("textarea").val($(memoWrap).find("div.memo-loaded-content").text());
	}
	
	function updateMemo(obj) {
		var memoWrap = $(obj).parent().parent().parent().parent();
		var content = $(memoWrap).find("textarea").val();
		$.ajax({
			type: "post",
			url: "guild_memo_process.jsp",
			data: "fn=update&memoId=" + $(memoWrap).find(".memoId").val() + "&content=" + content,
			success: function(data) {
				if (data == 1) {
					alert('권한이 없습니다.');
				}
				loadMemo();
			}
		})
	}
	
	function removeMemo(obj) {
		if (confirm("정말 삭제하시겠습니까?")) {
			var memoWrap = $(obj).parent().parent().parent().parent();
			$.ajax({
				type: "post",
				url: "guild_memo_process.jsp",
				data: "fn=remove&memoId=" + $(memoWrap).find(".memoId").val(),
				success: function(data) {
					if (data == 1) {
						alert('권한이 없습니다.');
					}
					loadMemo();
				}
			})
		}
	}
	
	function insertMemo(obj) {
		var memoWrap = $(obj).parent().parent().parent().parent();
		var content = $(memoWrap).find("textarea").val();
		$.ajax({
			type: "post",
			url: "guild_memo_process.jsp",
			data: "fn=insert&guildId=<%=guildId%>&content=" + content,
			success: function() {
				loadMemo();
			}
		})
	}
	
	function resetInsertForm(obj) {
		var memoWrap = $(obj).parent().parent().parent().parent();
		$(memoWrap).find("textarea").val('');
	}
	
	function removeGuild() {
		if (confirm("길드가 영구히 삭제되며 되돌릴 수 없습니다.\r\n계속하시겠습니까?")){
			location.href="guild_remove.jsp?guildId=<%=guildId%>"
		}
	}
</script>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div id="wrapper">
	
		<div id="game-title-wrap">
			<div id="game-title">
				<h1><%=guildDto.getGuildName()%></h1>
				
			</div>
			<%
			MemberDto masterDto = new MemberDto();
			%>
			<div class="game-logo-wrap">
				<div class="guild-members-wrap">
						<div id = "member-count" class="member-count"><a href='guild_member.jsp?guildId=<%=String.valueOf(guildId)%>'>멤버 <b>
						<%=String.valueOf(guildDao.getMemberList(guildId).size()) %>명
						</b>
						<%
						if (guildDao.getJoinWaitingList(guildId).size() > 0) {
							out.write(" | 대기중 <b>" + guildDao.getJoinWaitingList(guildId).size() + "명</b>");
						}
						%>
						</a></div>
						<div class="guild-master">마스터 <b>
						<a href='<%=request.getContextPath()%>/profile.jsp?id=<%=memberDao.getMemberInfo(guildDto.getGuildMasterIdx(), masterDto).getMember_idx()%>'>
							<%=memberDao.getMemberInfo(guildDto.getGuildMasterIdx(), masterDto).getMember_name() %></a>
						</b></div>
				</div>
				<div class="game-logo">
					<img src="<%=request.getContextPath() %>/images/<%=gameDto.getGame_Platform() %>_logo.png" width="50px">
				</div>
			</div>
			<div id="buttons">
				<% 
					if (sessionIdx == guildDto.getGuildMasterIdx()) {
				%>
				<input class="title-button" type="button" value="길드 폐쇄" onclick="removeGuild()">
				<%
					}
				%>
				<input class="title-button" type="button" value="게임 페이지" onclick="location.href='../bbs/game_bbs.jsp?id=<%=gameDto.getGame_id()%>&pageNum=1'">
				<%
					if (guildDao.isMember(guildId, sessionIdx) || memberDto.getMember_auth() == 2) {
				%>
				<input class="title-button" type="button" value="길드 게시판" onclick="location.href='bbs/guild_bbs.jsp?id=<%=guildId%>&pageNum=1'">
				<%
					}
				%>
			</div>
			<div id="img-wrap">
				<img id="game-cover" src="<%=gameDto.getGame_img_src()%>">
			</div>
		</div>
		<div id="guild-desc"><%=guildDto.getGuildDesc() %></div>
		<div id="contents-load">
		<%
			if (!guildDao.isMember(guildId, memberDto.getMember_idx()) && memberDto.getMember_auth() != 2) {
		%>
			<div id="join-guild">
				<input type="button" class="join-guild-button" value="가입 신청" onclick="joinGuild()">
			</div>
		</div>
		<div>
		<%
			} else {
		%>
		
		<div id="memo-board" class="memo-board">
		</div>
				
		<%
			}
		%>
		</div>
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>