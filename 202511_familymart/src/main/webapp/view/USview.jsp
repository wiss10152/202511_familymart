<%@ page contentType="text/html; charset=UTF-8" import="java.util.*"%>
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
<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/table.css"
	rel="stylesheet" type="text/css" />
<title>FamilyMartユーザ管理画面</title>

<style type="text/css">
body {
	background: linear-gradient(-45deg, rgba(127, 255, 212, .8),
		rgba(255, 250, 250, .8), rgba(0, 255, 0, .8)),
		url(familymart-iloveimg-converted.jpg) !important;
}

input[type="checkbox"][disabled] {
	cursor: default !important;
}

span.table2 table td {
	cursor: default;
}

span.table2 table td a {
	cursor: pointer;
}

.footer1 {
	display: flex;
	lign-items: center;
	gap: 20px;
	justify-content: center;
	margin-top: 20px
}

.btn1 {
background-color: #ADADAD;
	cursor: pointer;
	border: none;
	width: 110px;
		border-radius: 4px;
	
}

.btn1:hover {
	background-color: #C4C4C4;
}

h1 {
	display: inline-block;
	margin-top: -50px;
	margin-bottom: 80px;
}

span.table2>table {
	width: 55% !important;
	margin: 0 auto !important;
	border-collapse: collapse !important;
	border-spacing: 0 !important;
	font-size: 18px !important;
}

span.table2>table th, span.table2>table td {
	padding: 2px 3px !important;
	line-height: 1.1 !important;
	height: auto !important;
}

span.table2>table tr {
	height: 40px !important;
}

span.table2 input[type="checkbox"] {
	width: 12px !important;
	height: 12px !important;
}

.table2 {
	display: flex;
	align-items: center;
	justify-content: center;
}
</style>

<script type="text/javascript">

	
	
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





	
	

<!--	function logOut(){-->
<!--		if(confirm("ログアウトします。よろしいですか？")){-->
<!--			document.MyForm.action = "<%= request.getContextPath() %>/FMlogout"-->
<!--			document.MyForm.submit();-->
<!--		} else {-->
<!--			return;-->
<!--		}-->
<!--	}-->

	function go_access(num){
		var len = num;
		var str = "";
		var flg = 0;
		var alertFlg = true;

		for(i = 0; i < len ; i++) {
			if(document.MyForm.elements['chkBox'+i].checked ) {
				if(confirm("ユーザID[" + document.MyForm.elements['chkBox'+i].value + "]のアクセス権を変更しますか？") ) {
					flg++;
					str += "<input type=\"hidden\" name=\"userId\" value=\"";
					str += document.MyForm.elements['chkBox'+i].value + "\">";
				}
				alertFlg = false;				//ここで、上記のアラートがならないように設定
			}
		}

		if(flg > 0) {
			document.MyForm.actionId.value = 'access';
			document.getElementById("user").innerHTML= str;
			document.MyForm.action = "<%= request.getContextPath() %>/USaccessControl"
			document.MyForm.submit();
		}

		if(alertFlg != false) {				//上記と同じ不具合発生のため追加
			alert("チェックボックスが未入力です");
			alertFlg = true;
		}
	}

	function user_Regist(){
		document.MyForm.actionId.value = 'userRegist';
		document.MyForm.action = "<%= request.getContextPath() %>/view/USregist.jsp"
		document.MyForm.submit();
	}

	function move(Command){
		document.MyForm.actionId.value = "update";
		var values = Command.split(','); // , 区切;
		document.MyForm.userId.value = values[0];
		document.MyForm.username.value = values[1];
		<%-- document.MyForm.password.value = values[2]; --%>
		document.MyForm.action = "<%= request.getContextPath() %>/view/USregist.jsp"
		document.MyForm.submit();
	}

	function deletes(num){
		var len = num ;
		var str = "";
		var flg = 0;
		var alertFlg = true;

		for(i = 0; i < len ; i++) {
			if (document.MyForm.elements['chkBox'+i].checked) { //チェックが入っている時の処理
				if (confirm("ユーザID[" + document.MyForm.elements['chkBox'+i].value + "]を削除しますか？")){
					flg++;
					str += "<input type=\"hidden\" name=\"userId\" value=\"";
					str += document.MyForm.elements['chkBox'+i].value + "\">";
				}
				alertFlg = false;				//ここで、上記のアラートが鳴ってしまうので鳴らないように設定
			}
		}

		if(flg > 0) {
			document.MyForm.actionId.value = 'delete';
			document.getElementById("user").innerHTML= str;
			document.MyForm.action = "<%= request.getContextPath() %>/USaccessControl"
			document.MyForm.submit();
		}

		if(alertFlg != false) {						//上記と同じ不具合発生のため追加
			alert("チェックボックスが未入力です");
			alertFlg = true;
		}
	}

<!--	function movePrefecture(){-->
<!--		document.MyForm.action = "<%= request.getContextPath() %>/view/USgeneral.jsp"-->
<!--		document.MyForm.submit();-->
<!--	}-->

	//jspへの直アクセスを防ぐ
<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");
	if (login == null || login == false){
    	pageContext.forward("/view/login.jsp");
    }
%>

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
		<div class="end">

			<h1>管理者用ユーザリスト</h1>
		</div>

		<%--ここから、曲を流すプログラム --%>
		<%  boolean music  = (boolean)session.getAttribute("music");    //7月新規
		String   manege = (String)  session.getAttribute("manegement");
		if(music == true){ %>
		<%-- ここのIF文でログイン後の1度きりという設定している --%>
		<audio
			src="<%= request.getContextPath() %>/view/mp3/ファミマ入店音square.mp3"
			autoplay></audio>
		<%-- 入店音を出す --%>
		<%	session.setAttribute("music", false);		//これ以降ここの音楽は流れないように設定
				session.setAttribute("manegement", "LOW");
		} else if(manege  == "NORMAL") {%>
		<%--ここのIF文で一般画面から管理者画面に遷移したときに流す曲を設定している --%>
		<%--改善案 --%>
		<audio
			src="<%= request.getContextPath() %>/view/mp3/ファミマ入店音Normal.mp3"
			autoplay></audio>
		<%--同上 --%>
		<% session.setAttribute("manegement", "LOW");	//これで、次にユーザ管理画面に行かない限り音楽は流れない
		} %>
		<%--ここまで --%>

		<form name="MyForm" method="POST"
			action="<%= request.getContextPath() %>/FMlogout">
			<%--
		<div class="button-panel">
			<% out.print("ユーザ名 : " + session.getAttribute("userName"));%>
			<a style="margin-left: 20px" class="button" name="logout" onClick="logOut();"><img
			src="<%= request.getContextPath() %>/view/img/153.142.124.217 (2).gif"></a>
		</div>

		<div class="button2">
			<input type="submit" class="button" value="ユーザページへ" onclick="movePrefecture();">
		</div>
--%>
			<!--			<a href="#" onclick=go_portal();><img src="<%= request.getContextPath() %>/view/img/familymart.png"></a>-->



			<br>
			<%-- テーブルの表示--%>
			<span class="table2">
				<table border="1" align="center">
					<tr>
						<th></th>
						<th>ユーザID</th>
						<th>ユーザ名</th>
						<th>権限</th>
						<th>作成者</th>
					</tr>

					<%
					//ユーザ情報取得
					String current_user_id = (String) request.getAttribute("currentUserId");

					Boolean mngObj = (Boolean) session.getAttribute("management_flg");
					boolean iAmSuperUser = (mngObj != null && mngObj);

					List<HashMap<String, String>> userList = (List<HashMap<String, String>>) request.getAttribute("userList");
					int num = 0;
					String kizo[] = new String[50]; //ここで、既存配列を作成している
					if (userList != null) {
						for (HashMap<String, String> userInfo : userList) {
							String user_name = userInfo.get("userName");
							String user_id = userInfo.get("userId");
							String password = userInfo.get("password");
							String user_admin = userInfo.get("userAdmin");
							String creator_id = userInfo.get("createUser");

							boolean isCreator = current_user_id != null && current_user_id.equals(creator_id);
							boolean hasPermission = isCreator || iAmSuperUser;

							kizo[num] = user_id; //IDを既存配列の中に代入している
					%>

					<%
					if (!(userInfo.get("userId").equals(session.getAttribute("userId")))) { //7月新規 ログインしている管理者ユーザ以外を表示する
					%>
					<td><input type="checkbox" name="chkBox<%=num%>"
						style="width: 17px; height: 17px;" value="<%=user_id%>"
						<%if (!hasPermission) {
	out.print("disabled='disabled'");
}%>></td>
					<td>
						<%
						if (hasPermission) {
						%> <a href="#"
						onClick="move('<%=user_id%>,<%=user_name%>');"><%=user_id%></a>
					</td>
					<%
					} else {
					%>
					<%=user_id%>
					<%
					}
					%>
					</td>
					<td><%=user_name%></td>

					<td>
						<%
						if (user_admin.equals("true")) {
							out.print("管理者");
						} else {
							out.print("一般");
						}
						%>
					</td>

					<td><%=userInfo.get("createUser")%></td>

					</tr>
					<!-- 8月　開始タグはないが、入れないとレイアウトが壊れる -->
					<%
					num++;

					} else { //7月　ログインしている管理者ユーザは、チェックボックスに入力させない（自身で削除不可、アドレス変更不可)
					//(注　ただし、チェックボックスが本当に押せないのか判別がしづらいとのご指摘を受けました。不可を白色ではなく灰色にできないのかなどの助言有)
					%>
					<td><input type="hidden" name="checkItem2" value="0">
						<input type="checkbox" name="chkBox<%=num%>"
						style="width: 17px; height: 17px;" disabled='disabled'
						value="<%=user_id%>"> <label for='checkoff'></label></td>

					<td>
						<%
						if (hasPermission) {
						%> <a href="#"
						onClick="move('<%=user_id%>,<%=user_name%>');"><%=user_id%></a>
						<%
						} else {
						%> <%=user_id%> <%
 }
 %>
					</td>

					<td><%=user_name%></td>

					<td>
						<%
						if (user_admin.equals("true")) {
							out.print("管理者");
						} else {
							out.print("一般");
						}
						%>
					</td>

					<td><%=userInfo.get("createUser")%></td>

					</tr>
					<!-- 8月　開始タグはないが、入れないとレイアウトが壊れる -->
					<%
					num++;
					}
					}
					session.setAttribute("kizo", kizo); //7月　ここで「既存」配列をセッション内に入れる
					}
					%>

				</table>
			</span>
			<table>

				<div class="footer1">
					<input type="button" class="btn1 btn2" value="ユーザ登録"
						onClick="user_Regist();"> <input type="button"
						class="btn1" value="ユーザ削除" onClick="deletes(<%=num%>);">
					<%--7月　現在削除ボタンや更新ボタンを押したあとにブラウザバックを押してまた同じ動作をすると --%>
					<input type="button" class="btn1 btn2" name="inq_btn" value="権限変更"
						onClick="go_access(<%=num%>);">
					<%--処理はしないが動作できてしまうバグ。IF文でアラートを出すように設定すればいけるかもしれない --%>



				</div>
				<div id="user"></div>

				<input type="hidden" name="actionId" value="">
				<input type="hidden" name="userId" value="">
				<input type="hidden" name="username" value="">

			</table>


		</form>
	</div>
	<div class="footer">
		<span>© 2025 FamilyMart System — All Rights Reserved.</span>
	</div>
</body>
</html>