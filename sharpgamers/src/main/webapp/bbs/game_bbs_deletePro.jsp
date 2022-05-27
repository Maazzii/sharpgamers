<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글삭제 처리</title>
</head>
<body>

<jsp:useBean id = "boardDao"  class="board.GamesBoardDao"/>
<jsp:useBean id = "boardDto"  class="board.GamesBoardDto"/>
<jsp:useBean id = "memberDao"  class="dao.MemberDao"/>
<jsp:useBean id = "memberDto"  class="dao.MemberDto"/>
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<%
request.setCharacterEncoding("utf-8");
String game_id_str = request.getParameter("game_id");
String pageNum = request.getParameter("pageNum");
if (session.getAttribute("id") == null) {
	response.sendRedirect("login.jsp");
}
String writer_id = (String) session.getAttribute("id");
	String num = request.getParameter("num");
  boardDto = boardDao.getArticle(Integer.parseInt(num));
  memberDto = memberDao.getMemberInfo(writer_id, memberDto);
	int game_id = Integer.parseInt(game_id_str);
	gameDto = gameDao.getGameInfo(game_id, gameDto);
  
  if ((boardDto.getWriterId() != memberDto.getMember_idx() && memberDto.getMember_auth() != 2) || memberDto.getMember_auth() == 1) {
  	out.write("<script>alert('삭제 권한이 없습니다.')</script>");
  	out.write("<script>history.back()</script>");
  } else {
	
	/*
		파라미터 값으로 전달되는 글번호(num)을 request객체를 통해 얻고
		dao의 delete()메소드를 이용해서 게시글이 삭제되도록 구현하시오.
	*/
	try {
		boardDao.delete(Integer.parseInt(num));
	} catch (Exception e) { e.printStackTrace();}
    
   response.sendRedirect("game_bbs.jsp?id=" + request.getParameter("game_id") + "&pageNum=" + request.getParameter("pageNum"));
  }
%>

</body>
</html>