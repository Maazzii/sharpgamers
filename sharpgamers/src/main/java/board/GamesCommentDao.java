package board;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

public class GamesCommentDao {

	public Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();// 톰캣 자체의 Context정보를 얻어오는 부분
		Context envCtx = (Context) initCtx.lookup("java:comp/env");// java:comp/env: Resource정의 Context까지 접근하는 정해진 이름(JNDI)
		DataSource ds = (DataSource) envCtx.lookup("jdbc/OracleDB");// context.xml에 정의한 DataSource객체를 얻어오는 부분
		Connection conn = ds.getConnection();// ConnectionPool에서 Connection객체를 얻어오는 부분
		return conn;
	}

	public int insert(GamesCommentDto dto) {
		int result = 0;// 0:게시글 입력 실패, 1:게시글 입력 성공
		String sql = "INSERT INTO comments_games(COMMENT_ID, WRITER, WRITER_ID, CONTENT, BBS_NUM) "
				+ "VALUES(COMMENTS_GAMES_SEQ.nextval, ?, ?, ?, ?)";// 게시글을 입력하는 SQL문을 작성하시오.
		// 연결 연산자를 사용하여 분리하는 경우 공백에 주의하자.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, dto.getWriter());
			pstmt.setInt(2, dto.getWriterId());
			pstmt.setString(3, dto.getContent());
			pstmt.setInt(4, dto.getBbsNum());
			pstmt.executeUpdate();
			result = 1;

			/* 구현하시오. */

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int countArticles(int bbsNum) {
		int count = 0;
		String sql = "select count(comment_id) from comments_games where bbs_num = ?";// 게시판의 총 게시글 수를 조회하는 SQL문을 작성하시오.

		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, bbsNum);
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

	public List<GamesCommentDto> getArticles(int bbsNum) {
		List<GamesCommentDto> articleList = null;
		String sql = "select * from comments_games where bbs_num = ? order by comment_id";
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, bbsNum);

			ResultSet rs = pstmt.executeQuery();

			if (rs != null)
				articleList = new ArrayList<GamesCommentDto>();

			while (rs.next()) {
				GamesCommentDto dto = new GamesCommentDto();

				dto.setCommentId(rs.getInt("COMMENT_ID"));
				dto.setWriter(rs.getString("WRITER"));
				dto.setWriterId(rs.getInt("WRITER_ID"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setBbsNum(rs.getInt("BBS_NUM"));
				dto.setRegDate(rs.getDate("REG_DATE"));

				articleList.add(dto);
			}

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleList;
	}

	public GamesCommentDto getArticle(int commentId) {
		GamesCommentDto dto = null;
		String sql = "SELECT * FROM comments_games WHERE comment_id = ?";// 글번호에 대한 게시글 데이터를 가져오는 SQL문을 작성하시오.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, commentId);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				dto = new GamesCommentDto();
				dto.setCommentId(rs.getInt("COMMENT_ID"));
				dto.setWriter(rs.getString("WRITER"));
				dto.setWriterId(rs.getInt("WRITER_ID"));
				dto.setContent(rs.getString("CONTENT"));
				dto.setBbsNum(rs.getInt("BBS_NUM"));
				dto.setRegDate(rs.getDate("REG_DATE"));

			}

			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	public void update(GamesCommentDto dto) {
		String sql = "UPDATE comments_games SET CONTENT = ? WHERE comment_id = ?";// 글번호에 대한 게시글을 업데이트하는 SQL문을
																																													// 작성하시오.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			/* 구현하시오. */

			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getCommentId());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delete(int commentId) {
		String sql = "DELETE FROM comments_games WHERE comment_id = ?";// 글번호에 대한 게시글을 삭제하는 SQL문을 작성하시오.
		try (Connection con = getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, commentId);
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
}
