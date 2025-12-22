package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.FMsearchDAO;

@WebServlet("/FMsearch")
public class FMsearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("windows-31j");

		String shp = request.getParameter("shp");
		String edit = request.getParameter("edit");
		String[] presArr = request.getParameterValues("prefectures");
		String prefectures = "";
		if (presArr != null && presArr.length > 0) {
			prefectures = String.join(",", presArr);
		}

		if (shp == null)
			shp = "";
		shp = shp.trim();

		if (edit == null)
			edit = "false";

		int page = 1;
		if (request.getParameter("page") != null) {
			try {
				page = Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
				page = 1;
			}
		}

		FMsearchDAO fmDAO = new FMsearchDAO();
		List<Shopinfo> list = fmDAO.setShopDataList(shp, edit, prefectures);

		request.setAttribute("shopdata", list);
		request.setAttribute("page", page);
		request.setAttribute("shp", shp);
		request.setAttribute("edit", edit);
		request.setAttribute("prefectures", prefectures);

		RequestDispatcher dispatch = request.getRequestDispatcher("view/FMview.jsp");
		dispatch.forward(request, response);
	}
}
