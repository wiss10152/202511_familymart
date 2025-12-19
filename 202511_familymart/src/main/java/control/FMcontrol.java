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

/*
 * Servlet implementation class FMcontrol
 */
@WebServlet("/FMcontrol")
public class FMcontrol extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
	public FMcontrol() {
		super();
	}

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pre = request.getParameter("pre"); // 県情報の取得
		String edit = request.getParameter("edit"); // 出店済みか否か(TorF)の情報を取得

		request.setAttribute("shopdata", ShopDataList(pre, edit)); // 店舗データ
		request.setAttribute("skey", "1"); // hiddenに渡す
		request.setAttribute("pre", pre);
		request.setAttribute("edit", edit);
		RequestDispatcher dispatch = request.getRequestDispatcher("view/FMview.jsp");
		dispatch.forward(request, response);
	}

	// 8月　店舗の情報を取得するSQLをセットする。RankingListで呼び出している 9/22
	private String SendSQLSentence(String pre, String edit){
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT 店舗名,to_char(出店日, 'YYYY年MM月DD日')出店日,住所,deleted,店舗id ");
		sql.append("FROM 出店計画");
		
		if(pre != null && pre.equals("") && !pre.equals("総合")) {
			if(pre.contains(",")) {
				String[] preArray = pre.split(",");
				sql.append("WHERE 都道府県 IN (");
				for(int i=0; i<preArray.length; i++) {
					sql.append("'").append(preArray[i]).append("'");
					if(i<preArray.length - 1) sql.append(", ");
				}
				sql.append(") ");
			}else {
				sql.append("WHERE 都道府県 = '").append(pre).append("' ");
			}
			sql.append("AND deleted = '").append(edit).append("' ");
		}else {
			sql.append("WHERE deleted = '").append(edit).append("' ");
		}
		
		sql.append("ORDER BY 出店日;");
		
		return sql.toString();
	}

	/*if(edit.equals("true")){ // 非表示状態のものを表示するSQL
		sql = "SELECT "
			+ "店舗名,to_char(出店日, 'YYYY年MM月DD日')出店日,住所,deleted,店舗id "
			+ "FROM "
			+ "出店計画 "
			+ "WHERE "
			+ "都道府県='"+ pre +"' "
			+ "AND deleted='true' "
			+ "ORDER BY "
			+ "出店日; ";
	
	} else { 				 // 表示状態の店舗を表示するSQL
		sql = "SELECT "
			+ "店舗名,to_char(出店日, 'YYYY年MM月DD日')出店日,住所,deleted,店舗id "
			+ "FROM "
			+ "出店計画 "
			+ "WHERE "
			+ "都道府県='"+ pre +"' "
			+ "AND deleted='false' "
			+ "ORDER BY "
			+ "出店日; ";
	}
	
	return sql;
	}*/

	// 8月　店舗データをリストに入れる。リクエストで呼び出している 9/22
	private List<Shopinfo> ShopDataList(String pre, String edit) {
		List<Shopinfo> ShopList = new ArrayList<Shopinfo>();

		MyDBAccess model = new MyDBAccess();
		try {
			model.open();

			ResultSet rs = null;
			rs = model.getResultSet(SendSQLSentence(pre, edit));

			while (rs.next()) {
				Shopinfo shop = new Shopinfo();

				shop.shopName = rs.getString("店舗名");
				shop.uriShopName = URLEncoder.encode(shop.shopName, "UTF-8");
				shop.openDate = rs.getString("出店日");
				shop.shopAdr = rs.getString("住所");
				shop.uriShopAdr = URLEncoder.encode(shop.shopAdr, "UTF-8");
				shop.deleted = rs.getBoolean("deleted");//削除判定追加
				shop.shopid = rs.getString("店舗id");

				ShopList.add(shop);
			}

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return ShopList;
	}
}