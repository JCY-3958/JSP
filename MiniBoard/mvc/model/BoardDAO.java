package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class BoardDAO {
	private static BoardDAO instance;
	
	private BoardDAO() {
		
	}
	
	//BoradDAO 객체를 가지는 instance를 만듬
	public static BoardDAO getInstance() {
		if(instance == null)
			instance = new BoardDAO();
		return instance;
	}
	
	//해당 페이지의 댓글 수 가져오기
	public int getCommentCount(int boardNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int x = 0;
		
		sql = "select count(*) from reply";
		
		try {
			conn = DBConnection.getConnection();
			pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				//그래서 여기에서 getInt로 한 행 결과의 첫번째 열 = 행의 개수 값을 정수로 가져옴
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getCommentCount() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		
		return x;
	}
	
	//해당 페이지의 댓글들 가져오기
	public ArrayList<BoardReply> getCommentList(int boardNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		sql = "select * from reply where page_num = ?";
		
		ArrayList<BoardReply> commentList = new ArrayList<BoardReply>();
		
		try {
			conn = DBConnection.getConnection();
			
			pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardReply reply = new BoardReply();
				reply.setId(rs.getString("id"));
				reply.setName(rs.getString("name"));
				reply.setPage_num(rs.getInt("page_num"));
				reply.setReplycontent(rs.getString("replycontent"));
				reply.setTime(rs.getString("time"));
				commentList.add(reply);
			}
		} catch (Exception ex) {
			System.out.println("getCommentList() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}	
		}
		return commentList;
	}
	
	//reply 테이블에 새로운 댓글 삽입하기
	public void insertReply(BoardReply reply) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBConnection.getConnection();
			
			String sql = "insert into reply values(?,?,?,?,?)";
			pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			pstmt.setString(1, reply.getId());
			pstmt.setString(2, reply.getName());
			pstmt.setInt(3, reply.getPage_num());
			pstmt.setString(4, reply.getReplycontent());
			pstmt.setString(5, reply.getTime());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			try {									
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
	}
	
	//board 테이블의 레코드 개수
	public int getListCount(String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		String sql;
		
		//select 태그에서 선택된 것이 없다면 = 게시판을 처음 켰을 때는
		//sql문으로 board의 전체 행 개수를 가져옴
		if (items == null && text == null)
			sql = "select  count(*) from board";
		else
			//itmes와 text가 있으면 거기에 따른 쿼리문을 실행
			sql = "SELECT   count(*) FROM board where " + items + " like '%" + text + "%'";
		
		try {
			conn = DBConnection.getConnection();
			pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			//쿼리문을 실행시키면 한 행만 저장이되는데 그 행에 board의 행의 개수가 정수형으로 저장됨
			rs = pstmt.executeQuery();

			if (rs.next()) 
				//그래서 여기에서 getInt로 한 행 결과의 첫번째 열 = 행의 개수 값을 정수로 가져옴
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getListCount() 에러 : " + ex);
		} finally {			
			try {				
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();												
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}		
		return x;
	}
	
	//board 테이블의 레코드 가져오기
	//매개변수들을 받아서 DTO 객체를 가지는 List를 만드는 애 -> 데이터베이스의 행들을 저장
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		//전체 행 개수를 가져옴
		int total_record = getListCount(items, text);
		//몇 번째 페이지인지 매개변수로 받아 옴
		//page가 2이면 start 값은 5
		int start = (page - 1) * limit;
		//index 값은 6이된다.
		//이 말은 한 페이지당 게시물이 5개까지 limit인데 1페이지는 1~5번까지 있고
		//2번 페이지는 6~10번까지 있으니 page = 2면 index = 6
		//이 index 값은 밑에 while에서 씀
		int index = start + 1;

		String sql;

		if (items == null && text == null)
			sql = "select * from board ORDER BY num DESC";
		else
			sql = "SELECT  * FROM board where " + items + " like '%" + text + "%' ORDER BY num DESC ";

		//sql로 가져온 행들을 저장하기 위한 list 생성
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = pstmt.executeQuery();

			//위의 예시에 따르면 index는 6부터 시작
			while (rs.absolute(index)) {
				BoardDTO board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				//데이터베이스에 있는 6행부터 가져와서 list에 넣는다
				list.add(board);
				
				// 초기는 6 < 10 && 6 <= 10 참이면 index ++
				// 7 < 10
				// 8 < 10
				// 9 < 10
				// 10 < 10 은 거짓
				//System.out.println("index가 몇? : " + index);
				//마지막 9가 들어가고 index는 10이 되어서 index가 while문에 총 5번(6,7,8,9,10) 들어간다.
				//그래서 한 페이지에 최대 5개의 게시물이 표시되도록함
				if (index < (start + limit) && index <= total_record) {
					index++;
				}
				else
					break;
				
			}
			//System.out.println("===================");
			//5개의 게시물을 list로 반환
			return list;
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) 
					rs.close();							
				if (pstmt != null) 
					pstmt.close();				
				if (conn != null) 
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}			
		}
		return null;
	}
	
	//member 테이블에서 인증된 id의 사용자명 가져오기
		public String getLoginNameById(String id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;	

			String name=null;
			String sql = "select * from member where id = ? ";

			try {
				conn = DBConnection.getConnection();
				pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();

				if (rs.next()) 
					name = rs.getString("name");	
				
				return name;
			} catch (Exception ex) {
				System.out.println("getBoardByNum() 에러 : " + ex);
			} finally {
				try {				
					if (rs != null) 
						rs.close();							
					if (pstmt != null) 
						pstmt.close();				
					if (conn != null) 
						conn.close();
				} catch (Exception ex) {
					throw new RuntimeException(ex.getMessage());
				}		
			}
			return null;
		}
		
		//board 테이블에 새로운 글 삽입하기
		public void insertBoard(BoardDTO board) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = DBConnection.getConnection();		

				String sql = "insert into board values(?, ?, ?, ?, ?, ?, ?, ?)";
			
				pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				pstmt.setInt(1, board.getNum());
				pstmt.setString(2, board.getId());
				pstmt.setString(3, board.getName());
				pstmt.setString(4, board.getSubject());
				pstmt.setString(5, board.getContent());
				pstmt.setString(6, board.getRegist_day());
				pstmt.setInt(7, board.getHit());
				pstmt.setString(8, board.getIp());

				pstmt.executeUpdate();
			} catch (Exception ex) {
				System.out.println("insertBoard() 에러 : " + ex);
			} finally {
				try {									
					if (pstmt != null) 
						pstmt.close();				
					if (conn != null) 
						conn.close();
				} catch (Exception ex) {
					throw new RuntimeException(ex.getMessage());
				}		
			}	
		}
		
		//선택된 글의 조회 수 증가시키기
		public void updateHit(int num) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = DBConnection.getConnection();

				String sql = "select hit from board where num = ? ";
				pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				int hit = 0;

				if (rs.next())
					hit = rs.getInt("hit") + 1;
			

				sql = "update board set hit=? where num=?";
				pstmt = conn.prepareStatement(sql);		
				pstmt.setInt(1, hit);
				pstmt.setInt(2, num);
				pstmt.executeUpdate();
			} catch (Exception ex) {
				System.out.println("updateHit() 에러 : " + ex);
			} finally {
				try {
					if (rs != null) 
						rs.close();							
					if (pstmt != null) 
						pstmt.close();				
					if (conn != null) 
						conn.close();
				} catch (Exception ex) {
					throw new RuntimeException(ex.getMessage());
				}			
			}
		}
		
		//선택된 글 상세 내용 가져오기
		public BoardDTO getBoardByNum(int num, int page) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			BoardDTO board = null;

			updateHit(num);
			String sql = "select * from board where num = ? ";

			try {
				conn = DBConnection.getConnection();
				pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();

				if (rs.next()) {
					board = new BoardDTO();
					board.setNum(rs.getInt("num"));
					board.setId(rs.getString("id"));
					board.setName(rs.getString("name"));
					board.setSubject(rs.getString("subject"));
					board.setContent(rs.getString("content"));
					board.setRegist_day(rs.getString("regist_day"));
					board.setHit(rs.getInt("hit"));
					board.setIp(rs.getString("ip"));
				}
				
				return board;
			} catch (Exception ex) {
				System.out.println("getBoardByNum() 에러 : " + ex);
			} finally {
				try {
					if (rs != null) 
						rs.close();							
					if (pstmt != null) 
						pstmt.close();				
					if (conn != null) 
						conn.close();
				} catch (Exception ex) {
					throw new RuntimeException(ex.getMessage());
				}		
			}
			return null;
		}
		
		//선택된 글 수정하기
		public void updateBoard(BoardDTO board) {
			Connection conn = null;
			PreparedStatement pstmt = null;
		
			try {
				String sql = "update board set name=?, subject=?, content=? where num=?";

				conn = DBConnection.getConnection();
				pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				
				conn.setAutoCommit(false);

				pstmt.setString(1, board.getName());
				pstmt.setString(2, board.getSubject());
				pstmt.setString(3, board.getContent());
				pstmt.setInt(4, board.getNum());

				pstmt.executeUpdate();			
				conn.commit();

			} catch (Exception ex) {
				System.out.println("updateBoard() 에러 : " + ex);
			} finally {
				try {										
					if (pstmt != null) 
						pstmt.close();				
					if (conn != null) 
						conn.close();
				} catch (Exception ex) {
					throw new RuntimeException(ex.getMessage());
				}		
			}
		}
		
		//선택된 글 삭제하기
		public void deleteBoard(int num) {
			Connection conn = null;
			PreparedStatement pstmt = null;		

			String sql = "delete from board where num=?";	

			try {
				conn = DBConnection.getConnection();
				pstmt =conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();

			} catch (Exception ex) {
				System.out.println("deleteBoard() 에러 : " + ex);
			} finally {
				try {										
					if (pstmt != null) 
						pstmt.close();				
					if (conn != null) 
						conn.close();
				} catch (Exception ex) {
					throw new RuntimeException(ex.getMessage());
				}		
			}
		}
}
