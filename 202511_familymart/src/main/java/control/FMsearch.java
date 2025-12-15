package control;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.MyDBAccess;

/*
 * Servlet implementation class FMsearch
 */
@WebServlet("/FMsearch")
public class FMsearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
    public FMsearch() {
        super();
    }

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
    	
		String shp = request.getParameter("shp");// 検索窓に入力されたデータ
		if(shp == null) {
			shp = "";
		}
		String edit = request.getParameter("edit");// 出店済みか否か(TorF)の情報取得
		
		String prefecturesParam = request.getParameter("prefectures");
		List<String> selectedPrefs = null;
		if(prefecturesParam != null && !prefecturesParam.isEmpty()) {
			selectedPrefs = Arrays.asList(prefecturesParam.split(","));
		}
		
		if(edit == null) {
			edit = "all";
		}

		request.setAttribute("shopdata", ShopDataList(shp, edit, selectedPrefs)); // 表示する店舗データ
		
		request.setAttribute("skey", "2"); // hiddenに渡す
		request.setAttribute("shp", shp);
		request.setAttribute("edit", edit);
		
		request.setAttribute("prefectures",  prefecturesParam);
		
		RequestDispatcher dispatch = request.getRequestDispatcher("view/FMview.jsp");
		dispatch.forward(request, response);
	}

	// 8月　検索窓データから店舗を取得するSQLをセットする。ShopDataListで呼び出している 9/22
	private String SendSQLSentence(String shp, String edit, List<String> selectedPrefs) {
		String sql = "SELECT 店舗名, to_char(出店日, 'YYYY年MM月DD日')出店日, 住所, deleted, 店舗id FROM 出店計画 WHERE 店舗名 LIKE '%" + shp + "%'";

		if(edit != null){
			if(edit.equals("true")) {
				sql += " AND deleted='true'";
		}else if(edit.equals("false")) {
				sql += " AND deleted='false'";
		}
		
		}
		
		if(selectedPrefs != null && !selectedPrefs.isEmpty()) {
			StringBuilder prefCondition = new StringBuilder();
			prefCondition.append(" AND (");
			for(int i=0; i<selectedPrefs.size(); i++) {
				String pref = selectedPrefs.get(i);
			prefCondition.append("住所 LIKE '%").append(pref).append("%'");
			if(i<selectedPrefs.size() -1) {
				prefCondition.append(" OR ");
			}
			
			}
			prefCondition.append(")");
			sql += prefCondition.toString();
		}
		
		return sql;
	}

	// 8月　店舗のデータをリストに入れる。リクエストで呼び出している 9/22
	private List<Shopinfo> ShopDataList(String shp, String edit, List<String> selectedPrefs){
		List<Shopinfo> ShopList = new ArrayList<Shopinfo>();

		MyDBAccess model = new MyDBAccess();
		try {
			model.open();

			ResultSet rs = null;
			rs = model.getResultSet(SendSQLSentence(shp, edit, selectedPrefs));

			while(rs.next()) {
				Shopinfo setShop = new Shopinfo() ;

				setShop.shopName	= rs.getString("店舗名");
				setShop.uriShopName = URLEncoder.encode(setShop.shopName, "UTF-8");
				setShop.openDate 	= rs.getString("出店日");
				setShop.shopAdr		= rs.getString("住所");
				setShop.uriShopAdr	= URLEncoder.encode(setShop.shopAdr, "UTF-8");
				setShop.deleted		= rs.getBoolean("deleted");
				setShop.shopid		= rs.getString("店舗id");

				ShopList.add(setShop);
			}

			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ShopList;
	}

}