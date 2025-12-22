package model;

import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.Itemfam;

public class SHsearchDAO {
	private String sendSQLSentence(String str) {

		String sql = "SELECT * FROM 商品データ ";

		if (!str.isEmpty()) {
			sql += " WHERE 商品名 LIKE '%" + str + "%'";
		}

		return sql;
	}

	public List<Itemfam> setItemDataList(String str) {

		List<Itemfam> ItemList = new ArrayList<>();
		MyDBAccess model = new MyDBAccess();

		try {
			model.open();

			ResultSet rs = model.getResultSet(sendSQLSentence(str));

			while (rs.next()) {
				Itemfam setItem = new Itemfam();

				setItem.ItemId = rs.getString("商品コード");
				setItem.ItemName = rs.getString("商品名");
				setItem.uriItemName = URLEncoder.encode(setItem.ItemName, "UTF-8");
				setItem.maker = rs.getString("販売会社");
				setItem.genre = rs.getString("ジャンル");
				setItem.day = rs.getString("販売日");
				setItem.price = rs.getInt("価格");
				setItem.img = rs.getString("画像");

				ItemList.add(setItem);
			}

			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ItemList;
	}
}
