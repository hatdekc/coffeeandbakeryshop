<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.Item" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Sản Phẩm</title>
    <link rel="stylesheet" href="styles.css"> 
</head>
<body>
    <h1>Quản Lý Sản Phẩm</h1>

    <h2>Thêm Sản Phẩm</h2>
    <form action="ItemServlet" method="post">
        <input type="hidden" name="action" value="create">
        <label for="txtItemName">Tên Sản Phẩm:</label>
        <input type="text" name="txtItemName" required><br>

        <label for="txtPrice">Giá:</label>
        <input type="number" name="txtPrice" required><br>

        <label for="txtTypeID">ID Loại:</label>
        <input type="number" name="txtTypeID" required><br>

        <label for="txtStatusID">ID Trạng Thái:</label>
        <input type="number" name="txtStatusID" required><br>

        <label for="txtImage">Hình Ảnh:</label>
        <input type="text" name="txtImage" required><br>

        <input type="submit" value="Thêm Sản Phẩm">
    </form>

    <h2>Cập Nhật Sản Phẩm</h2>
    <form action="ItemServlet" method="post">
        <input type="hidden" name="action" value="update">
        <label for="txtItemId">ID Sản Phẩm:</label>
        <input type="number" name="txtItemId" required><br>

        <label for="txtItemName">Tên Sản Phẩm:</label>
        <input type="text" name="txtItemName" required><br>

        <label for="txtPrice">Giá:</label>
        <input type="number" name="txtPrice" required><br>

        <label for="txtStatusID">ID Trạng Thái:</label>
        <input type="number" name="txtStatusID" required><br>

        <label for="txtImage">Hình Ảnh:</label>
        <input type="text" name="txtImage" required><br>

        <input type="submit" value="Cập Nhật Sản Phẩm">
    </form>

    <h2>Xóa Sản Phẩm</h2>
    <form action="ItemServlet" method="post">
        <input type="hidden" name="action" value="delete">
        <label for="txtItemId">ID Sản Phẩm:</label>
        <input type="number" name="txtItemId" required><br>
        <input type="submit" value="Xóa Sản Phẩm">
    </form>

    <h2>Thông Báo</h2>
    <%
        String message = request.getAttribute("message") != null ? (String) request.getAttribute("message") : "";
        if (!message.isEmpty()) {
    %>
        <p><%= message %></p>
    <%
        }
    %>
    
    <form action="ItemServlet" method="get">
    <input type="hidden" name="action" value="list">
    <input type="submit" value="Làm Mới Danh Sách Sản Phẩm">
    </form>
    <h2>Danh Sách Sản Phẩm</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Tên Sản Phẩm</th>
            <th>Giá</th>
            <th>ID Loại</th>
            <th>ID Trạng Thái</th>
            <th>Hình Ảnh</th>
        </tr>
        <%
            List<Item> itemList = (List<Item>) request.getAttribute("itemList");
            if (itemList != null) {
                for (Item item : itemList) {
        %>
            <tr>
                <td><%= item.getItemId() %></td>
                <td><%= item.getItemName() %></td>
                <td><%= item.getPrice() %></td>
                <td><%= item.getTypeID() %></td>
                <td><%= item.getStatusID() %></td>
                <td><%= item.getImage() %></td>
            </tr>
        <%
                }
            }
        %>
    </table>
</body>
</html>
