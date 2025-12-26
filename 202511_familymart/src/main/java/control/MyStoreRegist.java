package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.MyStoreDAO;

/**
 * Servlet implementation class MyStoreRegist
 */
@WebServlet("/MyStoreRegist")
public class MyStoreRegist extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public MyStoreRegist() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
// MY店舗登録
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		request.setCharacterEncoding("UTF-8");
		String userId = (String) session.getAttribute("userId");
		String shopId = request.getParameter("shopId");
		String mode = request.getParameter("registMode");
		MyStoreDAO msDAO = new MyStoreDAO();
		if (mode != null) {
			if (mode.equals("regist")) {
				msDAO.registOwner(userId, shopId);
				request.setAttribute("status", "MY店舗に登録しました");
			} else {
				msDAO.removeOwner(userId, shopId);
				request.setAttribute("status", "MY店舗から削除しました");
			}
		}
		
		request.setAttribute("myStoreList", msDAO.setShopDataList(userId));
		
		request.setAttribute("mode", "listSet");
		RequestDispatcher dispatch = request.getRequestDispatcher("view/MyStore.jsp");
		dispatch.forward(request, response);
	}

}
