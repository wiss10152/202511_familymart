<%@ page import="java.util.*, control.Shopinfo"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("windows-31j");

Boolean login = (Boolean) session.getAttribute("adminFlg");
if (login == null) {
    pageContext.forward("/view/login.jsp");
    return;
}

List<Shopinfo> shopname = (List<Shopinfo>) request.getAttribute("shopdata");

String edit = (String) request.getAttribute("edit");
if (edit == null) edit = "";   // "" = すべて

String shp = (String)request.getAttribute("shp");
if (shp == null) shp = "";

String skey = (String)request.getAttribute("skey");
if (skey == null) skey = "0";

String pre = (String)request.getAttribute("pre");
if (pre == null) pre = "";
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>FamilyMart出店計画</title>

<link href="<%=request.getContextPath()%>/view/css/W0051.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/view/css/table.css" rel="stylesheet">

<style>
body { background:none !important; padding-bottom:320px; }
a { text-decoration:none; }
</style>

<script>
const pageSize = 10;
let currentPage = 1;

function renderPage(page) {
    currentPage = page;

    const rows = Array.from(document.querySelectorAll(".data-row"));
    const total = rows.length;
    const totalPage = Math.max(1, Math.ceil(total / pageSize));

    rows.forEach((row, idx) => {
        row.style.display =
            (idx >= (page - 1) * pageSize && idx < page * pageSize) ? "" : "none";
    });

    renderPager(totalPage);
}

function renderPager(totalPage) {
    const pager = document.getElementById("pager");
    pager.innerHTML = "";

    const addLink = (label, page) => {
        const a = document.createElement("a");
        a.href = "#";
        a.textContent = label;
        a.style.margin = "0 6px";
        a.addEventListener("click", e => {
            e.preventDefault();
            renderPage(page);
        });
        pager.appendChild(a);
    };

    const addSpan = (label, bold = false) => {
        const sp = document.createElement("span");
        sp.textContent = label;
        sp.style.margin = "0 6px";
        sp.style.color = "#999";
        if (bold) sp.style.fontWeight = "bold";
        pager.appendChild(sp);
    };

    if (currentPage > 1) addLink("<<", currentPage - 1);
    else addSpan("<<");

    if (totalPage <= 7) {
        for (let p = 1; p <= totalPage; p++) {
            if (p === currentPage) addSpan(String(p), true);
            else addLink(String(p), p);
        }
    } else {
        if (currentPage <= 4) {
            for (let p = 1; p <= 5; p++) {
                if (p === currentPage) addSpan(String(p), true);
                else addLink(String(p), p);
            }
            addSpan("...");
            addLink(String(totalPage), totalPage);
        } else if (currentPage >= totalPage - 3) {
            addLink("1", 1);
            addSpan("...");
            for (let p = totalPage - 4; p <= totalPage; p++) {
                if (p === currentPage) addSpan(String(p), true);
                else addLink(String(p), p);
            }
        } else {
            addLink("1", 1);
            addSpan("...");
            for (let p = currentPage - 1; p <= currentPage + 1; p++) {
                if (p === currentPage) addSpan(String(p), true);
                else addLink(String(p), p);
            }
            addSpan("...");
            addLink(String(totalPage), totalPage);
        }
    }

    if (currentPage < totalPage) addLink(">>", currentPage + 1);
    else addSpan(">>");
}

const currentEdit = "<%=edit%>"; // true / false / ""

function changeStatus(btn, shopId, nextDeleted) {
    fetch(
        'Delete?shop=' + shopId + '&deleted=' + nextDeleted,
        { method: 'GET' }
    ).then(res => {
        if (!res.ok) {
            alert('更新失敗');
            return;
        }

        if (currentEdit === "true" || currentEdit === "false") {
            btn.closest('tr').remove();
            renderPage(currentPage);
            return;
        }

        btn.value = nextDeleted ? "出店済みにする" : "未出店にする";
        btn.setAttribute(
            "onclick",
            "changeStatus(this, '" + shopId + "', " + (!nextDeleted) + ")"
        );
    });
}

window.addEventListener("DOMContentLoaded", () => {
    renderPage(1);
});
</script>
</head>

<body>

<div class="center">
<div class="end">

<% if (shopname != null && shopname.size() > 0) { %>

<table border="1" align="center">
<tr bgcolor="008000">
    <td><font color="white">店舗名</font></td>
    <td><font color="white">出店日</font></td>
    <td><font color="white">住所</font></td>
    <td><font color="white">店舗状況</font></td>
</tr>

<%
Boolean adminFlg = (Boolean) session.getAttribute("adminFlg");
for (Shopinfo s : shopname) {

    boolean deleted = s.deleted;
    String statusText = deleted ? "未出店" : "出店済み";
    String buttonText = deleted ? "出店済みにする" : "未出店にする";
%>

<tr class="data-row">
    <td>
        <a href="GScontrol?shop=<%=s.uriShopName%>"><%=s.shopName%></a>
    </td>
    <td><%=s.openDate%></td>
    <td align="left">
        <a href="https://www.google.co.jp/maps/place/<%=s.uriShopAdr%>" target="_blank">
            <%=s.shopAdr%>
        </a>
    </td>
    <td>
    <% if (Boolean.TRUE.equals(adminFlg)) { %>
        <input type="button"
               value="<%=buttonText%>"
               onclick="changeStatus(this, '<%=s.shopid%>', <%=!deleted%>)">
    <% } else { %>
        <%=statusText%>
    <% } %>
    </td>
</tr>

<% } %>

</table>

<% } else { %>
<div class="font">条件に合った店舗が存在しません。</div>
<% } %>

</div>
</div>

<div class="center">
<div class="end" style="margin-top:15px;">
    <div id="pager"></div>
</div>
</div>

</body>
</html>
