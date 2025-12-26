<%@ page import="java.sql.*, java.net.*,dbaccess.MyDBAccess"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>

<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html >
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/img/favicon.ico"
	rel="icon" type="img/x-icon" />
<title>ユーザ登録</title>
<style>
.password-wrapper {
	position: relative;
	display: inline-block;
}

.eye-icon {
	position: absolute;
	right: 8px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
	user-select: none;
	font-size: 18px;
}

.center form .tb {
	width: 100%;
	display: flex;
	justify-content: center;
}

.tb2 {
	margin-top: -70px;
	border: 1px solid #90EE90;
	border-radius: 6px;
	overflow: hidden;
	background: #fff;
}

.fm-table {
	border-collapse: collapse;
	margin: 0 auto;
}

.fm-table td {
	padding: 10px 14px;
	vertical-align: middle;
	border-top: 1px solid #90EE90;
}

.fm-table tr:first-child td {
	border-top: none;
}

.fm-table td:first-child {
	width: 220px;
	background: green;
	color: white;
	font-weight: 700;
	text-align: left;
	border-right: 1px solid #90EE90;
}

.fm-table input[type="text"], .fm-table input[type="password"] {
	width: 320px;
	height: 36px;
	padding: 6px 10px;
	font-size: 14px;
	border: 1px solid #b5b5b5;
	border-radius: 4px;
	background-color: #fff;
	box-sizing: border-box;
	transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.fm-table input[type="text"]:focus, .fm-table input[type="password"]:focus
	{
	outline: none;
	border-color: #4da3ff;
	box-shadow: 0 0 0 2px rgba(77, 163, 255, 0.15);
}

.fm-table input[disabled] {
	background-color: #f3f3f3;
	color: #666;
	cursor: not-allowed;
}

.footer1 {
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 20px;
	margin-top: 15px;
}

.footer1 input {
	background-color: #ADADAD;
	cursor: pointer;
	border: none;
	width: 100px;
	border-radius: 4px;
}

.footer1 input:hover {
	background-color: #C4C4C4;
}

h1 {
	display: inline-block;
}
</style>
<script type="text/javascript">

//パスワードの表示・非表示の切り替え
window.onload = function () {
//要素の取得
    const pwd0 = document.getElementsByName("passWord")[0];
    const pwd1 = document.getElementsByName("ConPassword")[0];
    const eye0 = document.getElementById("eyeIcon0");
    const eye1 = document.getElementById("eyeIcon1");
//パスワードのイベントリスナーの設定
    if(eye0 && pwd0) {
        eye0.addEventListener("mouseover", function () { pwd0.type = "text"; });
        eye0.addEventListener("mouseout", function () { pwd0.type = "password"; });
        }
//確認用パスワードのイベントリスナーの設定
    if(eye1 && pwd1) {
         eye1.addEventListener("mouseover", function () { pwd1.type = "text"; });
         eye1.addEventListener("mouseout", function () { pwd1.type = "password"; });
         }
    };




//ナビゲーションバーのボタンの画面遷移
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

for (let i = 0; i < 2; i++) {
function togglePasswordVisibility(input, passwordVisibleIcon, passwordHiddenIcon) {
	  if (input.type === 'password') {
	    input.type = 'text';
	   
	  } else {
	    input.type = 'password';
	    
	  }
}
			}


    //ユーザ登録・更新・エラー処理
	function Registration(actionId){
		// 8月　エラーメッセージが一番上のものしか表示されていなかったので、エラー項目をすべて表示するように修正
		var errorUserID 		= "";
		var errorUserName 		= "";
		var errorUserPass 		= "";
		var errorCheckPass		= "";
		var errorCase 			= 0;

		var userIdField = document.MyForm.userId;
		var userIdValue = (userIdField.length > 1) ? userIdField[1].value : userIdField.value;

		if(userIdValue === ""){
			errorUserID = "[ユーザID] ";
			errorCase = 1;
		}
		if(document.MyForm.username.value === "") {
			errorUserName	= "[ユーザ名] ";
			errorCase 		= 1;
		}
		if(actionId === "userRegist"){
			if(document.MyForm.passWord.value === "") {
				errorUserPass 	= "[パスワード] ";
				errorCase 		= 1;
			}
			if(document.MyForm.ConPassword.value === "") {
				errorCheckPass 	= "[確認パスワード]";
				errorCase 		= 1;
			}

			
		}
		// 8月　上述のエラー項目を洗い出し、表示したらその時点で返す
		if(errorCase == 1){
			alert(errorUserID + errorUserName + errorUserPass + errorCheckPass + "が未入力です。");
			return;
		}
        //パスワードと確認用パスワードの一致の確認をし、不一致の場合アラートを表示し返す
		if(actionId === "userRegist" || (document.MyForm.passWord && document.MyForm.passWord.value !== "")){
			if(document.MyForm.passWord.value != document.MyForm.ConPassword.value){
				alert("パスワードが一致していません");
				return;
			}
		}
		
		 
		//更新や作成時に確認ダイアログを表示
		var msg = (actionId === "update") ? "更新" : "作成";
		if(confirm("ユーザID[" +userIdValue + "]を" + msg + "します。よろしいですか？")){
			document.MyForm.actionId.value = actionId;
			document.MyForm.action = "<%=request.getContextPath()%>/USregist";
			document.MyForm.submit();
		}
		
	}
    //戻るボタンの処理
    function history_back(){
		document.MyForm.action = "<%=request.getContextPath()%>
	/USshow";
		document.MyForm.submit();
	}
<%if (Boolean.TRUE.equals(session.getAttribute("isRegisteredUserId"))) {%>
	alert("このIDは使われています。違うIDをお試しください。");
<%session.setAttribute("isRegisteredUserId", false);%>
	
<%}%>
	//記号を除去し、半角英数字のみ許可
	function removeSymbols(event) {
		event.value = event.value.replace(/[^a-zA-Z0-9]/g, '');
	}
</script>


</head>

<body>
	<%
	Boolean adminFlg = (Boolean) session.getAttribute("adminFlg");
	String actionId = request.getParameter("actionId");
	if (actionId == null)
		actionId = "userRegist";

	String user_id = request.getParameter("userId");
	String user_name = request.getParameter("username");

	if (user_id == null)
		user_id = "";
	if (user_name == null)
		user_name = "";

	String disabled = "update".equals(actionId) ? "disabled" : "";
	String change = "update".equals(actionId) ? "更新" : "登録";
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
			<%
			out.print("ユーザ名 : " + session.getAttribute("userName"));
			%>
			<a style="margin-left: 20px" class="button" name="logout"
				onClick="logOut();"> <img
				src="<%=request.getContextPath()%>/view/img/153.142.124.217 (2).gif">
			</a>
		</div>
	</div>

	<div class="center">
		<form name="MyForm" method="POST" action="#" onsubmit="return false;">

			<div>
				<h1>
					ユーザ<%=change%>画面
				</h1>
			</div>
			<div class="end">
				<br>

				<div class="tb">
					<div class="tb2">
						<table class="fm-table">
							<tr>
								<td align="left">ユーザID(半角英数字)：</td>
								<td><input pattern="[a-zA-Z0-9]+" type="text" name="userId"
									id="usernameInput" placeholder="半角英数字のみ入力可能"
									style="ime-mode: disabled" size="40" maxlength="8" required
									value="<%=user_id%>" <%=disabled%>
									oninput="removeSymbols(this)" /></td>
							</tr>

							<tr>
								<td align="left">ユーザ名(半角英数字)：</td>
								<td><input pattern="[a-zA-Z0-9]+" type="text"
									id="usernameInput" placeholder="半角英数字のみ入力可能" name="username"
									style="ime-mode: disabled" size="40" maxlength="8" required
									value="<%=user_name%>" oninput="removeSymbols(this)"></td>
							</tr>

							<%
							if ("userRegist".equals(actionId)) {
							%>
							<tr>
								<td align="left">パスワード(半角英数字)：</td>
								<td><div class="password-wrapper">
										<input pattern="[a-zA-Z0-9]+" type="password"
											id="usernameInput" placeholder="半角英数字のみ入力可能" name="passWord"
											style="ime-mode: disabled" size="40" maxlength="40" required
											oninput="removeSymbols(this)"> <span id="eyeIcon0"
											class="eye-icon">👁</span>
									</div></td>
							</tr>
							<tr>
								<td align="left">確認用パスワード：</td>
								<td>
									<div class="password-wrapper">
										<input pattern="[a-zA-Z0-9]+" type="password"
											id="usernameInput" placeholder="半角英数字のみ入力可能"
											name="ConPassword" style="ime-mode: disabled" size="40"
											maxlength="40" required oninput="removeSymbols(this)">
										<span id="eyeIcon1" class="eye-icon">👁</span>
									</div>

								</td>
							</tr>
							<%
							} else {
							%>
							<input type="hidden" name="passWord" value="">
							<input type="hidden" name="conPassword" value="">
							<%
							}
							%>
						</table>
					</div>
				</div>
				<div class="footer1">
					<input type="button" class="button" value="戻る"
						onclick="history_back();"> <input type="button"
						onClick="Registration('<%=actionId%>')" value="<%=change%>">
				</div>

				<div>
					<input type="hidden" name="actionId" value="<%=actionId%>">
					<%
					if ("update".equals(actionId)) {
					%>
					<input type="hidden" name="userId" value="<%=user_id%>">
					<%
					}
					%>
				</div>

			</div>
		</form>
	</div>
	<div class="footer">
		<span>© 2025 FamilyMart System — All Rights Reserved.</span>
	</div>
</body>
</html>
