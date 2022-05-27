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
	String game_id = request.getParameter("game_id");
	%>
	<jsp:useBean id="dto" class="board.GamesBoardDto" />
	<jsp:setProperty property="*" name="dto" />
	<jsp:useBean id="dao" class="board.GamesBoardDao" />
	<%
	if(dao.insert(dto) == 1) {
		response.sendRedirect("game_bbs_writeEnd.jsp?game_id=" + game_id + "&pageNum=1");
	} else {
		out.print("<script>alert('게시글 입력 실패');history.back();</script>");
	}
	%>
</body>
</html>