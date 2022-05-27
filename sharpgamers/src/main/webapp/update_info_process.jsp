<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<%
request.setCharacterEncoding("utf-8");
String sessionId = (String) session.getAttribute("id");
memberDto = memberDao.getMemberInfo(sessionId, memberDto);
String fn = request.getParameter("fn");

if (fn.equals("pw")) {
	String currPw = request.getParameter("currPw");
	String newPw1 = request.getParameter("newPw1");
	String newPw2 = request.getParameter("newPw2");
	
	if (!currPw.equals(memberDto.getMember_pw())) {
		out.write("1"); // 현재 비밀번호가 틀림
	} else {
		if (!newPw1.equals(newPw2)) {
			out.write("2"); // 새 비밀번호가 맞지 않음
		} else {
			if (currPw.equals(newPw1)) {		
				out.write("3"); // 새 비밀번호가 현재 비밀번호와 같음
			} else {
				memberDto.setMember_pw(newPw1);
				memberDao.updateMemberInfo(memberDto);
				out.write("0"); // 정상 변경
			}
		}
	}
	
} else if (fn.equals("name")) {
	String name = request.getParameter("name");

	if (memberDao.isNickNameExist(name)) {
		out.write("1"); // 존재하는 닉네임
	} else {
		memberDto.setMember_name(name);
		memberDao.updateMemberInfo(memberDto);
		out.write("0"); // 정상 변경
	}
} else if (fn.equals("phone")) {
	String phone = request.getParameter("phone");
	memberDto.setPhone_no(phone);
	memberDao.updateMemberInfo(memberDto);
	out.write("0");
}
%>