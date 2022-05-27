<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<%
request.setCharacterEncoding("utf-8");

int sessionIdx = 0;
boolean isAdmin = false;
if (session.getAttribute("id") != null) {
	sessionIdx = 0;
	memberDto = memberDao.getMemberInfo((String) session.getAttribute("id"), memberDto);
	if (memberDto.getMember_auth() == 2) {
		isAdmin = true;
	}
} else {
	response.sendRedirect("login.jsp");
}

if (isAdmin) {
	String fn = request.getParameter("fn");
	int targetIdx = Integer.parseInt(request.getParameter("targetId"));
	
	if (fn.equals("block")) {
		memberDao.blockMember(targetIdx);
		out.write("0"); // 정상 처리
	} else if (fn.equals("unblock")) {
		memberDao.unBlockMember(targetIdx);
		out.write("0"); // 정상 처리
	}
} else {
	out.write("1"); // 권한 없음
}
%>