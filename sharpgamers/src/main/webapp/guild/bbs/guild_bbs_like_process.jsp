<%@page import="dao.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="guildsBoardDao" class="board.GuildsBoardDao" />
<jsp:useBean id="guildsBoardDto" class="board.GuildsBoardDto" />
<%
	request.setCharacterEncoding("UTF-8");
	String like = request.getParameter("like");
	int bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
	guildsBoardDto = guildsBoardDao.getArticle(bbsNum);
	memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
	int sessionIdx = 0;
	if (memberDto != null) {
		sessionIdx = memberDto.getMember_idx();
	}
	memberDto = new MemberDto();
	if (sessionIdx != 0) {
		if (like.equals("add")) {
			guildsBoardDto = guildsBoardDao.addLike(sessionIdx, guildsBoardDto);
		} else if (like.equals("remove")) {
			guildsBoardDto = guildsBoardDao.removeLike(sessionIdx, guildsBoardDto);
		}
	}
	
	String likeIdxList = guildsBoardDto.getLikedUsers();
	String[] likeNames = likeIdxList.split(":");
	String likeNameList = "";
	
	if (likeNames.length != 0) {
		for (String likeName : likeNames) {
			likeNameList += memberDao.getMemberInfo(Integer.parseInt(likeName), memberDto).getMember_name() + ":";
		} 
	} else {
		likeNameList = ":";
	}
	out.write(likeIdxList + ",,," + likeNameList);
%>