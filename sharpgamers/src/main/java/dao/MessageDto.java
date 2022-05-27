package dao;

import java.util.Date;

public class MessageDto {
	private int messageId;
	private int senderId;
	private int receiverId;
	private String content;
	private Date sentDate;
	private int haveRead;
	
	public int getMessageId() {
		return messageId;
	}
	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}
	public int getSenderId() {
		return senderId;
	}
	public void setSenderId(int senderId) {
		this.senderId = senderId;
	}
	public int getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(int receiverId) {
		this.receiverId = receiverId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getSentDate() {
		return sentDate;
	}
	public void setSentDate(Date sentDate) {
		this.sentDate = sentDate;
	}
	public int getHaveRead() {
		return haveRead;
	}
	public void setHaveRead(int haveRead) {
		this.haveRead = haveRead;
	}
}
