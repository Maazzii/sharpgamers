<%@page import="dao.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="gamesBoardDao" class="board.GamesBoardDao" />
<jsp:useBean id="gamesBoardDto" class="board.GamesBoardDto" />
<%
	request.setCharacterEncoding("UTF-8");
	String like = request.getParameter("like");
	int bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
	gamesBoardDto = gamesBoardDao.getArticle(bbsNum);
	memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
	int sessionIdx = 0;
	if (memberDto != null) {
		sessionIdx = memberDto.getMember_idx();
	}
	memberDto = new MemberDto();
	if (sessionIdx != 0) {
		if (like.equals("add")) {
			gamesBoardDto = gamesBoardDao.addLike(sessionIdx, gamesBoardDto);
		} else if (like.equals("remove")) {
			gamesBoardDto = gamesBoardDao.removeLike(sessionIdx, gamesBoardDto);
		}
	}
	
	String likeIdxList = gamesBoardDto.getLikedUsers();
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