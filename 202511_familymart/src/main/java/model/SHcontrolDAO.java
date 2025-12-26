package model;

import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.Itemfam;
import dbaccess.MyDBAccess;

public class SHcontrolDAO {
	public String sendSQLSentence(String pre) {
		String sql = "";

		// 発売予定と新商品は日付指定が必要なためSQLを別枠で、それ以外は通常通りジャンルで分ける。
		if(pre.equals("発売予定")) { // 2017/8/8以降の商品は発売予定と判定
			sql ="SELECT "
				+ "商品コード,商品名,販売会社,ジャンル,to_Char(販売日, 'YYYY/MM/DD')販売日,価格,画像 "
				+ "FROM "
				+ "商品データ "
				+ "WHERE "
				+ "CAST('2017/08/08' AS DATE) <= 販売日 "
				+ "ORDER BY "
				+ "販売日 desc;";

		} else if(pre.equals("新商品")){ // 2017/07/01～2017/08/07の商品は新商品と判定
			sql ="SELECT "
				+ "商品コード,商品名,販売会社,ジャンル,to_Char(販売日, 'YYYY/MM/DD')販売日,価格,画像 "
				+ "FROM "
				+ "商品データ "
				+ "WHERE "
				+ "CAST('2017/08/08' AS DATE) > 販売日 AND 販売日 >= CAST('2017/07/01' AS DATE)"
				+ "ORDER BY "
				+ "販売日 desc;";
			
		} else if(pre.equals("総合")) {
			sql ="SELECT "
					+ "商品コード,商品名,販売会社,ジャンル,to_Char(販売日, 'YYYY/MM/DD')販売日,価格,画像 "
					+ "FROM "
					+ "商品データ;";

		} else { // ここが最初にあったコード
			sql ="SELECT "
				+ "商品コード,商品名,販売会社,ジャンル,to_Char(販売日, 'YYYY/MM/DD')販売日,価格,画像 "
				+ "FROM "
				+ "商品データ "
				+ "WHERE "
				+ "ジャンル = '"+ pre +"';";
		}

		return sql;
	}

	// ジャンル分けした商品データをリストに入れる。リクエストで呼び出している 9/22
	public List<Itemfam> setItemDataList(String pre){
		List<Itemfam> ItemList = new ArrayList<Itemfam>();

		MyDBAccess model = new MyDBAccess();
		try{
			model.open();

			ResultSet rs = null;
			rs = model.getResultSet(sendSQLSentence(pre));

			while(rs.next()){
				Itemfam setItem = new Itemfam();

				setItem.ItemId		 = rs.getString("商品コード");
				setItem.ItemName	 = rs.getString("商品名");
				setItem.uriItemName  = URLEncoder.encode(setItem.ItemName,"UTF-8");
				setItem.maker		 = rs.getString("販売会社");
				setItem.genre		 = rs.getString("ジャンル");
				setItem.day			 = rs.getString("販売日");
				setItem.price		 = rs.getInt("価格");
				setItem.img			 = rs.getString("画像");

				// 新商品判定を追加。1=発売予定 0=新商品 -1=既存商品
				if(("2017/08/08").compareTo(rs.getString("販売日")) <= 0) {
					setItem.newItemJudge = 1;
				} else if(("2017/07/01").compareTo(rs.getString("販売日")) <= 0) {
					setItem.newItemJudge = 0;
				} else {
					setItem.newItemJudge = -1;
				}

				ItemList.add(setItem);
			}

			model.close();

		} catch(Exception e) {
			e.printStackTrace();
		}

		return ItemList;
	}
}
