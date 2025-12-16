<%@ page import="java.util.*, java.net.URLEncoder, control.Itemfam"
    language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("windows-31j");
Boolean login = (Boolean)session.getAttribute("adminFlg");
if (login == null){
    pageContext.forward("/view/login.jsp");
    return;
}
%>

<%
List<Itemfam> itemname = (List<Itemfam>)request.getAttribute("itemfam");

String gen = (String)request.getAttribute("gen");
String str = (String)request.getAttribute("str");

int pageNo = 1;
int limit = 10;

if (request.getParameter("page") != null) {
    try {
        pageNo = Integer.parseInt(request.getParameter("page"));
    } catch (Exception e) {
        pageNo = 1;
    }
}

int total = itemname != null ? itemname.size() : 0;
int totalPage = (int)Math.ceil((double)total / limit);
if (totalPage <= 0) totalPage = 1;

if (pageNo > totalPage) pageNo = totalPage;
if (pageNo < 1) pageNo = 1;

int start = (pageNo - 1) * limit;
int end = Math.min(start + limit, total);

String Itemtable = "";
String pageHTML  = "";

if (itemname != null && itemname.size() > 0) {

    Itemtable += "<table border=1 align=center>";
    Itemtable += "<tr align='center' bgcolor='008000'>"
               + "<td><font color='white'>画像</font></td>"
               + "<td><font color='white'>商品名</font></td>"
               + "<td><font color='white'>販売会社</font></td>"
               + "<td><font color='white'>価格</font></td></tr>";

    for (int i = start; i < end; i++) {
        Itemfam item = itemname.get(i);

        Itemtable += "<tr><td>"
            + "<img src='" + request.getContextPath() + item.img + "' width='120' height='120'></td>"
            + "<td><a href='GIcontrol?item=" + item.uriItemName + "' target='_self'>"
            + item.ItemName + "</a></td>"
            + "<td>" + item.maker + "</td>"
            + "<td>" + String.format("%,3d", item.price) + "円</td></tr>";
    }

    Itemtable += "</table>";

    pageHTML += "<div style='text-align:center; margin-top:15px;'>";

    String q = "";
    StringBuilder sb = new StringBuilder();

    if (gen != null && gen.trim().length() > 0) {
        sb.append("&gen=").append(URLEncoder.encode(gen.trim(), "windows-31j"));
    }
    if (str != null && str.trim().length() > 0) {
        sb.append("&str=").append(URLEncoder.encode(str.trim(), "windows-31j"));
    }

    q = sb.toString();

    /* << */
    if (pageNo > 1)
        pageHTML += "<a href='SHsearch?page=" + (pageNo - 1) + q + "' style='margin:0 8px;'>&lt;&lt;</a>";
    else
        pageHTML += "<span style='margin:0 8px; color:#999;'>&lt;&lt;</span>";

    if (totalPage <= 7) {

        for (int p = 1; p <= totalPage; p++) {
            if (p == pageNo)
                pageHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
            else
                pageHTML += "<a href='SHsearch?page=" + p + q + "' style='margin:0 6px;'>" + p + "</a>";
        }

    } else {

        if (pageNo <= 4) {

            for (int p = 1; p <= 5; p++) {
                if (p == pageNo)
                    pageHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
                else
                    pageHTML += "<a href='SHsearch?page=" + p + q + "' style='margin:0 6px;'>" + p + "</a>";
            }

            pageHTML += "<span style='margin:0 6px;'>...</span>";
            pageHTML += "<a href='SHsearch?page=" + totalPage + q + "' style='margin:0 6px;'>" + totalPage + "</a>";

        } else if (pageNo >= totalPage - 3) {

            pageHTML += "<a href='SHsearch?page=1" + q + "' style='margin:0 6px;'>1</a>";
            pageHTML += "<span style='margin:0 6px;'>...</span>";

            for (int p = totalPage - 4; p <= totalPage; p++) {
                if (p == pageNo)
                    pageHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
                else
                    pageHTML += "<a href='SHsearch?page=" + p + q + "' style='margin:0 6px;'>" + p + "</a>";
            }

        } else {

            pageHTML += "<a href='SHsearch?page=1" + q + "' style='margin:0 6px;'>1</a>";
            pageHTML += "<span style='margin:0 6px;'>...</span>";

            for (int p = pageNo - 1; p <= pageNo + 1; p++) {
                if (p == pageNo)
                    pageHTML += "<span style='margin:0 6px; color:#999; font-weight:bold;'>" + p + "</span>";
                else
                    pageHTML += "<a href='SHsearch?page=" + p + q + "' style='margin:0 6px;'>" + p + "</a>";
            }

            pageHTML += "<span style='margin:0 6px;'>...</span>";
            pageHTML += "<a href='SHsearch?page=" + totalPage + q + "' style='margin:0 6px;'>" + totalPage + "</a>";
        }
    }

    /* >> */
    if (pageNo < totalPage)
        pageHTML += "<a href='SHsearch?page=" + (pageNo + 1) + q + "' style='margin:0 8px;'>&gt;&gt;</a>";
    else
        pageHTML += "<span style='margin:0 8px; color:#999;'>&gt;&gt;</span>";

    pageHTML += "</div>";

} else {
    Itemtable = "<div class='font'>一致する商品がありません。</div>";
}
%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%= request.getContextPath() %>/view/css/W0051.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/view/css/table.css" rel="stylesheet" type="text/css" />
<style>
html, body {
    margin: 0;
    padding: 0;
    height: 100%;
    overflow-y: auto;
}

.center {
    display: block !important;
}

.table, .table2 {
    display: block !important;
    width: 100%;
}

table {
    width: 100% !important;
    margin: 0 auto !important;
}

a{
    text-decoration:none;
}
</style>
<title>FamilyMart商品データ</title>
</head>

<body>
<br>

<div class="center">
    <span class="table2"><%= Itemtable %></span>
</div>

<div class="center">
    <%= pageHTML %>
</div>

</body>
</html>
