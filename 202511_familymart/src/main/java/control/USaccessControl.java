package control;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.UserStatusDAO;

@WebServlet("/USaccessControl")
public class USaccessControl extends HttpServlet{

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		jakarta.servlet.http.HttpSession session = request.getSession(false);
		String currentUserId = null;
		boolean isSuperUser = false;
		
		if(session != null) {
			currentUserId = (String) session.getAttribute("userId");
			Boolean mngObj = (Boolean) session.getAttribute("management_flg");
			isSuperUser = (mngObj != null && mngObj);
		}
		
		if(currentUserId == null) {
			response.sendRedirect(request.getContextPath() + "/view/login.jsp");
			return;
		}

		String actionId	  = request.getParameter("actionId");
		String[] userIdList = request.getParameterValues("userId");

		UserStatusDAO usDAO = new UserStatusDAO();
		
		if("access".equals(actionId) ){
			usDAO.usAccess(currentUserId, userIdList, isSuperUser);
		} else if("delete".equals(actionId)) {
			usDAO.usDelete(currentUserId, userIdList, isSuperUser);
		}

		RequestDispatcher dispatch = request.getRequestDispatcher("/USshow");
		dispatch.forward(request, response);
	}
}
