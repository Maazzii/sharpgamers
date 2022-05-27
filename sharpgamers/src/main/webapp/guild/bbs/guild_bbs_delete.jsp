<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id = "boardDao"  class="board.GuildsBoardDao"/>
<jsp:useBean id = "boardDto"  class="board.GuildsBoardDto"/>
<jsp:useBean id = "memberDao"  class="dao.MemberDao"/>
<jsp:useBean id = "memberDto"  class="dao.MemberDto"/>
<jsp:useBean id = "sessionDto"  class="dao.MemberDto"/>
<%
request.setCharacterEncoding("utf-8");
String pageNum = request.getParameter("pageNum");
String writer_id = (String) session.getAttribute("id");
if (writer_id == null) {
	response.sendRedirect(request.getContextPath() + "/main.jsp");
}
	String num = request.getParameter("num");
  boardDto = boardDao.getArticle(Integer.parseInt(num));
  memberDto = memberDao.getMemberInfo(writer_id, memberDto);
  
  if ((boardDto.getWriterId() != memberDao.getMemberInfo((String) session.getAttribute("id"), sessionDto).getMember_idx() 
  		&& memberDao.getMemberInfo((String) session.getAttribute("id"), sessionDto).getMember_auth() != 2) 
  		|| memberDao.getMemberInfo((String) session.getAttribute("id"), sessionDto).getMember_auth() == 1) {
  	out.write("<script>alert('삭제 권한이 없습니다.')</script>");
  	out.write("<script>history.back()</script>");
  } else {
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글삭제</title>
<link type="text/css" rel="stylesheet" href="../css/bbs.css"></link>
</head>
<body>

<div style="margin-top: 50px"><h3>글 삭제</h3></div>
   
<form action="guild_bbs_deletePro.jsp">

   <input type="hidden" name="num" value="<%=num %>"/>
   <input type="hidden" name="guildId" value="<%=boardDto.getGuildId()%>"/>
	<input type="hidden" name="pageNum" value="<%=pageNum %>"/>

<table>
	<tr>
		<th bgcolor="#FFFFB4">정말 삭제하시겠습니까?</th>
	</tr>
	<tr>
		<td>
			<input type="submit" value="삭제하기"/>&nbsp; | &nbsp;
			<input type="button" value="목록보기" onclick="window.location='game_bbs.jsp?id=<%=boardDto.getGuildId() %>&pageNum=<%=pageNum %>' "/>
		</td>
	</tr>
</table>

</form>

</body>
</html>
<% } %>