<%@
	page
	import="java.util.*, java.sql.*, java.net.*,model.MyDBAccess,control.RANKInfo"
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");										//7月新規　直接アクセス禁止
	if (login == null){
		pageContext.forward("/view/login.jsp");
	}

	List<RANKInfo>rankname = (List<RANKInfo>)request.getAttribute ("RANKInfo");

	String pre = (String)request.getAttribute("pre");
	String edit = (String)request.getAttribute("edit");
	int i = 0;

	String tableHTML = "<table border=1 align=center>";

	// データがなければ、売上データがありませんと出力する
	if(rankname.size()>0){
		if(edit.equals("true")) { // 都道府県データ表示
			tableHTML +=  "<tr align=\"center\" bgcolor=\"008000\">"
						+ "<td><font color=\"white\">順位</font></td>"
						+ "<td><font color=\"white\">店舗名</font></td>"
						+ "<td><font color=\"white\">住所</font></td>"
						+ "<td><font color=\"white\">売上</font></td></tr>";

			for(RANKInfo rank : rankname){ // リストのデータを順に表示する
				tableHTML += "<tr><td width=\"100\">" + rank.shop_rank + " 位</td>"
						  +  "<td>" + rank.shop_name + "</td>"
						  +  "<td>" + rank.shop_add  + "</td>"
						  +  "<td>" + rank.shop_sale + "</td></tr>";
			}
			tableHTML += "</table>";

		} else if(edit.equals("false")) { // 商品データ表示
			tableHTML +=  "<tr align=\"center\" bgcolor=\"008000\">"
						+ "<td><font color=\"white\">順位</font></td>"
						+ "<td><font color=\"white\">画像</font></td>"
						+ "<td><font color=\"white\">商品名</font></td>"
						+ "<td><font color=\"white\">売上数</font></td>"
						+ "<td><font color=\"white\">売上額</font></td></tr>";

			for(RANKInfo rank : rankname){ // リストのデータを順に表示する
				tableHTML += "<tr><td width=\"100\">" + rank.product_rank + " 位</td>"
						  +  "<td><img src='" + (String)request.getContextPath() + rank.product_img
						  										+"' width=\"120\" height=\"120\"></td>"
						  +  "<td>" + rank.product_name + "</td>"
						  +  "<td>" + rank.product_Sale + "</td>"
						  +  "<td>" + rank.product_AmountSales + "</td></tr>";
			}
		}

	} else { // 該当データが存在しない場合に表示
		tableHTML = "<div class=\"font\">売上データはありません。</div>";
	}
%>

<!DOCTYPE HTML>
<html lang="ja">
<title>FamilyMartランキング</title>
<head>
	<link href="<%= request.getContextPath() %>/view/css/W0051.css"
			rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
<div class="center">

	<div class="end">
		<h1><%= pre %>　売上ランキング</h1>

		<span class = "table">
			<%= tableHTML %>
		</span>
	</div>

</div>
</body>
</html>