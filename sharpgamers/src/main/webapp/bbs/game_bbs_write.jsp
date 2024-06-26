<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardDao" class="board.GamesBoardDao" />
<jsp:useBean id="boardDto" class="board.GamesBoardDto" />
<jsp:useBean id="memberDao" class="dao.MemberDao" />
<jsp:useBean id="memberDto" class="dao.MemberDto" />
<jsp:useBean id="gameDao" class="dao.GameDao" />
<jsp:useBean id="gameDto" class="dao.GameDto" />
<%
request.setCharacterEncoding("utf-8");
String pageNum = request.getParameter("pageNum");
String game_id_str = request.getParameter("id");
String writer_id = (String) session.getAttribute("id");
if (writer_id == null || game_id_str == null) {
	response.sendRedirect("../main.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	body {
		background-image: url("../images/background.png");
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
		
	input[type=button], input[type=submit], input[type=reset] {
		cursor: pointer;
	}
	button:hover {
		cursor: pointer;
	}
	
	div#game-title-wrap {
		display: flex;
		justify-content: space-between;
		position: relative;
		width: 100%;
	}
	div#game-title {
		position: relative;
		height: 40px;
		width: 100%;
	}
	h1.game-title {
		position: absolute;
		bottom: 30px; 
		margin: 20px;
	}	
	div#content-wrap {
		position: relative;
		width: 100%;
		border: 1px solid lightgray;
		border-radius: 15px;
		background: rgba(255, 255, 255, 0.7);
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
		
	table {
		width: 100%;
		border-collapse: collapse;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	
	tr {
		height: 50px;
	}
	
	tr:last-child {
		height: 80px;
	}
	
	tr:not(tr:last-child) {
		border-bottom: 1px solid lightgray;
	}
	
	td>div {
		padding: 0px 20px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	input[name=subject] {
		width: 100%;
		font-size: 18px;
		background-color: rgba(255, 255, 255, 0.0);
		border: 0px;
		border-radius: 3px;
		margin: 20px 0px;
		padding: 10px;
		-webkit-box-sizing: border-box; /* Safari/Chrome, other WebKit */
		-moz-box-sizing: border-box;    /* Firefox, other Gecko */
		box-sizing: border-box;         /* Opera/IE 8+ */
	}
	
	.outter-buttons-wrap {
		width: 100%;
		padding: 50px 0px;
		display: flex;
		justify-content: flex-end;
	}
	
	.outter-button {
		margin-left: 15px;
		height: 40px;
		width: 120.5px;
		border: 2px solid rgba(0, 191, 134, 0.2);
		border-radius: 5px;
		background-color: rgba(0, 191, 134, 0.1);
		position: relative;
	}
	
	.outter-button-reset {
		background-color: rgba(255, 255, 255, 0.2);
	}
	
	.outter-button:hover {
		border: 2px solid rgba(0, 191, 134, 0.4);
	}
	
</style>
<script src="<%=request.getContextPath() %>/jquery/jquery-3.6.0.min.js"></script>
<script src="<%=request.getContextPath() %>/summernote/summernote-lite.js"></script>
<script src="<%=request.getContextPath() %>/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/summernote/summernote-lite.css">
<script>
$(function() {
	
	$('#summernote').summernote({
			toolbar: [
			    // [groupName, [list of button]]
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert',['link','picture', 'video']],
			    ['view', ['help']]
			  ],
			fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		  height: 500,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  dialogsInBody: true,
		  maximumImageFileSize: 10 * 1024 * 1024,
		  callbacks: {
			  onImageUpload: function(files, editor, welEditable) {
				  var alerted = false;
				  for (var i = files.length - 1; i >= 0; i--) {
						if (files[i].size > 10 * 1024 * 1024) {
							if(!alerted) {
								alert('10MB 이하의 파일만 업로드 가능합니다.');
								alerted = true;
							}
							continue;
						}
					  uploadImage(files[i], this);
				  }
			  }
		  }
	});
	$('#summernote').summernote('fontName', '맑은 고딕');
});

function uploadImage(file, el) {
	var formData = new FormData();
	formData.append("file", file);
	$.ajax({
		type: "post",
		data: formData,
		contentType: false,
		processData: false,
		url: "<%=request.getContextPath()%>/uploadImage.jsp",
		success: function(data) {
			$(el).summernote('editor.insertImage', data.trim());
		}
	})
	
}

function formReset() {
	$(write)[0].reset();
	$('#summernote').summernote('reset');
}
</script>
</head>
<body>

	<%@ include file="../header.jsp"%>
	<div id="wrapper">
<%
	int game_id = Integer.parseInt(game_id_str);
	gameDto = gameDao.getGameInfo(game_id, gameDto);
	memberDto = memberDao.getMemberInfo(writer_id, memberDto);
	if (memberDto.getMember_auth() == 1) {
		out.write("<script>alert('글쓰기 권한이 없습니다.')</script>");
		out.write("<script>history.back();</script>");
	} else {
	%>

	<div id="game-title-wrap">
		<div id="game-title">
	<h1 class="game-title"><a href="game_bbs.jsp?id=<%=game_id_str%>&pageNum=1"><%=gameDto.getGame_name()%></a></h1>
		</div>
	</div>

	<div id="content-wrap">
<div>
	<form method="post" action="game_bbs_writePro.jsp" name="write" id="write">
		<input type="hidden" name="game_id" value="<%=game_id%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="writer" value="<%=memberDto.getMember_name()%>">
		<input type="hidden" name="writerId" value="<%=memberDto.getMember_idx()%>">
		<table>
			<tr>
				<td><div style="margin-top: 30px; margin-left: 10px;"><h3>글쓰기</h3></div></td>
			</tr>
			<tr>
				<td><div><input type="text" name="subject" placeholder="제목" required/></div></td>
			</tr>
			<tr>
				<td><div style="margin: 20px 0px;"><textarea id="summernote" name="content" ></textarea></div></td>
			</tr>
		</table>
					<!--<input type="button" value="테스트" onclick="javascript: console.log($(write).serialize())">
					<input type="submit" value="글등록"/> &nbsp; | &nbsp;
					<input type="reset" value="다시쓰기"/>&nbsp; | &nbsp;
					<input type="button" value="뒤로가기" onclick="history.back();"/>-->
	</form>
</div>
</div>
<div class="outter-buttons-wrap">
	<div class="buttons">
		<button class="outter-button outter-button-reset" onclick="formReset()">다시쓰기</button>
		<button class="outter-button" onclick="javascript: $(write).submit()">등록</button>
	</div>
	</div>

</div>
	<%@ include file="../footer.jsp"%>
	<%} %>
</body>
</html>