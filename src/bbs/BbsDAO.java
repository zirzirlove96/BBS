package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "csedbadmin";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}//데이터베이스 mysql과 연결
	}
	
	//게시판 글쓰기를 위해 3개의 함수가 필요 하다.
	public String getDate() {//데이터베이스에 현재의 시간을 넣어준다.
		String sql = "select now()";//지금 시간을 나타낼 수 있는 sql문법이다.
		try {
			PreparedStatement pmst = conn.prepareStatement(sql);//연결되어 있는 객체를 sql문장을 통해 실행할 준비를 한다.
			rs = pmst.executeQuery();//실행햇을 때의 결과
			if(rs.next()) {
				return rs.getString(1);//실행한 결과 시간이 출력된다.
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {//게시글의 번호를 지정하는 함수이다.
		String sql = "select bbsID from bbs order by bbsID desc";
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;//글이 여러 개인 경우 1씩 증가할 수 있도록
			}
			return 1;//글이 하나인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		//실제 글을 쓰고 나서 데이터베이스에 삽입하기 위한 함수이다.
		String sql = "insert into bbs values (?,?,?,?,?,?)";
		
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, getNext());
			psmt.setString(2, bbsTitle);
			psmt.setString(3, userID);
			psmt.setString(4, getDate());
			psmt.setString(5, bbsContent);
			psmt.setInt(6, 1);//bbsAvailable로 삽입했을 때는 1로 표시
			return psmt.executeUpdate();//insert를 하는데에 필요로 한다.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Bbs> getList(int pageNumber){//list형태로 값을 가져온다. 글 목록은 10개까지만 가져오도록 한다.
		String sql = "select * from bbs where bbsID<? and bbsAvailable=1 order by bbsID desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, getNext() - (pageNumber-1)*10);//만약 목록의 개수가 6개라고 한다면 페이지가 1페이지이기 때문에 6개가 sql의 '?'에 들어간다.
			rs = psmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;//list반환
	}
	
	public boolean nextPage(int pageNumber) {
		//글의 개수를 10개 단위로 나누어 다음 페이지가 드러나게 한다.
		//만약 글의 개수가 11개라고 할 때 다음 페이지가 나타나야 한다.
		String sql = "select * from bbs where bbsID < ? and bbsAvailable=1";
		
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, getNext() - (pageNumber-1)*10);//만약 목록의 개수가 6개라고 한다면 페이지가 1페이지이기 때문에 6개가 sql의 '?'에 들어간다.
			rs = psmt.executeQuery();
			if(rs.next()) {//결과 값이 11개 21 개 이런식으로 된다면 true
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {//bbs 데이터베이스에 저장된 게시글 내용을 가져올 수 있게 하는 함수
		String sql ="select * from bbs where bbsID=?";
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bbsID);
			rs = psmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//게시글을 수정하기 위한 함수.
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String sql = "update bbs set bbsTitle = ?, bbsContent=? where bbsID=?";
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, bbsTitle);
			psmt.setString(2, bbsContent);
			psmt.setInt(3, bbsID);
			return psmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID) {
		String sql = "update bbs set bbsAvailable=0 where bbsID=?";//bbsAvailable값을 0으로 변경해 주고 bbsID에 해당하는 게시글은 남아 있게 한다.
		
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, bbsID);
			return psmt.executeUpdate();//availalbe 값을 변경함으로써 삭제처리할 수 있는 기능을 한다.
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

}
