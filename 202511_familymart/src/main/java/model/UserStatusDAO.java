package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dbaccess.MyDBAccess;

public class UserStatusDAO {
	public boolean idCheck(String userId) {
		MyDBAccess model = new MyDBAccess();
		boolean isRegistered = false;
		ResultSet rs = null;
		try {
			model.open();
			String checkSql = "SELECT COUNT(*) FROM ユーザ情報 WHERE user_id = '"
			+ userId + "' AND delete_flg = 'false'";
			rs = model.getResultSet(checkSql);
			if(rs.next() && rs.getInt(1) > 0) {
				isRegistered = true;
			}
			model.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return isRegistered;
	}
	
	public void userRegist(String username, String userId,
			String hashedpassword, String createuser, String updateuser) {
		MyDBAccess model = new MyDBAccess();
		String sql = "INSERT"
				+ " INTO"
				+ " ユーザ情報 (user_name, user_id, password, admin_flg, delete_flg,"
				+ " create_date, create_user, update_date, update_user) "
				+ " VALUES"
				+ " ('"+ username +"', '"+ userId +"', '"+ hashedpassword +"', FALSE, FALSE,"
				+ " current_timestamp, '"+ createuser +"', current_timestamp, '"+ updateuser +"')"
				+ " ON CONFLICT (user_id) DO UPDATE SET "
				+ " user_name = EXCLUDED.user_name, password =EXCLUDED.password, "
				+ " delete_flg = 'false', update_date = current_timestamp, update_user = EXCLUDED.update_user;";
		try {
			model.open();
			model.execute(sql);
			model.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void userUpdate(String username, String userId,
			String hashedpassword,  String updateuser) {
		MyDBAccess model = new MyDBAccess();
		String sql = "UPDATE"
				+ " ユーザ情報 SET"
				+ " user_name = '"+ username +"',"
				+ (!hashedpassword.isEmpty() ? "password = '" + hashedpassword + "', " : "")
				+ " update_date = current_timestamp,"
				+ " update_user = '"+ updateuser +"'"
				+ " WHERE"
				+ " user_id='"+ userId +"';";
		try {
			model.open();
			model.execute(sql);
			model.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<HashMap<String, String>> setUserList(boolean adminflg) {
		ResultSet rs = null;
		String sql = "SELECT * FROM ユーザ情報 where delete_flg = 'false' order by user_id ASC ";
		// DBアクセス処理
		List<HashMap<String, String>> userList = new ArrayList<HashMap<String, String>>();
		MyDBAccess model = new MyDBAccess();
		try {
			model.open();
			rs = model.getResultSet(sql);
			while (rs.next()) {
				HashMap<String, String> userInfo = new HashMap<String, String>();

				userInfo.put("userName", rs.getString("user_name"));
				userInfo.put("userId", rs.getString("user_id"));
				userInfo.put("createUser" ,  rs.getString("create_user"));
				adminflg = rs.getBoolean("admin_flg"); // 削除判定追加
				String userAdmin = adminflg == true ? "true" : "false";
				userInfo.put("userAdmin", userAdmin);

				userList.add(userInfo);
			}
			model.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userList;
	}
	
	public String getCreatorId(MyDBAccess model, String userId) throws Exception{
		String creatorId = null;
		String sql = "SELECT create_user FROM ユーザ情報 WHERE user_id='" + userId + "'";
		
		ResultSet rs = model.getResultSet(sql);
		if(rs.next()) {
			creatorId = rs.getString("create_user");
		}
		return creatorId;
	}

	public void usAccess(String currentUserId, String[] userIdList, boolean isSuperUser){
		Boolean adminflg = false;
		String str = ""; // コンソール表示用

		MyDBAccess model = new MyDBAccess();
		try{
			model.open();

			for(String userId : userIdList){
				if(!(userId.equals(""))){
					String creatorId = getCreatorId(model, userId);
					
					if(isSuperUser || (creatorId != null && creatorId.equals(currentUserId))) {
					String sql = "SELECT admin_flg, delete_flg "
								+ "FROM ユーザ情報 "
								+ "WHERE user_id='" + userId + "'";
					ResultSet rs = null;
					rs = model.getResultSet(sql);
					while(rs.next()) {
						adminflg = rs.getBoolean("admin_flg");
					}
					String updateSql;
					if(adminflg == false) {
						 str = "管理者 ";
						updateSql = "UPDATE ユーザ情報 "
									+ "SET admin_flg='true' "
									+ "WHERE user_id='" + userId + "'";
					} else {
						str = "一般 ";
						updateSql = "UPDATE ユーザ情報 "
									+ "SET admin_flg='false' "
									+ "WHERE user_id='" + userId + "'";
					}
					model.execute(updateSql);
					System.out.println("ユーザ " + userId + " は " + str + "です");
					
					}else {
						System.err.println("エラー：ユーザ" + userId + "のアクセス権変更権限がありません");
					}
				}
			}
			model.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void usDelete(String currentUserId, String[] userIdList, boolean isSuperUser){

		MyDBAccess model = new MyDBAccess();
		try{
			model.open();

			for(String userId : userIdList){
				if(!(userId.equals(""))){
					String creatorId = getCreatorId(model, userId);
					String sql = null;

					if(isSuperUser || (creatorId != null && creatorId.equals(currentUserId))){
						sql = "UPDATE ユーザ情報 SET delete_flg = 'true' " + "WHERE user_id='" + userId + "'";
					}

					if(sql != null) {
						model.execute(sql);
						System.out.println("ユーザ " + userId + " は 削除 されました");
					}else{
						System.err.println("エラー：ユーザ" + userId + "の削除権限がありません");
					}
				}
			}
			model.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
