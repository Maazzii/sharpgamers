<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	request.setCharacterEncoding("utf-8");
	String guildId = request.getParameter("guildId");
	%>
	<jsp:useBean id="dto" class="board.GuildsBoardDto" />
	<jsp:setProperty property="*" name="dto" />
	<jsp:useBean id="dao" class="board.GuildsBoardDao" />
	<%
	if(dao.insert(dto) == 1) {
		response.sendRedirect("guild_bbs_writeEnd.jsp?guildId=" + guildId + "&pageNum=1");
	} else {
		out.print("<script>alert('게시글 입력 실패');history.back();</script>");
	}
	%>
</body>
</html>