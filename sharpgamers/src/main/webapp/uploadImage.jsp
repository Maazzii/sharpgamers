<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File, com.oreilly.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String uploadPath = new File("C:/Users/tlwlr/OneDrive/문서/이젠/갠프할거/solproject/gameinside/src/main/webapp/uploadedImages").getAbsolutePath();
int maxSize = 10 * 1024 * 1024;
MultipartRequest mr = new MultipartRequest(request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());

// 클라이언트가 업로드한 파일명을 MultipartRequest 객체를 통해 얻음

// 1. <form> 태그의 <input type="file">의 이름들(uploadfile, ...)을 반환받음
Enumeration fileTypeNames = mr.getFileNames();

// 2. <input type="file"> 태그의 name을 이용해 value값(업로드한 파일명)을 얻음
String fileName = (String) fileTypeNames.nextElement();
String systemFileName = mr.getFilesystemName(fileName);
String originalFileName = mr.getOriginalFileName(fileName);

out.write(request.getContextPath() + "/uploadedImages/" + systemFileName);
%>