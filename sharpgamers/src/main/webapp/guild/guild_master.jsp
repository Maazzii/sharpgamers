<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />
<%
request.setCharacterEncoding("utf-8");
String guildIdStr = request.getParameter("guildId");
int guildId = Integer.parseInt(guildIdStr);
int sessionIdx = 0;
String sessionId = (String) session.getAttribute("id");
if (sessionId != null) {
	memberDto = memberDao.getMemberInfo(sessionId, memberDto);
	sessionIdx = memberDto.getMember_idx();
} 
guildDto = guildDao.getGuildInfo(guildId, guildDto);

if (sessionIdx == guildDto.getGuildMasterIdx() || memberDto.getMember_auth() == 2) {
	int targetIdx = Integer.parseInt(request.getParameter("memberIdx"));
	guildDao.changeMaster(targetIdx, guildDto);
	out.write("0"); // 정상 변경
} else {
	out.write("1"); // 권한 없음
}
%>