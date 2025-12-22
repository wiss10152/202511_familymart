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
	<link href="<%=request.getContextPath()%>/view/img/favicon.ico"
	rel="icon" type="img/x-icon" />
<style>
html, body {
	margin: 0;
	padding: 0;
	height: auto;
	overflow: visible;
}
</style>
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

function moveMyStore(){
	window.location.href = "<%=request.getContextPath()%>/MyStoreServlet"
}








	// 8月　ページ遷移しないように変更。変更箇所は後述のコメントアウト。
	function send() {
		var text = selectedItemText;
		var radiobtn2 = document.getElementById("label2");
		var editValue = radiobtn2.checked ? "true" : "false";

		waku.location = "<%= request.getContextPath() %>/FMrank?pre=" + encodeURIComponent(text) + "&edit=" + editValue;
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
		var listContainer = document.getElementById("itemSelectionList");
		listContainer.style.height = "450px";
		listContainer.innerHTML = '';

		var items = [
		"総合","おにぎり","パン","そば","うどん","パスタ","サラダ","ホットスナック",
		"お菓子","飲料","お酒","アイス","冷凍食品","日用品","お弁当","中華まん","おでん",
		"ファミデリカ","新商品"
		];

		items.forEach(function(text, index){
			var item = document.createElement('p');
			item.className = 'selectable-item';
			item.textContent = text;
			item.setAttribute('data-text', text);

			item.onclick = function(){
				selectItem(this);
			};

			listContainer.appendChild(item);
		});

		if(listContainer.children.length > 0){
			selectItem(listContainer.children[0]);
		}
		document.getElementById("regionButtonArea").style.display = "none";
	}
	
	// 8月　都道府県データを追加
	function City(){
		var listContainer = document.getElementById("itemSelectionList");
        listContainer.style.height = "300px";
        listContainer.innerHTML = ''; 

		var items = [
            "総合", "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", 
            "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", 
            "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", 
            "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", 
            "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", 
            "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", 
            "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
        ];
        
        items.forEach(function(text, index) {
            var item = document.createElement('p');
            item.className = 'selectable-item';
            item.textContent = text;
            item.setAttribute('data-text', text);
            
            item.onclick = function() {
                selectItem(this);
            };
            
            listContainer.appendChild(item);
        });

        if (listContainer.children.length > 0) {
            selectItem(listContainer.children[0]);
        }
        document.getElementById("regionButtonArea").style.display = "block";
	}

	var selectedItemText = "総合";

	function selectItem(clickedElement){
	var allItems = clickedElement.parentNode.querySelectorAll('.selectable-item');
	allItems.forEach(function(item){
		item.classList.remove('selected');
		});

	clickedElement.classList.add('selected');

	selectedItemText = clickedElement.getAttribute('data-text');

	send();
	}

	const regions = {
		 "hokkaido-tohoku": ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県"],
		 "kanto": ["茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県"],
		"chubu": ["新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県"],
		 "kinki": ["三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県"],
		"chugoku-shikoku": ["鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県"],
		"kyushu-okinawa": ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]
	};

	function filterRegion(regionKey){
		var prefsArray = regions[regionKey];
		if(!prefsArray) return;

		const regionNameJP = {
				"hokkaido-tohoku": "北海道・東北",
				"kanto": "関東",
				"chubu": "中部",
				"kinki": "近畿",
				"chugoku-shikoku": "中国・四国",
				"kyushu-okinawa": "九州・沖縄"
		};

		var prefString = prefsArray.join(",");
		var radiobtn2 = document.getElementById("label2");
		var editValue = radiobtn2.checked ? "true" : "false";
		var jpName = regionNameJP[regionKey];
		waku.location = "<%=request.getContextPath()%>/FMrank?pre=" + encodeURIComponent(prefString) 
						+ "&edit=" + editValue + "&regionName=" + encodeURIComponent(jpName);

		var allItems = document.querySelectorAll('.selectable-item');
		allItems.forEach(function(item){item.classList.remove('selected');});

		var prefString = prefsArray.join(",");
		var edit = document.getElementById("label2").checked;
	}

</script>
</head>

<body onload="Items()">
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
			<div class="btn">
                    <button class="btn2" onclick="moveMyStore();">MY店舗</button>
                </div>
			<%
			}
			%>

			<div class="button-panel">
				<%="ユーザ名 : " + session.getAttribute("userName")%>
				<a style="margin-left: 20px" class="button" name="logout"
					onClick="logOut();"> <img
					src="<%=request.getContextPath()%>/view/img/153.142.124.217 (2).gif">
				</a>
			</div>
		</div>
		<div class="sidenav">
			<div class="search-container" style="padding-bottom: 40px;">

				<div class="sidebar-radio-group">
					<p class="status-title">ジャンル選択</p>
					<div style="display: flex; gap: 10px;">
						<label for="label1" class="radio-label"> <input
							id="label1" type="radio" name=radio1 onclick="Items()" checked>
							商品
						</label> <label for="label2" class="radio-label"> <input
							id="label2" type="radio" name="radio1" onclick="City()">
							店舗
						</label>
					</div>
				</div>

				<div class="sidebar-item-group">
					<p class="status-title">項目選択</p>
					<div id="itemSelectionList" class="item-list-container"></div>

					<div id="regionButtonArea" class="region-button-area">
						<p class="status-title">地方別</p>
						<div class="region-grid">
							<button type="button" class="region-btn"
								onclick="filterRegion('hokkaido-tohoku')">北海道・東北</button>
							<button type="button" class="region-btn"
								onclick="filterRegion('kanto')">関東</button>
							<button type="button" class="region-btn"
								onclick="filterRegion('chubu')">中部</button>
							<button type="button" class="region-btn"
								onclick="filterRegion('kinki')">近畿</button>
							<button type="button" class="region-btn"
								onclick="filterRegion('chugoku-shikoku')">中国・四国</button>
							<button type="button" class="region-btn"
								onclick="filterRegion('kyushu-okinawa')">九州・沖縄</button>
						</div>

						<%-- <input type="submit" class="rank-button" value="売上順位表示"
				onclick="send();" style="display: none;"> --%>

					</div>
				</div>
			</div>
		</div>

		<div class="main-content-area">
			<iframe id="wakuFrame" name="waku" src="about:blank"
				class="ranking-iframe" frameborder="0"></iframe>

		</div>

		<div class="footer">
			<span>© 2025 FamilyMart System — All Rights Reserved.</span>
		</div>
</body>
</html>