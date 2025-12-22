package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.GIcontrolDAO;

/*
 * Servlet implementation class GIcontrol
 */
@WebServlet("/GIcontrol")
public class GIcontrol extends HttpServlet{
	private static final long serialVersionUID=1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
	public GIcontrol(){
		super();
	}

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{

		String item = request.getParameter("item"); // 商品名
		item = new String(item.getBytes("UTF-8"), "UTF-8");

		GIcontrolDAO giDAO = new GIcontrolDAO();
		request.setAttribute("getitem", giDAO.setItemDetailList(item));
		RequestDispatcher dispatch = request.getRequestDispatcher("view/getItem.jsp");
		dispatch.forward(request, response);
	}
}