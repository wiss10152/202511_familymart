<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%= request.getContextPath() %>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<link href="<%= request.getContextPath() %>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<title>商品ジャンル選択</title>
<style>

</style>

<script>
<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");
	if (login == null){
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

    
<%
Class.forName("org.postgresql.Driver");

Connection conn = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/familymart", 
    "postgres",   
    "postgres"    );

String sql = "SELECT DISTINCT ON (ジャンル) ジャンル, 画像 FROM 商品データ ORDER BY ジャンル, 商品コード;";

PreparedStatement ps = conn.prepareStatement(sql);
ResultSet rs = ps.executeQuery();

List<Map<String, String>> list = new ArrayList<>();

while(rs.next()) {
    Map<String,String> map = new HashMap<>();
    map.put("genre", rs.getString("ジャンル"));
    map.put("image", rs.getString("画像"));
    list.add(map);
}

rs.close();
ps.close();
conn.close();
%>
    
    
    
    
    //11月　ここまで
    
    
    
    
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
<!--	var flag = false;-->
<!--	function logout(){-->
<!--		if(confirm("ログアウトします。よろしいですか？")){-->
<!--			flag = true;-->
<!--			document.MyForm.action = "<%= request.getContextPath() %>/FMlogout"-->
<!--			document.MyForm.submit();-->
<!--		} else {-->
<!--			return;-->
<!--		}-->
<!--	}-->

<!--	function movePrefecture(){-->
<!--		document.MyForm.action = "<%= request.getContextPath() %>/view/FMtest.jsp"-->
<!--		document.MyForm.submit();-->
<!--	}-->

<!--	function moveUserList(){-->
<!--		document.MyForm.action = "<%= request.getContextPath()%>/USshow"-->
<!--		document.MyForm.submit();-->
<!--	}-->

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
		<div class="menu">
			<h1>ジャンル一覧</h1>

			<div class="grid-container">
				<%
    			for (Map<String,String> it : list) {
				%>
				<div class="grid-item">
					<a href="SHcontrol?pre=<%= it.get("genre") %>"> <img
						src="<%= request.getContextPath() %><%= it.get("image") %>">
						<div class="genre-name"><%= it.get("genre") %></div>
					</a>
				</div>
				<%
    			}
				%>
			</div>
		</div>

		<!--	<br>-->
		<!--	<div class="center">-->


		<!--	<form name="MyForm" method="POST" action="#" onsubmit="return flag;">-->
		<!--		<div class="button-panel">-->
		<!--			<% out.print("ユーザ名 : " + session.getAttribute("userName")); %>-->
		<!--			<a style="margin-left: 20px" class="button" onClick="logout();">-->
		<!--				<img src="<%= request.getContextPath() %>/view/img/153.142.124.217 (2).gif"></a>-->
		<!--		</div>-->

		<!--		<div class="button1">-->
		<!--			<input type="submit" class="button" value="戻る" onclick="location.href='USgeneral.jsp';">-->
		<!--		</div>-->
		<!--	</form>-->

		<!--	<div class ="end">-->
		<!--		<h1>商品データ</h1>-->
		<!--	</div>-->

		<!--	<br>-->
		<!--	<%--7月　ボタンや表示が小さいとの指摘有、大きくしたほうがよいと思います → 8月　しました--%>-->
		<!--	<div class="select">-->

		<!--		 応急処置 -->
		<!--		<div class="subh">-->
		<!--			--商品を表示する方法を選択してください---->
		<!--		</div>-->

		<!--		<br>-->
		<!--		<form name="f1" action="#" onsubmit="return false">-->
		<!--			<input id="label1" type="radio" name="radio1" onclick="Items(pre,this.cheaked);sea.disabled=true;sea.value=null;sea.placeholder='入力できません'">-->
		<!--				<label for="label1">商品ジャンル</label>-->
		<!--			<input id="label2" type="radio" name="radio1" onclick="Connecttext(sea,this.cheaked);pre.disabled=true;sea.placeholder='商品名で検索'">-->
		<!--				<label for="label2">商品名検索</label><br>-->

		<!--			<select name="selectName" id="pre" disabled></select>-->
		<!--			<input type="search" id="sea" name="searchText" placeholder="入力できません" disabled>-->
		<!--		</form>-->

		<!--		<br>-->
		<!--		<input type="submit" class="button" id="" value="検索結果の表示" onClick="SearchGenreSelect()" >-->
		<!--		<br>-->
		<!--	</div>-->

		<!--	<br><br>-->
		<!--	 8月　インラインフレームでSHview.jspを表示する。最初は白紙。属性名wakuはsenditemとsearchWordで使用 -->
		<!--	<iframe src="about:blank" name="waku" width="90%" height="500"></iframe>-->

		<!--		</div>-->
		
		<div class="footer">
            <span>© 2025 FamilyMart System — All Rights Reserved.</span>
        </div>
</body>
</html>