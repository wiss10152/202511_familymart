package model;

import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.Shopinfo;

public class FMcontrolDAO {
	private String sendSQLSentence(String pre, String edit) {
		String sql = null;

		if (edit.equals("true")) { // 非表示状態のものを表示するSQL
			sql = "SELECT "
					+ "店舗名,to_char(出店日, 'YYYY年MM月DD日')出店日,住所,deleted,店舗id "
					+ "FROM "
					+ "出店計画 "
					+ "WHERE "
					+ "都道府県='" + pre + "' "
					+ "AND deleted='true' "
					+ "ORDER BY "
					+ "出店日; ";

		} else { // 表示状態の店舗を表示するSQL
			sql = "SELECT "
					+ "店舗名,to_char(出店日, 'YYYY年MM月DD日')出店日,住所,deleted,店舗id "
					+ "FROM "
					+ "出店計画 "
					+ "WHERE "
					+ "都道府県='" + pre + "' "
					+ "AND deleted='false' "
					+ "ORDER BY "
					+ "出店日; ";
		}

		return sql;
	}

	// 8月　店舗データをリストに入れる。リクエストで呼び出している 9/22
	public List<Shopinfo> setShopDataList(String pre, String edit) {
		List<Shopinfo> ShopList = new ArrayList<Shopinfo>();

		MyDBAccess model = new MyDBAccess();
		try {
			model.open();

			ResultSet rs = null;
			rs = model.getResultSet(sendSQLSentence(pre, edit));

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

	public int delete(String shopId, String deleted) {
		MyDBAccess model = new MyDBAccess();
		try {
			model.open();
			model.execute(
					"UPDATE 出店計画 SET deleted='" + deleted + "' WHERE 店舗id='" + shopId + "'");
			model.close();
		} catch (Exception e) {
			return 500;
		}
		return 200;
	}
}
