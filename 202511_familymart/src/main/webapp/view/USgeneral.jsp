<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.SQLException"%>

<% String un =(String) session.getAttribute("userName"); %>

<!DOCTYPE html>

<html lang="ja">
<head>
<meta charset="UTF-8" />
<link href="<%= request.getContextPath() %>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<title>FamilyMartユーザ画面</title>

<script type="text/javascript">

	//8月新規　onloadイベントで、ログイン直後の1回のみ管理ユーザ画面でユーザ名アラートを表示させる。
	window.onload = function (){
		<% boolean firstlogin = (boolean)session.getAttribute("firstlogin");
		if(firstlogin){ %> // trueの時(ログイン直後のみ)に表示される
			alert("ユーザ" + "<%= un %>" + "でログインしています");
			<% session.setAttribute("firstlogin", false); %> //これ以降ユーザアラートが出ないように設定
		<% } %>
	}

	// ログアウト処理
	function logOut(){
		if(confirm("ログアウトします。よろしいですか？")){
			document.MyForm.action = "<%= request.getContextPath() %>/FMlogout"
			document.MyForm.submit();
		} else {
			return;
		}
	}

	function moveShopItem(){
		document.MyForm.action = "<%= request.getContextPath() %>/view/SHtest.jsp"
		document.MyForm.submit();		//↑ここの文で違うページに遷移するという意味になる
	}

	function movePrefecture(){
		document.MyForm.action = "<%= request.getContextPath() %>/view/FMtest.jsp"
		document.MyForm.submit();
	}

	function moveUserList(){
		document.MyForm.action = "<%= request.getContextPath() %>/USshow"
		document.MyForm.submit();
	}

	function moveRank(){
		document.MyForm.action = "<%= request.getContextPath() %>/view/FMrank1.jsp"
		document.MyForm.submit();
	}

//jspへの直アクセスを防ぐ
<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");
	if(login == null){
		pageContext.forward("/view/login.jsp");
	}
%>

</script>
</head>

<body>

<br>
<div class="center">
	<%--7月　ここから、曲を流すプログラム --%>
	<%  String manege= (String)session.getAttribute("manegement");%>
	<%  boolean music = (boolean)session.getAttribute("music");

	if(music == true){ %>	<%-- ここのIF文でログイン後の1度きりという設定している --%>
		<audio src="<%= request.getContextPath() %>/view/mp3/ファミマ入店音square短調.mp3" autoplay></audio>
		<% session.setAttribute("manegement", "NORMAL");%>
		<% session.setAttribute("music", false);	//これ以降ここの音楽は流れないように設定

	} else if(manege  == "LOW") {%>    <%--ここのIF文で管理者画面から一般画面に遷移したときに流す曲を設定している --%>
		<%--改善案 --%>
		<audio src="<%= request.getContextPath() %>/view/mp3/ファミマ入店音Low.mp3" autoplay></audio>
		<% session.setAttribute("manegement", "NORMAL");%>  <%--これで、次にユーザ管理画面に行かない限り音楽は流れない --%>
	<% } %>
	<%--ここまで --%>

	<form name="MyForm" method="POST"action="<%= request.getContextPath() %>/FMlogout">
		<div class="button-panel">
			<% out.print("ユーザ名 : " + session.getAttribute("userName"));%>
			<a style="margin-left: 20px" class="button" name="logout" onClick="logOut();">
				<img src="<%= request.getContextPath() %>/view/img/153.142.124.217 (2).gif"></a>
		</div>

		<% Boolean adminFlg = (Boolean)session.getAttribute("adminFlg"); %>
		<% if(adminFlg){ %>
		<div class="button1">
			<input type="submit" class="button" value="ユーザ管理画面へ" onclick="moveUserList();">
		</div>
		<% } %>

		<br>
		<div class="end">
			<a href="#" onclick=go_portal();></a>
				<img src="<%= request.getContextPath() %>/view/img/familymart.png"></img>
			<h1>ユーザ画面</h1>
		</div>

		<div class="footer1">
			<input type="button" value="商品一覧画面へ" onClick="moveShopItem();">
			<input type="button" value="都道府県データへ" onClick="movePrefecture();"><br>
			<input type="button" value="ランキングへ" onClick="moveRank();">

			<input type="hidden" name="actionId" value="">
			<input type="hidden" name="userId"	 value="">
			<input type="hidden" name="username" value="">
			<input type="hidden" name="password" value="">
		</div>

		<div class="footer2">
			Copyright (c) WISS1, Inc. All Rights Reserved.
		</div>
	</form>

</div>
</body>
</html>