<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<title>FamilyMart都道府県データ</title>

<script type="text/javascript">
<%request.setCharacterEncoding("windows-31j");
Boolean login = (Boolean) session.getAttribute("adminFlg");
if (login == null) {
	pageContext.forward("/view/login.jsp");
}%>
//11月
function moveShopItem(){
window.location.href = "<%=request.getContextPath()%>/view/SHtest.jsp";
}

function movePrefecture(){
window.location.href = "<%=request.getContextPath()%>/view/FMtest.jsp";
}

function moveUserList(){
window.location.href = "<%=request.getContextPath()%>/USshow";
}

function moveRank(){
window.location.href = "<%=request.getContextPath()%>/view/FMrank1.jsp";
}

function logOut(){
if(confirm("ログアウトします。よろしいですか？")){
    window.location.href = "<%=request.getContextPath()%>/view/login.jsp";
}
}

function moveHome(){
window.location.href = "<%=request.getContextPath()%>/view/USgeneral.jsp";
}













	// 8月　このページで画面遷移を行わないように変更。画面遷移はインラインフレームで行う。
	// こちらはプルダウン選択を反映する。
	function send() {
		var idx = document.getElementById("pre").selectedIndex;
		var text = document.getElementById("pre").options[idx].text; // 表示テキスト

		// 8月　edit1の状態から判別
		radiobtn1 = document.getElementById("edit2");
		if(radiobtn1.checked) {
			edit = true;
		} else {
			edit = false;
		}

		// 8月　インラインフレームのページ遷移を行う。
		waku.location = "<%=request.getContextPath()%>\/FMcontrol?pre=" + encodeURI(text)
																		+ "&edit=" + encodeURI(edit);
	}

	// 8月　検索用の画面遷移をインラインフレームに渡す。上述のコードとだいたい同じ。
	function search(){
		var shp = document.getElementById("seatxt").value;

		// 8月　edit2の状態から判別
		radiobtn2 = document.getElementById("edit2");
		if(radiobtn2.checked) {
			edit = true;
		} else {
			edit = false;
		}

		waku.location = "<%=request.getContextPath()%>\/FMsearch?shp=" + encodeURI(shp)
																		+ "&edit=" + encodeURI(edit);
	}

	// ログアウト処理
<!--	var flag = false;-->
<!--	function logout() {-->
<!--		if(confirm("ログアウトします。よろしいですか？")){-->
<!--			flag = true;-->
<!--			document.MyForm.action = "<%=request.getContextPath()%>/FMlogout"-->
<!--			document.MyForm.submit();-->
<!--		} else {-->
<!--			return;-->
<!--		}-->
<!--	}-->

<!--	function moveUserList(){-->
<!--		document.MyForm.action = "<%=request.getContextPath()%>/view/USgeneral.jsp"-->
<!--		document.MyForm.submit();-->
<!--	}-->

<!--	function movePrefecture(){-->
<!--		document.MyForm.action = "<%=request.getContextPath()%>-->
<!--	/view/FMrank1.jsp"-->
<!--		document.MyForm.submit();-->
<!--	}-->

	function Items(pre, ischecked) {
		if (ischecked == true) {
			// チェックが入っていたら有効化
			document.getElementById("pre").disabled = true;
		} else {
			// チェックが入っていなかったら無効化
			document.getElementById("pre").disabled = false;
		}
		document.f1.selectName.length = 47;
		document.f1.selectName.options[0].text = "北海道";
		document.f1.selectName.options[1].text = "青森県";
		document.f1.selectName.options[2].text = "岩手県";
		document.f1.selectName.options[3].text = "宮城県";
		document.f1.selectName.options[4].text = "秋田県";
		document.f1.selectName.options[5].text = "山形県";
		document.f1.selectName.options[6].text = "福島県";
		document.f1.selectName.options[7].text = "茨城県";
		document.f1.selectName.options[8].text = "栃木県";
		document.f1.selectName.options[9].text = "群馬県";
		document.f1.selectName.options[10].text = "埼玉県";
		document.f1.selectName.options[11].text = "千葉県";
		document.f1.selectName.options[12].text = "東京都";
		document.f1.selectName.options[13].text = "神奈川県";
		document.f1.selectName.options[14].text = "新潟県";
		document.f1.selectName.options[15].text = "富山県";
		document.f1.selectName.options[16].text = "石川県";
		document.f1.selectName.options[17].text = "福井県";
		document.f1.selectName.options[18].text = "山梨県";
		document.f1.selectName.options[19].text = "長野県";
		document.f1.selectName.options[20].text = "岐阜県";
		document.f1.selectName.options[21].text = "静岡県";
		document.f1.selectName.options[22].text = "愛知県";
		document.f1.selectName.options[23].text = "三重県";
		document.f1.selectName.options[24].text = "滋賀県";
		document.f1.selectName.options[25].text = "京都府";
		document.f1.selectName.options[26].text = "大阪府";
		document.f1.selectName.options[27].text = "兵庫県";
		document.f1.selectName.options[28].text = "奈良県";
		document.f1.selectName.options[29].text = "和歌山県";
		document.f1.selectName.options[30].text = "鳥取県";
		document.f1.selectName.options[31].text = "島根県";
		document.f1.selectName.options[32].text = "岡山県";
		document.f1.selectName.options[33].text = "広島県";
		document.f1.selectName.options[34].text = "山口県";
		document.f1.selectName.options[35].text = "徳島県";
		document.f1.selectName.options[36].text = "香川県";
		document.f1.selectName.options[37].text = "愛媛県";
		document.f1.selectName.options[38].text = "高知県";
		document.f1.selectName.options[39].text = "福岡県";
		document.f1.selectName.options[40].text = "佐賀県";
		document.f1.selectName.options[41].text = "長崎県";
		document.f1.selectName.options[42].text = "熊本県";
		document.f1.selectName.options[43].text = "大分県";
		document.f1.selectName.options[44].text = "宮崎県";
		document.f1.selectName.options[45].text = "鹿児島県";
		document.f1.selectName.options[46].text = "沖縄県";
	}

	function Connecttext(seatxt, ischecked) {
		if (ischecked == true) {
			// チェックが入っていたら有効化
			document.getElementById("seatxt").disabled = true;
		} else {
			// チェックが入っていなかったら無効化

			document.getElementById("seatxt").disabled = false;
		}
	}

	function SearchGenreSelect() {
		radiobtn1 = document.getElementById("label1");
		radiobtn2 = document.getElementById("label2")
		if (radiobtn1.checked) {
			send();
		}
		if (radiobtn2.checked) {
			search();
		}
	}
</script>
</head>

<body>
	<div>
		<div>
			<%
			Boolean adminFlg = (Boolean) session.getAttribute("adminFlg");
			%>

			<div class="navbar">
				<img src="<%=request.getContextPath()%>/view/img/familymart.png"
					style="height: 50px; margin: 5px; float: left;">

				<div class="btn">
					<button class="btn2" onclick="moveHome();">ホーム</button>
				</div>

				<div class="btn">
					<button class="btn2" onClick="moveShopItem();">商品</button>
				</div>

				<div class="btn">
					<button class="btn2" onClick="movePrefecture();">店舗</button>
				</div>

				<div class="btn">
					<button class="btn2" onClick="moveRank();">ランキング</button>
				</div>

				<%
				if (Boolean.TRUE.equals(adminFlg)) {
				%>
				<div class="btn">
					<button class="btn2" onclick="moveUserList();">ユーザ管理</button>
				</div>
				<%
				}
				%>

				<div class="button-panel">
					<%
					out.print("ユーザ名 : " + session.getAttribute("userName"));
					%>
					<a style="margin-left: 20px" class="button" name="logout"
						onClick="logOut();"> <img
						src="<%=request.getContextPath()%>/view/img/153.142.124.217 (2).gif">
					</a>
				</div>
			</div>
			<div class="sidenav">
				<p></p>
				<a href="#"></a> <a href="#"></a> <a href="#"></a>
			</div>
			<%--
			<form name="Logout" method="POST" action="#" onsubmit="return flag;">
				<div class="button-panel">
					<%
					out.print("ユーザ名 : " + session.getAttribute("userName"));
					<a style="margin-left: 20px" class="button" onClick="logout();">
						<img
						src="<%=request.getContextPath()%>/view/img/153.142.124.217 (2).gif">
					</a>
				</div>
			</form>

			<form name="MyForm" method="POST" action="#" onsubmit="return flag;">
				<div class="button1">
					<input type="submit" class="button" value="ユーザ画面へ"
						onclick="moveUserList();">
				</div>

				<div class="button2">
					<input type="submit" class="button" value="商品ランキングへ"
						onclick="movePrefecture();">
				</div>
			</form>
--%>
			<div class="end">
				<h1>都道府県別 店舗一覧データ</h1>
			</div>

			<br> <br>
			<div class="select">
				<input id="edit1" name="edit" type="radio" checked /> <label
					for="edit1">出店予定店舗の表示</label><br /> <input id="edit2" name="edit"
					type="radio" /> <label for="edit2">出店済み店舗の表示</label><br /> <br>
				<form name="f1" action="#" onsubmit="return false">
					<input id="label1" type="radio" name="radio1"
						onclick="Items(pre,this.cheaked);seatxt.disabled=true;seatxt.value=null;seatxt.placeholder='入力できません'">
					<label for="label1">都道府県検索</label> <input id="label2" type="radio"
						name="radio1"
						onclick="Connecttext(seatxt,this.cheaked);pre.disabled=true;seatxt.placeholder='店舗名で検索'">
					<label for="label2">店舗名検索</label><br> <select
						name="selectName" id="pre" disabled></select> <input type="search"
						id="seatxt" name="searchText" placeholder="入力できません" disabled>
				</form>

				<br> <input type="submit" class="button" id="" value="検索結果の表示"
					onClick="SearchGenreSelect()"> <br>
			</div>

			<br>
			<!-- 8月　インラインフレームでFMview.jspを表示する。最初は白紙。属性名wakuはsendとsearchで使用 -->
			<iframe src="about:blank" name="waku" width="90%" height="500"></iframe>

		</div>

		<div class="footer">
			<span>© 2025 FamilyMart System — All Rights Reserved.</span>
		</div>
</body>
</html>