package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.SHsearchDAO;

/*
 * Servlet implementation class SHsearch
 */

// 商品検索
@WebServlet("/SHsearch")
public class SHsearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String str = request.getParameter("str");
		if (str == null)
			str = "";
		str = str.trim();

		SHsearchDAO shDAO = new SHsearchDAO();
		List<Itemfam> list = shDAO.setItemDataList(str);

		request.setAttribute("itemfam", list);
		request.setAttribute("str", str);

		RequestDispatcher dispatch = request.getRequestDispatcher("/view/SHview.jsp");
		dispatch.forward(request, response);
	}
}
