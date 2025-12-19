package control;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.UserStatusDAO;

/*
 * Servlet implementation class SUshow
 */
@WebServlet("/USshow")
public class USshow extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		String currentUserId = (session != null) ? (String) session.getAttribute("userId"): null;

		List<HashMap<String, String>> userList = new ArrayList<HashMap<String, String>>();
		Boolean adminflg = true;
		
		try {
			UserStatusDAO usDAO = new UserStatusDAO();

			ResultSet rs = usDAO.setUserList();

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

		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("userList", userList);
		request.setAttribute("currentUserId", currentUserId);
		RequestDispatcher dispatch = request.getRequestDispatcher("view/USview.jsp");
		dispatch.forward(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}