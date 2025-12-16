package control;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.MyDBAccess;

/*
 * Servlet implementation class SHsearch
 */
@WebServlet("/SHsearch")
public class SHsearch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("windows-31j");

        String str = request.getParameter("str");
        if (str == null) str = "";
        str = str.trim();

        List<Itemfam> list = ItemDataList(str);

        request.setAttribute("itemfam", list);
        request.setAttribute("str", str);

        RequestDispatcher dispatch =
                request.getRequestDispatcher("/view/SHview.jsp");
        dispatch.forward(request, response);
    }

    private String SendSQLSentence(String str) {

        String sql =
            "SELECT * FROM 商品データ ";

        if (!str.isEmpty()) {
            sql += " WHERE 商品名 LIKE '%" + str + "%'";
        }

        return sql;
    }

    private List<Itemfam> ItemDataList(String str) {

        List<Itemfam> ItemList = new ArrayList<>();
        MyDBAccess model = new MyDBAccess();

        try {
            model.open();

            ResultSet rs = model.getResultSet(SendSQLSentence(str));

            while (rs.next()) {
                Itemfam setItem = new Itemfam();

                setItem.ItemId   = rs.getString("商品コード");
                setItem.ItemName = rs.getString("商品名");
                setItem.uriItemName = URLEncoder.encode(setItem.ItemName, "UTF-8");
                setItem.maker    = rs.getString("販売会社");
                setItem.genre    = rs.getString("ジャンル");
                setItem.day      = rs.getString("販売日");
                setItem.price    = rs.getInt("価格");
                setItem.img      = rs.getString("画像");

                ItemList.add(setItem);
            }

            model.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ItemList;
    }
}
