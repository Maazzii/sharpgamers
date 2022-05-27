<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.MessageDto"%>
<%@page import="dao.MemberDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="messageDao" class="dao.MessageDao" />
<jsp:useBean id="messageDto" class="dao.MessageDto" />
<%
request.setCharacterEncoding("utf-8");
String fn = request.getParameter("fn");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

int sessionIdx = 0;
String sessionId = (String) session.getAttribute("id");
if (sessionId != null) {
	memberDto = memberDao.getMemberInfo(sessionId, memberDto);
	sessionIdx = memberDto.getMember_idx();
}

if (fn.equals("load")) {
	int targetIdx = Integer.parseInt(request.getParameter("idx"));
	List<MessageDto> messageList = messageDao.getMessages(sessionIdx, targetIdx);
	messageDao.readUpdate(targetIdx, sessionIdx);
	
	for (int i = 0; i < messageList.size(); i++) {
		String sentDate = sdf.format(messageList.get(i).getSentDate());
		
		if (messageList.get(i).getSenderId() == sessionIdx) {
			out.write("<div class='message-sent-wrap'>");
		} else {
			out.write("<div class='message-received-wrap'>");
		}
		if (i == 0) {			
			out.write("<div class='message message-first'>");
		} else {			
			out.write("<div class='message'>");
		}
		out.write("<div class='message-sender'>");
		out.write("<a href='profile.jsp?id=" + messageList.get(i).getSenderId() + "'>");
		out.write(memberDao.getMemberInfo(messageList.get(i).getSenderId(), memberDto).getMember_name());
		out.write("</a></div>");
		out.write("<div class='message-content'>");
		out.write(messageList.get(i).getContent());
		out.write("</div>");
		out.write("<div class='message-sent-date'>" + sentDate + "</div>");
		out.write("</div></div>");
	}
	
} else if (fn.equals("send")) {
	int receiverId = Integer.parseInt(request.getParameter("receiverId"));
	String content = request.getParameter("content");
	
	messageDto.setSenderId(sessionIdx);
	messageDto.setReceiverId(receiverId);
	messageDto.setContent(content);
	
	messageDao.sendMessage(messageDto);
}
%>