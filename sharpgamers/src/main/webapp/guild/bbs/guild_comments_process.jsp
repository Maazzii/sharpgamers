
<%@page import="board.GuildsCommentDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="commentDao" class="board.GuildsCommentDao" />
<jsp:useBean id="commentDto" class="board.GuildsCommentDto" />
<jsp:useBean id="boardDao" class="board.GuildsBoardDao" />
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="guildDao" class="dao.GuildDao" />
<jsp:useBean id="guildDto" class="dao.GuildDto" />
<%
request.setCharacterEncoding("UTF-8");
String sessionId = (String) session.getAttribute("id");
int sessionIdx = 0;
if (sessionId != null) {
	sessionIdx = memberDao.getMemberInfo(sessionId, memberDto).getMember_idx();
}
String fn = request.getParameter("fn");
int bbsNum = Integer.parseInt(request.getParameter("bbsNum"));
guildDto = guildDao.getGuildInfo(boardDao.getArticle(bbsNum).getGuildId(), guildDto);

if (fn.equals("load")) {
	List<GuildsCommentDto> articleList = commentDao.getArticles(bbsNum);

	for (int i = 0; i < articleList.size(); i++) {
		commentDto = (GuildsCommentDto) articleList.get(i);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String reg_date = sdf.format(commentDto.getRegDate());
		
		out.write("<div class='comments'>");
		out.write("<div class='comment-id' style='display: none;'>");
		out.write(String.valueOf(commentDto.getCommentId()));
		out.write("</div><div class='comment-first-row'><div class='comment-writer'><a href='../profile.jsp?id=");
		out.write(String.valueOf(commentDto.getWriterId()));
		out.write("'>");
		out.write(commentDto.getWriter());
		out.write("</a></div></div><div class='comment-second-row'><div class='comment-content'>");
		out.write(commentDto.getContent());
		out.write("</div></div><div class='comment-third-row'><div class='comment-reg-date'>");
		out.write(reg_date);
		out.write("</div><div class='comment-buttons-wrap'>");
			if (commentDto.getWriterId() == sessionIdx || guildDto.getGuildMasterIdx() == sessionIdx || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) {
				out.write("<input class='comment-button comment-modify-button' type='button' value='수정' onclick='showCommentUpdate(this)'>");
				out.write("<input class='comment-button comment-remove-button' type='button' value='삭제' onclick='removeComment(this)'>");
			}
		out.write("</div></div></div>");
	}
} else if (fn.equals("insert")) {
		int writerId = Integer.parseInt(request.getParameter("writerId"));
		String content = request.getParameter("content");
		if (sessionIdx == writerId && memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() != 1) {
			commentDto.setWriter(memberDao.getMemberInfo(sessionIdx, memberDto).getMember_name());
			commentDto.setWriterId(sessionIdx);
			commentDto.setContent(content);
			commentDto.setBbsNum(bbsNum);
			int result = commentDao.insert(commentDto);
			if (result == 1) {
				out.write("0"); // 정상 등록
			} else {
				out.write("2"); // 등록 오류
			}
		} else {
			out.write("1"); // 권한 없음
		}
} else if (fn.equals("remove")) {
	int commentId = Integer.parseInt(request.getParameter("commentId"));
	int writerId = Integer.parseInt(request.getParameter("writerId"));
	if ((sessionIdx == writerId || guildDto.getGuildMasterIdx() == sessionIdx || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) && memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() != 1) {
		commentDao.delete(commentId);
		out.write("0"); // 정상 삭제
	} else {
		out.write("1"); // 권한 없음
	}
} else if (fn.equals("update")) {
	int commentId = Integer.parseInt(request.getParameter("commentId"));
	int writerId = Integer.parseInt(request.getParameter("writerId"));
	String content = request.getParameter("content");
	if ((sessionIdx == writerId || guildDto.getGuildMasterIdx() == sessionIdx || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) && memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() != 1) {
		commentDto = commentDao.getArticle(commentId);
		commentDto.setContent(content);
		commentDao.update(commentDto);
		
		out.write("0");
	} else {
		out.write("1"); // 권한 없음
	}
}
%>