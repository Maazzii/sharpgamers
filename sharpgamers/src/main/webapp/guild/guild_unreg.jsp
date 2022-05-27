<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />
<%
request.setCharacterEncoding("utf-8");
int sessionIdx = 0;
String sessionId = (String) session.getAttribute("id");
if (sessionId != null) {
	memberDto = memberDao.getMemberInfo(sessionId, memberDto);
	sessionIdx = memberDto.getMember_idx();
} 

int guildId = Integer.parseInt(request.getParameter("guildId"));
guildDto = guildDao.getGuildInfo(guildId, guildDto);
guildDao.removeMember(sessionIdx, guildDto);


%>