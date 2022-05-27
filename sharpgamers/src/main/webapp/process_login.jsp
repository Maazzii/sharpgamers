<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:useBean id="dao" class="dao.MemberDao" />

	<%
	request.setCharacterEncoding("UTF-8");
	String member_id = request.getParameter("member_id");
	String member_pw = request.getParameter("member_pw");
	int result = dao.login(member_id, member_pw);

	if (result != 0) { // 회원인 경우
		out.print("0"); // 정상 로그인 반환
		// 회원정보를 유지하기 위해 session 객체 이용
		session.setAttribute("id", member_id);
		response.sendRedirect("main.jsp");
	} else { // 회원이 아닌 경우
		out.print("1"); // 비정상 로그인
		out.print("<script>history.back()</script>");
	}
	%>