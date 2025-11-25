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
 * Servlet implementation class SHsearch
 */
@WebServlet("/SHsearch")
public class SHsearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/*
	 * @see HttpServlet#HttpServlet()
	 */
    public SHsearch() {
        super();
    }

	/*
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {

		String str = request.getParameter("str"); // 検索窓に入力された文字列

		request.setAttribute("itemfam", ItemDataList(str)); // strに該当する商品リスト
		request.setAttribute("str", str);
		RequestDispatcher dispatch = request.getRequestDispatcher("view/SHview.jsp");
		dispatch.forward(request,response);
	}

	// 8月　検索文字列で得た店舗データを取得するSQLをセットする。ItemDataListで呼び出している 9/22
	private String SendSQLSentence(String str) {
		String sql = " SELECT" // 入力されたワードを含む商品名の検索SQL
					+ " *"
					+ " FROM"
					+ " 商品データ"
					+ " WHERE"
					+ " 商品名 LIKE '%" + str + "%';";

		return sql;
	}

	// 8月　検索した店舗データをリストに入れる。リクエストで呼び出している 9/22
	private List<Itemfam> ItemDataList(String str){
		List<Itemfam> ItemList = new ArrayList<Itemfam>();

		MyDBAccess model = new MyDBAccess();
		try{
			model.open();

			ResultSet rs = null;
			rs = model.getResultSet(SendSQLSentence(str));

			while(rs.next()){
				Itemfam setItem = new Itemfam();

				setItem.ItemId 		 = rs.getString("商品コード");
				setItem.ItemName	 = rs.getString("商品名");
				setItem.uriItemName  = URLEncoder.encode(setItem.ItemName,"UTF-8");
				setItem.maker		 = rs.getString("販売会社");
				setItem.genre		 = rs.getString("ジャンル");
				setItem.day			 = rs.getString("販売日");
				setItem.price		 = rs.getInt("価格");
				setItem.img			 = rs.getString("画像");

				ItemList.add(setItem);
			}

			model.close();

		} catch(Exception e) {
			e.printStackTrace();
		}

		return ItemList;
	}

}