<%@ page
	import="java.util.*, java.sql.*, java.net.*,dbaccess.MyDBAccess,control.RANKInfo, java.net.URLEncoder"
	language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("windows-31j");

//管理者ログイン確認（未ログインの場合はログイン画面へ遷移）
Boolean login = (Boolean) session.getAttribute("adminFlg");
if (login == null) {
	pageContext.forward("/view/login.jsp");
}

List<RANKInfo> rankname = (List<RANKInfo>) request.getAttribute("RANKInfo");
String pre = (String) request.getAttribute("pre");
String edit = (String) request.getAttribute("edit");
String displayName = (String) request.getAttribute("displayName");
if(displayName == null) displayName = pre;

int pageNo = 1;
int limit = 10;

//pageパラメータ取得（不正値は1ページ目にする）
if (request.getParameter("page") != null) {
	try {
		pageNo = Integer.parseInt(request.getParameter("page"));
	} catch (Exception e) {
		pageNo = 1;
	}
}

int total = rankname != null ? rankname.size() : 0;
int start = (pageNo - 1) * limit;
int end = Math.min(start + limit, total);
int totalPage = (int) Math.ceil((double) total / limit);

String queryBase = "&pre=" + URLEncoder.encode(pre, "UTF-8") + "&edit=" + edit + "&regionName=" + URLEncoder.encode(displayName, "UTF-8");

String tableHTML = "<table border=1 align=center>";

//データが存在する場合のみ表を作成
if (rankname != null && rankname.size() > 0) {

	
	// 店舗ランキング表示の場合
if (edit.equals("true")) {

		tableHTML += "<tr align='center' bgcolor='008000'>"
		+ "<td width='40px'><font color='white'>順位</font></td>"
		+ "<td><font color='white'>店舗名</font></td>"
		+ "<td><font color='white'>住所</font></td>"
		+ "<td width='100'><font color='white'>売上額</font></td>"
		+ "<td width='100'><font color='white'>利益</font></td></tr>";

		for (int i = start; i < end; i++) {
	RANKInfo r = rankname.get(i);

	tableHTML += "<tr><td>" + r.shop_rank + " 位</td>"
			+ "<td>" + r.shop_name + "</td>"
			+ "<td>" + r.shop_add + "</td>"
			+ "<td>" + r.shop_sale_str + "</td>"
			+ "<td>" + r.shop_profit_str + "</td></tr>";
		}

		
		// 商品ランキング表示の場合
} else {

		tableHTML += "<tr align='center' bgcolor='008000'>"
		+ "<td width='40px'><font color='white'>順位</font></td>"
		+ "<td  width='125'><font color='white'>画像</font></td>"
		+ "<td><font color='white'>商品名</font></td>"
		+ "<td width='100'><font color='white'>売上数</font></td>"
		+ "<td width='100'><font color='white'>売上額</font></td>"
		+ "<td width='100'><font color='white'>利益</font></td></tr>";

		for (int i = start; i < end; i++) {
	RANKInfo r = rankname.get(i);

	tableHTML += "<tr><td>" + r.product_rank + " 位</td>"
			+ "<td><img src='" + request.getContextPath() + r.product_img
			+ "' width='120' height='120'></td>"
			+ "<td>" + r.product_name + "</td>"
			+ "<td>" + r.product_Sale + "</td>"
			+ "<td>" + r.product_sale_str + "</td>"
			+ "<td>" + r.product_profit_str + "</td></tr>";
		}
	}

	tableHTML += "</table>";

	

	tableHTML += "<div style='text-align:center; margin-top:15px;'>";

	if (pageNo > 1) {
		tableHTML += "<a href='FMrank?page=" + (pageNo - 1)
		+ queryBase
		+ "' style='margin:0 8px;'>&lt;&lt;</a>";
	} else {
		tableHTML += "<span style='margin:0 8px; color:#999;'>&lt;&lt;</span>";
	}


	if (totalPage <= 7) {
		for (int p = 1; p <= totalPage; p++) {

	if (p == pageNo) 
		tableHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
	  else 
		tableHTML += "<a href='FMrank?page=" + p + queryBase
				+ "' style='margin:0 6px;'>" + p + "</a>";
	
		}

	} else {

		if (pageNo <= 4) {
	for (int p = 1; p <= 5; p++) {
		if (p == pageNo)
			tableHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
		else
			tableHTML += "<a href='FMrank?page=" + p + queryBase
					+ "' style='margin:0 6px;'>" + p + "</a>";
	}
	tableHTML += "<span style='margin:0 6px;'>...</span>";
	tableHTML += "<a href='FMrank?page=" + totalPage + queryBase
			+ "' style='margin:0 6px;'>" + totalPage + "</a>";
		}

		else if (pageNo >= totalPage - 3) {
	tableHTML += "<a href='FMrank?page=1&pre=" + queryBase
			+ "' style='margin:0 6px;'>1</a>";
	tableHTML += "<span style='margin:0 6px;'>...</span>";

	for (int p = totalPage - 4; p <= totalPage; p++) {
		if (p == pageNo)
			tableHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
		else
			tableHTML += "<a href='FMrank?page=" + p + queryBase
					+ "' style='margin:0 6px;'>" + p + "</a>";
	}
		}

		else {
	tableHTML += "<a href='FMrank?page=1&pre=" + queryBase
			+ "' style='margin:0 6px;'>1</a>";
	tableHTML += "<span style='margin:0 6px;'>...</span>";

	for (int p = pageNo - 1; p <= pageNo + 1; p++) {
		if (p == pageNo)
			tableHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
		else
			tableHTML += "<a href='FMrank?page=" + p + queryBase
					+ "' style='margin:0 6px;'>" + p + "</a>";
	}

	tableHTML += "<span style='margin:0 6px;'>...</span>";
	tableHTML += "<a href='FMrank?page=" + totalPage + queryBase
			+ "' style='margin:0 6px;'>" + totalPage + "</a>";
		}
	}

	if (pageNo < totalPage) {
		tableHTML += "<a href='FMrank?page=" + (pageNo + 1)
		+ queryBase
		+ "' style='margin:0 8px;'>&gt;&gt;</a>";
	} else {
		tableHTML += "<span style='margin:0 8px; color:#999;'>&gt;&gt;</span>";
	}

	tableHTML += "</div>";

} else {
	tableHTML = "<div class='font'>売上データはありません。</div>";
}
%>

<!DOCTYPE HTML>
<html lang="ja">
<title>ランキング</title>
<head>
<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/table.css"
	rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
body {
	background: none !important;
	overflow:hidden;
}

a {
	text-decoration: none;
}

.end h1 {
	display: block;
	width: 100%;
	text-align: center;
	margin: 10px 0 25px 0;
	font-size: 26px;
	font-weight: bold;
}

.table {
	display: block;
	width: 100%;
	text-align: center;
}

.table table {
	margin: 0 auto;
}

.end {
	display: block !important;
}

.center {
	display: block !important;
	text-align: center;
}
.end > div,
.end > span {
    font-size: 15px;
}

</style>

</head>
<body>

	<div class="center">
		<div class="end">
			

			<span class="table"> <%=tableHTML%>
			</span>

		</div>
	</div>
	<script>
(function () {
	// iframe の高さをランキング内容に合わせて自動調整する処理
    function resizeIframe() {
        const iframe = parent.document.getElementById("wakuFrame");
        if (!iframe) return;

        const content = document.querySelector(".end");
        if (!content) return;

        const rect = content.getBoundingClientRect();
        const contentHeight = rect.top + rect.height;

        const screenHeight = parent.innerHeight 
            || parent.document.documentElement.clientHeight;

        const finalHeight = contentHeight < screenHeight
            ? screenHeight - 120
            : contentHeight + 20;

        iframe.style.height = Math.ceil(finalHeight) + "px";
    }

    window.addEventListener("load", () => {
        requestAnimationFrame(resizeIframe);
    });
})();
</script>



	

</body>
</html>
