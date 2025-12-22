package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.FMcontrolDAO;

/*
 * Servlet implementation class FMcontrol
 */
@WebServlet("/FMcontrol")
public class FMcontrol extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
	public FMcontrol() {
		super();
	}

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pre = request.getParameter("pre"); // 県情報の取得
		String edit = request.getParameter("edit"); // 出店済みか否か(TorF)の情報を取得

		FMcontrolDAO fmDAO = new FMcontrolDAO();
		request.setAttribute("shopdata", fmDAO.setShopDataList(pre, edit)); // 店舗データ
		request.setAttribute("skey", "1"); // hiddenに渡す
		request.setAttribute("pre", pre);
		request.setAttribute("edit", edit);
		RequestDispatcher dispatch = request.getRequestDispatcher("view/FMview.jsp");
		dispatch.forward(request, response);
	}
}