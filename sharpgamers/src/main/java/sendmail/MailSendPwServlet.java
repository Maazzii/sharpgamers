package sendmail;

import java.io.*;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import dao.MemberDto;

/**
 * Servlet implementation class MailSendServlet
 */
@WebServlet("/MailSendServletPw")
public class MailSendPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MailSendPwServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		MemberDao dao = new MemberDao();
		MemberDto dto = new MemberDto();
		String phoneNo = request.getParameter("phone_no");
		String sender = "ginsiderservice@gmail.com";
		String receiver = request.getParameter("member_id");
		String subject = "임시 비밀번호입니다.";
		String content = "";
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		dto = dao.getMemberInfo(receiver, dto);
		if (dto == null) {
			out.write("1"); // 찾는 이메일이 없음
		} else {		
			if (dto.getPhone_no().equals(phoneNo)) {
				
				String tempPw = "";
				char pwCollection[] = new char[] {
		        '1','2','3','4','5','6','7','8','9','0',
		        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
		        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
		        '!','@','#','$','%','^','&','*','(',')'};
				
				for (int i = 0; i < 10; i++) {
					tempPw += pwCollection[(int) (Math.random() * pwCollection.length)];
				}
				
				content = "<h2>임시 비밀번호입니다.</h2><p/>아래 암호로 로그인한 뒤 암호를 변경해 주세요.<p/>" + 
						"<div style='width: fit-content; font-size: 15px; border-radius: 5px; background-color: lightgray; padding: 5px;'>" + 
						tempPw + "</div>";
				


				try {
					Properties properties = System.getProperties();
					properties.put("mail.smtp.starttls.enable", "true");
					properties.put("mail.smtp.host", "smtp.gmail.com");
					properties.put("mail.smtp.auth", "true");
					properties.put("mail.smtp.port", "587");
					properties.put("mail.transport.protocol", "smtp");
					properties.put("mail.debug", "true");
					properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
					properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

					Authenticator auth = new Authenticator() {
						public PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication("ginsiderservice@gmail.com", "ldgjwutnnukusxvb");
						}
					};

					Session s = Session.getDefaultInstance(properties, auth);
					Message message = new MimeMessage(s);
					Address sender_address = new InternetAddress(sender);
					Address receiver_address = new InternetAddress(receiver);
					
					message.setHeader("content-type", "text/html;charset=UTF-8");
					message.setFrom(sender_address);
					message.addRecipient(Message.RecipientType.TO, receiver_address);
					message.setSubject(subject);
					message.setContent(content, "text/html; charset=UTF-8");
					message.setSentDate(new java.util.Date());
					Transport.send(message);
					
					dto.setMember_pw(tempPw);
					dao.updateMemberInfo(dto);
					
					out.println("0"); // 정상 발송
				} catch (Exception e) {
					out.println("3");
				}

			} else {
				out.println("2"); // 등록된 번호와 맞지 않음
			}
		}
		
	}

}
