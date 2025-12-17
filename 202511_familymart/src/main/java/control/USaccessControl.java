package control;

import java.io.IOException;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.MyDBAccess;

@WebServlet("/USaccessControl")
public class USaccessControl extends HttpServlet{

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		jakarta.servlet.http.HttpSession session = request.getSession(false);
		String currentUserId = null;
		boolean isSuperUser = false;
		
		if(session != null) {
			currentUserId = (String) session.getAttribute("userId");
			Boolean mngObj = (Boolean) session.getAttribute("management_flg");
			isSuperUser = (mngObj != null && mngObj);
		}
		
		if(currentUserId == null) {
			response.sendRedirect(request.getContextPath() + "/view/login.jsp");
			return;
		}

		String actionId	  = request.getParameter("actionId");
		String[] userIdList = request.getParameterValues("userId");

		if("access".equals(actionId) ){
			usAccess(currentUserId, userIdList, isSuperUser);
		} else if("delete".equals(actionId)) {
			usDelete(currentUserId, userIdList, isSuperUser);
		}

		RequestDispatcher dispatch = request.getRequestDispatcher("/USshow");
		dispatch.forward(request, response);
	}
	
	private String getCreatorId(MyDBAccess model, String userId) throws Exception{
		String creatorId = null;
		String sql = "SELECT create_user FROM ユーザ情報 WHERE user_id='" + userId + "'";
		
		ResultSet rs = model.getResultSet(sql);
		if(rs.next()) {
			creatorId = rs.getString("create_user");
		}
		return creatorId;
	}

	// ユーザのアクセス権を変更する関数
	private void usAccess(String currentUserId, String[] userIdList, boolean isSuperUser){
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

	// ユーザを削除する関数
	private void usDelete(String currentUserId, String[] userIdList, boolean isSuperUser){

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
