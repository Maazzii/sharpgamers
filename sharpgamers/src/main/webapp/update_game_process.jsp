<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />

<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("id") == null) {
		response.sendRedirect("login.jsp");
	} else {
		memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
		if (memberDto.getMember_auth() != 2) {
			out.write("<script>alert('접근 권한이 없습니다.')</script>");
			out.write("<script>history.back()</script>");
		} else {
			
			gameDto.setGame_id(Integer.parseInt(request.getParameter("gameId")));
			gameDto.setGame_Platform(request.getParameter("platform"));
			gameDto.setGame_name(request.getParameter("name").replace("\"", "'").replace(";", ":"));
			gameDto.setGame_img_src(request.getParameter("imgSrc"));
			gameDto.setGame_link(request.getParameter("link"));
			
			gameDao.updateGame(gameDto);
			gameDto = gameDao.getGameInfo(gameDto.getGame_Platform(), gameDto.getGame_name(), gameDto);
			
			
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	body {
		background-image: url("<%=request.getContextPath()%>/images/background.png");
		margin: 0px;
	}
	
	div#wrapper {
		min-width: 700px;
		max-width: 900px;
		min-height: 70vh;
		margin: auto;
		padding: 150px 100px 100px; 
		background : rgba( 255, 255, 255, 0.6);
		backdrop-filter: blur(10px);
		position: relative;
		box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.2);
		background: rgba(255, 255, 255, 0.6);
	}
	
	footer {
		width: 100%;
		height: 200px;
		position: absolute;
		background-color: white;
		z-index: 99;
	}
	
	#content {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	
	button {
		margin: 20px;
		height: 40px;
		width: 100px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
		position: relative;
	}
	
	button:hover {
		cursor: pointer;
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
</style>
</head>
<body>
	<%@ include file="header.jsp"%>
	<div id="wrapper">
		<div id="content">
			<div>게임 정보가 수정되었습니다.</div>
			<a href="bbs/game_bbs.jsp?id=<%=gameDto.getGame_id()%>&pageNum=1"><button>게시판 가기</button></a>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>
<%
		}
	}
%>