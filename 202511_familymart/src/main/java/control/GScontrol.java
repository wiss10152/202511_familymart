package control;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.GScontrolDAO;

/*
 * Servlet implementation class GScontrol
 */
@WebServlet("/GScontrol")
public class GScontrol extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
	public GScontrol() {
		super();
	}

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
// 店舗詳細取得
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String shop = request.getParameter("shop"); // 店舗名
		shop = new String(shop.getBytes("UTF-8"), "UTF-8");
		
		GScontrolDAO gsDAO = new GScontrolDAO();
		String shopAddress = gsDAO.getShopAddress(shop);
		if(shopAddress != null) {
			String encodeAddress = URLEncoder.encode(shopAddress, "UTF-8");
			request.setAttribute("encodeShopAddress", encodeAddress);
			request.setAttribute("shopAddress", shopAddress);
		}

		request.setAttribute("shopfam", gsDAO.setShopTopDetailList(shop));
		request.setAttribute("shoppay", gsDAO.setShopDownDetailList(shop));
		RequestDispatcher dispatch = request.getRequestDispatcher("view/getShop.jsp");
		dispatch.forward(request, response);
	}
}