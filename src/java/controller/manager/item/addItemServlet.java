/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.manager.item;

import dao.ItemDAO;
import dto.Item;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class addItemServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            // Lấy thông tin item từ form
            String itemName = request.getParameter("txtItemName");
            int price = Integer.parseInt(request.getParameter("txtPrice"));
            int typeID = Integer.parseInt(request.getParameter("txtTypeID"));
            int statusID = Integer.parseInt(request.getParameter("txtStatusID"));
            String image = request.getParameter("txtImage");

            // Kiểm tra các thông tin đầu vào có hợp lệ hay không
            if (itemName.isEmpty() || price <= 0 || typeID < 0 || statusID < 0 || image.isEmpty()) {
                request.setAttribute("ERROR", "Thông tin không được để trống");
                request.getRequestDispatcher("itemForm.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng Item và lưu vào database
            int itemId = 0; // Giá trị tự tăng trong cơ sở dữ liệu
            Item newItem = new Item(itemId, itemName, price, typeID, statusID, image);

            ItemDAO dao = new ItemDAO();
            boolean isAdded = dao.createItem(newItem);

            if (isAdded) {
                response.sendRedirect("viewItem.jsp");
            } else {
                request.setAttribute("ERROR", "Thêm item thất bại! Vui lòng thử lại.");
                request.getRequestDispatcher("itemAdmin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("ERROR", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("itemAdmin.jsp").forward(request, response);
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
