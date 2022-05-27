<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="dao.MemberDto" />
<jsp:useBean id="dao" class="dao.MemberDao" />
<%
	request.setCharacterEncoding("UTF-8");
	String check = request.getParameter("check");
	String value = request.getParameter("value");
	
	if (check.equals("id")) {
		if (dao.getMemberInfo(value, dto) == null) {
			out.write("0"); // 사용가능한 ID
		} else {
			out.write("1"); // 존재하는 ID
		}
	}
	
	if (check.equals("name")) {
		if (!dao.isNickNameExist(value)) {
			out.write("0"); // 사용가능한 닉네임
		} else {
			out.write("1"); // 존재하는 닉네임
		}
	}
%>