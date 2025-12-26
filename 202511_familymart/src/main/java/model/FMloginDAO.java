package model;

import java.sql.ResultSet;

import control.UserInfo;
import dbaccess.MyDBAccess;
// FMloginで
// FMloginDAO loginDAO = new FMloginDAO;
// ResultSet rs = loginDAO.setUserInfo(userId);
public class FMloginDAO {
	public UserInfo setUserInfo(String userId) {
		UserInfo usInfo = new UserInfo();
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

			while(rs.next()) {
				usInfo.name 	 = rs.getString("user_name");
				usInfo.pw 		 = rs.getString("password");
				usInfo.adminflg = rs.getBoolean("admin_flg");
				usInfo.create_user = rs.getString("create_user");
				usInfo.management_flg = rs.getBoolean("management_flg");
			}
			
			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return usInfo;
	}
}
