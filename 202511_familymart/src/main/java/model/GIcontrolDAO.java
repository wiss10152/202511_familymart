package model;

import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.Itemfam;
import dbaccess.MyDBAccess;

public class GIcontrolDAO {
	private String sendSQLSentence(String item) {
		String sql ="SELECT " // プルダウンで指定された商品データを取得するSQL
					+ "商品コード,商品名,販売会社,ジャンル,to_Char(販売日, 'YYYY/MM/DD')販売日,価格,画像 "
					+ "FROM "
					+ "商品データ "
					+ "WHERE "
					+ "商品名='" + item +"';";

		return sql;
	}

	// 商品の詳細データをリストに入れる。リクエストで呼び出している
	public List<Itemfam> setItemDetailList(String item){
		List<Itemfam> ItemList = new ArrayList<Itemfam>();

		MyDBAccess model = new MyDBAccess();
		try{
			model.open();

			ResultSet rs = null;
			rs = model.getResultSet(sendSQLSentence(item));

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

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ItemList;
	}
}
