package control;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.MyDBAccess;

/**
 * Servlet implementation class MyStore
 */
@WebServlet("/MyStoreServlet")
public class MyStoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public MyStoreServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String ownerId = (String)session.getAttribute("userId");

		request.setAttribute("myStoreList", ShopDataList(ownerId));
		
		request.setAttribute("mode", "listSet");
		RequestDispatcher dispatch = request.getRequestDispatcher("view/MyStore.jsp");
		dispatch.forward(request, response);
	}
	
	private List<Shopinfo> ShopDataList(String id) {
		String sql = "SELECT * FROM 出店計画 WHERE 店舗オーナー = '" + id + "' ";
		List<Shopinfo> storeList = new ArrayList<Shopinfo>();
		// DBアクセス処理
		MyDBAccess model = new MyDBAccess();
		try {
			model.open();
			ResultSet rs = null;
			rs = model.getResultSet(sql);

			while (rs.next()) {
				Shopinfo shopData = new Shopinfo();
				shopData.shopid = rs.getString("店舗id");
				shopData.shopName = rs.getString("店舗名");
				shopData.openDate = rs.getString("出店日");
				shopData.shopAdr = rs.getString("住所");
				shopData.deleted = rs.getBoolean("deleted");
				
				storeList.add(shopData);
			}
			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return storeList;
	}

}
