<%@page import="dao.GameDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<%
	request.setCharacterEncoding("UTF-8");
	String favorite = request.getParameter("favorite");
	int gameId = Integer.parseInt(request.getParameter("gameId"));
	gameDto = gameDao.getGameInfo(gameId, gameDto);
	int sessionIdx = 0;
	String sessionId = (String) session.getAttribute("id");
	if (sessionId != null) {
		memberDto = memberDao.getMemberInfo(sessionId, memberDto);
		sessionIdx = memberDto.getMember_idx();
	} 
	gameDto = new GameDto();
	if (sessionIdx != 0) {
		if (favorite.equals("add")) {
			memberDto = memberDao.addFavorite(gameId, memberDto);
		} else if (favorite.equals("remove")) {
			memberDto = memberDao.removeFavorite(gameId, memberDto);
		}
	}
	
	if(favorite.equals("loadMember")) {
		memberDto = memberDao.getMemberInfo(Integer.parseInt(request.getParameter("memberIdx")), memberDto);
	}
	
	String favoriteIdxList = memberDto.getFav_game();
	String[] favoriteGames = favoriteIdxList.split(":");
	String favoriteNameList = "";
	String platformList = "";
	
	if (favoriteGames.length != 0) {
		for (String favoriteGame : favoriteGames) {
			favoriteNameList += gameDao.getGameInfo(Integer.parseInt(favoriteGame), gameDto).getGame_name() + "::";
			platformList += gameDao.getGameInfo(Integer.parseInt(favoriteGame), gameDto).getGame_Platform() + ":";
		} 
	} else {
		favoriteNameList = "::";
		platformList = ":";
	}
	
	
	out.write(favoriteIdxList + ",,," + favoriteNameList + ",,," + platformList);
%>