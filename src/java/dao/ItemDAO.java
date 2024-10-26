
package dao;

import dto.Item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mylib.DBUtils;

public class ItemDAO {
    
    //TẠO MỚI, THÊM SẢN PHẨM
    public boolean createItem(Item item){
        
        Connection cn = null;
        PreparedStatement pst = null;
        String sql = "insert into Items (ItemName, Price, typeID, statusID, Image) values (?,?,?,?,?)";
        try{
            cn = DBUtils.makeConnection();
            pst = cn.prepareStatement(sql);
            if(cn != null){
                pst.setString(1, item.getItemName());
                pst.setInt(2, item.getPrice());
                pst.setInt(3, item.getTypeID());
                pst.setInt(4, item.getStatusID());
                pst.setString(5, item.getImage());
                int rowsAffected = pst.executeUpdate();
                
                if(rowsAffected > 0){
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try {
                if(cn != null) cn.close();
             } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    //CẬP NHẬT SẢN PHẨM
    public boolean updateItem(int itemId, String name, int price, int statusID, String image){
        Connection cn = null;
        boolean result = false;
        try{
            cn = DBUtils.makeConnection();
            String sql = "update Items set ItemName=?, Price=?, typeID=?, statusID=?, Image=?"
                    + "where ItemId";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, name);
            st.setInt(2, price);
            st.setInt(3, statusID);
            st.setString(4, image);
            st.setInt(5, itemId);
            int rows = st.executeUpdate();
            result = (rows > 0);
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    //XÓA SẢN PHẨM
    public boolean deleteItem(int itemId){
        Connection cn = null;
        boolean success = false;
        try{
           cn = DBUtils.makeConnection();
           String sql = "delete from Items where ItemId=?";
           PreparedStatement st = cn.prepareStatement(sql);
           st.setInt(1, itemId);
           int rows = st.executeUpdate();
           success = (rows > 0);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return success;
    }
    
    
    
    //lấy tất cả các item dựa vào TÊN SẢN PHẨM
    public ArrayList<Item> getAllItemByName(String name){
        ArrayList<Item> list = new ArrayList<>();
        Connection cn = null;
        try{
            cn = DBUtils.makeConnection();
            if(cn != null){
                String sql = "select ItemId, ItemName, Price, typeID, statusID, Image\n"
                        + "from dbo.Items\n"
                        + "where ItemName like ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + name + "%");
                ResultSet table = st.executeQuery();
                if(table != null){
                    while(table.next()){
                        Item t = new Item();
                        t.setItemId(table.getInt("ItemId"));
                        t.setItemName(table.getString("ItemName"));
                        t.setPrice(table.getInt("Price"));
                        t.setTypeID(table.getInt("typeID"));
                        t.setStatusID(table.getInt("statusID"));
                        t.setImage(table.getString("Image"));
                        list.add(t);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try {
                if(cn != null) cn.close();
             } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    
    //Lấy tất cả các đồ uống (Type ID = 1)
    public List<Item> getAllDrinks(){
        List<Item> drinks = new ArrayList<>();
        Connection cn = null;
        try{
            cn = DBUtils.makeConnection();
            if(cn != null){
                String sql = "SELECT ItemId, ItemName, Price, typeID, statusID, Image"
                        + " from Items"
                        + " where typeID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, 1);
                ResultSet table = st.executeQuery();
                while(table.next()){
                    Item drink = new Item();
                    drink.setItemId(table.getInt("ItemId"));
                    drink.setItemName(table.getString("ItemName"));
                    drink.setPrice(table.getInt("Price"));
                    drink.setTypeID(table.getInt(table.getInt("typeID")));
                    drink.setStatusID(table.getInt(table.getInt("statusID")));
                    drink.setImage(table.getString("Image"));
                    drinks.add(drink);
                }
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return drinks;
    
    }

    // Phương thức lấy tất cả sản phẩm
    public List<Item> getAllItems() {
        List<Item> itemList = new ArrayList<>();
        String sql = "SELECT * FROM Items"; // Thay đổi tên bảng nếu cần

        try (Connection conn = DBUtils.getConnection(); // Kết nối đến cơ sở dữ liệu
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                int itemId = rs.getInt("itemId"); // Thay đổi tên cột nếu cần
                String itemName = rs.getString("itemName");
                int price = rs.getInt("price");
                int typeID = rs.getInt("typeID");
                int statusID = rs.getInt("statusID");
                String image = rs.getString("image");

                // Tạo đối tượng Item và thêm vào danh sách
                Item item = new Item(itemId, itemName, price, typeID, statusID, image);
                itemList.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return itemList;
}

    
    public List<Item> getAllItems(int statusID){
        List<Item> itemList = new ArrayList<>();
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            cn = DBUtils.makeConnection();
            
            String sql = "select ItemId, itemName, price, typeID, statusID, Image"
                    + " from Items"
                    + " where statusID = ?";
            
            ps = cn.prepareStatement(sql);
            ps.setInt(1, statusID);
            rs = ps.executeQuery();
            
            while(rs.next()){
                Item item = new Item(rs.getInt("ItemId"), rs.getString("ItemName"), rs.getInt("Price"), rs.getInt("typeID"), rs.getInt("statusID"), rs.getString("Image"));
                itemList.add(item);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally{
            try {
                if(cn != null) cn.close();
             } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return itemList; 
    }
    
}

