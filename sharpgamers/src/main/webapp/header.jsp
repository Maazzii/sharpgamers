<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="headerMemberDto" class="dao.MemberDto" />
<jsp:useBean id="headerMemberDao" class="dao.MemberDao" />
<jsp:useBean id="headerMessageDao" class="dao.MessageDao" />
<style>
	header {
		width: 100%;
		height: 40px;
		position: fixed;
		top: 0px;
		background-color: white;
		z-index: 99;
	}
	header a {
		text-decoration: none;
		color: black;
		}
	#header-wrap {
		height: 100%;
		padding: 0px 50px;
		box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.2);
		display:flex; 
		justify-content: space-between; 
		align-items: center;
	}
	
	#header-wrap > a {
		display:flex; 
		justify-content: center; 
		align-items: center;
	}
	#header-right-side {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	#message-unread-count {
		padding: 0px 7px;
		height: 20px;
		border-radius: 10px;
		background-color: red; 
		margin: 0px 10px 0px 4px;
		display: flex;
		justify-content: center;
		align-items: center;
		color: white;
		font-size: 10px;
	}
</style>
<header>
<div id="header-wrap">
	<a href="<%=request.getContextPath() %>/main.jsp"><img class="logo" src="<%=request.getContextPath() %>/images/logo.png" style="height: 30px;"></a>
<%
	String id = (String) session.getAttribute("id");
	if(id != null) {
		headerMemberDto = headerMemberDao.getMemberInfo((String) session.getAttribute("id"), headerMemberDto);
%>
<div id="header-right-side">
<h4>
<%
	if (headerMemberDto.getMember_auth() == 2) {
%>
	<a href="<%=request.getContextPath() %>/manage.jsp">관리</a>&nbsp;&nbsp;&nbsp;&nbsp;
<%
	}
%>
	<a href="<%=request.getContextPath() %>/message.jsp">메시지</a></h4>
<%
	if (headerMessageDao.countUnReadForAllMember(headerMemberDto.getMember_idx()) > 0) {
%>
	<div id="message-unread-count"><%=headerMessageDao.countUnReadForAllMember(headerMemberDto.getMember_idx()) %></div>
<%
	} else {
%>
	&nbsp;&nbsp;
<%
	}
%>
	<h4>
	<a href="<%=request.getContextPath() %>/profile.jsp?id=<%=headerMemberDto.getMember_idx()%>"><%=headerMemberDto.getMember_name() %></a>&nbsp;&nbsp;<a href="<%=request.getContextPath() %>/process_logout.jsp">로그아웃</a></h4>

<%
	} else {

out.println("<h4><a href='" + request.getContextPath() + "/login.jsp'>로그인</a></h4>");
	}
	%>
	</div>
	</div>
	
</header>