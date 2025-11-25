<%@ page import="java.util.*, java.net.*, java.sql.*, model.MyDBAccess,control.Itemfam"
	language="java" contentType="text/html; charset=UTF-8" %>

<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");
	if (login == null){
		pageContext.forward("/view/login.jsp");
	}
%>

<%
	// 取得したデータをリストに格納する
	List<Itemfam> itemname = (List<Itemfam>)request.getAttribute("itemfam");

	String gen =(String)request.getAttribute("gen");
	String str =(String)request.getAttribute("str");

	String x = "";
	//ジャンル表示かキーワード検索かの判断
	if(gen == null){
		x = str;
	} else {
		x = gen;
	}

	//商品の表示用テーブル
	String Itemtable ="<table border=1  align=center>";

	Itemtable += "<tr align=\"center\" bgcolor=\"008000\"><td><font color=\"white\">画像</font></td>"
			 + "<td><font color=\"white\">商品名</font></td>"
			 + "<td><font color=\"white\">販売会社</font></td>"
			 + "<td><font color=\"white\">価格</font></td></tr>";

	if(str != ""){	//商品名を入力したかの判断
		if(itemname.size() > 0){	//商品名と一致するかの判断
			for(Itemfam item : itemname){
				Itemtable += "<tr><td>"
						//画像表示8.22追加
					+ "<img src='" +(String)request.getContextPath() + item.img  +"' width=\"120\" height=\"120\"></td>"
					+ "<td><a href='GIcontrol?item=" + item.uriItemName +"' target='_self'>"//改良
					+ item.ItemName +"</a></td>"
					+"<td>" + item.maker + "</td>"
					+"<td>" + String.format("%,3d",item.price) + "円</td></tr>";
			}

		} else {
			Itemtable = "<div class=\"font\">一致する商品がありません。</div>";
		}

	} else {
		Itemtable = "<div class=\"font\">商品名が入力されていません。</div>";
	}
	Itemtable += "</table>";
%>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<%= request.getContextPath() %>/view/css/W0051.css"
		rel="stylesheet" type="text/css" />

	<title>FamilyMart商品データ</title>
</head>

<body>
<br>
<div class="center">

	<div class="center">
		<span class = "table2">
			<%= Itemtable %>
		</span>
	</div>

</div>
</body>
</html>