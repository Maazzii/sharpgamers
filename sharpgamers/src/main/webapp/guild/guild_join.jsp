<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />
<%
	request.setCharacterEncoding("utf-8");
	String fn = request.getParameter("fn");
	String guildIdStr = request.getParameter("guildId");
	int guildId = Integer.parseInt(guildIdStr);

	int sessionIdx = 0;
	String sessionId = (String) session.getAttribute("id");
	if (sessionId != null) {
		memberDto = memberDao.getMemberInfo(sessionId, memberDto);
		sessionIdx = memberDto.getMember_idx();
	} 
	guildDto = guildDao.getGuildInfo(guildId, guildDto);
	
	if (sessionIdx != 0) {
		if (fn.equals("join")) {
			if (!guildDao.isJoined(guildId, sessionIdx)) {
				guildDao.addJoinList(sessionIdx, guildDto);
			}
		} else if (fn.equals("abort")) {
			if (guildDao.isJoined(guildId, sessionIdx)) {
				guildDao.removeJoinList(sessionIdx, guildDto);
			}
		} else if (fn.equals("accept")) {
			if (sessionIdx != guildDto.getGuildMasterIdx() && memberDto.getMember_auth() != 2) {
				out.write("1"); // 권한 없음
			} else {
				int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
				if (!guildDao.isMember(guildId, memberIdx)) {
					guildDao.addMember(memberIdx, guildDto);
					guildDao.removeJoinList(memberIdx, guildDto);
					out.write("0"); // 정상 등록
				} else {
					out.write("2"); // 이미 멤버임
				}
			}
		} else if (fn.equals("deny")) {
			if (sessionIdx != guildDto.getGuildMasterIdx() && memberDto.getMember_auth() != 2) {
				out.write("1"); // 권한 없음
			} else {
				int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
				if (guildDao.isJoined(guildId, memberIdx)) {
					guildDao.removeJoinList(memberIdx, guildDto);
					out.write("0"); // 정상 제거
				} else {
					out.write("2"); // 가입목록에 없음
				}
			}
		} else if (fn.equals("remove")) {
			if (sessionIdx != guildDto.getGuildMasterIdx() && memberDto.getMember_auth() != 2) {
				out.write("1"); // 권한 없음
			} else {
				int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
				if (guildDao.isMember(guildId, memberIdx)) {
					guildDao.removeMember(memberIdx, guildDto);
					out.write("0"); // 정상 제거
				} else {
					out.write("2"); // 멤버가 아님
				}
			}
		}
	}
%>