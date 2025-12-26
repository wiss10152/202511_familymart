<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.SQLException"%>

<%
String un = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>

<html lang="ja">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/view/img/favicon.ico"
	rel="icon" type="img/x-icon" />
<title>メニュー</title>
<style type="text/css">

body, .center {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.button-container {
    display: flex;
    flex-wrap: wrap;          
    justify-content: center;  
    gap: 25px; 
}

.footer{
	margin-top:85px;
	margin-bottom:0 !important;
	text-align: center;
	
}

.navbar {
    margin-bottom: 0;
}
.USmenu {
    margin-top: 0;
}
.USmenu h1 {
    margin-top: 0;
}

</style>

<script type="text/javascript">

window.onload = function () {
	const inputerror = document.getElementById("inputerror");

	if (loginAlert) {
	 loginAlert.remove();
	}
	}


	// ログアウト処理
	function logOut(){
		if(confirm("ログアウトします。よろしいですか？")){
			document.MyForm.action = "<%=request.getContextPath()%>/FMlogout"
			document.MyForm.submit();
		} else {
			return;
		}
	}

	function moveShopItem(){
		document.MyForm.action = "<%=request.getContextPath()%>/view/SHtest.jsp"
		document.MyForm.submit();		//↑ここの文で違うページに遷移するという意味になる
	}

	function movePrefecture(){
		document.MyForm.action = "<%=request.getContextPath()%>/view/FMtest.jsp"
		document.MyForm.submit();
	}
	
	function moveHome(){
		document.MyForm.action = "<%=request.getContextPath()%>/view/USgeneral.jsp"
		document.MyForm.submit();
	}

	function moveUserList(){
		document.MyForm.action = "<%=request.getContextPath()%>/USshow"
		document.MyForm.submit();
	}

	function moveRank(){
		document.MyForm.action = "<%=request.getContextPath()%>/view/FMrank1.jsp"
		document.MyForm.submit();
	}

	function moveMyStore(){
		document.MyForm.action = "<%=request.getContextPath()%>/MyStoreServlet"
		document.MyForm.submit();
	}

	//jspへの直アクセスを防ぐ
<%request.setCharacterEncoding("windows-31j");
Boolean login = (Boolean) session.getAttribute("adminFlg");
if (login == null) {
	pageContext.forward("/view/login.jsp");
}%>

</script>
</head>

<body>
	<div class="center">

		<form name="MyForm" method="POST"
			action="<%=request.getContextPath()%>/FMlogout" style="margin:0; padding:0; flex:1 0 auto; display:flex; flex-direction:column;">

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
			<!--<div class="sidenav">-->
			<!--			<p></p>-->
			<!--			<a href="#"></a> <a href="#"></a> <a href="#"></a>-->
			<!--		</div>-->
			<!--            <br>-->

			<div class="USmenu">
				<h1>メニュー</h1>
			</div>

			<div>
				<h2>
					<%
					out.print(" ようこそ" + session.getAttribute("userName") + "様");
					%>
				</h2>

				<hs>ご利用のボタンを押してください↓</hs>
			</div>
			<div class="button-container">


				<div class="bbtn">
					<button class="btn3" onClick="moveShopItem();">商品</button>
				</div>

				<div class="bbtn">
					<button class="btn3" onClick="movePrefecture();">店舗</button>
				</div>

				<div class="bbtn">
					<button class="btn3" onClick="moveRank();">ランキング</button>
				</div>
				<%
				    if (Boolean.TRUE.equals(adminFlg)) {
				%>
				<div class="bbtn">
					<button class="btn3" onclick="moveUserList();">ユーザ管理</button>
				</div>
				<div class="bbtn">
					<button class="btn3" onclick="moveMyStore();">MY店舗</button>
				</div>
				<%
				    }
				%>
			</div>
			</br>
		</form>

		<div class="footer">
			<span>© 2025 FamilyMart System — All Rights Reserved.</span>
		</div>

	</div>
</body>

</html>