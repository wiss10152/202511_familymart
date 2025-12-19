package model;

import java.sql.ResultSet;
// FMloginで
// FMloginDAO loginDAO = new FMloginDAO;
// ResultSet rs = loginDAO.setUserInfo(userId);
public class FMloginDAO {
	public ResultSet setUserInfo(String userId) {
		MyDBAccess model = new MyDBAccess();
		ResultSet rs = null;
		try {
			model.open();

			
			String sql = "SELECT"
					+ " user_name,"
					+ " password,"
					+ " admin_flg,"
					+ " create_user,"
					+ " management_flg"
					+ " FROM"
					+ " ユーザ情報"
					+ " WHERE user_id ='"+ userId +"' "
					+ " AND delete_flg = 'false';";
			rs = model.getResultSet(sql);

			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
}
