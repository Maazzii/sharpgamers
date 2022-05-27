package dao;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

public class GameDao {

	public Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();// 톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context) initCtx.lookup("java:comp/env");// java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource) envCtx.lookup("jdbc/OracleDB");// context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();// ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}

	public String getGamesList() {
		String sql = "select * from games ORDER BY nlssort(game_name, 'NLS_SORT=generic_m_ci')";
		String result = "";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String gameName = rs.getString("GAME_NAME").replace("\"", "'");
				result += "<option value=\"" + gameName + "\">";
			}
			rs.close();

		} catch (Exception e) {
		}

		return result;
	}

	public String getGamesList(String platform) {
		String sql = "select * from games where game_platform = ? ORDER BY nlssort(game_name, 'NLS_SORT=generic_m_ci')";
		String result = "";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, platform);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String gameName = rs.getString("GAME_NAME").replace("\"", "'");
				result += "<option value=\"" + gameName + "\">";
			}
			rs.close();

		} catch (Exception e) {
		}

		return result;
	}

	public GameDto getGameInfo(String platform, String game_name, GameDto dto) {
		String sql = "select * from games where lower(game_name) = lower(?) and game_platform = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, game_name);
			pstmt.setString(2, platform);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			dto.setGame_id(rs.getInt("game_id"));
			dto.setGame_name(rs.getString("game_name"));
			dto.setGame_img_src(rs.getString("game_img_src"));
			dto.setGame_link(rs.getString("game_link"));
			dto.setGame_Platform(rs.getString("game_platform"));
			rs.close();

		} catch (Exception e) {
		}
		return dto;
	}

	public GameDto getGameInfo(int game_id, GameDto dto) {
		String sql = "select * from games where game_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, game_id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			dto.setGame_id(rs.getInt("game_id"));
			dto.setGame_name(rs.getString("game_name"));
			dto.setGame_img_src(rs.getString("game_img_src"));
			dto.setGame_link(rs.getString("game_link"));
			dto.setGame_Platform(rs.getString("game_platform"));
			rs.close();

		} catch (Exception e) {
		}
		return dto;
	}
	
	public List<GameDto> getAllGames() {
		List<GameDto> gameList = new ArrayList<GameDto>();
		String sql = "select * from games ORDER BY nlssort(game_name, 'NLS_SORT=generic_m_ci')";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				GameDto dto = new GameDto();
				dto.setGame_id(rs.getInt("game_id"));
				dto.setGame_name(rs.getString("game_name"));
				dto.setGame_img_src(rs.getString("game_img_src"));
				dto.setGame_link(rs.getString("game_link"));
				dto.setGame_Platform(rs.getString("game_platform"));
				gameList.add(dto);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return gameList;
	}

	public List<GameDto> searchGames(String game_name) {
		List<GameDto> gameList = new ArrayList<GameDto>();
		String sql = "select * from games where lower(game_name) like lower(?) ORDER BY nlssort(game_name, 'NLS_SORT=generic_m_ci')";
		
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, "%"+ game_name +"%");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				GameDto dto = new GameDto();
				dto.setGame_id(rs.getInt("game_id"));
				dto.setGame_name(rs.getString("game_name"));
				dto.setGame_img_src(rs.getString("game_img_src"));
				dto.setGame_link(rs.getString("game_link"));
				dto.setGame_Platform(rs.getString("game_platform"));
				gameList.add(dto);
			}
			rs.close();
			
		} catch (Exception e) {
		}
		
		return gameList;
	}
	
	public void insertGame (GameDto dto) {
		String sql = "INSERT INTO GAMES VALUES(GAMES_SEQ.NEXTVAL, ?, ?, ?, ?)";

		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, dto.getGame_Platform());
			pstmt.setString(2, dto.getGame_name());
			pstmt.setString(3, dto.getGame_img_src());
			pstmt.setString(4, dto.getGame_link());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateGame (GameDto dto) {
		String sql = "update games set game_platform = ?, game_name = ?, game_img_src = ?, game_link = ? where game_id = ?";
		
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, dto.getGame_Platform());
			pstmt.setString(2, dto.getGame_name());
			pstmt.setString(3, dto.getGame_img_src());
			pstmt.setString(4, dto.getGame_link());
			pstmt.setInt(5, dto.getGame_id());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteGame (int gameId) {
		String sql = "delete from games where game_id = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, gameId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
