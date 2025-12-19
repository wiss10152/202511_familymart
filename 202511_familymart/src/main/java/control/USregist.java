package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.UserStatusDAO;

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
		
//		Boolean mngObj = (Boolean) session.getAttribute("management_flg");
//		boolean isSuperUser = (mngObj != null && mngObj);

//		String[] ArrayUserId = (String[])session.getAttribute("kizo");

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
		
		boolean isRegistered = false;

		if(execProcess.equals("userRegist")) {
			str = "登録";
			
			UserStatusDAO usDAO = new UserStatusDAO();
			isRegistered = usDAO.idCheck(userId);


		} else if(execProcess.equals("update")) {
			str = "更新";
			userId = request.getParameter("userId");
		}

		if(isRegistered) {
			session.setAttribute("isRegisteredUserId", true);
			RequestDispatcher dispatch = request.getRequestDispatcher("view/USregist.jsp");
			dispatch.forward(request, response);

		} else {
			UserStatusDAO usDAO = new UserStatusDAO();

			if(execProcess.equals("userRegist")) {
				usDAO.userRegist(username, userId, hashedpassword, createuser, updateuser);
				
			} else if(execProcess.equals("update")) {

				if(session.getAttribute("userId").equals(userId)){
					session.setAttribute("userName", username);
				}
				usDAO.userUpdate(username, userId, hashedpassword, updateuser);
			}

			System.out.println("ユーザ " + userId + " は " + str + " されました");
			session.setAttribute("isRegisteredUserId", false);
			response.sendRedirect(request.getContextPath() + "/USshow");

		}
	}

}