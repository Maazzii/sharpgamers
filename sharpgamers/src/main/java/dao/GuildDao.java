package dao;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

public class GuildDao {

	public Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();// 톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context) initCtx.lookup("java:comp/env");// java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource) envCtx.lookup("jdbc/OracleDB");// context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();// ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}
	
	public void makeGuild(GuildDto dto) {
		String sql = "INSERT INTO GUILDS(GUILD_ID,GUILD_NAME,GUILD_DESC,GUILD_MASTER_IDX,GUILD_MEMBERS_IDX,GAME_ID) VALUES(GUILDS_SEQ.nextval,?,?,?,?,?)";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, dto.getGuildName());
			pstmt.setString(2, dto.getGuildDesc());
			pstmt.setInt(3, dto.getGuildMasterIdx());
			pstmt.setString(4, dto.getGuildMembersIdx());
			pstmt.setInt(5, dto.getGame_id());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void removeGuild(int guildId) {
		String sql = "DELETE FROM guilds WHERE guild_id = ?";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, guildId);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int countGuildsForGame(int gameId) {
		String sql = "select count(*) from guilds where game_id = ?";
		int count = 0;
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, gameId);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public int countGuildsForMember(int memberIdx) {
		String idxStr = String.valueOf(memberIdx);
		String sql = "select count(*) from guilds where guild_members_idx LIKE ? OR guild_members_idx LIKE ?";
		int count = 0;
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, idxStr + ":%");
			pstmt.setString(2, "%:" + idxStr + ":%");
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public List<GuildDto> getGuildsForGame(int gameId) {
		List<GuildDto> guildList = null;
		String sql = "select * from guilds where game_id = ? order by guild_reg_date";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, gameId);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs != null) {
				guildList = new ArrayList<GuildDto>();
			}
			
			while (rs.next()) {
				GuildDto dto = new GuildDto();

				dto.setGuildId(rs.getInt("guild_id"));
				dto.setGuildName(rs.getString("guild_name"));
				dto.setGuildDesc(rs.getString("guild_desc"));
				dto.setGuildMasterIdx(rs.getInt("guild_master_idx"));
				dto.setGuildMembersIdx(rs.getString("guild_members_idx"));
				dto.setGuildJoinWaitingIdx(rs.getString("guild_join_waiting_idx"));
				dto.setGuildRegDate(rs.getDate("guild_reg_date"));
				dto.setGame_id(rs.getInt("game_id"));
				
				guildList.add(dto);
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return guildList;
	}
	
	public List<GuildDto> getGuildsForMember(int memberIdx) {
		List<GuildDto> guildList = null;
		String sql = "SELECT * FROM guilds WHERE guild_members_idx LIKE ? OR guild_members_idx LIKE ?";

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			String idxStr = String.valueOf(memberIdx);
			pstmt.setString(1, idxStr + ":%");
			pstmt.setString(2, "%:" + idxStr + ":%");
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs != null) {
				guildList = new ArrayList<GuildDto>();
			}
			
			while (rs.next()) {
				GuildDto dto = new GuildDto();

				dto.setGuildId(rs.getInt("guild_id"));
				dto.setGuildName(rs.getString("guild_name"));
				dto.setGuildDesc(rs.getString("guild_desc"));
				dto.setGuildMasterIdx(rs.getInt("guild_master_idx"));
				dto.setGuildMembersIdx(rs.getString("guild_members_idx"));
				dto.setGuildJoinWaitingIdx(rs.getString("guild_join_waiting_idx"));
				dto.setGuildRegDate(rs.getDate("guild_reg_date"));
				dto.setGame_id(rs.getInt("game_id"));
				
				guildList.add(dto);
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return guildList;
	}
	
	public GuildDto getGuildInfo(int guildId, GuildDto dto) {
		String sql = "select * from guilds where guild_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, guildId);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			dto.setGuildId(rs.getInt("guild_id"));
			dto.setGuildName(rs.getString("guild_name"));
			dto.setGuildDesc(rs.getString("guild_desc"));
			dto.setGuildMasterIdx(rs.getInt("guild_master_idx"));
			dto.setGuildMembersIdx(rs.getString("guild_members_idx"));
			dto.setGuildJoinWaitingIdx(rs.getString("guild_join_waiting_idx"));
			dto.setGuildRegDate(rs.getDate("guild_reg_date"));
			dto.setGame_id(rs.getInt("game_id"));
			
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public boolean isMember(int guildId, int memberIdx) {
		boolean result = false;
		String sql = "SELECT count(*) FROM guilds WHERE (guild_members_idx LIKE ? OR guild_members_idx LIKE ?) AND guild_id = ?";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, memberIdx + ":%");
			pstmt.setString(2, "%:" + memberIdx + ":%");
			pstmt.setInt(3, guildId);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			if (count != 0) {
				result = true;
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public boolean isJoined(int guildId, int memberIdx) {
		boolean result = false;
		String sql = "SELECT count(*) FROM guilds WHERE (GUILD_JOIN_WAITING_IDX LIKE ? OR GUILD_JOIN_WAITING_IDX LIKE ?) AND guild_id = ?";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, memberIdx + ":%");
			pstmt.setString(2, "%:" + memberIdx + ":%");
			pstmt.setInt(3, guildId);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			if (count != 0) {
				result = true;
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<MemberDto> getMemberList(int guildId) {
		GuildDto guildDto = getGuildInfo(guildId, new GuildDto());
		String[] membersIdxArr = guildDto.getGuildMembersIdx().split(":");
		List<MemberDto> memberList = new ArrayList<MemberDto>();
		MemberDao memberDao = new MemberDao();
		
		for (String memberIdxStr : membersIdxArr) {
			int memberIdx = Integer.parseInt(memberIdxStr);
			MemberDto memberDto = memberDao.getMemberInfo(memberIdx, new MemberDto());
			memberList.add(memberDto);
		}
		
		return memberList;
	}
	
	public List<MemberDto> getJoinWaitingList(int guildId) {
		List<MemberDto> joinWaitingList = new ArrayList<MemberDto>();
		GuildDto guildDto = getGuildInfo(guildId, new GuildDto());
		String[] joinWaitingArr = guildDto.getGuildJoinWaitingIdx().split(":");
		if (joinWaitingArr.length > 0) {
			MemberDao memberDao = new MemberDao();
			for (String joinWaitingStr : joinWaitingArr) {
				int joinIdx = Integer.parseInt(joinWaitingStr);
				MemberDto memberDto = memberDao.getMemberInfo(joinIdx, new MemberDto());
				joinWaitingList.add(memberDto);
			}
		}
		return joinWaitingList;
	}
	
	public void addJoinList(int memberIdx, GuildDto dto) {
		String joined_users = "";
		String[] joinedArr = dto.getGuildJoinWaitingIdx().split(":");
		List<Integer> joinedList = new ArrayList<Integer>();
		for (String joinedIdx : joinedArr) {
			joinedList.add(Integer.parseInt(joinedIdx));
		}
		joinedList.add(new Integer(memberIdx));
		Integer[] joinedIdxArr = (Integer[]) joinedList.toArray(new Integer[joinedList.size()]);
		for (int joinedIdx : joinedIdxArr) {
			joined_users += joinedIdx + ":";
		}
		
		String sql = "update guilds set GUILD_JOIN_WAITING_IDX = ? where guild_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, joined_users);
			pstmt.setInt(2, dto.getGuildId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void removeJoinList(int memberIdx, GuildDto dto) {
		String joined_users = "";
		String[] joinedArr = dto.getGuildJoinWaitingIdx().split(":");
		List<Integer> joinedList = new ArrayList<Integer>();
		for (String joinedIdx : joinedArr) {
			joinedList.add(Integer.parseInt(joinedIdx));
		}
		joinedList.remove(new Integer(memberIdx));
		if (joinedList.size() != 0) {
			Integer[] joinedIdxArr = (Integer[]) joinedList.toArray(new Integer[joinedList.size()]);
			for (int joinedIdx : joinedIdxArr) {
				joined_users += joinedIdx + ":";
			}
		} else {
			joined_users = ":";
		}
		
		String sql = "update guilds set GUILD_JOIN_WAITING_IDX = ? where guild_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, joined_users);
			pstmt.setInt(2, dto.getGuildId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void addMember(int memberIdx, GuildDto dto) {
		String members = "";
		String[] membersArr = dto.getGuildMembersIdx().split(":");
		List<Integer> memberList = new ArrayList<Integer>();
		for (String idxStr : membersArr) {
			memberList.add(Integer.parseInt(idxStr));
		}
		memberList.add(new Integer(memberIdx));
		Integer[] memberIdxArr = (Integer[]) memberList.toArray(new Integer[memberList.size()]);
		for (int idx : memberIdxArr) {
			members += idx + ":";
		}
		
		String sql = "update guilds set GUILD_MEMBERS_IDX = ? where guild_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, members);
			pstmt.setInt(2, dto.getGuildId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void removeMember(int memberIdx, GuildDto dto) {
		String members = "";
		String[] membersArr = dto.getGuildMembersIdx().split(":");
		List<Integer> memberList = new ArrayList<Integer>();
		for (String idxStr : membersArr) {
			memberList.add(Integer.parseInt(idxStr));
		}
		memberList.remove(new Integer(memberIdx));
		if (memberList.size() != 0) {
			Integer[] memberIdxArr = (Integer[]) memberList.toArray(new Integer[memberList.size()]);
			for (int idx : memberIdxArr) {
				members += idx + ":";
			}
		} else {
			members = ":";
		}
		
		String sql = "update guilds set GUILD_MEMBERS_IDX = ? where guild_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, members);
			pstmt.setInt(2, dto.getGuildId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void changeMaster(int memberIdx, GuildDto dto) {
		String sql = "update guilds set GUILD_MASTER_IDX = ? where guild_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, memberIdx);
			pstmt.setInt(2, dto.getGuildId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
