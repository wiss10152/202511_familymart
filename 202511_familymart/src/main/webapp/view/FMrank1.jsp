<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>

<!DOCTYPE HTML>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%= request.getContextPath() %>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<title>FamilyMart 都道府県別商品ランキング</title>
<script type="text/javascript">

<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");									//7月新規　直接アクセス禁止
	if(login == null){
		pageContext.forward("/view/login.jsp");
	}
%>

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










	// 8月　ページ遷移しないように変更。変更箇所は後述のコメントアウト。
	function send() {
		var idx = document.getElementById("pre").selectedIndex;
		var text = document.getElementById("pre").options[idx].text;

		radiobtn2 = document.getElementById("label2");
		if(radiobtn2.checked){
			edit = true;
		} else {
			edit = false;
		}

		// 8月　インラインフレームのページ遷移を行う
		waku.location = "<%= request.getContextPath() %>\/FMrank?pre=" + encodeURI(text) + "&edit=" + encodeURI(edit);
	}

<!--	var flag = false;-->
<!--	function logout() {-->
<!--		if(confirm("ログアウトします。よろしいですか？")){-->
<!--			flag = true;-->
<!--			document.Logout.action = "<%= request.getContextPath()%>/FMlogout"-->
<!--			document.Logout.submit();-->
<!--		} else {-->
<!--			return;-->
<!--		}-->
<!--	}-->

<!--	function movePrefecture(){-->
<!--		document.MyForm.action = "<%= request.getContextPath()%>/view/FMtest.jsp"-->
<!--		document.MyForm.submit();-->
<!--	}-->

<!--	function moveUserList(){-->
<!--		document.MyForm.action = "<%= request.getContextPath() %>/view/USgeneral.jsp"-->
<!--		document.MyForm.submit();-->
<!--	}-->

	// 8月　プルダウンメニューの項目をラジオボタンで切り替えるため、JavaScript側で導入する。
	//		頭の悪そうなプログラムなので、DBで管理するのも一考？
	// 8月　商品ジャンルデータを追加
	function Items(){
		document.f1.selectName.length=19;
		document.f1.selectName.options[0].text	="おにぎり";
		document.f1.selectName.options[1].text	="パン";
		document.f1.selectName.options[2].text	="そば";
		document.f1.selectName.options[3].text	="うどん";
		document.f1.selectName.options[4].text	="パスタ";
		document.f1.selectName.options[5].text	="サラダ";
		document.f1.selectName.options[6].text	="ホットスナック";
		document.f1.selectName.options[7].text	="お菓子";
		document.f1.selectName.options[8].text	="飲料";
		document.f1.selectName.options[9].text	="お酒";
		document.f1.selectName.options[10].text ="アイス";
		document.f1.selectName.options[11].text ="冷凍食品";
		document.f1.selectName.options[12].text ="日用品";
		document.f1.selectName.options[13].text ="お弁当";
		document.f1.selectName.options[14].text ="中華まん";
		document.f1.selectName.options[15].text ="おでん";
		document.f1.selectName.options[16].text ="ファミデリカ";
		document.f1.selectName.options[17].text ="新商品";
		document.f1.selectName.options[18].text ="総合";
	}

	// 8月　都道府県データを追加
	function City(){
		document.f1.selectName.length=48;
		document.f1.selectName.options[0].text ="北海道";
		document.f1.selectName.options[1].text ="青森県";
		document.f1.selectName.options[2].text ="岩手県";
		document.f1.selectName.options[3].text ="宮城県";
		document.f1.selectName.options[4].text ="秋田県";
		document.f1.selectName.options[5].text ="山形県";
		document.f1.selectName.options[6].text ="福島県";
		document.f1.selectName.options[7].text ="茨城県";
		document.f1.selectName.options[8].text ="栃木県";
		document.f1.selectName.options[9].text ="群馬県";
		document.f1.selectName.options[10].text="埼玉県";
		document.f1.selectName.options[11].text="千葉県";
		document.f1.selectName.options[12].text="東京都";
		document.f1.selectName.options[13].text="神奈川県";
		document.f1.selectName.options[14].text="新潟県";
		document.f1.selectName.options[15].text="富山県";
		document.f1.selectName.options[16].text="石川県";
		document.f1.selectName.options[17].text="福井県";
		document.f1.selectName.options[18].text="山梨県";
		document.f1.selectName.options[19].text="長野県";
		document.f1.selectName.options[20].text="岐阜県";
		document.f1.selectName.options[21].text="静岡県";
		document.f1.selectName.options[22].text="愛知県";
		document.f1.selectName.options[23].text="三重県";
		document.f1.selectName.options[24].text="滋賀県";
		document.f1.selectName.options[25].text="京都府";
		document.f1.selectName.options[26].text="大阪府";
		document.f1.selectName.options[27].text="兵庫県";
		document.f1.selectName.options[28].text="奈良県";
		document.f1.selectName.options[29].text="和歌山県";
		document.f1.selectName.options[30].text="鳥取県";
		document.f1.selectName.options[31].text="島根県";
		document.f1.selectName.options[32].text="岡山県";
		document.f1.selectName.options[33].text="広島県";
		document.f1.selectName.options[34].text="山口県";
		document.f1.selectName.options[35].text="徳島県";
		document.f1.selectName.options[36].text="香川県";
		document.f1.selectName.options[37].text="愛媛県";
		document.f1.selectName.options[38].text="高知県";
		document.f1.selectName.options[39].text="福岡県";
		document.f1.selectName.options[40].text="佐賀県";
		document.f1.selectName.options[41].text="長崎県";
		document.f1.selectName.options[42].text="熊本県";
		document.f1.selectName.options[43].text="大分県";
		document.f1.selectName.options[44].text="宮崎県";
		document.f1.selectName.options[45].text="鹿児島県";
		document.f1.selectName.options[46].text="沖縄県";
		document.f1.selectName.options[47].text="総合";
	}

</script>
</head>

<body>
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
		
		
		
		<%--<form name="Logout" method="POST" action="#" onsubmit="return flag;">
		<div  class="button-panel">
			<% out.print("ユーザ名 : " + session.getAttribute("userName")); %>
			<a style="margin-left: 20px" class="button" onClick="logout();">
			<img src="<%= request.getContextPath() %>/view/img/153.142.124.217 (2).gif"></a>
		</div>
	</form>

	<form name="MyForm" method="POST" action="#" onsubmit="return flag;">
		<div class="button1">
			<input type="submit" class="button" value="ユーザ画面へ"onclick="moveUserList();">
		</div>

		<div class="button2">
			<input type="submit" class="button" value="都道府県データへ"onclick="movePrefecture();">
		</div>
	</form>
--%>
		<div class="end">
			<h1>ランキングページ</h1>
		</div>
		<br>

		<div class="select">
			<!-- フォント変更の応急処置 -->
			<div class="subh">--表示したいジャンルを選択してください--</div>
			<br>

			<!-- 8月　ラジオボタンで選択したジャンルを、プルダウンメニューに表示する。
			 HTML側に書かれていた項目はすべてJavaScript側に引っ越している。 -->
			<form name="f1">
				<input id="label1" type="radio" name="radio1" onclick="Items()">
				<label for="label1">商品ランキング</label> <input id="label2" type="radio"
					name="radio1" onclick="City()"> <label for="label2">都道府県ランキング</label><br>

				<!-- 8月　ここにJavaScript側で入れた項目を入れる。 -->
				項目選択：<select name="selectName" id="pre"></select>
			</form>

			<br>
			<!-- 送信ボタン。プルダウンで選択された項目を送る。 -->
			<input type="submit" class="button" value="売上順位表示" id="pre"
				onclick="send();"> <br>
			<br>
		</div>

		<!-- 8月　インラインフレームでFMrank2.jspを表示する。最初は白紙。属性名wakuはsend関数で使用 -->
		<iframe src="about:blank" name="waku" width="90%" height="500"></iframe>

	</div>
	<div class="footer">
		<span>© 2025 FamilyMart System — All Rights Reserved.</span>
	</div>
</body>
</html>