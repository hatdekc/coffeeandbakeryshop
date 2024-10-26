/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.item;

import dao.ItemDAO;
import dto.Item;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class ItemServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        ItemDAO itemDAO = new ItemDAO();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            //Thêm sản phẩm mới
            if("create".equals(action)){
                String itemName = request.getParameter("txtItemName");
                int price = Integer.parseInt(request.getParameter("txtPrice"));
                int typeID = Integer.parseInt(request.getParameter("txtTypeID"));
                int statusID = Integer.parseInt(request.getParameter("txtStatusID"));
                String image = request.getParameter("txtImage");
                
//                Item newItem = new Item(0, itemName, price, typeID, statusID, image);
                int result = itemDAO.createItem(itemName, price, typeID, statusID, image);
                
                if(result > 0){
                    out.print("Sản phẩm đã được thêm thành công!");
                } else {
                    out.print("Thêm sản phẩm thất bại");
                }
            }
            
            //Cập nhật sản phẩm
            else if("update".equals(action)){
                int itemId = Integer.parseInt(request.getParameter("txtItemId"));
                String itemName = request.getParameter("txtItemName");
                int price = Integer.parseInt(request.getParameter("txtPrice"));
                int statusID = Integer.parseInt(request.getParameter("txtStatusID"));
                String image = request.getParameter("txtImage");

                boolean result = itemDAO.updateItem(itemId, itemName, price, statusID, image);
                
                if (result) {
                    out.println("Sản phẩm đã được cập nhật thành công!");
                } else {
                    out.println("Cập nhật sản phẩm thất bại!");
                }
            }
            
            // Xóa sản phẩm
            else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("txtItemId"));
                boolean result = itemDAO.deleteItem(itemId);
                
                if (result) {
                    out.println("Sản phẩm đã được xóa thành công!");
                } else {
                    out.println("Xóa sản phẩm thất bại!");
                }
            }
            // Trả về danh sách sản phẩm
            else if ("list".equals(action)) {
                List<Item> itemList = itemDAO.getAllItems(); // Phương thức lấy tất cả sản phẩm
                request.setAttribute("itemList", itemList);
                request.getRequestDispatcher("item.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
