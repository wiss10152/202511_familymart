package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.MyDBAccess;

@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String shopId  = request.getParameter("shop");
	    String deleted = request.getParameter("deleted");

	    if (shopId != null && deleted != null) {
	        MyDBAccess model = new MyDBAccess();
	        try {
	            model.open();
	            model.execute(
	                "UPDATE 出店計画 SET deleted='" + deleted + "' WHERE 店舗id='" + shopId + "'"
	            );
	            model.close();
	        } catch (Exception e) {
	            response.setStatus(500);
	            return;
	        }
	    }

	    response.setStatus(200);
	}

	
}
