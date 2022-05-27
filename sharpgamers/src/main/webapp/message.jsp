<%@page import="dao.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="senderDto" class="dao.MemberDto" />
<jsp:useBean id="receiverDto" class="dao.MemberDto" />
<jsp:useBean id="messageDao" class="dao.MessageDao" />
<jsp:useBean id="messageDto" class="dao.MessageDto" />

<%
request.setCharacterEncoding("utf-8");
int sessionIdx = 0;
String sessionId = (String) session.getAttribute("id");
if (sessionId != null) {
	senderDto = memberDao.getMemberInfo(sessionId, senderDto);
	sessionIdx = senderDto.getMember_idx();
}

String receiverId = request.getParameter("receiverId");
if (receiverId != null) {
	receiverDto = memberDao.getMemberInfo(Integer.parseInt(receiverId), receiverDto);
}

if (sessionIdx == 0) {
	response.sendRedirect("login.jsp");
} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메세지</title>
<style>

	body {
		background-image: url("<%=request.getContextPath() %>/images/background.png");
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
		height: 40px;
		width: 40%;
	}
	h1.game-title {
		position: absolute;
		bottom: 30px; 
		margin: 20px;
	}	
	
	
	div#content-wrap {
		position: relative;
		width: 100%;
		height: 600px;
		border: 1px solid lightgray;
		border-radius: 15px;
		background: rgba(255, 255, 255, 0.7);
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
		display: flex;
		justify-content: center;
		align-items: center;
		overflow: hidden;
	}
	
	#users-list {
		position: relative;
		width: 30%;
		height: 100%;
		overflow: auto;
	}
	
	#message-view {
		position: relative;
		display: flex;
		flex-direction: column;
		width: 70%;
		height: 100%;
		overflow: hidden;
	}
	
	label{
		display: flex;
		align-items: center;
		border: 1px solid lightgray;
		border-radius: 5px;
		background: rgba(255, 255, 255, 0.7);
		padding: 5px;
		margin-bottom: 5px;
	}
	
	label input {
		margin-left: 10px;
		height: 20px;
		width: 20px;
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
		border-bottom: 1px solid lightgray;
	}
	
	td>div {
		padding: 0px 20px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	td:hover {
		cursor: pointer;
		background-color: rgba(0, 191, 134, 0.2);
	}
	
	div#users-list {
		border-right: 1px solid darkgray;
	}
	
	div.member-idx {
		display: none;
	}
	
	#users-list td {
		height: 50px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	div.unread-count-for-member {
		margin-right: 20px;
		padding: 0px;
		width: 30px;
		height: 24px;
		display: flex;
		justify-content: center;
		align-items: center;
		font-size: 14px;
		border-radius: 12px;
		background-color: rgba(0, 191, 134, 0.4);
	}
	
	div#message-receiver {
		height: 25px;
		padding-left: 20px;
		font-size: 14px;
		font-weight: bold;
		display: flex;
		align-items: center;
		border-bottom: 1px solid darkgray;
	}
	
	div#message-list {
		display: block;
		flex-direction: column;
		justify-content: flex-end;
		position: relative;
		width: 100%;
		height: 90%;
		overflow: auto;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	div.message-sent-wrap {
		display: flex;
		width: 100%;
		justify-content: flex-end;
		text-align: right;
	}
	
	div.message-received-wrap {
		display: flex;
		width: 100%;
		justify-content: flex-start;
	}
	
	div.message {
		position: relative;
		max-width: 60%;
		margin: 0px 20px 20px 20px;
	}
	
	div.message-first {
		margin: 20px;
	}
	
	div.message-sender {
		font-size: 14px;
		font-weight: bold;
	}
	
	div.message-content {
		margin: 5px 0px;
		padding: 10px;
		border: 1px solid darkgray;
		border-radius: 7px;
		word-break: break-all;
	}
	
	div.message-sent-wrap .message-content {
		background-color: rgba(0, 191, 134, 0.2);
	}
	div.message-received-wrap .message-content {
		background-color: rgba(255, 255, 255, 0.1);
	}
	div.message-sent-date {
		font-size: 12px;
	}
	
	div#message-input {
		position: relative;
		border-top: 1px solid darkgray;
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		height: 10%;
		padding: 0px 20px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	div#message-input * {
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	input.message-text {
		width: 80%;
		font-size: 16px;
		height: 30px;
		padding: 0px 10px;
		border: none;
		background: none;
	}
	
	input.message-send-button {
		width: 100px;
		height: 30px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
	}
	
	input.message-send-button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
	
</style>
<script src="./jquery/jquery-3.6.0.min.js"></script>
<script>
function clickMember(obj) {
	var idx = $(obj).find(".member-idx").text();
	$("input.message-receiver-idx").val(idx);
	$("#message-receiver").text($(obj).find(".member-name").text() + "님과의 대화");
	loadMessages(idx);
	setTimeout(function() {
		$("#message-list").scrollTop(9999999999999);		
	}, 100);
}
function loadMessages(idx) {
	$.ajax({
		type: "post",
		url: "message_process.jsp",
		data: "fn=load&idx=" + idx,
		success: function(data) {
			$("#message-list").html(data.trim());
			$("#message-list").scrollTop(9999999999999);
			$("#users-list table").load(location.href + " #users-list table");
			$("#header-right-side").load(location.href + ' #header-right-side');
		}
	});
}

function sendMessage() {
	var receiverId = $("input.message-receiver-idx").val();
	var content = $("input.message-text").val();
	
	if (receiverId == '') {
		alert('멤버를 선택해 주세요.');
		return;
	}
	if (content == '') {
		return;
	}

	$.ajax({
		type: "post",
		url: "message_process.jsp",
		data: "fn=send&receiverId=" + receiverId + "&content=" + content,
		success: function() {
			loadMessages(receiverId);
			$("input.message-text").val("");
		}
	});
}

var refresh;

function toggleRefresh() {
	if ($("#refresh").is(":checked")) {
		refresh = setInterval(function() {
			if ($(".message-receiver-idx").val() != '') {
			loadMessages($(".message-receiver-idx").val());
			}
		}, 1000);
	} else {
		clearInterval(refresh);
	}
}
</script>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="wrapper">
		<div id="game-title-wrap">
			<div id="game-title">
		<h1 class="game-title">메시지</h1>
			</div>
			
			<div class="refresh-wrap">
				<label>1초마다 자동 로드 <input id="refresh" type="checkbox" onclick="toggleRefresh()"></label>
			</div>
		</div>

		<div id="content-wrap">
			<div id="users-list">
				<table>
				<%
					List<MemberDto> memberList = messageDao.getConnectedMembers(sessionIdx);
					int receiverIndex = -1;
					int unRead = 0;
					for (int i = 0; i < memberList.size(); i++) {
						if (memberList.get(i).getMember_idx() == receiverDto.getMember_idx()) {
							unRead = messageDao.countUnread(memberList.get(i).getMember_idx(), sessionIdx);
							receiverIndex = i;
						}
				%>
					<tr>
						<td onclick="clickMember(this)">
							<div class="member-idx"><%=memberList.get(i).getMember_idx() %></div>
							<div class="member-name"><%=memberList.get(i).getMember_name() %></div>
				<%
					if (messageDao.countUnread(memberList.get(i).getMember_idx(), sessionIdx) > 0) {
				%>
							<div class="unread-count-for-member"><%=messageDao.countUnread(memberList.get(i).getMember_idx(), sessionIdx) %></div>
				<%
					}
				%>
						</td>
					</tr>
				<%
					}
					if (receiverDto.getMember_idx() != 0) {
						if (receiverIndex == -1) {
				%>	
					<tr>
						<td onclick="clickMember(this)">
							<div class="member-idx"><%=receiverDto.getMember_idx() %></div>
							<div class="member-name"><%=receiverDto.getMember_name() %></div>
						</td>
					</tr>
				<%
						}
					}
				%>
				</table>
			</div>
			<div id="message-view">
				<div id="message-receiver"></div>
				<div id="message-list">
				</div>
				<div id="message-input">
					<input type="hidden" class="message-receiver-idx" value="">
					<input type="text" class="message-text" onKeypress="javascript:if(event.keyCode==13) {sendMessage()}" placeholder="입력">
					<input type="button" class="message-send-button" value="전송" onclick="sendMessage()">
				</div>
			</div>
		</div>
	</div>
	<%
		if (receiverDto.getMember_idx() != 0) {
			if (receiverIndex != -1) {
	%>
	<script>
	$(function() {
		clickMember($("td").eq(<%=receiverIndex%>));
	})
	</script>
	<%
			} else {

	%>
	<script>
	$(function() {
		clickMember($("td").last());
	})
	</script>
	<%
			}
		}
	%>

	<%@ include file="footer.jsp"%>
</body>
</html>
<%}%>