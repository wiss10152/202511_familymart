package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.FMrankDAO;

@WebServlet("/FMrank")
public class FMrank extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FMrank() {
		super();
	}

// ランキング取得
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pre = request.getParameter("pre");
		String edit = request.getParameter("edit");
		
		String regionName = request.getParameter("regionName");
		String displayName = (regionName != null && !regionName.isEmpty()) ? regionName : pre;

		FMrankDAO fmDAO = new FMrankDAO();
		request.setAttribute("RANKInfo", fmDAO.setRankingList(pre, edit));
		request.setAttribute("pre", pre);
		request.setAttribute("displayName", displayName);
		request.setAttribute("edit", edit);

		RequestDispatcher dispatch = request.getRequestDispatcher("view/FMrank2.jsp");
		dispatch.forward(request, response);
	}
}
