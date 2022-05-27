package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GamesBoardDao {

	// DBCP를 이용한 데이터베이스 연결객체 얻기
	public Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();// 톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context) initCtx.lookup("java:comp/env");// java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource) envCtx.lookup("jdbc/OracleDB");// context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();// ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}

	public int insert(GamesBoardDto dto) {
		int result = 0;// 0:게시글 입력 실패, 1:게시글 입력 성공
		String sql = "INSERT INTO bbs_games(bbs_num, bbs_writer, writer_id, bbs_subject, bbs_content, game_id) "
				+ "VALUES(bbs_games_seq.nextval, ?, ?, ?, ?, ?)";// 게시글을 입력하는 SQL문을 작성하시오.
		// 연결 연산자를 사용하여 분리하는 경우 공백에 주의하자.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, dto.getWriter());
			pstmt.setInt(2, dto.getWriterId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getGame_id());
			pstmt.executeUpdate();
			result = 1;

			/* 구현하시오. */

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int countArticles(int game_id) {
		int count = 0;
		String sql = "select count(bbs_num) from bbs_games where game_id = ?";// 게시판의 총 게시글 수를 조회하는 SQL문을 작성하시오.

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, game_id);
			ResultSet rs = pstmt.executeQuery();

			if (rs != null)
				rs.next();

			count = rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}
	
	public int countArticlesForMember(int memberIdx) {
		int count = 0;
		String sql = "select count(*) from bbs_games where writer_id = ?";
		
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, memberIdx);
			ResultSet rs = pstmt.executeQuery();

			if (rs != null)
				rs.next();

			count = rs.getInt(1);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public int countSearchedArticles(int game_id, String searchType, String searchText) {
		int count = 0;
		// String sql = "select count(bbs_num) from bbs_games where game_id = ?";// 게시판의 총 게시글 수를 조회하는 SQL문을 작성하시오.
		String sql;
		switch (searchType) {
		case "subject":
			sql = "SELECT count(bbs_num) FROM bbs_games WHERE bbs_subject LIKE ? AND GAME_ID = ?";
			try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, "%" + searchText + "%");
				pstmt.setInt(2, game_id);
				ResultSet rs = pstmt.executeQuery();

				if (rs != null)
					rs.next();

				count = rs.getInt(1);
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "content":
			sql = "SELECT count(bbs_num) FROM bbs_games WHERE (bbs_subject LIKE ? OR bbs_content LIKE ?) AND GAME_ID = ?";
			try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, "%" + searchText + "%");
				pstmt.setString(2, "%" + searchText + "%");
				pstmt.setInt(3, game_id);
				ResultSet rs = pstmt.executeQuery();

				if (rs != null)
					rs.next();

				count = rs.getInt(1);
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "writer":
			sql = "SELECT count(bbs_num) FROM bbs_games WHERE bbs_writer LIKE ? AND GAME_ID = ?";
			try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, "%" + searchText + "%");
				pstmt.setInt(2, game_id);
				ResultSet rs = pstmt.executeQuery();

				if (rs != null)
					rs.next();

				count = rs.getInt(1);
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		}

		return count;
	}

	public List<GamesBoardDto> getArticles(int game_id, int start, int end) {
		List<GamesBoardDto> articleList = null;
		String sql = "SELECT * FROM "
				+ "(SELECT ROWNUM r, BBS_NUM, BBS_WRITER, WRITER_ID, BBS_SUBJECT, BBS_CONTENT, REG_DATE, READCOUNT, LIKES, LIKED_USERS, GAME_ID "
				+ "FROM (select * from bbs_games where game_id = ? order by bbs_num DESC)) WHERE r >= ? AND r <= ?";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, game_id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			ResultSet rs = pstmt.executeQuery();

			if (rs != null)
				articleList = new ArrayList<GamesBoardDto>();

			while (rs.next()) {
				GamesBoardDto dto = new GamesBoardDto();

				dto.setNum(rs.getInt("BBS_NUM"));
				dto.setWriter(rs.getString("BBS_WRITER"));
				dto.setWriterId(rs.getInt("writer_id"));
				dto.setSubject(rs.getString("BBS_SUBJECT"));
				dto.setContent(rs.getString("BBS_CONTENT"));
				dto.setReg_date(rs.getDate("REG_DATE"));
				dto.setReadCount(rs.getInt("readcount"));
				dto.setLikes(rs.getInt("LIKES"));
				dto.setLikedUsers(rs.getString("LIKED_USERS"));
				dto.setGame_id(rs.getInt("game_id"));

				articleList.add(dto);
			}

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleList;
	}

	public List<GamesBoardDto> getArticlesForMember(int memberIdx, int start, int end) {
		List<GamesBoardDto> articleList = null;
		String sql = "SELECT * FROM "
				+ "(SELECT ROWNUM r, BBS_NUM, BBS_WRITER, WRITER_ID, BBS_SUBJECT, BBS_CONTENT, REG_DATE, READCOUNT, LIKES, LIKED_USERS, GAME_ID "
				+ "FROM (select * from bbs_games where writer_id = ? order by bbs_num DESC)) WHERE r >= ? AND r <= ?";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, memberIdx);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			ResultSet rs = pstmt.executeQuery();

			if (rs != null)
				articleList = new ArrayList<GamesBoardDto>();

			while (rs.next()) {
				GamesBoardDto dto = new GamesBoardDto();

				dto.setNum(rs.getInt("BBS_NUM"));
				dto.setWriter(rs.getString("BBS_WRITER"));
				dto.setWriterId(rs.getInt("writer_id"));
				dto.setSubject(rs.getString("BBS_SUBJECT"));
				dto.setContent(rs.getString("BBS_CONTENT"));
				dto.setReg_date(rs.getDate("REG_DATE"));
				dto.setReadCount(rs.getInt("readcount"));
				dto.setLikes(rs.getInt("LIKES"));
				dto.setLikedUsers(rs.getString("LIKED_USERS"));
				dto.setGame_id(rs.getInt("game_id"));

				articleList.add(dto);
			}

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleList;
	}
	
	public List<GamesBoardDto> getLikedArticles(int game_id) {
		List<GamesBoardDto> articleList = null;
		String sql = "SELECT * FROM "
				+ "(SELECT ROWNUM r, BBS_NUM, BBS_WRITER, WRITER_ID, BBS_SUBJECT, BBS_CONTENT, REG_DATE, READCOUNT, LIKES, LIKED_USERS, GAME_ID "
				+ "FROM (select * from bbs_games where game_id = ? order by likes DESC)) WHERE r <= 3";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, game_id);

			ResultSet rs = pstmt.executeQuery();

			if (rs != null)
				articleList = new ArrayList<GamesBoardDto>();

			while (rs.next()) {
				GamesBoardDto dto = new GamesBoardDto();

				dto.setNum(rs.getInt("BBS_NUM"));
				dto.setWriter(rs.getString("BBS_WRITER"));
				dto.setWriterId(rs.getInt("writer_id"));
				dto.setSubject(rs.getString("BBS_SUBJECT"));
				dto.setContent(rs.getString("BBS_CONTENT"));
				dto.setReg_date(rs.getDate("REG_DATE"));
				dto.setReadCount(rs.getInt("readcount"));
				dto.setLikes(rs.getInt("LIKES"));
				dto.setLikedUsers(rs.getString("LIKED_USERS"));
				dto.setGame_id(rs.getInt("game_id"));

				articleList.add(dto);
			}

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleList;
	}
	
	public List<GamesBoardDto> getSearchedArticles(int game_id, String searchType, String searchText, int start, int end) {
		List<GamesBoardDto> articleList = null;
		String sql;
		switch (searchType) {
		case "subject":
			sql = "SELECT * FROM "
					+ "(SELECT ROWNUM r, BBS_NUM, BBS_WRITER, WRITER_ID, BBS_SUBJECT, BBS_CONTENT, REG_DATE, READCOUNT, LIKES, LIKED_USERS, GAME_ID "
					+ "FROM (SELECT * FROM bbs_games WHERE bbs_subject LIKE ? AND GAME_ID = ? ORDER BY bbs_num DESC)) "
					+ "WHERE r >= ? AND r <= ?";
			try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, "%" + searchText + "%");
				pstmt.setInt(2, game_id);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
				ResultSet rs = pstmt.executeQuery();

				if (rs != null)
					articleList = new ArrayList<GamesBoardDto>();

				while (rs.next()) {
					GamesBoardDto dto = new GamesBoardDto();

					dto.setNum(rs.getInt("BBS_NUM"));
					dto.setWriter(rs.getString("BBS_WRITER"));
					dto.setWriterId(rs.getInt("writer_id"));
					dto.setSubject(rs.getString("BBS_SUBJECT"));
					dto.setContent(rs.getString("BBS_CONTENT"));
					dto.setReg_date(rs.getDate("REG_DATE"));
					dto.setReadCount(rs.getInt("readcount"));
					dto.setLikes(rs.getInt("LIKES"));
					dto.setLikedUsers(rs.getString("LIKED_USERS"));
					dto.setGame_id(rs.getInt("game_id"));

					articleList.add(dto);
				}

				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "content":
			sql = "SELECT * FROM "
					+ "(SELECT ROWNUM r, BBS_NUM, BBS_WRITER, WRITER_ID, BBS_SUBJECT, BBS_CONTENT, REG_DATE, READCOUNT, LIKES, LIKED_USERS, GAME_ID "
					+ "FROM (SELECT * FROM bbs_games WHERE (bbs_subject LIKE ? OR bbs_content LIKE ?) AND GAME_ID = ? ORDER BY BBS_Num DESC)) "
					+ "WHERE r >= ? AND r <= ?";
			try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, "%" + searchText + "%");
				pstmt.setString(2, "%" + searchText + "%");
				pstmt.setInt(3, game_id);
				pstmt.setInt(4, start);
				pstmt.setInt(5, end);
				ResultSet rs = pstmt.executeQuery();

				if (rs != null)
					articleList = new ArrayList<GamesBoardDto>();

				while (rs.next()) {
					GamesBoardDto dto = new GamesBoardDto();

					dto.setNum(rs.getInt("BBS_NUM"));
					dto.setWriter(rs.getString("BBS_WRITER"));
					dto.setWriterId(rs.getInt("writer_id"));
					dto.setSubject(rs.getString("BBS_SUBJECT"));
					dto.setContent(rs.getString("BBS_CONTENT"));
					dto.setReg_date(rs.getDate("REG_DATE"));
					dto.setReadCount(rs.getInt("readcount"));
					dto.setLikes(rs.getInt("LIKES"));
					dto.setLikedUsers(rs.getString("LIKED_USERS"));
					dto.setGame_id(rs.getInt("game_id"));

					articleList.add(dto);
				}

				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}			
			break;
		case "writer":
			sql = "SELECT * FROM "
					+ "(SELECT ROWNUM r, BBS_NUM, BBS_WRITER, WRITER_ID, BBS_SUBJECT, BBS_CONTENT, REG_DATE, READCOUNT, LIKES, LIKED_USERS, GAME_ID "
					+ "FROM (SELECT * FROM bbs_games WHERE bbs_writer LIKE ? AND GAME_ID = ? ORDER BY bbs_num DESC)) "
					+ "WHERE r >= ? AND r <= ?";
			try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, "%" + searchText + "%");
				pstmt.setInt(2, game_id);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
				ResultSet rs = pstmt.executeQuery();

				if (rs != null)
					articleList = new ArrayList<GamesBoardDto>();

				while (rs.next()) {
					GamesBoardDto dto = new GamesBoardDto();

					dto.setNum(rs.getInt("BBS_NUM"));
					dto.setWriter(rs.getString("BBS_WRITER"));
					dto.setWriterId(rs.getInt("writer_id"));
					dto.setSubject(rs.getString("BBS_SUBJECT"));
					dto.setContent(rs.getString("BBS_CONTENT"));
					dto.setReg_date(rs.getDate("REG_DATE"));
					dto.setReadCount(rs.getInt("readcount"));
					dto.setLikes(rs.getInt("LIKES"));
					dto.setLikedUsers(rs.getString("LIKED_USERS"));
					dto.setGame_id(rs.getInt("game_id"));

					articleList.add(dto);
				}

				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		
		}
		return articleList;
	}

	public GamesBoardDto getArticle(int num) {
		GamesBoardDto dto = null;
		String sql = "SELECT * FROM bbs_games WHERE BBS_NUM = ?";// 글번호에 대한 게시글 데이터를 가져오는 SQL문을 작성하시오.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, num);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				dto = new GamesBoardDto();
				dto.setNum(rs.getInt("BBS_NUM"));
				dto.setWriter(rs.getString("BBS_WRITER"));
				dto.setWriterId(rs.getInt("writer_id"));
				dto.setSubject(rs.getString("BBS_SUBJECT").replaceAll("'", "\\\\'"));
				dto.setContent(rs.getString("BBS_CONTENT").replaceAll("'", "\\\\'"));
				dto.setReg_date(rs.getDate("REG_DATE"));
				dto.setReadCount(rs.getInt("READCOUNT"));
				dto.setLikes(rs.getInt("LIKES"));
				dto.setLikedUsers(rs.getString("LIKED_USERS"));
				dto.setGame_id(rs.getInt("game_id"));

			}

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	public void update(GamesBoardDto dto) {
		String sql = "UPDATE bbs_games SET BBS_SUBJECT = ?,BBS_CONTENT = ? WHERE BBS_NUM = ?";// 글번호에 대한 게시글을 업데이트하는 SQL문을
																																													// 작성하시오.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			/* 구현하시오. */

			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delete(int num) {
		String sql = "DELETE FROM bbs_games WHERE BBS_NUM = ?";// 글번호에 대한 게시글을 삭제하는 SQL문을 작성하시오.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, num);
			/*
			 * PreparedStatement객체는 미완성의 SQL문을 가지고 객체가 만들어지므로 미완성된 부분(?로 표시됨)을 객체생성 이후에
			 * 완성시켜서 실행을 해야합니다. 각 필드에 들어가는 데이터 영역과 맞는 데이터형으로 setXXX(XXX:데이터형)를 가지고 각각의 ?를
			 * 순서에 맞추어 값을 설정합니다.
			 */
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateReadCount(int num) {
		String sql = "UPDATE bbs_games SET READCOUNT = (readcount + 1) WHERE BBS_NUM = ?";// 게시글의 조회수를 증가시키는 SQL문을 작성하시오.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public GamesBoardDto addLike(int member_idx, GamesBoardDto dto) {
		String liked_users = "";
		String[] likesArr = dto.getLikedUsers().split(":");
		List<Integer> likesList = new ArrayList<Integer>();
		for (String like : likesArr) {
			likesList.add(Integer.parseInt(like));
		}
		likesList.add(new Integer(member_idx));
		Integer[] likeIdxs = (Integer[]) likesList.toArray(new Integer[likesList.size()]);
		for (int likeIdx : likeIdxs) {
			liked_users += likeIdx + ":";
		}
		int likes = likeIdxs.length;
		String sql = "update bbs_games set likes = ?, liked_users = ? where bbs_num = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, likes);
			pstmt.setString(2, liked_users);
			pstmt.setInt(3, dto.getNum());
			pstmt.executeUpdate();
			return getArticle(dto.getNum());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public GamesBoardDto removeLike(int member_idx, GamesBoardDto dto) {
		String liked_users = "";
		String[] likesArr = dto.getLikedUsers().split(":");
		List<Integer> likesList = new ArrayList<Integer>();
		for (String like : likesArr) {
			likesList.add(Integer.parseInt(like));
		}
		likesList.remove(new Integer(member_idx));
		int likes;
		if (likesList.size() != 0) {
			Integer[] likeIdxs = (Integer[]) likesList.toArray(new Integer[likesList.size()]);
			for (int likeIdx : likeIdxs) {
				liked_users += likeIdx + ":";
			}
			likes = likeIdxs.length;
		} else {
			liked_users = ":";
			likes = 0;
		}

		String sql = "update bbs_games set likes = ?, liked_users = ? where bbs_num = ?";
		try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, likes);
			pstmt.setString(2, liked_users);
			pstmt.setInt(3, dto.getNum());
			pstmt.executeUpdate();
			return getArticle(dto.getNum());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
