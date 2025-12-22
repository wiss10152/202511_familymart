package model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.Shopinfo;

public class MyStoreDAO {
	// MY店舗一覧取得
	public List<Shopinfo> setShopDataList(String id) {
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
	
	// MY店舗に登録
	public void registOwner(String userId, String shopId){

		MyDBAccess model = new MyDBAccess();
		String updateSql;
		try{
			model.open();
			updateSql = "UPDATE 出店計画 "
					+ "SET 店舗オーナー='" + userId + "' "
					+ "WHERE 店舗id='" + shopId + "'";
			model.execute(updateSql);
			model.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// MY店舗から削除
	public void removeOwner(String userId, String shopId){
		MyDBAccess model = new MyDBAccess();
		String updateSql;
		try{
			model.open();
			updateSql = "UPDATE 出店計画 "
					+ "SET 店舗オーナー = NULL "
					+ "WHERE 店舗id='" + shopId + "'";
			model.execute(updateSql);
			model.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 店舗を探す
	public List<Shopinfo> setSearchedShopList(String text) {
		String sql = "SELECT * FROM 出店計画 WHERE 店舗オーナー IS NULL AND 店舗名 LIKE '%" + text + "%' ";
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
