<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="control.Shopinfo"%>
<%
String un = (String) session.getAttribute("userName");
String mode = (String) request.getAttribute("mode");
List<Shopinfo> shopList = (List<Shopinfo>) request.getAttribute("myStoreList");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/table.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/img/favicon.ico"
	rel="icon" type="img/x-icon" />
<title>MY店舗</title>
<script type="text/javascript">

<%request.setCharacterEncoding("windows-31j");
Boolean login = (Boolean) session.getAttribute("adminFlg");
if (login == null) {
	pageContext.forward("/view/login.jsp");
}%>

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
	window.location.href = "<%=request.getContextPath()%>/MyStoreServlet";
}

function checkInput(){
	const value = document.getElementById("shopName").value.trim();
	if (value === ""){
		alert("入力してください");
		return false;
	} else {
		return true;
	}
}

function checkRegist(text){
	if (confirm(text + "をMY店舗として登録しますか？")){
		return true;
	}
	return false;
}

function checkRemove(text){
	if (confirm(text + "をMY店舗から削除しますか？")){
		return true;
	}
	return false;
}

</script>
<style type="text/css">
body {
	position:relative;
	background: linear-gradient(-45deg, rgba(127, 255, 212, .8),
		rgba(255, 250, 250, .8), rgba(0, 255, 0, .8)),
		url(familymart-iloveimg-converted.jpg) !important;
	background-size: cover;
	min-height: 100vh;
}

.radio-box {
	display: flex;
	align-items: center;
	width: 100%;
	gap: 8px;
	background-color: #32cd32;
	border: 1px solid #ccc;
	padding: 12px;
	cursor: pointer;
}

.radio-box:hover {
	background-color: #006633;
}

.radio-box input[type="radio"] {
	cursor: pointer;
}

.search-input-group {
	margin-left: 5px;
}

.center {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

.main-content-area {
	flex: 1;
	margin-left: 260px;
	margin-bottom: 80px;
}

table button[type='submit'] {
	padding: 6px 12px;
	border: none;
	background-color: #008000;
	color: #fff;
	border-radius: 4px;
	font-size: 14px;
}

table button[type='submit']:hover {
	background-color: #00a000;
}

.USmenu {

	margin-left: 160px;
}

.menu2{
	position:absolute;
	top:60px;
	left:160px;
	display:inline-block;
	width:1190px;
}

</style>
</head>
<body>
	<div class="center">

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

			<label class="radio-box"> <input type="radio"
				id="myStoreList" value="listSet" name="fncSelect"
				onclick="location.href='MyStoreServlet'">
				<p class="sidebar-search-title">MY店舗一覧</p>
			</label> <label class="radio-box"> <input type="radio"
				id="myStoreRegist" value="search" name="fncSelect"
				onclick="document.getElementById('shopName')">
				<p class="sidebar-search-title">MY店舗登録</p>
			</label>
			<div class="sidebar-search-group">
				<form name="MyForm" method="post"
					action="<%=request.getContextPath()%>/MyStoreSearch"
					onsubmit="return checkInput();">
					<div class="search-input-group">
						<input type="search" id="shopName" name="shopName"
							placeholder="検索" class="sidebar-search-input"> <input
							type="submit" value="検索" class="sidebar-search-button">
					</div>
				</form>
			</div>
		</div>

		<%
		if (mode.equals("listSet")) {
		%>
		<div class="USmenu">
			<h1>MY店舗一覧</h1>
		</div>
		<div class="main-content-area">

			<%
			if (shopList.size() > 0) {
			%>
			<table border="1" align="center">
				<form method="post"
					action="<%=request.getContextPath()%>/MyStoreRegist">
					<input type="hidden" name="registMode" value="remove">
					<tr>
						<th>店舗ID</th>
						<th>店舗名</th>
						<th>MY店舗から削除</th>
					</tr>
					<%
					String[] shopIdList = new String[50];
					for (Shopinfo info : shopList) {
					%>
					<tr>
						<td><%=info.shopid%></td>
						<td><%=info.shopName%></td>
						<td><button class="btn-cls" type="submit" name="shopId"
								value="<%=info.shopid%>"
								onClick="return checkRemove('<%=info.shopName%>')">MY店舗から削除</button></td>
					</tr>
					<%
					}
					%>

				</form>
			</table>
			<%
			} else {
			%>
			<h2>登録されたMY店舗はありません</h2>
			<%
			}
			} else {
			%>
			<div class="menu2">
				<h1>MY店舗登録</h1>

				<%
				if (shopList.size() > 0) {
				%>
				<table border="1" align="center">
					<form method="post"
						action="<%=request.getContextPath()%>/MyStoreRegist">
						<input type="hidden" name="registMode" value="regist">
						<tr>
							<th>店舗ID</th>
							<th>店舗名</th>
							<th>MY店舗に登録</th>
						</tr>
						<%
						String[] shopIdList = new String[50];
						for (Shopinfo info : shopList) {
						%>
						<tr>
							<td><%=info.shopid%></td>
							<td><%=info.shopName%></td>
							<td><button class="btn2" type="submit" name="shopId"
									value="<%=info.shopid%>"
									onClick="return checkRegist('<%=info.shopName%>')">MY店舗に登録</button></td>
						</tr>
						<%
						}
						%>

					</form>
				</table>
			</div>
			<%
			} else {
			%>
			<h2>登録可能な店舗が見つかりませんでした</h2>
			<%
			}
			}
			%>
		</div>
		<div class="footer">
			<span>© 2025 FamilyMart System — All Rights Reserved.</span>
		</div>

	</div>
	<script type="text/javascript">
	document.querySelector('input[name="fncSelect"][value="<%=mode%>"]').checked = true;

		document.getElementById("shopName").addEventListener("focus",
				function() {
					document.getElementById("myStoreRegist").checked = true;
				});

		document.getElementById("myStoreRegist").addEventListener("click",
				function() {
					document.getElementById("shopName").focus();
				});

	const msg = "<%=request.getAttribute("status")%>";

		if (msg !== "null" && msg !== "") {
			alert(msg);
		}
	</script>
</body>
</html>