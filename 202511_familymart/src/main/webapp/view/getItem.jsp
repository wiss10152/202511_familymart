<%@ page import="java.util.*,java.net.*,java.sql.*,dbaccess.MyDBAccess,control.Itemfam"
	language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "jakarta.servlet.http.HttpSession" %>

<%
	request.setCharacterEncoding("windows-31j");
	Boolean login = (Boolean)session.getAttribute("adminFlg");

	if (login == null){
		pageContext.forward("/view/login.jsp");
	}

	// 取得した商品データを格納する
	List<Itemfam>itemdata = (List<Itemfam>)request.getAttribute("getitem");

	String gen  = (String)request.getAttribute("gen");
	String item = request.getParameter("item");
	item = new String(item.getBytes("UTF-8"), "UTF-8");

	// テーブル作成
	String itemHTML = "<table align='center' cellpadding='3'>";

for(Itemfam data : itemdata){

    itemHTML +=
        "<tr><td bgcolor=\"008000\">商品名</td><td>" + data.ItemName + "</td></tr>" +
        "<tr><td bgcolor=\"008000\">販売会社</td><td>" + data.maker + "</td></tr>" +
        "<tr><td bgcolor=\"008000\">ジャンル</td><td>" + data.genre + "</td></tr>" +
        "<tr><td bgcolor=\"008000\">販売日</td><td>" + data.day + "</td></tr>" +
        "<tr><td bgcolor=\"008000\">価格</td><td>" + String.format("%,3d", data.price) + " 円</td></tr>";
}

itemHTML += "</table>";


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%= request.getContextPath() %>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />

<title>商品詳細表示</title>

<style>
body{
overflow:hidden;
background:none;
}


.item-layout {
    display: flex;
    align-items: flex-start;
    justify-content: center;
    gap: 20px;
    margin-top: 10px;
}

img{
width:300px;
height:300px;
}

.item-image {
    text-align: center;
}

.item-info {
    min-width: 300px;
}

.table2 table {
    border-collapse: collapse;
    font-size: 14px;
}

.table2{
    display: block;
    margin-top: 30px;
    margin-left: 80px;
    }
    
.table2 td {
    padding: 4px 8px;
    border: 1px solid #008000;
        border: 1px solid #ccc;
    
}

.btn{
margin-left:460px;
}

.btn input{
background-color: #ADADAD;
	cursor: pointer;
	border: none;
	width: 100px;
	border-radius: 4px;
}

.btn input:hover {
	background-color: #C4C4C4;
}
</style>

</head>
<body>
<br>
<div class ="center">

	<h2>商品 詳細</h2>

	<!-- 8月　商品画像とPOP画像のレイアウト。CSS(W0051.css)による座標指定で画像を重ねて表示する -->
	<div class="item-layout">

    <div class="item-image">
        <div class="relative">
            <% for(Itemfam data : itemdata){ %>
                <img src="<%= request.getContextPath() + data.img %>" width="150" height="150">
            <% } %>

            <% for(Itemfam data : itemdata){ %>
                <% if(data.newItemJudge == 0) { %>
                    <img src="./view/img/new_image.png" width="120" height="90" class="absolute">
                <% } else if (data.newItemJudge == 1) { %>
                    <img src="./view/img/coming_soon.png" width="120" height="90" class="absolute">
                <% } %>
            <% } %>
        </div>
    </div>

    <div class="item-info">
        <span class="table2">
            <%= itemHTML %>
        </span>
    </div>

</div>


	
<div class="btn">
	<input type="button" value="戻る"onClick="history.back(); return false;">
</div>

</div>
<script>
(function () {
    const OFFSET = 80; 

    function setIframeHeight() {
        const iframe = parent.document.getElementById("wakuFrame");
        if (!iframe) return;

        const screenHeight = parent.document.documentElement.clientHeight;
        const finalHeight = Math.max(screenHeight - OFFSET, 0);

        iframe.style.height = finalHeight + "px";
    }

    window.addEventListener("load", () => {
        requestAnimationFrame(setIframeHeight);
    });

    window.addEventListener("resize", setIframeHeight);
})();
</script>


</body>
</html>