package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.FMloginDAO;

/*
 * Servlet implementation class FMlogin
 */
@WebServlet("/FMlogin")
public class FMlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
	public FMlogin() {
		super();
	}

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		String userId		 = request.getParameter("userId");
		String password	 = request.getParameter("password");

		FMloginDAO loginDAO = new FMloginDAO();
		UserInfo usInfo = loginDAO.setUserInfo(userId);
		Boolean firstlogin	= true; // 8月新規
		
		// 指定されたユーザIDの持つ、ユーザの名前、パスワード、管理者権限の有無を取得する


		Ubcrypt ubcrypt = Ubcrypt.getInstance();
		String epw = ubcrypt.encodePw(password);
		System.out.println(epw);
		if(ubcrypt.matchesPw(password, usInfo.pw)){ // パスワードとIDが合致しているとき
			session.setAttribute("userId", userId);
			session.setAttribute("userName", usInfo.name);
			session.setAttribute("adminFlg", usInfo.adminflg);
			session.setAttribute("create_user", usInfo.create_user);
			session.setAttribute("management_flg", usInfo.management_flg);

			session.setAttribute("music", usInfo.music);			 //7月音楽を流すための判断
			session.setAttribute("manegement", usInfo.manegement);  //7月音楽を変更する判断
			session.setAttribute("isRegisteredUserId", false);	//7月既存登録かどうかの判断

			session.setAttribute("firstlogin",firstlogin); // 8月新規
			request.setAttribute("disp_alert", "0"); // loginアラートを出したいがためのフラグ…未解決

			response.sendRedirect(request.getContextPath() + "/view/USgeneral.jsp");


		} else {				  // パスワードとIDが間違っているとき
			request.setAttribute("disp_alert", "1"); // loginアラートを出したいがためのフラグ…未解決
			RequestDispatcher dispatch = request.getRequestDispatcher("view/login.jsp");
			dispatch.forward(request, response);
		}

	}

}