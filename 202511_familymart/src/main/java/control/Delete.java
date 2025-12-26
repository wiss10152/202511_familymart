package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.FMcontrolDAO;

@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
// 出店状況変更
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String shopId = request.getParameter("shop");
		String deleted = request.getParameter("deleted");
		int num = 500;
		if (shopId != null && deleted != null) {
			FMcontrolDAO fmDAO = new FMcontrolDAO();
			num = fmDAO.delete(shopId, deleted);
		}

		response.setStatus(num);
	}

}
