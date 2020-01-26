package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class userDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs; // 데이터베이스와 연결

	public userDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
			//timezone이 안맞아서 뒤에 UTC를 적어줘야함
			String dbID = "root";
			String dbPassword = "csedbadmin";
			Class.forName("com.mysql.jdbc.Driver"); // mysql에 연결되게 하는 매개체
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int login(String userID, String userPassword) {//로그인 기능 구현
		String sql = "select userPassword from user where userID=?";

		try {
			pstmt = conn.prepareStatement(sql);// ->sql문을 연결시켜준다.
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // ->sql문을 실행한 결과값

			if (rs.next()) {// 결과값이 있다면
				if (rs.getString(1).equals(userPassword)) {
					return 1;// 로그인 성공
				}
				else {
					return 0;//비밀번호 불일치
				}

			}

			return -1;// 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}

		return -2;// 데이터베이스 오류
	}
	
	//회원가입 수행
	public int join(User user) {//User객체를 이용한다
		String sql = "insert into user values (?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);//위에서 명시한 sql문장을 넣어준다
			pstmt.setString(1, user.getUserID());		
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			//sql문장에서 ?에 들어간 것을 pstmt에 넣어준다. 단 순서를 지켜가면서 넣는다.
			return pstmt.executeUpdate();//해당 statement를 실행한 결과값을 return 해 준다
			//insert문장을 실행한 것을 0이상의 숫자가 반환되기 때문에 0이상의 숫자가 반환된다고 하면 성공적으로 삽입이 된 것이다
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
		
	}

}
