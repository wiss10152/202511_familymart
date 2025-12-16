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
<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/view/css/W0052.css"
	rel="stylesheet" type="text/css" />
<title>FamilyMartユーザ画面</title>


<script type="text/javascript">

	//8月新規　onloadイベントで、ログイン直後の1回のみ管理ユーザ画面でユーザ名アラートを表示させる。
	window.onload = function (){
		<%
Boolean firstlogin = (Boolean) session.getAttribute("firstlogin");
if (Boolean.TRUE.equals(firstlogin)) {
%>
 // trueの時(ログイン直後のみ)に表示される
			alert("ユーザ" + "<%=un%>" + "でログインしています");
			<%session.setAttribute("firstlogin", false);%> //これ以降ユーザアラートが出ないように設定
		<%}%>
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
            action="<%=request.getContextPath()%>/FMlogout">

            <%
                Boolean adminFlg = (Boolean) session.getAttribute("adminFlg");
            %>

            <div class="navbar">
                <img src="<%=request.getContextPath()%>/view/img/familymart.png"
                    style="height: 50px; margin: 5px; float: left;">

                <div class="btn">
                    <button class="btn2" onclick="moveHome();">
                        ホーム
                    </button>
                </div>

                <div class="btn">
                    <button class="btn2" onClick="moveShopItem();">
                        商品
                    </button>
                </div>

                <div class="btn">
                    <button class="btn2" onClick="movePrefecture();">
                        店舗
                    </button>
                </div>

                <div class="btn">
                    <button class="btn2" onClick="moveRank();">
                        ランキング
                    </button>
                </div>

               

                <%
                    if (Boolean.TRUE.equals(adminFlg)) {
                %>
                <div class="btn">
                    <button class="btn2" onclick="moveUserList();">ユーザ管理</button>
                </div>
                <div class="btn">
                    <button class="btn2" onclick="moveMyStore();">マイ店舗</button>
                </div>
                <%
                    }
                %>

                <div class="button-panel">
                    <%
                        out.print("ユーザ名 : " + session.getAttribute("userName"));
                    %>
                    <a style="margin-left: 20px" class="button" name="logout"
                        onClick="logOut();">
                        <img src="<%=request.getContextPath()%>/view/img/153.142.124.217 (2).gif">
                    </a>
                </div>
            </div>
<div class="sidenav">
			<p></p>
			<a href="#"></a> <a href="#"></a> <a href="#"></a>
		</div>
            <br>

            <div>
                <h1>キャンペーン無し</h1>
            </div>

            <%--
            <div>
                <%
                String manege = (String) session.getAttribute("manegement");
                boolean music = (boolean) session.getAttribute("music");

                if (music == true) {
                %>
                    <audio src="<%=request.getContextPath()%>/view/mp3/ファミマ入店音square短調.mp3" autoplay></audio>
                <%
                    session.setAttribute("manegement", "NORMAL");
                    session.setAttribute("music", false);

                } else if ("LOW".equals(manege)) {
                %>
                    <audio src="<%=request.getContextPath()%>/view/mp3/ファミマ入店音Low.mp3" autoplay></audio>
                <%
                    session.setAttribute("manegement", "NORMAL");
                }
                %>
            </div>
            --%>

        </form>

        <div class="footer">
            <span>© 2025 FamilyMart System — All Rights Reserved.</span>
        </div>

    </div>
</body>

</html>