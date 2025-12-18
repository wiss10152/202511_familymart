package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.Shopinfo;

public class MyStoreDAO {
	public List<Shopinfo> ShopDataList(String id) {
		String sql = "SELECT * FROM 出店計画 WHERE 店舗オーナー = '" + id + "' ";
		List<Shopinfo> storeList = new ArrayList<Shopinfo>();
		// DBアクセス処理
		MyDBAccess model = new MyDBAccess();
		try {
			model.open();
			ResultSet rs = null;
			rs = model.getResultSet(sql);

			while (rs.next()) {
				Shopinfo shopData = new Shopinfo();
				shopData.shopid = rs.getString("店舗id");
				shopData.shopName = rs.getString("店舗名");
				shopData.openDate = rs.getString("出店日");
				shopData.shopAdr = rs.getString("住所");
				shopData.deleted = rs.getBoolean("deleted");
				
				storeList.add(shopData);
			}
			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return storeList;
	}
}
