<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%= request.getContextPath() %>/view/css/W0051.css"
		rel="stylesheet" type="text/css" />
<title>商品ジャンル選択</title>

<script>
<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");
	if (login == null){
		pageContext.forward("/view/login.jsp");
	}
%>
	// 8月　SHviewへ飛ばすプログラムをインラインフレームでのページ遷移へ変更
	function senditem(){
		var index = document.getElementById("pre").selectedIndex;
		var text =document.getElementById("pre").options[index].text;

		// 8月　インラインフレームのページ遷移を行う。
		waku.location = "<%= request.getContextPath() %>\/SHcontrol?pre=" + encodeURI(text);
	}

	// 8月 検索結果のページへ遷移する
	function searchWord(){
		var str = document.getElementById("sea").value;
		waku.location = "<%= request.getContextPath() %>\/SHsearch?str=" + encodeURI(str);
	}

	// ログアウト処理
	var flag = false;
	function logout(){
		if(confirm("ログアウトします。よろしいですか？")){
			flag = true;
			document.MyForm.action = "<%= request.getContextPath() %>/FMlogout"
			document.MyForm.submit();
		} else {
			return;
		}
	}

	function movePrefecture(){
		document.MyForm.action = "<%= request.getContextPath() %>/view/FMtest.jsp"
		document.MyForm.submit();
	}

	function moveUserList(){
		document.MyForm.action = "<%= request.getContextPath()%>/USshow"
		document.MyForm.submit();
	}

	function Items(pre,ischecked){
		if(ischecked == true){
			// チェックが入っていたら有効化
			document.getElementById("pre").disabled = true;
		} else {
			// チェックが入っていなかったら無効化
			document.getElementById("pre").disabled = false;
		}
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
		document.f1.selectName.options[18].text ="発売予定";
	}

	function Connecttext( sea, ischecked ) {
		if( ischecked == true ) {
			// チェックが入っていたら有効化
			document.getElementById("sea").disabled = true;
		} else {
			// チェックが入っていなかったら無効化
			document.getElementById("sea").disabled = false;
		}
	}

	function SearchGenreSelect(){
		radiobtn1 = document.getElementById("label1");
		radiobtn2 = document.getElementById("label2")
		if(radiobtn1.checked){
			senditem();
		}
		if(radiobtn2.checked){
			searchWord();
		}
	}

</script>
</head>

<body>
<br>
<div class="center">
	<form name="MyForm" method="POST" action="#" onsubmit="return flag;">
		<div class="button-panel">
			<% out.print("ユーザ名 : " + session.getAttribute("userName")); %>
			<a style="margin-left: 20px" class="button" onClick="logout();">
				<img src="<%= request.getContextPath() %>/view/img/153.142.124.217 (2).gif"></a>
		</div>

		<div class="button1">
			<input type="submit" class="button" value="戻る" onclick="location.href='USgeneral.jsp';">
		</div>
	</form>

	<div class ="end">
		<h1>商品データ</h1>
	</div>

	<br>
	<%--7月　ボタンや表示が小さいとの指摘有、大きくしたほうがよいと思います → 8月　しました--%>
	<div class="select">

		<!-- 応急処置 -->
		<div class="subh">
			--商品を表示する方法を選択してください--
		</div>

		<br>
		<form name="f1" action="#" onsubmit="return false">
			<input id="label1" type="radio" name="radio1" onclick="Items(pre,this.cheaked);sea.disabled=true;sea.value=null;sea.placeholder='入力できません'">
				<label for="label1">商品ジャンル</label>
			<input id="label2" type="radio" name="radio1" onclick="Connecttext(sea,this.cheaked);pre.disabled=true;sea.placeholder='商品名で検索'">
				<label for="label2">商品名検索</label><br>

			<select name="selectName" id="pre" disabled></select>
			<input type="search" id="sea" name="searchText" placeholder="入力できません" disabled>
		</form>

		<br>
		<input type="submit" class="button" id="" value="検索結果の表示" onClick="SearchGenreSelect()" >
		<br>
	</div>

	<br><br>
	<!-- 8月　インラインフレームでSHview.jspを表示する。最初は白紙。属性名wakuはsenditemとsearchWordで使用 -->
	<iframe src="about:blank" name="waku" width="90%" height="500"></iframe>

</div>
</body>
</html>