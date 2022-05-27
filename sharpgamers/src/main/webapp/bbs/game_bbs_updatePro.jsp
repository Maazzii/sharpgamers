<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글수정 처리</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	
%>

<jsp:useBean id="dto" class="board.GamesBoardDto"/>
<jsp:setProperty name="dto" property="*"/>
<jsp:useBean id="dao" class="board.GamesBoardDao"/>

<% 
   try{
	dao.update(dto);
   }catch(Exception e){e.printStackTrace();}
  
	dto = dao.getArticle(num);
	String url ="game_bbs_content.jsp?id=" + dto.getGame_id() + "&pageNum=" + pageNum + "&bbsNum=" + num;
	response.sendRedirect(url);
%>

</body>
</html>