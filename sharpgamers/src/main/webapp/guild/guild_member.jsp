<%@page import="dao.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />

<%
request.setCharacterEncoding("utf-8");
guildDto = guildDao.getGuildInfo(Integer.parseInt(request.getParameter("guildId")), guildDto);
List<MemberDto> memberList = guildDao.getMemberList(guildDto.getGuildId());
List<MemberDto> joinWaitingList = guildDao.getJoinWaitingList(guildDto.getGuildId());

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
<meta charset="UTF-8" />
<title>Insert title here</title>
<style>
	
	body {
		background-image: url("../images/background.png");
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

	a {
		text-decoration: none;
		color: black;
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
	
	
	tr {
		height: 50px;
		z-index: 10;
	}
	
	tr.joined-members-list > td > div, tr.join-wating-members-list > td > div {
		font-size: 14px;
	}
	
	tr:not(tr:last-child) {
		border-bottom: 1px solid lightgray;
	}
	
	td.join-waiting-members-name-wrap:hover, td.joined-members-name-wrap:hover {
		cursor: pointer;
		background-color: rgba(27, 165, 124, 0.2);
	}
	
	td>div {
		padding: 0px 20px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	div.joined-members-name, div.join-wating-members-name {
		display: flex;
		align-items: center;
	}
	td.join-accept-wrap>div, td.member-remove-wrap {
		text-align: right;
	}
	input.join-accept-button, input.joined-member-button {
		border: 0px;
		border-radius: 3px;
		background-color: rgba(0, 191, 134, 0.3);
		z-index: 11;
	}
	input.join-deny, input.member-remove-button {
		background-color: rgba(255, 200, 200, 1);
	}
	
</style>
<script src="../jquery/jquery-3.6.0.min.js"></script>
<script>
	function acceptJoin(memberIdx, obj) {
		var name = $(obj).parent().parent().parent().find(".join-waiting-members-name").text().trim();
		if (confirm(name + "님의 가입을 승인하시겠습니까?")) {
			$.ajax({
				type: "post",
				url: "guild_join.jsp",
				data: "fn=accept&guildId=<%=guildDto.getGuildId()%>&memberIdx=" + memberIdx,
				success: function(data) {
					result = data.trim();
					if (result == 0) {
						alert('가입을 승인했습니다.');
					} else if (result == 1) {
						alert('권한이 없습니다.');
					} else if (result == 2) {
						alert('이미 가입된 멤버입니다.');
					}
					
					$("#content-wrap-wrap").load(window.location.href + " #content-wrap-wrap");
				}
			})	
		}
	}
	
	function denyJoin(memberIdx, obj) {
		var name = $(obj).parent().parent().parent().find(".join-waiting-members-name").text().trim();
		if (confirm(name + "님의 가입을 거절하시겠습니까?")) {
			$.ajax({
				type: "post",
				url: "guild_join.jsp",
				data: "fn=deny&guildId=<%=guildDto.getGuildId()%>&memberIdx=" + memberIdx,
				success: function(data) {
					result = data.trim();
					if (result == 0) {
						alert('가입을 거절했습니다.');
					} else if (result == 1) {
						alert('권한이 없습니다.');
					} else if (result == 2) {
						alert('대기목록에 없는 멤버입니다.');
					}
					
					$("#content-wrap-wrap").load(window.location.href + " #content-wrap-wrap");
				}
			})
		}
	}
	
	function removeMember(memberIdx, obj) {
		var name = $(obj).parent().parent().parent().find(".joined-members-name").text().trim();
		if (confirm(name + "님을 길드에서 추방하시겠습니까?")) {
			$.ajax({
				type: "post",
				url: "guild_join.jsp",
				data: "fn=remove&guildId=<%=guildDto.getGuildId()%>&memberIdx=" + memberIdx,
				success: function(data) {
					result = data.trim();
					if (result == 0) {
						alert('멤버를 추방했습니다.');
					} else if (result == 1) {
						alert('권한이 없습니다.');
					} else if (result == 2) {
						alert('가입하지 않은 멤버입니다.');
					}
					$("#content-wrap-wrap").load(window.location.href + " #content-wrap-wrap");
				}
			})
		}
	}
	
	function changeMaster(memberIdx, obj) {
		var name = $(obj).parent().parent().parent().find(".joined-members-name").text().trim();
		if (confirm(name + "님에게 길드마스터를 위임하시겠습니까?")) {
			$.ajax({
				type: "post",
				url: "guild_master.jsp",
				data: "guildId=<%=guildDto.getGuildId()%>&memberIdx=" + memberIdx,
				success: function(data) {
					result = data.trim();
					if (result == 0) {
						alert('길드 마스터를 변경했습니다.');
					} else if (result == 1) {
						alert('권한이 없습니다.');
					}
					$("#content-wrap-wrap").load(window.location.href + " #content-wrap-wrap");
				}
			})
		}
	}
	
	function unreg() {
		if (<%=sessionIdx%> == <%=guildDto.getGuildMasterIdx()%>) {
			alert("길드 마스터는 탈퇴할 수 없습니다.");
			return;
		}
		if (confirm("정말 탈퇴하시겠습니까?")) {
			$.ajax({
				type: "post",
				url: "guild_unreg.jsp",
				data: "guildId=<%=guildDto.getGuildId()%>",
				success: function() {
					alert('길드에서 탈퇴했습니다.');
					location.href = "guild_main.jsp?guildId=<%=guildDto.getGuildId()%>";
				}
			});
		}
	}
</script>
<script>
function formReset() {
	$(make-guild-form)[0].reset();
}
</script>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div id="wrapper">
	
	<div id="game-title-wrap">
		<div id="game-title">
		
	<h1><a href="guild_main.jsp?guildId=<%=guildDto.getGuildId()%>"><%=guildDto.getGuildName()%></a></h1>
		</div>
		<div class="buttons">
			<%
			if (guildDao.isMember(guildDto.getGuildId(), sessionIdx)) {
			%>
			<input class="title-button" type="button" value="길드 탈퇴" onclick="unreg()">
			<%
			} else {
			%>
			<input type="button" style="visibility: hidden;">
			<%
			}
			%>
		</div>
	</div>
	
		<div id="content-wrap-wrap" class="content-wrap-wrap">
			<div class="content-wrap">
				<table id="joined-members">
					<tr>
						<td><div>가입한 멤버 <%=String.valueOf(memberList.size()) %></div></td>
					</tr>
					<%
						for (int i = 0; i < memberList.size(); i++) {
					%>
					<tr class='joined-members-list'>
						<td class='joined-members-name-wrap' onclick='location.href="<%=request.getContextPath()%>/profile.jsp?id=<%=memberList.get(i).getMember_idx()%>"'>
							
							<div class='joined-members-name'>
							<%=memberList.get(i).getMember_name() %>
							<%
							if (memberList.get(i).getMember_idx() == guildDto.getGuildMasterIdx()) {
								out.write("👑");
							}
							%>
							</div>
							
						</td>
						<%
							if ((sessionIdx == guildDto.getGuildMasterIdx() || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) && memberList.get(i).getMember_idx() != guildDto.getGuildMasterIdx()) {
						%>
						<td class="member-remove-wrap">
							<div class='member-remove-button-wrap'>
								<input class='joined-member-button change-master-button' type="button" value="길드마스터 위임" onclick="changeMaster(<%=memberList.get(i).getMember_idx() %>, this)">
								<input class='joined-member-button member-remove-button' type="button" value="🚫" onclick="removeMember(<%=memberList.get(i).getMember_idx()%>, this)">
							</div>
						</td>
						<%
							}
						%>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div class="content-wrap">
				<table>
					<tr>
						<td><div>가입 대기중인 멤버 <%=String.valueOf(joinWaitingList.size()) %></div></td>
					</tr>
					<%
						if (joinWaitingList.size() == 0) {
					%>
					<tr>
						<td><div>가입 대기중인 멤버가 없습니다.</div></td>
					</tr>
					<%
						} else {
							for (int i = 0; i < joinWaitingList.size(); i++) {
					%>
					<tr class="join-wating-members-list">
						<td class="join-waiting-members-name-wrap" onclick='location.href="<%=request.getContextPath()%>/profile.jsp?id=<%=joinWaitingList.get(i).getMember_idx()%>"'>
							<div class='join-waiting-members-name'>
								<%=joinWaitingList.get(i).getMember_name() %>
							</div>
						</td>
						<%
							if (sessionIdx == guildDto.getGuildMasterIdx() || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) {
						%>
						<td class="join-accept-wrap">
							<div class='join-accept-buttons'>
								<input class='join-accept-button' type="button" value="✔️" onclick="acceptJoin(<%=joinWaitingList.get(i).getMember_idx()%>, this)">
								<input class='join-accept-button join-deny' type="button" value="❌" onclick = "denyJoin(<%=joinWaitingList.get(i).getMember_idx()%>, this)">
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
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>
