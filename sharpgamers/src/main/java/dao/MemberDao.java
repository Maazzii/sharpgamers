package dao;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDao {
	public Connection getConnection() throws Exception{
		Context initCtx = new InitialContext();//톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context)initCtx.lookup("java:comp/env");//java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource)envCtx.lookup("jdbc/OracleDB");//context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();//ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}

	public int joinMember(MemberDto dto) {
		int result = 0; // 0: 회원정보 입력 실패
		String sql = "insert into members(member_idx, member_id, member_pw, member_name, phone_no) values(member_seq.nextval, ?, ?, ?, ?)";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, dto.getMember_id());
			pstmt.setString(2, dto.getMember_pw());
			pstmt.setString(3, dto.getMember_name());
			pstmt.setString(4, dto.getPhone_no());

			pstmt.executeUpdate();
			result = 1; // 1: 회원정보 입력 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	

	public int login(String member_id, String member_pw) {
		int result = 0; // 0: 로그인 실패

		String sql = "select count(*) from members where member_id = ? and member_pw = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, member_id);
			pstmt.setString(2, member_pw);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				result = rs.getInt(1);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	public boolean isNickNameExist(String member_name) {
		int count = 0;
		boolean result = true;
		String sql = "select count(*) from members where member_name=?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, member_name);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
			
			if (count == 1) {
				result = true;
			} else {
				result = false;
			}
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public MemberDto getMemberInfo(String member_id, MemberDto dto) {
		String sql = "select * from members where member_id=?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			dto.setMember_idx(rs.getInt("member_idx"));
			dto.setMember_id(member_id);
			dto.setMember_pw(rs.getString("member_pw"));
			dto.setMember_name(rs.getString("member_name"));
			dto.setPhone_no(rs.getString("phone_no"));
			dto.setMember_auth(rs.getInt("member_auth"));
			dto.setJoin_date(rs.getDate("join_date"));
			dto.setFav_game(rs.getString("fav_game"));
			rs.close();

		} catch (SQLException e) {
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public MemberDto getMemberInfo(int member_idx, MemberDto dto) {
		String sql = "select * from members where member_idx=?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, member_idx);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			dto.setMember_idx(member_idx);
			dto.setMember_id(rs.getString("member_id"));
			dto.setMember_pw(rs.getString("member_pw"));
			dto.setMember_name(rs.getString("member_name"));
			dto.setPhone_no(rs.getString("phone_no"));
			dto.setMember_auth(rs.getInt("member_auth"));
			dto.setJoin_date(rs.getDate("join_date"));
			dto.setFav_game(rs.getString("fav_game"));
			rs.close();

		} catch (SQLException e) {
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public int updateMemberInfo(MemberDto dto) {
		int result = 0; // 0: 회원정보 입력 실패
		// SQL문 작성
		String sql = "update members set member_id = ?, member_pw = ?, member_name = ?, phone_no = ? where member_id = ?";
		// DB 연결 객체 얻기
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			
			pstmt.setString(1, dto.getMember_id());
			pstmt.setString(2, dto.getMember_pw());
			pstmt.setString(3, dto.getMember_name());
			pstmt.setString(4, dto.getPhone_no());
			pstmt.setString(5, dto.getMember_id());

			pstmt.executeUpdate();
			result = 1; // 1: 회원정보 변경 성공
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public MemberDto addFavorite(int game_id, MemberDto dto) {

		String favorite_games = "";
		String[] favoritesArr = dto.getFav_game().split(":");
		List<Integer> favoritesList = new ArrayList<Integer>();
		for (String favorite : favoritesArr) {
			favoritesList.add(Integer.parseInt(favorite));
		}
		favoritesList.add(new Integer(game_id));
		Integer[] favoriteIdxs = (Integer[]) favoritesList.toArray(new Integer[favoritesList.size()]);
		for (int favoriteIdx : favoriteIdxs) {
			favorite_games += favoriteIdx + ":";
		}
		String sql = "update members set fav_game = ? where member_idx = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, favorite_games);
			pstmt.setInt(2, dto.getMember_idx());
			pstmt.executeUpdate();
			return getMemberInfo(dto.getMember_idx(), new MemberDto());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public MemberDto removeFavorite(int game_id, MemberDto dto) {
		String favorite_games = "";
		String[] favoritesArr = dto.getFav_game().split(":");
		List<Integer> favoritesList = new ArrayList<Integer>();
		for (String favorite : favoritesArr) {
			favoritesList.add(Integer.parseInt(favorite));
		}
		favoritesList.remove(new Integer(game_id));
		if (favoritesList.size() != 0) {
			Integer[] favoriteIdxs = (Integer[]) favoritesList.toArray(new Integer[favoritesList.size()]);
			for (int favoriteIdx : favoriteIdxs) {
				favorite_games += favoriteIdx + ":";
			}
		} else {
			favorite_games = ":";
		}

		String sql = "update members set fav_game = ? where member_idx = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, favorite_games);
			pstmt.setInt(2, dto.getMember_idx());
			pstmt.executeUpdate();
			return getMemberInfo(dto.getMember_idx(), new MemberDto());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public void blockMember(int memberIdx) {
		String sql = "update members set member_auth = 1 where member_idx = ?";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, memberIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void unBlockMember(int memberIdx) {
		String sql = "update members set member_auth = 0 where member_idx = ?";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, memberIdx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<MemberDto> getBlockedList() {
		String sql = "select * from members where member_auth = 1";
		List<MemberDto> blockedList = null;

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			
			
			if (rs != null) {
				blockedList = new ArrayList<MemberDto>();
			}
			
			while(rs.next()) {
				MemberDto dto = new MemberDto();
				dto.setMember_idx(rs.getInt("MEMBER_IDX"));
				dto.setMember_id(rs.getString("member_id"));
				dto.setMember_pw(rs.getString("member_pw"));
				dto.setMember_name(rs.getString("member_name"));
				dto.setPhone_no(rs.getString("phone_no"));
				dto.setMember_auth(rs.getInt("member_auth"));
				dto.setJoin_date(rs.getDate("join_date"));
				dto.setFav_game(rs.getString("fav_game"));
				
				blockedList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return blockedList;
	}
}
