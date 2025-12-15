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
	<%--function send() {
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
	} --%>

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

	<%-- function Items(pre, ischecked) {
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
	} --%>

	function toggleRegion(regionId){
		var content = document.getElementById(regionId);
		var icon = document.querySelector('[data-region-id="' + regionId + '"] .toggle-icon');
		if(content.style.maxHeight){
			content.style.maxHeight = null;
			if(icon) icon.textContent = '▲';
		}else{
			content.style.maxHeight = content.scrollHeight + "px";
			if(icon) icon.textContent = '▼';
		}
		checkAllRegionStatus();
	}

	function toggleAllRegions(button){
		var allSections = document.querySelectorAll('.region-content');
		var isOpening = button.getAttribute('data-action') === 'open';
		allSections.forEach(function(content){
			var icon = document.querySelector('[data-region-id="' + content.id + '"] .toggle-icon');
			if(isOpening){
				content.style.maxHeight = content.scrollHeight + "px";
				if(icon) icon.textContent = '▼';
			}else{
				content.style.maxHeight = null;
				if(icon) icon.textContent = '▲';
			}
		});
		checkAllRegionStatus();
	}

	function checkAllRegionStatus(){
		var allSections = document.querySelectorAll('.region-content');
		var openCount = 0;
		allSections.forEach(function(content){
			if(content.style.maxHeight && content.style.maxHeight !== '0px'){
				openCount++;
			}
		});
		var openAllButton = document.getElementById('openAllRegions');
		var closeAllButton = document.getElementById('closeAllRegions');
		if(openAllButton && closeAllButton){
			if(openCount > 0){
				openAllButton.style.display = 'none';
				closeAllButton.style.display = 'block';
				closeAllButton.textContent = 'すべて閉じる';
			}else{
				openAllButton.style.display = 'block';
				openAllButton.textContent = 'すべて開く';
				closeAllButton.style.display = 'none';
			}
		}
	}
	
	function toggleAllPrefectures(allCheckbox){
		var allPrefectures = document.querySelectorAll('input[name="prefecture_status"]');
		for(var i=0; i<allPrefectures.length; i++){
			allPrefectures[i].checked = allCheckbox.checked;
				}
		}
	function toggleSectionPrefectures(allCheckbox, regionId){
		var contentDiv = document.getElementById(regionId);
		if(!contentDiv)return;
		var prefectureCheckboxes = contentDiv.querySelectorAll('input[name="prefecture_status"]');
		for(var i=0; i<prefectureCheckboxes.length; i++){
			prefectureCheckboxes[i].checked = allCheckbox.checked;
		}
	}
	
	function searchBySidenav(searchType){
		var shp = document.getElementById("seatxt_sidenav").value;
		var status = document.querySelector('input[name="edit_status"]:checked').value;
		
		var selectedPrefs = [];
		var prefectureCheckboxes = document.querySelectorAll('input[name="prefecture_status"]:checked');
		for(var i=0; i<prefectureCheckboxes.length; i++){
			selectedPrefs.push(prefectureCheckboxes[i].value);
		}
		if(searchType === 'shopName'){
			if(shp.trim() === "" && selectedPrefs.length === 0){
				return;
				}
		}
		if(searchType === 'prefectureOnly'){
			if(selectedPrefs.length === 0){
				return;
			}
			shp = "";
		}
		var url = "<%=request.getContextPath()%>\/FMsearch";
		var params = [];
		if(shp.trim() !== ""){
			params.push("shp=" + encodeURI(shp));
		}
		params.push("edit=" + encodeURI(status));
		if(selectedPrefs.length > 0){
			params.push("prefectures=" + encodeURI(selectedPrefs.join(",")));
		}
		if(params.length > 0){
			url += "?" + params.join("&")
		}
		
		waku.location = url;
	}

	document.addEventListener('DOMContentLoaded', checkAllRegionStatus);
</script>
</head>

<body>
	<div></div>
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
			
				<div class="search-container">
				
				<div class="sidebar-radio-group"><p class="status-title">出店状況</p>
						
							<label class="status-label">
								<input type="radio" name="edit_status" value="all" id="edit_all" 
								checked>すべて</label>
							<label class="status-label">
								<input type="radio" name="edit_status" value="true" id="edit_true" 
								>出店済み</label>
							<label class="status-label">
								<input type="radio" name="edit_status" value="false" id="edit_false" 
								>出店予定</label>
				</div>
				
				<div class="sidebar-search-group"><p class="sidebar-search-title">店舗名検索</p>
					
					<div class="search-input-group">
						<input type="search" id="seatxt_sidenav" name="searchText_sidenav" 
							placeholder="入力" class="sidebar-search-input">
						<button type="button" onclick="searchBySidenav('shopName');" 
							class="sidebar-search-button">検索</button>
					</div>
				</div>
					
					<div class="sidebar-region-group">
						<p class="status-title">都道府県検索</p>
						
						<div class="toggle-all-buttons">
							<button type="button" id="openAllRegions" data-action="open" onclick="toggleAllRegions(this)">すべて開く</button>
							<button type="button" id="closeAllRegions" data-action="close" onclick="toggleAllRegions(this)" style="display: none;">すべて閉じる</button>
						</div>
						
						<div class="region-list-scroll-area" id="region-list-area">
							<div class="region-item all-region">
								<label class="status-label region-label">
									<input type="checkbox" name="region_status-all" value="all" onchange="toggleAllPrefectures(this)">すべて
								</label>
							</div>
							
							<div class="region-item">
								<div class="region-header" onclick="toggleRegion('region-hokkaido-tohoku')" data-region-id="region-hokkaido-tohoku">
									<span class="toggle-icon">▲</span>北海道・東北
							</div>
							<div class="region-content" id="region-hokkaido-tohoku">
								<label class="status-label all-in-section">
									<input type="checkbox" name="all_in_section_hokkaido_tohoku"
										onchange="toggleSectionPrefectures(this, 'region-hokkaido-tohoku')">
									すべて選択
								</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="北海道">北海道</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="青森県">青森県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="岩手県">岩手県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="宮城県">宮城県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="秋田県">秋田県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="山形県">山形県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="福島県">福島県</label>
							</div>
							
							<div class="region-item">
								<div class="region-header" onclick="toggleRegion('region-kanto')" data-region-id="region-kanto">
									<span class="toggle-icon">▲</span>関東
							</div>
							<div class="region-content" id="region-kanto">
								<label class="status-label all-in-section">
									<input type="checkbox" name="all_in_section_kanto"
										onchange="toggleSectionPrefectures(this, 'region-kanto')">
									すべて選択
								</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="茨城県">茨城県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="栃木県">栃木県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="群馬県">群馬県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="埼玉県">埼玉県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="千葉県">千葉県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="東京都">東京都</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="神奈川県">神奈川県</label>
							</div>
							
							<div class="region-item">
								<div class="region-header" onclick="toggleRegion('region-chubu')" data-region-id="region-chubu">
									<span class="toggle-icon">▲</span>中部
							</div>
							<div class="region-content" id="region-chubu">
								<label class="status-label all-in-section">
									<input type="checkbox" name="all_in_section_chubu"
										onchange="toggleSectionPrefectures(this, 'region-chubu')">
									すべて選択
								</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="新潟県">新潟県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="富山県">富山県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="石川県">石川県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="福井県">福井県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="山梨県">山梨県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="長野県">長野県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="岐阜県">岐阜県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="静岡県">静岡県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="愛知県">愛知県</label>
							</div>
							
							<div class="region-item">
								<div class="region-header" onclick="toggleRegion('region-kinki')" data-region-id="region-kinki">
									<span class="toggle-icon">▲</span>近畿
							</div>
							<div class="region-content" id="region-kinki">
								<label class="status-label all-in-section">
									<input type="checkbox" name="all_in_section_kinki"
										onchange="toggleSectionPrefectures(this, 'region-kinki')">
									すべて選択
								</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="三重県"> 三重県</label>
									<label class="status-label"><input type="checkbox" name="prefecture_status" value="滋賀県"> 滋賀県</label>
									<label class="status-label"><input type="checkbox" name="prefecture_status" value="京都府"> 京都府</label>
									<label class="status-label"><input type="checkbox" name="prefecture_status" value="大阪府"> 大阪府</label>
									<label class="status-label"><input type="checkbox" name="prefecture_status" value="兵庫県"> 兵庫県</label>
									<label class="status-label"><input type="checkbox" name="prefecture_status" value="奈良県"> 奈良県</label>
									<label class="status-label"><input type="checkbox" name="prefecture_status" value="和歌山県"> 和歌山県</label>
							</div>
							<div class="region-item">
								<div class="region-header" onclick="toggleRegion('region-chugoku-shikoku')" data-region-id="region-chugoku-shikoku">
									<span class="toggle-icon">▲</span>中国・四国
							</div>
							<div class="region-content" id="region-chugoku-shikoku">
								<label class="status-label all-in-section">
									<input type="checkbox" name="all_in_section_chugoku-shikoku"
										onchange="toggleSectionPrefectures(this, 'region-chugoku-shikoku')">
									すべて選択
								</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="鳥取県">鳥取県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="島根県">島根県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="岡山県">岡山県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="広島県">広島県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="山口県">山口県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="徳島県">徳島県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="香川県">香川県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="愛媛県">愛媛県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="高知県">高知県</label>
							</div>
							
							<div class="region-item">
								<div class="region-header" onclick="toggleRegion('region-kyushu-okinawa')" data-region-id="region-kyushu-okinawa">
									<span class="toggle-icon">▲</span>九州・沖縄
							</div>
							<div class="region-content" id="region-kyushu-okinawa">
								<label class="status-label all-in-section">
									<input type="checkbox" name="all_in_section_kyushu-okinawa"
										onchange="toggleSectionPrefectures(this, 'region-kyushu-okinawa')">
									すべて選択
								</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="福岡県">福岡県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="佐賀県">佐賀県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="長崎県">長崎県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="熊本県">熊本県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="大分県">大分県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="宮崎県">宮崎県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="鹿児島県">鹿児島県</label>
								<label class="status-label"><input type="checkbox" name="prefecture_status" value="沖縄県">沖縄県</label>
							</div>
							
						<button type="button" onclick="searchBySidenav('prefectureOnly');" class="global-prefecture-search-button">検索</button>
			</div></div></div>
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
			<%-- <div class="end">
				<h1>都道府県別 店舗一覧データ</h1>
			</div> --%>

			<br> <br>
			<%-- <div class="select">
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

			<br> --%>
			<!-- 8月　インラインフレームでFMview.jspを表示する。最初は白紙。属性名wakuはsendとsearchで使用 -->
			<iframe src="about:blank" name="waku" width="90%" height="500"></iframe>

		</div>

		<div class="footer">
			<span>© 2025 FamilyMart System — All Rights Reserved.</span>
		</div>
</body>
</html>