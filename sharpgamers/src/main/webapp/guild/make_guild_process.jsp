<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />

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

if (gameId != 0 && sessionIdx != 0) {
	
	guildDto.setGuildName(request.getParameter("guildName"));
	guildDto.setGuildDesc(request.getParameter("guildDesc"));
	guildDto.setGuildMasterIdx(sessionIdx);
	guildDto.setGuildMembersIdx(sessionIdx + ":");
	guildDto.setGame_id(gameId);
	
	guildDao.makeGuild(guildDto);
	

	response.sendRedirect("make_guild_end.jsp?gameId=" + gameId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 등록 완료
</body>
</html>
<%
}
%>