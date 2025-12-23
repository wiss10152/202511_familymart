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
<link href="<%=request.getContextPath()%>/view/img/favicon.ico"
	rel="icon" type="img/x-icon" />
<style>

.USmenu{
margin-left:160px;
}
</style>
<title>FamilyMart都道府県データ</title>

<script type="text/javascript">
<%
request.setCharacterEncoding("windows-31j");
Boolean login = (Boolean) session.getAttribute("adminFlg");
if (login == null) {
	pageContext.forward("/view/login.jsp");
}
%>

function moveShopItem(){ window.location.href = "<%=request.getContextPath()%>/view/SHtest.jsp"; }
function movePrefecture(){ window.location.href = "<%=request.getContextPath()%>/view/FMtest.jsp"; }
function moveUserList(){ window.location.href = "<%=request.getContextPath()%>/USshow"; }
function moveRank(){ window.location.href = "<%=request.getContextPath()%>/view/FMrank1.jsp"; }
function moveHome(){ window.location.href = "<%=request.getContextPath()%>/view/USgeneral.jsp"; }
function logOut(){
	if(confirm("ログアウトします。よろしいですか？")){
		window.location.href = "<%=request.getContextPath()%>/view/login.jsp";
	}
}
function moveMyStore(){
	window.location.href = "<%=request.getContextPath()%>/MyStoreServlet"
}

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
		}else{
			openAllButton.style.display = 'block';
			closeAllButton.style.display = 'none';
		}
	}
}

function toggleAllPrefectures(allCheckbox){
	var allPrefectures = document.querySelectorAll('input[name="prefecture_status"]');
	for(var i=0;i<allPrefectures.length;i++){
		allPrefectures[i].checked = allCheckbox.checked;
	}
}

function toggleSectionPrefectures(allCheckbox, regionId){
	var contentDiv = document.getElementById(regionId);
	if(!contentDiv)return;
	var prefectureCheckboxes = contentDiv.querySelectorAll('input[name="prefecture_status"]');
	for(var i=0;i<prefectureCheckboxes.length;i++){
		prefectureCheckboxes[i].checked = allCheckbox.checked;
	}
}

function searchBySidenav(searchType){
	var shp = document.getElementById("seatxt_sidenav").value;
	var status = document.querySelector('input[name="edit_status"]:checked').value;

	var selectedPrefs = [];
	var prefectureCheckboxes = document.querySelectorAll('input[name="prefecture_status"]:checked');
	for(var i=0;i<prefectureCheckboxes.length;i++){
		selectedPrefs.push(prefectureCheckboxes[i].value);
	}

	if(searchType === 'shopName'){
		if(shp.trim()==="" && selectedPrefs.length===0 && status==="all") return;
	}
	if(searchType === 'prefectureOnly'){
		if(selectedPrefs.length===0) return;
		shp="";
	}

	var url = "<%=request.getContextPath()%>/FMsearch";
	var params = [];
	if (shp.trim() !== ""){
		params.push("shp=" + encodeURI(shp));
	}
	params.push("edit=" + encodeURI(status));
	
	if (selectedPrefs.length > 0){
		params.push("prefectures=" + encodeURI(selectedPrefs.join(",")));
	}
	if (params.length > 0){
		url += "?" + params.join("&");
	}

	waku.location = url;

}

	document.addEventListener('DOMContentLoaded', function() {
		checkAllRegionStatus();
		var allChk = document.querySelector('input[name="region_status-all"]');
		if (allChk)
			allChk.checked = true;
	});
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
				<button class="btn2" onclick="moveShopItem();">商品</button>
			</div>
			<div class="btn">
				<button class="btn2" onclick="movePrefecture();">店舗</button>
			</div>
			<div class="btn">
				<button class="btn2" onclick="moveRank();">ランキング</button>
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
				<a style="margin-left: 20px" class="button" onclick="logOut();">
					<img
					src="<%=request.getContextPath()%>/view/img/153.142.124.217 (2).gif">
				</a>
			</div>
		</div>

		<div class="sidenav">
			<div class="search-container" style="padding-bottom: 40px;">

				<div class="sidebar-radio-group">
					<p class="status-title">出店状況</p>

					<label class="status-label"> <input type="radio"
						name="edit_status" value="all" id="edit_all" checked>すべて
					</label> <label class="status-label"> <input type="radio"
						name="edit_status" value="true" id="edit_true">出店済み
					</label> <label class="status-label"> <input type="radio"
						name="edit_status" value="false" id="edit_false">出店予定
					</label>
				</div>

				<div class="sidebar-search-group">
					<p class="sidebar-search-title">店舗名検索</p>

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
						<button type="button" id="openAllRegions" data-action="open"
							onclick="toggleAllRegions(this)">すべて開く</button>
						<button type="button" id="closeAllRegions" data-action="close"
							onclick="toggleAllRegions(this)" style="display: none;">すべて閉じる</button>
					</div>

					<div class="region-list-scroll-area" id="region-list-area">
						<div class="region-item all-region">
							<label class="status-label region-label"> <input
								type="checkbox" name="region_status-all" value="all"
								onchange="toggleAllPrefectures(this)">すべて
							</label>
						</div>

						<div class="region-item">
							<div class="region-header"
								onclick="toggleRegion('region-hokkaido-tohoku')"
								data-region-id="region-hokkaido-tohoku">
								<span class="toggle-icon">▲</span>北海道・東北
							</div>
							<div class="region-content" id="region-hokkaido-tohoku">
								<label class="status-label all-in-section"> <input
									type="checkbox" name="all_in_section_hokkaido_tohoku"
									onchange="toggleSectionPrefectures(this, 'region-hokkaido-tohoku')">
									すべて選択
								</label> <label class="status-label"><input type="checkbox"
									name="prefecture_status" value="北海道">北海道</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="青森県">青森県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="岩手県">岩手県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="宮城県">宮城県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="秋田県">秋田県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="山形県">山形県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="福島県">福島県</label>
							</div>
						</div>

						<div class="region-item">
							<div class="region-header" onclick="toggleRegion('region-kanto')"
								data-region-id="region-kanto">
								<span class="toggle-icon">▲</span>関東
							</div>
							<div class="region-content" id="region-kanto">
								<label class="status-label all-in-section"> <input
									type="checkbox" name="all_in_section_kanto"
									onchange="toggleSectionPrefectures(this, 'region-kanto')">
									すべて選択
								</label> <label class="status-label"><input type="checkbox"
									name="prefecture_status" value="茨城県">茨城県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="栃木県">栃木県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="群馬県">群馬県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="埼玉県">埼玉県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="千葉県">千葉県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="東京都">東京都</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="神奈川県">神奈川県</label>
							</div>
						</div>

						<div class="region-item">
							<div class="region-header" onclick="toggleRegion('region-chubu')"
								data-region-id="region-chubu">
								<span class="toggle-icon">▲</span>中部
							</div>
							<div class="region-content" id="region-chubu">
								<label class="status-label all-in-section"> <input
									type="checkbox" name="all_in_section_chubu"
									onchange="toggleSectionPrefectures(this, 'region-chubu')">
									すべて選択
								</label> <label class="status-label"><input type="checkbox"
									name="prefecture_status" value="新潟県">新潟県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="富山県">富山県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="石川県">石川県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="福井県">福井県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="山梨県">山梨県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="長野県">長野県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="岐阜県">岐阜県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="静岡県">静岡県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="愛知県">愛知県</label>
							</div>
						</div>

						<div class="region-item">
							<div class="region-header" onclick="toggleRegion('region-kinki')"
								data-region-id="region-kinki">
								<span class="toggle-icon">▲</span>近畿
							</div>
							<div class="region-content" id="region-kinki">
								<label class="status-label all-in-section"> <input
									type="checkbox" name="all_in_section_kinki"
									onchange="toggleSectionPrefectures(this, 'region-kinki')">
									すべて選択
								</label> <label class="status-label"><input type="checkbox"
									name="prefecture_status" value="三重県"> 三重県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="滋賀県"> 滋賀県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="京都府"> 京都府</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="大阪府"> 大阪府</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="兵庫県"> 兵庫県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="奈良県"> 奈良県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="和歌山県"> 和歌山県</label>
							</div>
						</div>

						<div class="region-item">
							<div class="region-header"
								onclick="toggleRegion('region-chugoku-shikoku')"
								data-region-id="region-chugoku-shikoku">
								<span class="toggle-icon">▲</span>中国・四国
							</div>
							<div class="region-content" id="region-chugoku-shikoku">
								<label class="status-label all-in-section"> <input
									type="checkbox" name="all_in_section_chugoku-shikoku"
									onchange="toggleSectionPrefectures(this, 'region-chugoku-shikoku')">
									すべて選択
								</label> <label class="status-label"><input type="checkbox"
									name="prefecture_status" value="鳥取県">鳥取県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="島根県">島根県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="岡山県">岡山県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="広島県">広島県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="山口県">山口県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="徳島県">徳島県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="香川県">香川県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="愛媛県">愛媛県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="高知県">高知県</label>
							</div>
						</div>

						<div class="region-item">
							<div class="region-header"
								onclick="toggleRegion('region-kyushu-okinawa')"
								data-region-id="region-kyushu-okinawa">
								<span class="toggle-icon">▲</span>九州・沖縄
							</div>
							<div class="region-content" id="region-kyushu-okinawa">
								<label class="status-label all-in-section"> <input
									type="checkbox" name="all_in_section_kyushu-okinawa"
									onchange="toggleSectionPrefectures(this, 'region-kyushu-okinawa')">
									すべて選択
								</label> <label class="status-label"><input type="checkbox"
									name="prefecture_status" value="福岡県">福岡県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="佐賀県">佐賀県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="長崎県">長崎県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="熊本県">熊本県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="大分県">大分県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="宮崎県">宮崎県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="鹿児島県">鹿児島県</label> <label
									class="status-label"><input type="checkbox"
									name="prefecture_status" value="沖縄県">沖縄県</label>
							</div>
						</div>

						<button type="button" onclick="searchBySidenav('prefectureOnly');"
							class="global-prefecture-search-button">検索</button>
					</div>
				</div>
			</div>
		</div>
		<div class="USmenu">
			<h1>店舗一覧</h1>
		</div>
		<div id="contentWrapper">
			<iframe id="wakuFrame" name="waku"
				src="<%=request.getContextPath()%>/FMsearch" frameborder="0"></iframe>
		</div>


		<div class="footer">
			<span>© 2025 FamilyMart System — All Rights Reserved.</span>
		</div>
	</div>
</body>
</html>
