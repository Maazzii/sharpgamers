<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.GuildMemoDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memoDao" class="dao.GuildMemoDao" />
<jsp:useBean id="memoDto" class="dao.GuildMemoDto" />
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

if (fn.equals("load")) {
	int guildId = Integer.parseInt(request.getParameter("guildId"));
	int masterIdx = guildDao.getGuildInfo(guildId, guildDto).getGuildMasterIdx();
	List<GuildMemoDto> articleList = memoDao.getArticles(guildId);
	
	out.write("<div class='memo-wrap'>");
	out.write("<div class='memo'>");
	out.write("<div class='memo-content memo-input-wrap'>");
	out.write("<textarea class='memo-input'></textarea>");
	out.write("</div>");
	out.write("<div class='memo-buttons-wrap'>");
	out.write("<div class='memo-buttons'>");
	out.write("<input type='button' class='memo-button memo-button-reset' value='다시쓰기' onclick='resetInsertForm(this)'>");
	out.write("<input type='button' class='memo-button memo-button-insert' value='등록' onclick='insertMemo(this)'>");
	out.write("</div></div></div></div>");
	
	for (int i = 0; i < articleList.size(); i++) {
		memoDto = articleList.get(i);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String reg_date = sdf.format(memoDto.getRegDate());
		
		out.write("<div class='memo-wrap'>");
		out.write("<input type='hidden' class='memoId' value='" + memoDto.getMemoId() + "'>");
		out.write("<div class='memo memo-loaded'>");
		out.write("<div class='memo-content memo-loaded-content'>");
		out.write(memoDto.getContent());
		out.write("</div>");
		out.write("<div class='memo-buttons-wrap'>");
		out.write("<div class='memo-buttons'>");
		if (sessionIdx == memoDto.getWriterId() || sessionIdx == masterIdx || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) {
			out.write("<input type='button' class='memo-button memo-button-update' value='수정' onclick='showUpdateForm(this)'>");
			out.write("<input type='button' class='memo-button memo-button-remove' value='삭제' onclick='removeMemo(this)'>");
		}
		out.write("</div>");
		out.write("<div class='memo-info'>");
		out.write("<div class='memo-writer'>");
		out.write("<a href='" + request.getContextPath() + "/profile.jsp?id=" + memoDto.getWriterId() + "'>");
		out.write("<b>" + memoDto.getWriter() + "</b>");
		out.write("</a></div>");
		out.write("<div class='memo-reg-date'>" + reg_date + "</div>");
		out.write("</div></div></div>");
		if (sessionIdx == memoDto.getWriterId() || sessionIdx == masterIdx || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) {
			out.write("<div class='memo memo-update'>");
			out.write("<div class='memo-content memo-input-wrap'>");
			out.write("<textarea class='memo-input'>" + memoDto.getContent() + "</textarea>");
			out.write("</div>");
			out.write("<div class='memo-buttons-wrap'>");
			out.write("<div class='memo-buttons'>");
			out.write("<input type='button' class='memo-button memo-button-close' value='닫기' onclick='closeUpdateForm(this)'>");
			out.write("<input type='button' class='memo-button memo-button-reset' value='다시쓰기' onclick='resetUpdateForm(this)'>");
			out.write("<input type='button' class='memo-button memo-button-insert' value='등록' onclick='updateMemo(this)'>");
			out.write("</div></div></div>");
		}
		out.write("</div>");
	}
	
	if ((articleList.size() + 1) % 3 == 1) {
		out.write("<div class='memo-wrap'></div>");
		out.write("<div class='memo-wrap'></div>");
	} else if ((articleList.size() + 1) % 3 == 2) {
		out.write("<div class='memo-wrap'></div>");
	}
} else if (fn.equals("insert")) {
	int guildId = Integer.parseInt(request.getParameter("guildId"));
	String content = request.getParameter("content");
	memberDto = memberDao.getMemberInfo(sessionId, memberDto);

	if (memberDto.getMember_auth() == 1) {
		out.write("1");
	} else {
		memoDto.setWriter(memberDto.getMember_name());
		memoDto.setWriterId(memberDto.getMember_idx());
		memoDto.setContent(content);
		memoDto.setGuildId(guildId);
		
		memoDao.insert(memoDto);
	}
	
} else if (fn.equals("update")) {
	int memoId = Integer.parseInt(request.getParameter("memoId"));
	String content = request.getParameter("content");
	memoDto = memoDao.getArticle(memoId);
	int masterIdx = guildDao.getGuildInfo(memoDto.getGuildId(), guildDto).getGuildMasterIdx();
	if ((sessionIdx == memoDto.getWriterId() || sessionIdx == masterIdx || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) && memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() != 1) {
		memoDto.setContent(content);
		memoDao.update(memoDto);
		out.write("0"); // 정상 업데이트
	} else {
		out.write("1"); // 권한 없음
	}
} else if (fn.equals("remove")) {
	int memoId = Integer.parseInt(request.getParameter("memoId"));
	memoDto = memoDao.getArticle(memoId);
	int masterIdx = guildDao.getGuildInfo(memoDto.getGuildId(), guildDto).getGuildMasterIdx();
	if ((sessionIdx == memoDto.getWriterId() || sessionIdx == masterIdx || memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() == 2) && memberDao.getMemberInfo(sessionIdx, memberDto).getMember_auth() != 1) {
		memoDao.delete(memoId);
		out.write("0"); // 정상 제거
	} else {
		out.write("1"); // 권한 없음
	}
}
%>