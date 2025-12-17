package control;

import java.io.IOException;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.MyDBAccess;

/*
 * Servlet implementation class USregist
 */
@WebServlet("/USregist")
public class USregist extends HttpServlet {

	/*
	 * @see HttpServlet#HttpServlet()
	 */
	public USregist() {
		super();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession(true);
		
		Boolean mngObj = (Boolean) session.getAttribute("management_flg");
		boolean isSuperUser = (mngObj != null && mngObj);

		String[] ArrayUserId = (String[])session.getAttribute("kizo");

		String userId			= request.getParameter("userId");
		String username		= request.getParameter("username");
		String createuser		= (String)session.getAttribute("userId");
		String updateuser		= (String)session.getAttribute("userId");
		String execProcess		= request.getParameter("actionId");
		String pw = request.getParameter("passWord");
		Ubcrypt bcrypt = Ubcrypt.getInstance();
		String hashedpassword = bcrypt.encodePw(pw);
		
		session.setAttribute("isRegisteredUserId", false);

		String str = ""; // コンソール表示用
		String sql = "";
		boolean isRegistered = false;

		if(execProcess.equals("userRegist")) {
			str = "登録";
			MyDBAccess model = new MyDBAccess();
			try {
				model.open();
				String checkSql = "SELECT COUNT(*) FROM ユーザ情報 WHERE user_id = '" + userId + "' AND delete_flg = 'false'";
				ResultSet rs = model.getResultSet(checkSql);
				if(rs.next() && rs.getInt(1) > 0) {
					isRegistered = true;
				}
				model.close();
			}catch(Exception e) {
				e.printStackTrace();
			}

		} else if(execProcess.equals("update")) {
			str = "更新";
			userId = request.getParameter("userId");
		}

		if(isRegistered) {
			session.setAttribute("isRegisteredUserId", true);
			RequestDispatcher dispatch = request.getRequestDispatcher("view/USregist.jsp");
			dispatch.forward(request, response);

		} else {
			MyDBAccess model = new MyDBAccess();
			try{
				model.open();

				if(execProcess.equals("userRegist")) {
					sql = "INSERT"
						+ " INTO"
						+ " ユーザ情報 (user_name, user_id, password, admin_flg, delete_flg,"
						+ " create_date, create_user, update_date, update_user) "
						+ " VALUES"
						+ " ('"+ username +"', '"+ userId +"', '"+ hashedpassword +"', FALSE, FALSE,"
						+ " current_timestamp, '"+ createuser +"', current_timestamp, '"+ updateuser +"')"
						+ " ON CONFLICT (user_id) DO UPDATE SET "
						+ " user_name = EXCLUDED.user_name, password =EXCLUDED.password, "
						+ " delete_flg = 'false', update_date = current_timestamp, update_user = EXCLUDED.update_user;";

				} else if(execProcess.equals("update")) {
					sql = "UPDATE"
						+ " ユーザ情報 SET"
						+ " user_name = '"+ username +"',"
						+ (!hashedpassword.isEmpty() ? "password = '" + hashedpassword + "', " : "")
						+ " update_date = current_timestamp,"
						+ " update_user = '"+ updateuser +"'"
						+ " WHERE"
						+ " user_id='"+ userId +"';";

						if(session.getAttribute("userId").equals(userId)){
							session.setAttribute("userName", username);
						}
				}

				model.execute(sql);
				model.close();

			} catch(Exception e) {
				e.printStackTrace();
			}

			System.out.println("ユーザ " + userId + " は " + str + " されました");
			session.setAttribute("isRegisteredUserId", false);
			response.sendRedirect(request.getContextPath() + "/USshow");

		}
	}

}