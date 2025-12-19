package control;

import java.io.IOException;
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

@WebServlet("/FMrank")
public class FMrank extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FMrank() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pre = request.getParameter("pre");
		String edit = request.getParameter("edit");
		
		String regionName = request.getParameter("regionName");
		String displayName = (regionName != null && !regionName.isEmpty()) ? regionName : pre;

		request.setAttribute("RANKInfo", RankingList(pre, edit));
		request.setAttribute("pre", pre);
		request.setAttribute("displayName", displayName);
		request.setAttribute("edit", edit);

		RequestDispatcher dispatch = request.getRequestDispatcher("view/FMrank2.jsp");
		dispatch.forward(request, response);
	}

	private String SendSQLSentence(String pre, String edit) {
		String sql = null;

		if (edit.equals("true")) { // 店舗ランキング

			String whereClause = "";
			if (pre.equals("総合")) {
				whereClause = "";
			} else if (pre.contains(",")) {
				String[] preArray = pre.split(",");
				StringBuilder inPart = new StringBuilder(" WHERE 都道府県 IN (");
				for (int i = 0; i < preArray.length; i++) {
					inPart.append("'").append(preArray[i]).append("'");
					if (i < preArray.length - 1)
						inPart.append(", ");
				}
				inPart.append(") ");
				whereClause = inPart.toString();
			} else {
				whereClause = " WHERE 都道府県 = '" + pre + "' ";
			}

			sql = "SELECT " +
					" 出店計画.店舗id, 店舗名, 住所, " +
					" Sum(数量*価格) AS 売上_raw, " +
					" Sum(数量*仕入れ値) AS 原価_raw, " +
					" (Sum(数量*価格) - Sum(数量*仕入れ値)) AS 利益_raw, " +
					" TO_CHAR(Sum(数量*価格), 'FM999,999,999円') AS 売上額, " +
					" TO_CHAR((Sum(数量*価格) - Sum(数量*仕入れ値)), 'FM999,999,999円') AS 利益, " +
					" DENSE_RANK() OVER(ORDER BY Sum(数量*価格) DESC) AS 順位 " +
					" FROM 売上データ " +
					" INNER JOIN 出店計画 ON 出店計画.店舗id = 売上データ.店舗id " +
					" INNER JOIN 商品データ ON 売上データ.商品コード = 商品データ.商品コード " +
					whereClause +
					" GROUP BY 出店計画.店舗id, 店舗名, 住所 ";

		} else if (edit.equals("false")) { // 商品ランキング

			String whereClause = "";
			if (pre.equals("新商品")) {
				whereClause = " WHERE CAST('2017/08/08' AS DATE) > 販売日 AND 販売日 >= CAST('2017/07/01' AS DATE) ";
			} else if (pre.equals("総合")) {
				whereClause = "";
			} else {
				whereClause = " WHERE ジャンル = '" + pre + "' ";
			}
			sql = "SELECT " +
					" 画像, 商品名, " +
					" Sum(数量) AS 売上数, " +
					" Sum(数量)*価格 AS 売上_raw, " +
					" Sum(数量*仕入れ値) AS 原価_raw, " +
					" (Sum(数量)*価格 - Sum(数量*仕入れ値)) AS 利益_raw, " +
					" TO_CHAR(Sum(数量)*価格, 'FM999,999,999円') AS 売上額, " +
					" TO_CHAR((Sum(数量)*価格 - Sum(数量*仕入れ値)), 'FM999,999,999円') AS 利益, " +
					" DENSE_RANK() OVER(ORDER BY Sum(数量)*価格 DESC) AS 順位 " +
					" FROM 商品データ " +
					" INNER JOIN 売上データ ON 商品データ.商品コード = 売上データ.商品コード " +
					whereClause +
					" GROUP BY 商品名, 画像, 価格 ";
			} 
		
		return sql;
	}

	private List<RANKInfo> RankingList(String pre, String edit) {

		List<RANKInfo> RankList = new ArrayList<>();
		MyDBAccess model = new MyDBAccess();

		try {
			model.open();
			String sql = SendSQLSentence(pre, edit);
			if(sql == null) return RankList;

			ResultSet rs = model.getResultSet(sql);

			if (edit.equals("true")) { // 店舗

				while (rs.next()) {
					RANKInfo r = new RANKInfo();

					r.shop_name = rs.getString("店舗名");
					r.shop_add = rs.getString("住所");
					r.shop_rank = rs.getInt("順位");

					// 文字列（FEはこれをそのまま表示）
					r.shop_sale_str = rs.getString("売上額");
					r.shop_profit_str = rs.getString("利益");

					RankList.add(r);
				}

			} else if (edit.equals("false")) { // 商品

				while (rs.next()) {
					RANKInfo r = new RANKInfo();

					r.product_img = rs.getString("画像");
					r.product_name = rs.getString("商品名");
					r.product_Sale = rs.getInt("売上数");
					r.product_rank = rs.getInt("順位");

					// 文字列（FEはこれをそのまま表示）
					r.product_sale_str = rs.getString("売上額");
					r.product_profit_str = rs.getString("利益");

					RankList.add(r);
				}
			}

			model.close();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return RankList;
	}
}
