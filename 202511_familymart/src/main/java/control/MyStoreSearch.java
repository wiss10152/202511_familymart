package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.MyStoreDAO;

/**
 * Servlet implementation class MyStoreSerch
 */
@WebServlet("/MyStoreSearch")
public class MyStoreSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public MyStoreSearch() {
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
		request.setCharacterEncoding("UTF-8");
//		HttpSession session = request.getSession();
		String text = request.getParameter("shopName");
		MyStoreDAO msDAO = new MyStoreDAO();
		
		if (text != null) {
			request.setAttribute("myStoreList", msDAO.setSearchedShopList(text));
		} else {
			request.setAttribute("myStoreList", null);
		}
		request.setAttribute("mode", "search");
		RequestDispatcher dispatch = request.getRequestDispatcher("view/MyStore.jsp");
		dispatch.forward(request, response);
	}

}
