package control;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.MyDBAccess;

@WebServlet("/FMsearch")
public class FMsearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    request.setCharacterEncoding("windows-31j");

	    String shp  = request.getParameter("shp");
	    String edit = request.getParameter("edit");
	    String prefectures = request.getParameter("prefectures");

	    if (shp == null) shp = "";
	    shp = shp.trim();

	    if (edit == null) edit = "false";

	    int page = 1;
	    if (request.getParameter("page") != null) {
	        try {
	            page = Integer.parseInt(request.getParameter("page"));
	        } catch (Exception e) {
	            page = 1;
	        }
	    }

	    List<Shopinfo> list = ShopDataList(shp, edit, prefectures);

	    request.setAttribute("shopdata", list);
	    request.setAttribute("page", page);
	    request.setAttribute("shp", shp);
	    request.setAttribute("edit", edit);
	    request.setAttribute("prefectures", prefectures);


	    RequestDispatcher dispatch =
	        request.getRequestDispatcher("view/FMview.jsp");
	    dispatch.forward(request, response);
	}

	
	private String SendSQLSentence(String shp, String edit, String prefectures) {

		StringBuilder sql = new StringBuilder();

		sql.append("SELECT 店舗名, ");
		sql.append("to_char(出店日,'YYYY年MM月DD日') 出店日, ");
		sql.append("住所, deleted, 店舗id ");
		sql.append("FROM 出店計画 ");
		sql.append("WHERE 店舗名 LIKE '%").append(shp).append("%' ");

		if ("true".equals(edit)) {
			sql.append("AND deleted = true ");
		} else if ("false".equals(edit)) {
			sql.append("AND deleted = false ");
		}

		if (prefectures != null && !prefectures.isEmpty()) {
			String[] pres = prefectures.split(",");
			sql.append("AND (");
			for (int i = 0; i < pres.length; i++) {
				if (i > 0) sql.append(" OR ");
				sql.append("住所 LIKE '%").append(pres[i]).append("%'");
			}
			sql.append(") ");
		}

		return sql.toString();
	}

	
	private List<Shopinfo> ShopDataList(String shp, String edit, String prefectures) {

		List<Shopinfo> list = new ArrayList<>();
		MyDBAccess model = new MyDBAccess();

		try {
			model.open();

			String sql = SendSQLSentence(shp, edit, prefectures);
			ResultSet rs = model.getResultSet(sql);

			while (rs.next()) {
				Shopinfo s = new Shopinfo();
				s.shopName = rs.getString("店舗名");
				s.uriShopName = URLEncoder.encode(s.shopName, "UTF-8");
				s.openDate = rs.getString("出店日");
				s.shopAdr = rs.getString("住所");
				s.uriShopAdr = URLEncoder.encode(s.shopAdr, "UTF-8");
				s.deleted = rs.getBoolean("deleted");
				s.shopid = rs.getString("店舗id");
				list.add(s);
			}

			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}
