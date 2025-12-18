package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.MyDBAccess;
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		request.setCharacterEncoding("UTF-8");
		String userId = (String) session.getAttribute("userId");
		String shopId = request.getParameter("shopId");
		String mode = request.getParameter("registMode");
		if (mode != null) {
			changeOwner(userId, shopId, mode);
			if (mode.equals("regist")) {
				request.setAttribute("status", "MY店舗に登録しました");
			} else {
				request.setAttribute("status", "MY店舗から削除しました");
			}
		}
		
		MyStoreDAO msDAO = new MyStoreDAO();
		request.setAttribute("myStoreList", msDAO.ShopDataList(userId));
		
		request.setAttribute("mode", "listSet");
		RequestDispatcher dispatch = request.getRequestDispatcher("view/MyStore.jsp");
		dispatch.forward(request, response);
	}
	private void changeOwner(String userId, String shopId, String mode){

		MyDBAccess model = new MyDBAccess();
		String updateSql;
		if (mode.equals("regist")) {
			try{
				model.open();
				updateSql = "UPDATE 出店計画 "
						+ "SET 店舗オーナー='" + userId + "' "
						+ "WHERE 店舗id='" + shopId + "'";
				model.execute(updateSql);
				model.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else {
			try{
				model.open();
				updateSql = "UPDATE 出店計画 "
						+ "SET 店舗オーナー = NULL "
						+ "WHERE 店舗id='" + shopId + "'";
				model.execute(updateSql);
				model.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}

}
