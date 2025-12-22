package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.SHcontrolDAO;

/*
 * Servlet implementation class SHcontrol
 */
@WebServlet("/SHcontrol")
public class SHcontrol extends HttpServlet{
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
	public SHcontrol(){
		super();
	}

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException,IOException{

		String pre = request.getParameter("pre"); // pre=ジャンル(おにぎり、パスタ、新商品etc)

		SHcontrolDAO shDAO = new SHcontrolDAO();
		request.setAttribute("itemfam", shDAO.setItemDataList(pre));
		request.setAttribute("pre", pre);
		RequestDispatcher dispatch = request.getRequestDispatcher("view/SHview.jsp");
		dispatch.forward(request,response);
	}
}