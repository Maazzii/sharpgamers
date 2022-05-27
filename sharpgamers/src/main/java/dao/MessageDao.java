package dao;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MessageDao {

	public Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();// 톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context) initCtx.lookup("java:comp/env");// java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource) envCtx.lookup("jdbc/OracleDB");// context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();// ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}
	
	public List<MemberDto> getConnectedMembers (int memberIdx) {
		List<Integer> connectedIdxList = new ArrayList<Integer>();
		List<MemberDto> connectedList = new ArrayList<MemberDto>();
		String sql = "SELECT distinct receiver_id FROM messages WHERE sender_id = ?";
		try (Connection con = getConnection()) {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, memberIdx);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				connectedIdxList.add(rs.getInt("receiver_id"));
			}
			
			sql = "SELECT DISTINCT sender_id FROM messages WHERE receiver_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, memberIdx);
			rs = pstmt.executeQuery();
			
			while (rs.next() ) {
				connectedIdxList.add(rs.getInt("sender_id"));
			}
			pstmt.close();
			rs.close();
			
			connectedIdxList.stream().distinct().forEach(idx -> {
				MemberDao memberDao = new MemberDao();
				MemberDto memberDto = new MemberDto();
				memberDto = memberDao.getMemberInfo(idx, memberDto);
				connectedList.add(memberDto);
				
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return connectedList;
	}
	
	public List<MessageDto> getMessages (int thisMemberId, int targetMemberId) {
		List<MessageDto> messageList = null;
		String sql = "SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) order by message_id";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, thisMemberId);
			pstmt.setInt(2, targetMemberId);
			pstmt.setInt(3, targetMemberId);
			pstmt.setInt(4, thisMemberId);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs != null) {
				messageList = new ArrayList<MessageDto>();
			}
			
			while (rs.next()) {
				MessageDto dto = new MessageDto();
				dto.setMessageId(rs.getInt("message_id"));
				dto.setSenderId(rs.getInt("sender_id"));
				dto.setReceiverId(rs.getInt("receiver_id"));
				dto.setContent(rs.getString("content"));
				dto.setSentDate(rs.getDate("sent_date"));
				dto.setHaveRead(rs.getInt("have_read"));
				
				messageList.add(dto);
			}
			
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return messageList;
	}
	
	public MessageDto getMessage (int messageId) {
		MessageDto dto = null;
		String sql = "select * from messages where message_id = ?";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, messageId);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				dto = new MessageDto();
				dto.setMessageId(rs.getInt("message_id"));
				dto.setSenderId(rs.getInt("sender_id"));
				dto.setReceiverId(rs.getInt("receiver_id"));
				dto.setContent(rs.getString("content"));
				dto.setSentDate(rs.getDate("sent_date"));
				dto.setHaveRead(rs.getInt("have_read"));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public void sendMessage (MessageDto dto) {
		String sql = "insert into messages(message_id, sender_id, receiver_id, content) values(messages_seq.nextval, ?, ?, ?)";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, dto.getSenderId());
			pstmt.setInt(2, dto.getReceiverId());
			pstmt.setString(3, dto.getContent());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void readUpdate (int senderId, int receiverId) {
		String sql = "update messages set have_read = 1 where sender_id = ? and receiver_id = ?";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, senderId);
			pstmt.setInt(2, receiverId);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int countUnReadForAllMember (int receiverId) {
		int count = 0;
		
		String sql = "select count(*) from messages where receiver_id = ? and have_read = 0";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, receiverId);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs != null) {
				rs.next();
			}
			
			count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public int countUnread (int senderId, int receiverId) {
		int count = 0;
		
		String sql = "select count(*) from messages where sender_id = ? and receiver_id = ? and have_read = 0";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, senderId);
			pstmt.setInt(2, receiverId);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs != null) {
				rs.next();
			}
			
			count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}
}
