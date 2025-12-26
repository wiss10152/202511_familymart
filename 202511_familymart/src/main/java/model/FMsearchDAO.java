package model;

import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.Shopinfo;
import dbaccess.MyDBAccess;

public class FMsearchDAO {
	private String sendSQLSentence(String shp, String edit, String prefectures) {

		StringBuilder sql = new StringBuilder();

		sql.append("SELECT 店舗名, ");
		sql.append("to_char(出店日,'YYYY年MM月DD日') 出店日, ");
		sql.append("住所, deleted, 店舗id ");
		sql.append("FROM 出店計画 ");
		sql.append("WHERE 店舗名 LIKE '%").append(shp).append("%' ");

// editの値で出店済みかを判断
		if ("true".equals(edit)) {
			sql.append("AND deleted = false ");
		} else if ("false".equals(edit)) {
			sql.append("AND deleted = true ");
		}

		if (prefectures != null && !prefectures.isEmpty()) {
			String[] pres = prefectures.split(",");
			sql.append("AND (");
			for (int i = 0; i < pres.length; i++) {
				if (i > 0) sql.append(" OR ");
				sql.append("住所 LIKE '%").append(pres[i]).append("%'");
			}
			sql.append(") ");
		}

		return sql.toString();
	}

	
	public List<Shopinfo> setShopDataList(String shp, String edit, String prefectures) {

		List<Shopinfo> list = new ArrayList<>();
		MyDBAccess model = new MyDBAccess();

		try {
			model.open();

			String sql = sendSQLSentence(shp, edit, prefectures);
			ResultSet rs = model.getResultSet(sql);

			while (rs.next()) {
				Shopinfo s = new Shopinfo();
				s.shopName = rs.getString("店舗名");
				s.uriShopName = URLEncoder.encode(s.shopName, "UTF-8");
				s.openDate = rs.getString("出店日");
				s.shopAdr = rs.getString("住所");
				s.uriShopAdr = URLEncoder.encode(s.shopAdr, "UTF-8");
				s.deleted = rs.getBoolean("deleted");
				s.shopid = rs.getString("店舗id");
				list.add(s);
			}

			model.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}
