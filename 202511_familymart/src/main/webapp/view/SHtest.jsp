<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/img/favicon.ico"
	rel="icon" type="img/x-icon" />
<title>商品一覧</title>
<style>
html, body {
	margin: 0;
	height: auto;
	overflow-y: auto;
}

#contentWrapper {
	margin-left: 120px;
	padding: 20px;
	box-sizing: border-box;
	overflow: visible;
}

#wakuWrapper {
	width: 100%;
	margin: 0;
	padding: 0;
	overflow: visible;
}

#wakuFrame {
	display: block;
	width: 100%;
	border: none;
	background: transparent;
}

.USmenu {
	margin-left: 160px;
}
</style>

<script>
	<%request.setCharacterEncoding("UTF-8");
	Boolean login = (Boolean) session.getAttribute("adminFlg");
	if (login == null) {
		pageContext.forward("/view/login.jsp");
	}%>
// 画面上部のナビゲーションの画面遷移処理
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


	<%String[] items = {"総合", "おにぎり", "パン", "そば", "うどん", "パスタ", "サラダ", "ホットスナック", "お菓子", "飲料", "お酒", "アイス", "冷凍食品", "日用品",
			"お弁当", "中華まん", "おでん", "ファミデリカ", "新商品"};%>

// 選択中の項目を保持する変数
	var selectedItemText;

	function senditem(text){
		// インラインフレームのページ遷移を行う。
		waku.location = "<%=request.getContextPath()%>\/SHcontrol?pre=" + encodeURI(text);
	}

	function searchWord(text){
		waku.location = "<%=request.getContextPath()%>\/SHsearch?str=" + encodeURI(text);
	}

// labelの中身によって選択か検索を判別する
	function SearchGenreSelect(label, elem){
		
		selectItem(label, elem);
		
		if(label == "genre"){
			senditem(elem.getAttribute('data-text'));
		}
		
		if(label == "search"){
			if(elem.value.trim()===""){
				alert('商品名を入力してください');
			}else{
				searchWord(elem.value);
			}
		}
	}

// 選択されている項目にselectedを付与する
// cssファイルでselectedに対して色付けを行っている
	function selectItem(label, clickedElement){
		var allItems = clickedElement.parentNode.querySelectorAll('.selectable-item');
		allItems.forEach(function(item){
			item.classList.remove('selected');
			});
		if(label == "genre"){
			clickedElement.classList.add('selected');
			selectedItemText = clickedElement.getAttribute('data-text');
		}
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
				<button class="btn2" onclick="moveHome();">メニュー</button>
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
			<div class="search-container" style="padding-bottom: 40px;">

				<div class="sidebar-search-group" style="padding: 0 5px 0;">
					<p class="sidebar-search-title">商品名検索</p>
					<div class="search-input-group">
						<input type="search" id="shName" placeholder="商品名で検索"
							class="sidebar-search-input">
						<button class="sidebar-search-button"
							onClick="SearchGenreSelect('search', document.getElementById('shName'));">
							検索</button>
					</div>
				</div>

				<div class="sidebar-item-group">
					<p class="status-title">ジャンル一覧</p>
					<div id="itemSelectionList" class="item-list-container"
						style="height: 450px;">
						<%
						int i = 0;
						for (String item : items) {
						%>
						<p id="pre<%=i%>" class="selectable-item" data-text="<%=item%>"
							onClick="SearchGenreSelect('genre', this);"><%=item%></p>
						<%
						i++;
						}
						%>
					</div>
				</div>
			</div>
		</div>
		<div class="USmenu">
			<h1>商品一覧</h1>
		</div>

		<div id="contentWrapper">

			<!--			 インラインフレームでSHview.jspを表示する。最初は白紙。属性名wakuはsenditemとsearchWordで使用 -->
			<div id="wakuWrapper">
				<iframe id="wakuFrame" name="waku" src="about:blank" frameborder="0"></iframe>
			</div>
		</div>

		<!--	自動で総合を表示するscript  -->
		<script>
			SearchGenreSelect("genre", document.getElementById("pre0"));
		</script>

		<div class="footer">
			<span>© 2025 FamilyMart System — All Rights Reserved.</span>
		</div>
	</div>
</body>
</html>